#tag Class
Protected Class AudioPlayer
	#tag Method, Flags = &h0
		Sub Destructor()
		  Unload
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Duration() As Double
		  // Length in seconds, or 0 when the platform can't tell.
		  #If TargetMacOS Then
		    Declare Function getDuration Lib "Foundation" Selector "duration" (obj As Ptr) As Double
		    If mPlayer = Nil Then Return 0
		    Return getDuration(mPlayer)
		  #Else
		    Return 0
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLoaded() As Boolean
		  #If TargetMacOS Then
		    Return mPlayer <> Nil
		  #Else
		    Return mSound <> Nil
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPlaying() As Boolean
		  #If TargetMacOS Then
		    Declare Function getIsPlaying Lib "Foundation" Selector "isPlaying" (obj As Ptr) As Boolean
		    If mPlayer = Nil Then Return False
		    Return getIsPlaying(mPlayer)
		  #Else
		    Return mSound <> Nil And mSound.IsPlaying
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Load(f As FolderItem) As Boolean
		  Unload

		  #If TargetMacOS Then
		    // AVAudioPlayer supports pausing and seeking, which Xojo's Sound class doesn't.
		    Declare Function dlopen Lib "/usr/lib/libSystem.B.dylib" (path As CString, mode As Int32) As Ptr
		    Declare Function NSClassFromString Lib "Foundation" (className As CFStringRef) As Ptr
		    Declare Function fileURLWithPath Lib "Foundation" Selector "fileURLWithPath:" (cls As Ptr, path As CFStringRef) As Ptr
		    Declare Function alloc Lib "Foundation" Selector "alloc" (cls As Ptr) As Ptr
		    Declare Function initWithContentsOfURL Lib "Foundation" Selector "initWithContentsOfURL:error:" (obj As Ptr, url As Ptr, ByRef outError As Ptr) As Ptr
		    Declare Function prepareToPlay Lib "Foundation" Selector "prepareToPlay" (obj As Ptr) As Boolean
		    Declare Sub setEnableRate Lib "Foundation" Selector "setEnableRate:" (obj As Ptr, value As Boolean)

		    // AVFoundation isn't necessarily loaded yet; make sure the class exists.
		    Const RTLD_LAZY = 1
		    Call dlopen("/System/Library/Frameworks/AVFoundation.framework/AVFoundation", RTLD_LAZY)
		    Var playerClass As Ptr = NSClassFromString("AVAudioPlayer")
		    If playerClass = Nil Then Return False

		    Var url As Ptr = fileURLWithPath(NSClassFromString("NSURL"), f.NativePath)
		    If url = Nil Then Return False

		    Var errorObject As Ptr
		    mPlayer = initWithContentsOfURL(alloc(playerClass), url, errorObject) // owned (+1), released in Unload
		    If mPlayer = Nil Then Return False
		    setEnableRate(mPlayer, True) // must be set before prepareToPlay
		    Call prepareToPlay(mPlayer)
		    Rate = mRate
		    Return True
		  #Else
		    // Other platforms: Xojo's Sound class plays from the start only.
		    Try
		      mSound = Sound.Open(f)
		    Catch e As RuntimeException
		      mSound = Nil
		    End Try
		    Return mSound <> Nil
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanChangeRate() As Boolean
		  #If TargetMacOS Then
		    Return True
		  #Else
		    Return False
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pause()
		  #If TargetMacOS Then
		    Declare Sub avPause Lib "Foundation" Selector "pause" (obj As Ptr)
		    If mPlayer <> Nil Then avPause(mPlayer)
		  #Else
		    // Sound can't pause; stopping is the closest match.
		    If mSound <> Nil Then mSound.Stop
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Play()
		  #If TargetMacOS Then
		    Declare Function avPlay Lib "Foundation" Selector "play" (obj As Ptr) As Boolean
		    If mPlayer <> Nil Then Call avPlay(mPlayer)
		  #Else
		    If mSound <> Nil Then
		      mSound.Play
		      mStartMicroseconds = System.Microseconds
		    End If
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  // Stops and rewinds to the beginning.
		  #If TargetMacOS Then
		    Declare Sub avStop Lib "Foundation" Selector "stop" (obj As Ptr)
		    If mPlayer <> Nil Then
		      avStop(mPlayer)
		      Position = 0
		    End If
		  #Else
		    If mSound <> Nil Then mSound.Stop
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unload()
		  #If TargetMacOS Then
		    Declare Sub avStop Lib "Foundation" Selector "stop" (obj As Ptr)
		    Declare Sub release Lib "Foundation" Selector "release" (obj As Ptr)
		    If mPlayer <> Nil Then
		      avStop(mPlayer)
		      release(mPlayer)
		      mPlayer = Nil
		    End If
		  #Else
		    If mSound <> Nil Then mSound.Stop
		    mSound = Nil
		  #EndIf
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mPlayer As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRate As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSound As Sound
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartMicroseconds As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Playback position in seconds.
			  #If TargetMacOS Then
			    Declare Function getCurrentTime Lib "Foundation" Selector "currentTime" (obj As Ptr) As Double
			    If mPlayer = Nil Then Return 0
			    Return getCurrentTime(mPlayer)
			  #Else
			    If mSound = Nil Or Not mSound.IsPlaying Then Return 0
			    Return (System.Microseconds - mStartMicroseconds) / 1000000
			  #EndIf
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #If TargetMacOS Then
			    Declare Sub setCurrentTime Lib "Foundation" Selector "setCurrentTime:" (obj As Ptr, seconds As Double)
			    If mPlayer <> Nil Then setCurrentTime(mPlayer, Max(0, value))
			  #Else
			    #Pragma Unused value // Sound can't seek
			  #EndIf
			End Set
		#tag EndSetter
		Position As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Playback speed: 1.0 is normal, 0.5 half speed, 2.0 double speed.
			  // AVAudioPlayer keeps the pitch unchanged.
			  Return mRate
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRate = Max(0.5, Min(2.0, value)) // range supported by AVAudioPlayer
			  #If TargetMacOS Then
			    Declare Sub setRate Lib "Foundation" Selector "setRate:" (obj As Ptr, rate As Single)
			    If mPlayer <> Nil Then setRate(mPlayer, mRate)
			  #EndIf
			End Set
		#tag EndSetter
		Rate As Double
	#tag EndComputedProperty


End Class
#tag EndClass
