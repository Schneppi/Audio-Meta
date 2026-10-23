#tag Class
Protected Class MP3Waveform
	#tag Method, Flags = &h21
		Private Shared Function BitrateForIndex(isMPEG1 As Boolean, layer As Integer, index As Integer) As Integer
		  Var table() As Integer
		  If isMPEG1 Then
		    Select Case layer
		    Case 1
		      table = Array(0, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448)
		    Case 2
		      table = Array(0, 32, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320, 384)
		    Else
		      table = Array(0, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320)
		    End Select
		  Else
		    If layer = 1 Then
		      table = Array(0, 32, 48, 56, 64, 80, 96, 112, 128, 144, 160, 176, 192, 224, 256)
		    Else
		      table = Array(0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160)
		    End If
		  End If
		  Return table(index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BuildApproximatePeaks(gains() As Double, bucketCount As Integer)
		  // Turns per-frame global gain values into a symmetric loudness envelope.
		  // Each global_gain step is 1.5 dB; frames without coded values are silent.
		  MinPeaks.ResizeTo(-1)
		  MaxPeaks.ResizeTo(-1)
		  If gains.Count = 0 Then Return

		  Var maxGain As Double = 0
		  For Each gain As Double In gains
		    If gain > maxGain Then maxGain = gain
		  Next

		  Var buckets As Integer = Min(bucketCount, gains.Count)
		  MinPeaks.ResizeTo(buckets - 1)
		  MaxPeaks.ResizeTo(buckets - 1)

		  For i As Integer = 0 To gains.LastIndex
		    Var amplitude As Double = 0
		    If gains(i) >= 0 Then
		      Var db As Double = (gains(i) - maxGain) * 1.5
		      If db > -48 Then amplitude = Pow(10, db / 20)
		    End If
		    Var b As Integer = Min(buckets - 1, i * buckets \ gains.Count)
		    If amplitude > MaxPeaks(b) Then
		      MaxPeaks(b) = amplitude
		      MinPeaks(b) = -amplitude
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecodeWithAudioToolbox(f As FolderItem, bucketCount As Integer) As Boolean
		  // Decodes the file to PCM with the system's ExtAudioFile API and stores
		  // the minimum/maximum sample of each bucket. Runs fine on a Thread.
		  #If TargetMacOS Then
		    #Pragma BoundsChecking False
		    #Pragma StackOverflowChecking False
		    #Pragma NilObjectChecking False
		    
		    Declare Function CFURLCreateWithFileSystemPath Lib "CoreFoundation" (allocator As Ptr, filePath As CFStringRef, pathStyle As Integer, isDirectory As Boolean) As Ptr
		    Declare Sub CFRelease Lib "CoreFoundation" (cf As Ptr)
		    Declare Function ExtAudioFileOpenURL Lib "AudioToolbox" (inURL As Ptr, ByRef outExtAudioFile As Ptr) As Int32
		    Declare Function ExtAudioFileGetProperty Lib "AudioToolbox" (inExtAudioFile As Ptr, inPropertyID As UInt32, ByRef ioPropertyDataSize As UInt32, outPropertyData As Ptr) As Int32
		    Declare Function ExtAudioFileSetProperty Lib "AudioToolbox" (inExtAudioFile As Ptr, inPropertyID As UInt32, inPropertyDataSize As UInt32, inPropertyData As Ptr) As Int32
		    Declare Function ExtAudioFileRead Lib "AudioToolbox" (inExtAudioFile As Ptr, ByRef ioNumberFrames As UInt32, ioData As Ptr) As Int32
		    Declare Function ExtAudioFileSeek Lib "AudioToolbox" (inExtAudioFile As Ptr, inFrameOffset As Int64) As Int32
		    Declare Function ExtAudioFileDispose Lib "AudioToolbox" (inExtAudioFile As Ptr) As Int32
		    Declare Sub vDSP_minv Lib "Accelerate" (a As Ptr, stride As Integer, ByRef result As Single, count As UInteger)
		    Declare Sub vDSP_maxv Lib "Accelerate" (a As Ptr, stride As Integer, ByRef result As Single, count As UInteger)
		    
		    Const kPropertyFileDataFormat = &h66666D74   // 'ffmt'
		    Const kPropertyClientDataFormat = &h63666D74 // 'cfmt'
		    Const kPropertyFileLengthFrames = &h2366726D // '#frm'
		    Const kFormatLinearPCM = &h6C70636D          // 'lpcm'
		    Const kFormatFlagsFloatPacked = 9            // kAudioFormatFlagIsFloat | kAudioFormatFlagIsPacked
		    Const kProbeFrames = 1024                    // frames decoded per bucket
		    
		    Var url As Ptr = CFURLCreateWithFileSystemPath(Nil, f.NativePath, 0, False) // 0 = kCFURLPOSIXPathStyle
		    If url = Nil Then Return False
		    
		    Var audioFile As Ptr
		    Var status As Int32 = ExtAudioFileOpenURL(url, audioFile)
		    CFRelease(url)
		    If status <> 0 Or audioFile = Nil Then Return False
		    
		    // AudioStreamBasicDescription (40 bytes)
		    Var fileFormat As New MemoryBlock(40)
		    fileFormat.LittleEndian = True
		    Var propertySize As UInt32 = 40
		    status = ExtAudioFileGetProperty(audioFile, kPropertyFileDataFormat, propertySize, fileFormat)
		    Var rate As Double = fileFormat.DoubleValue(0)
		    Var fileChannels As Integer = fileFormat.UInt32Value(28)
		    
		    Var lengthBlock As New MemoryBlock(8)
		    lengthBlock.LittleEndian = True
		    propertySize = 8
		    Var totalFrames As Int64 = 0
		    If ExtAudioFileGetProperty(audioFile, kPropertyFileLengthFrames, propertySize, lengthBlock) = 0 Then
		      totalFrames = lengthBlock.Int64Value(0)
		    End If
		    
		    If status <> 0 Or rate <= 0 Or fileChannels <= 0 Or totalFrames <= 0 Then
		      Call ExtAudioFileDispose(audioFile)
		      Return False
		    End If
		    
		    // Ask for 32-bit float samples at the file's own rate. Let Core Audio
		    // mix down to mono; fall back to interleaved channels if it refuses.
		    Var clientFormat As New MemoryBlock(40)
		    clientFormat.LittleEndian = True
		    Var channelCount As Integer = 1
		    For attempt As Integer = 1 To 2
		      If attempt = 2 Then channelCount = fileChannels
		      clientFormat.DoubleValue(0) = rate
		      clientFormat.UInt32Value(8) = kFormatLinearPCM
		      clientFormat.UInt32Value(12) = kFormatFlagsFloatPacked
		      clientFormat.UInt32Value(16) = 4 * channelCount
		      clientFormat.UInt32Value(20) = 1
		      clientFormat.UInt32Value(24) = 4 * channelCount
		      clientFormat.UInt32Value(28) = channelCount
		      clientFormat.UInt32Value(32) = 32
		      status = ExtAudioFileSetProperty(audioFile, kPropertyClientDataFormat, 40, clientFormat)
		      If status = 0 Then Exit For
		    Next
		    If status <> 0 Then
		      Call ExtAudioFileDispose(audioFile)
		      Return False
		    End If
		    
		    // Instead of decoding the whole file, seek to the start of each bucket
		    // and decode a short probe there. A 5 minute song needs about 0.25 s
		    // this way instead of 0.7 s for a full decode, and the loop below only
		    // sees a few percent of the samples.
		    Var buckets As Integer = Max(1, Min(bucketCount, totalFrames \ kProbeFrames))
		    Var probeFrames As Integer = Min(kProbeFrames, totalFrames)
		    Var buffer As New MemoryBlock(probeFrames * 4 * channelCount)
		    Var samples As Ptr = buffer
		    Var bufferBytes As Integer = buffer.Size
		    
		    // AudioBufferList with a single AudioBuffer (64-bit layout)
		    Var bufferList As New MemoryBlock(24)
		    bufferList.LittleEndian = True
		    
		    Var mins() As Double
		    Var maxs() As Double
		    
		    For b As Integer = 0 To buckets - 1
		      If Cancelled Then Exit For
		      
		      Var startFrame As Int64 = totalFrames * b \ buckets
		      If ExtAudioFileSeek(audioFile, startFrame) <> 0 Then Exit For
		      
		      bufferList.UInt32Value(0) = 1
		      bufferList.UInt32Value(8) = channelCount
		      bufferList.UInt32Value(12) = bufferBytes
		      bufferList.Ptr(16) = samples
		      
		      Var framesRead As UInt32 = probeFrames
		      If ExtAudioFileRead(audioFile, framesRead, bufferList) <> 0 Then Exit For
		      
		      // vDSP finds the extremes in C; a Xojo loop over the samples is far slower.
		      Var sampleCount As Integer = framesRead * channelCount
		      Var low As Single = 0
		      Var high As Single = 0
		      If sampleCount > 0 Then
		        vDSP_minv(samples, 1, low, sampleCount)
		        vDSP_maxv(samples, 1, high, sampleCount)
		      End If
		      mins.Add(low)
		      maxs.Add(high)
		      
		      If b Mod 50 = 0 Then Progress = 0.1 + 0.9 * b / buckets
		    Next
		    
		    Call ExtAudioFileDispose(audioFile)
		    
		    // A failed seek or read falls back to the approximate envelope.
		    If Cancelled Or mins.Count < buckets Then Return False
		    
		    MinPeaks = mins
		    MaxPeaks = maxs
		    Return True
		  #Else
		    #Pragma Unused f
		    #Pragma Unused bucketCount
		    Return False
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FrameGain(data As MemoryBlock, pos As Integer, isMPEG1 As Boolean, channelCount As Integer, hasCRC As Boolean) As Double
		  // Reads the highest global_gain of a Layer III frame's granules from its
		  // side information. Returns -1 for frames without coded spectral values.
		  Var bit As Integer = (pos + 4 + If(hasCRC, 2, 0)) * 8
		  Var granules As Integer
		  Var stride As Integer
		  If isMPEG1 Then
		    bit = bit + 9 + If(channelCount = 1, 5, 3) + 4 * channelCount
		    granules = 2
		    stride = 59
		  Else
		    bit = bit + 8 + If(channelCount = 1, 1, 2)
		    granules = 1
		    stride = 63
		  End If

		  Var maxGain As Integer = -1
		  For gr As Integer = 1 To granules
		    For ch As Integer = 1 To channelCount
		      Var bigValues As Integer = ReadBits(data, bit + 12, 9)
		      Var gain As Integer = ReadBits(data, bit + 21, 8)
		      If bigValues > 0 And gain > maxGain Then maxGain = gain
		      bit = bit + stride
		    Next
		  Next
		  Return maxGain
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Load(f As FolderItem, bucketCount As Integer) As Boolean
		  // Analyzes f and fills MinPeaks/MaxPeaks with up to bucketCount values.
		  // Safe to call from a Thread; set Cancelled to stop early.
		  MinPeaks.ResizeTo(-1)
		  MaxPeaks.ResizeTo(-1)
		  IsApproximate = False
		  ErrorMessage = ""
		  Progress = 0
		  
		  // Frame headers give format info on every platform. The per-frame gain
		  // values are only needed for the approximate envelope.
		  Var gains() As Double
		  #If TargetMacOS Then
		    If Not ScanFrames(f, gains, False) Then Return False
		    If DecodeWithAudioToolbox(f, bucketCount) Then
		      Progress = 1
		      Return True
		    End If
		    If Cancelled Then Return False
		  #EndIf
		  
		  If Not ScanFrames(f, gains, True) Then Return False
		  BuildApproximatePeaks(gains, bucketCount)
		  IsApproximate = True
		  Progress = 1
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ParseHeader(data As MemoryBlock, pos As Integer, ByRef frameLength As Integer, ByRef sampleCount As Integer, ByRef rate As Integer, ByRef channelCount As Integer, ByRef isMPEG1 As Boolean, ByRef layer As Integer, ByRef hasCRC As Boolean) As Boolean
		  Var b0 As Integer = data.UInt8Value(pos)
		  Var b1 As Integer = data.UInt8Value(pos + 1)
		  If b0 <> &hFF Or (b1 And &hE0) <> &hE0 Then Return False
		  Var b2 As Integer = data.UInt8Value(pos + 2)
		  Var b3 As Integer = data.UInt8Value(pos + 3)

		  Var versionBits As Integer = Bitwise.ShiftRight(b1, 3) And 3
		  Var layerBits As Integer = Bitwise.ShiftRight(b1, 1) And 3
		  Var bitrateIndex As Integer = Bitwise.ShiftRight(b2, 4) And 15
		  Var rateIndex As Integer = Bitwise.ShiftRight(b2, 2) And 3
		  If versionBits = 1 Or layerBits = 0 Or bitrateIndex = 0 Or bitrateIndex = 15 Or rateIndex = 3 Then Return False

		  Var padding As Integer = Bitwise.ShiftRight(b2, 1) And 1
		  layer = 4 - layerBits
		  isMPEG1 = (versionBits = 3)
		  hasCRC = (b1 And 1) = 0
		  channelCount = If((Bitwise.ShiftRight(b3, 6) And 3) = 3, 1, 2)

		  Var rates() As Integer
		  Select Case versionBits
		  Case 3
		    rates = Array(44100, 48000, 32000)
		  Case 2
		    rates = Array(22050, 24000, 16000)
		  Else
		    rates = Array(11025, 12000, 8000) // MPEG 2.5
		  End Select
		  rate = rates(rateIndex)

		  Var bitrate As Integer = BitrateForIndex(isMPEG1, layer, bitrateIndex) * 1000
		  Select Case layer
		  Case 1
		    sampleCount = 384
		    frameLength = (12 * bitrate \ rate + padding) * 4
		  Case 2
		    sampleCount = 1152
		    frameLength = 144 * bitrate \ rate + padding
		  Else
		    sampleCount = If(isMPEG1, 1152, 576)
		    frameLength = If(isMPEG1, 144, 72) * bitrate \ rate + padding
		  End Select

		  Return frameLength > 4
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ReadBits(data As MemoryBlock, bitOffset As Integer, count As Integer) As Integer
		  Var result As Integer = 0
		  For i As Integer = bitOffset To bitOffset + count - 1
		    Var byteValue As Integer = data.UInt8Value(i \ 8)
		    result = result * 2 + (Bitwise.ShiftRight(byteValue, 7 - (i Mod 8)) And 1)
		  Next
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ScanFrames(f As FolderItem, gains() As Double, collectGains As Boolean) As Boolean
		  // Walks all MPEG audio frames to compute duration, format and bitrate.
		  #Pragma BoundsChecking False

		  Var data As MemoryBlock
		  Try
		    Var bs As BinaryStream = BinaryStream.Open(f, False)
		    data = bs.Read(bs.Length)
		    bs.Close
		  Catch e As IOException
		    ErrorMessage = Localized.Error_ReadFile.Replace("%1", e.Message)
		    Return False
		  End Try

		  If data Is Nil Or data.Size < 4 Then
		    ErrorMessage = Localized.Error_EmptyFile
		    Return False
		  End If
		  data.LittleEndian = False

		  Var fileSize As Integer = data.Size
		  Var pos As Integer = 0

		  // Skip the ID3v2 tag ("ID3")
		  If fileSize >= 10 And data.UInt8Value(0) = &h49 And data.UInt8Value(1) = &h44 And data.UInt8Value(2) = &h33 Then
		    pos = 10 + (data.UInt8Value(6) And &h7F) * 2097152 + (data.UInt8Value(7) And &h7F) * 16384 + _
		    (data.UInt8Value(8) And &h7F) * 128 + (data.UInt8Value(9) And &h7F)
		    If (data.UInt8Value(5) And &h10) <> 0 Then pos = pos + 10
		  End If

		  // Stop before an ID3v1 tag ("TAG")
		  Var endPos As Integer = fileSize
		  If fileSize >= 128 And data.UInt8Value(fileSize - 128) = &h54 And data.UInt8Value(fileSize - 127) = &h41 And data.UInt8Value(fileSize - 126) = &h47 Then
		    endPos = fileSize - 128
		  End If

		  Var frameLength, sampleCount, rate, channelCount, layer As Integer
		  Var isMPEG1, hasCRC As Boolean
		  Var nextLength, nextSamples, nextRate, nextChannels, nextLayer As Integer
		  Var nextMPEG1, nextCRC As Boolean

		  Var frames As Integer = 0
		  Var totalSamples As Double = 0
		  Var totalBytes As Double = 0
		  Var inSync As Boolean = False

		  While pos + 4 <= endPos
		    If ParseHeader(data, pos, frameLength, sampleCount, rate, channelCount, isMPEG1, layer, hasCRC) And pos + frameLength <= endPos Then
		      // While searching for sync, require the following frame to be valid too.
		      Var accept As Boolean = inSync
		      If Not accept Then
		        Var nextPos As Integer = pos + frameLength
		        accept = nextPos + 4 > endPos Or ParseHeader(data, nextPos, nextLength, nextSamples, nextRate, nextChannels, nextMPEG1, nextLayer, nextCRC)
		      End If

		      If accept Then
		        If frames = 0 Then
		          SampleRate = rate
		          Channels = channelCount
		        End If
		        frames = frames + 1
		        totalSamples = totalSamples + sampleCount
		        totalBytes = totalBytes + frameLength
		        If collectGains Then
		          If layer = 3 Then
		            gains.Add(FrameGain(data, pos, isMPEG1, channelCount, hasCRC))
		          Else
		            gains.Add(100)
		          End If
		        End If
		        If frames Mod 2000 = 0 Then
		          If Cancelled Then Return False
		          Progress = 0.1 * pos / endPos
		        End If
		        pos = pos + frameLength
		        inSync = True
		        Continue
		      End If
		    End If

		    inSync = False
		    pos = pos + 1
		  Wend

		  If frames = 0 Or SampleRate = 0 Then
		    ErrorMessage = Localized.Error_NoFrames
		    Return False
		  End If

		  FrameCount = frames
		  DurationSeconds = totalSamples / SampleRate
		  If DurationSeconds > 0 Then BitrateKbps = Round(totalBytes * 8 / DurationSeconds / 1000)
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		BitrateKbps As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Cancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Channels As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		DurationSeconds As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		ErrorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h0
		FrameCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		IsApproximate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		MaxPeaks() As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		MinPeaks() As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Progress As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		SampleRate As Integer
	#tag EndProperty


End Class
#tag EndClass
