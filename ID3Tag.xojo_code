#tag Class
Protected Class ID3Tag
	#tag Method, Flags = &h21
		Private Sub AddFrame(id As String, flags As Integer, data As String)
		  mFrameIDs.Add(id.DefineEncoding(Encodings.ASCII))
		  mFrameFlags.Add(flags)
		  mFrameData.Add(data.DefineEncoding(Nil))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub AppendEncoded(parts() As String, value As String, encoding As Integer, terminate As Boolean)
		  // Appends a string in the given ID3 text encoding, optionally null-terminated.
		  Select Case encoding
		  Case 0
		    If value.Bytes > 0 Then parts.Add(value.ConvertEncoding(Encodings.ISOLatin1))
		    If terminate Then parts.Add(ChrB(0))
		  Case 1
		    parts.Add(ChrB(&hFF))
		    parts.Add(ChrB(&hFE))
		    If value.Bytes > 0 Then parts.Add(value.ConvertEncoding(Encodings.UTF16LE))
		    If terminate Then
		      parts.Add(ChrB(0))
		      parts.Add(ChrB(0))
		    End If
		  Else
		    If value.Bytes > 0 Then parts.Add(value.ConvertEncoding(Encodings.UTF8))
		    If terminate Then parts.Add(ChrB(0))
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub AppendFrame(parts() As String, id As String, flags As Integer, payload() As String, major As Integer)
		  Var payloadSize As Integer = PartsSize(payload)
		  If payloadSize = 0 Then Return

		  parts.Add(id)
		  parts.Add(SizeBytes(payloadSize, major = 4))
		  parts.Add(ChrB(Bitwise.ShiftRight(flags, 8) And &hFF))
		  parts.Add(ChrB(flags And &hFF))
		  For Each p As String In payload
		    parts.Add(p)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub AppendTextFrame(parts() As String, id As String, value As String, major As Integer)
		  If value.Trim = "" Then Return

		  Var encoding As Integer = TextEncodingFor(value, major)
		  Var payload() As String
		  payload.Add(ChrB(encoding))
		  AppendEncoded(payload, value, encoding, False)
		  AppendFrame(parts, id, 0, payload, major)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ApplyID3v1(v1 As MemoryBlock)
		  // ID3v1 values are only used for fields the ID3v2 tag left empty.
		  mHasID3v1 = True

		  If Title = "" Then Title = V1Text(v1, 3, 30)
		  If Artist = "" Then Artist = V1Text(v1, 33, 30)
		  If Album = "" Then Album = V1Text(v1, 63, 30)
		  If Year = "" Then Year = V1Text(v1, 93, 4)

		  // ID3v1.1: a zero byte at 125 followed by a track number at 126.
		  If v1.UInt8Value(125) = 0 And v1.UInt8Value(126) <> 0 Then
		    If Comment = "" Then Comment = V1Text(v1, 97, 28)
		    If Track = "" Then
		      Var trackNumber As Integer = v1.UInt8Value(126)
		      Track = trackNumber.ToString
		    End If
		  Else
		    If Comment = "" Then Comment = V1Text(v1, 97, 30)
		  End If

		  If Genre = "" Then
		    Var genreIndex As Integer = v1.UInt8Value(127)
		    Var names() As String = GenreNames
		    If genreIndex <= names.LastIndex Then Genre = names(genreIndex)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BuildID3v1() As MemoryBlock
		  Var v1 As New MemoryBlock(128)
		  v1.StringValue(0, 3) = "TAG"
		  PutLatin1(v1, 3, 30, Title)
		  PutLatin1(v1, 33, 30, Artist)
		  PutLatin1(v1, 63, 30, Album)
		  PutLatin1(v1, 93, 4, Year.Left(4))

		  Var trackNumber As Integer = Track.NthField("/", 1).Trim.ToInteger
		  If trackNumber > 0 And trackNumber < 256 Then
		    PutLatin1(v1, 97, 28, Comment)
		    v1.UInt8Value(125) = 0
		    v1.UInt8Value(126) = trackNumber
		  Else
		    PutLatin1(v1, 97, 30, Comment)
		  End If

		  Var names() As String = GenreNames
		  Var genreIndex As Integer = names.IndexOf(Genre)
		  If genreIndex >= 0 And genreIndex < 255 Then
		    v1.UInt8Value(127) = genreIndex
		  Else
		    v1.UInt8Value(127) = 255
		  End If

		  Return v1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ConvertPICToAPIC(data As String) As String
		  // ID3v2.2 PIC: encoding, 3-char image format, type, description, data.
		  // ID3v2.3 APIC: encoding, null-terminated MIME type, type, description, data.
		  If data.Bytes < 5 Then Return data

		  Var format As String = data.MiddleBytes(1, 3).DefineEncoding(Encodings.ASCII).Lowercase
		  Var mime As String = If(format = "png", "image/png", "image/jpeg")

		  Var parts() As String
		  parts.Add(data.LeftBytes(1))
		  parts.Add(mime)
		  parts.Add(ChrB(0))
		  parts.Add(data.MiddleBytes(4, data.Bytes - 4))
		  Return JoinParts(parts, 0).StringValue(0, PartsSize(parts))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub CopyParts(parts() As String, target As MemoryBlock, offset As Integer)
		  Var position As Integer = offset
		  For Each p As String In parts
		    Var length As Integer = p.Bytes
		    If length > 0 Then
		      target.StringValue(position, length) = p
		      position = position + length
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecodeComment(index As Integer, ByRef description As String, ByRef commentText As String) As Boolean
		  // COMM: encoding, 3-byte language, terminated description, text.
		  Var mb As MemoryBlock = FrameContent(index)
		  If mb Is Nil Or mb.Size < 5 Then Return False

		  Var encoding As Integer = mb.UInt8Value(0)
		  Var terminator As Integer = FindTerminator(mb, 4, encoding)
		  If terminator < 0 Then
		    description = ""
		    commentText = DecodeString(mb, 4, mb.Size - 4, encoding)
		  Else
		    description = DecodeString(mb, 4, terminator - 4, encoding)
		    Var textStart As Integer = terminator + TerminatorLength(encoding)
		    commentText = DecodeString(mb, textStart, mb.Size - textStart, encoding)
		  End If
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DecodeFields()
		  Title = TextFrame("TIT2")
		  Artist = TextFrame("TPE1")
		  Album = TextFrame("TALB")
		  AlbumArtist = TextFrame("TPE2")
		  Composer = TextFrame("TCOM")
		  Genre = NormalizeGenre(TextFrame("TCON"))
		  Year = TextFrame("TDRC")
		  If Year = "" Then Year = TextFrame("TYER")
		  Track = TextFrame("TRCK")
		  Disc = TextFrame("TPOS")

		  // Prefer the comment without a description; iTunes stores technical
		  // data in COMM frames with descriptions such as "iTunNORM".
		  mCommentFrameIndex = -1
		  Comment = ""
		  For i As Integer = 0 To mFrameIDs.LastIndex
		    If mFrameIDs(i) <> "COMM" Then Continue
		    Var description, commentText As String
		    If Not DecodeComment(i, description, commentText) Then Continue
		    If description = "" Then
		      mCommentFrameIndex = i
		      Comment = commentText
		      Exit For
		    ElseIf mCommentFrameIndex = -1 And Not description.BeginsWith("iTun") Then
		      mCommentFrameIndex = i
		      Comment = commentText
		    End If
		  Next

		  // Prefer the front cover (picture type 3).
		  mArtworkFrameIndex = -1
		  mArtworkData = ""
		  mArtworkMIME = ""
		  For i As Integer = 0 To mFrameIDs.LastIndex
		    If mFrameIDs(i) <> "APIC" Then Continue
		    Var mime, pictureData As String
		    Var pictureType As Integer
		    If Not DecodePicture(i, mime, pictureType, pictureData) Then Continue
		    If mArtworkFrameIndex = -1 Or pictureType = 3 Then
		      mArtworkFrameIndex = i
		      mArtworkData = pictureData
		      mArtworkMIME = mime
		      If pictureType = 3 Then Exit For
		    End If
		  Next
		  mArtworkChanged = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecodePicture(index As Integer, ByRef mime As String, ByRef pictureType As Integer, ByRef pictureData As String) As Boolean
		  // APIC: encoding, null-terminated MIME type, picture type, terminated description, data.
		  Var mb As MemoryBlock = FrameContent(index)
		  If mb Is Nil Or mb.Size < 4 Then Return False

		  Var encoding As Integer = mb.UInt8Value(0)
		  Var mimeEnd As Integer = FindTerminator(mb, 1, 0)
		  If mimeEnd < 0 Or mimeEnd + 2 >= mb.Size Then Return False

		  mime = If(mimeEnd > 1, mb.StringValue(1, mimeEnd - 1).DefineEncoding(Encodings.ASCII), "image/jpeg")
		  pictureType = mb.UInt8Value(mimeEnd + 1)

		  Var descriptionEnd As Integer = FindTerminator(mb, mimeEnd + 2, encoding)
		  If descriptionEnd < 0 Then Return False
		  Var dataStart As Integer = descriptionEnd + TerminatorLength(encoding)
		  If dataStart >= mb.Size Then Return False

		  pictureData = mb.StringValue(dataStart, mb.Size - dataStart)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DecodeString(mb As MemoryBlock, start As Integer, length As Integer, encoding As Integer) As String
		  If length <= 0 Or start < 0 Or start + length > mb.Size Then Return ""

		  Var s As String
		  Select Case encoding
		  Case 1
		    // UTF-16 with byte order mark
		    If length >= 2 And mb.UInt8Value(start) = &hFE And mb.UInt8Value(start + 1) = &hFF Then
		      s = DecodeString(mb, start + 2, length - 2, 2)
		      Return s
		    ElseIf length >= 2 And mb.UInt8Value(start) = &hFF And mb.UInt8Value(start + 1) = &hFE Then
		      If length = 2 Then Return ""
		      s = mb.StringValue(start + 2, length - 2).DefineEncoding(Encodings.UTF16LE)
		    Else
		      s = mb.StringValue(start, length).DefineEncoding(Encodings.UTF16LE)
		    End If
		  Case 2
		    s = mb.StringValue(start, length).DefineEncoding(Encodings.UTF16BE)
		  Case 3
		    s = mb.StringValue(start, length).DefineEncoding(Encodings.UTF8)
		  Else
		    s = mb.StringValue(start, length).DefineEncoding(Encodings.ISOLatin1)
		  End Select

		  s = s.ConvertEncoding(Encodings.UTF8)

		  // ID3v2.4 separates multiple values with nulls; join them for display.
		  Var values() As String
		  For Each value As String In s.Split(Chr(0))
		    If value.Trim <> "" Then values.Add(value)
		  Next
		  Return String.FromArray(values, "; ")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Description() As String
		  Var result As String
		  If mSourceVersion >= 2 Then
		    result = "ID3v2." + mSourceVersion.ToString
		  Else
		    result = Localized.Info_NoID3v2
		  End If
		  If mHasID3v1 Then result = result + " + ID3v1"
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FindTerminator(mb As MemoryBlock, start As Integer, encoding As Integer) As Integer
		  // Returns the offset of the string terminator, or -1 when there is none.
		  If encoding = 1 Or encoding = 2 Then
		    Var i As Integer = start
		    While i + 1 < mb.Size
		      If mb.UInt8Value(i) = 0 And mb.UInt8Value(i + 1) = 0 Then Return i
		      i = i + 2
		    Wend
		  Else
		    For i As Integer = start To mb.Size - 1
		      If mb.UInt8Value(i) = 0 Then Return i
		    Next
		  End If
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FrameContent(index As Integer) As MemoryBlock
		  // Returns the frame payload with per-frame flags undone, or Nil if it
		  // can't be decoded (compressed or encrypted frames are kept untouched).
		  Var raw As String = mFrameData(index)
		  Var flags As Integer = mFrameFlags(index)

		  If mSourceVersion = 4 Then
		    If (flags And &h000C) <> 0 Then Return Nil
		    Var skip As Integer = 0
		    If (flags And &h0040) <> 0 Then skip = skip + 1 // grouping identity
		    If (flags And &h0001) <> 0 Then skip = skip + 4 // data length indicator
		    If skip >= raw.Bytes Then Return Nil
		    If skip > 0 Then raw = raw.MiddleBytes(skip, raw.Bytes - skip)
		    If (flags And &h0002) <> 0 Then raw = raw.ReplaceAllBytes(ChrB(&hFF) + ChrB(0), ChrB(&hFF))
		  Else
		    If (flags And &h00C0) <> 0 Then Return Nil
		    If (flags And &h0020) <> 0 Then
		      If raw.Bytes <= 1 Then Return Nil
		      raw = raw.MiddleBytes(1, raw.Bytes - 1)
		    End If
		  End If

		  If raw.Bytes = 0 Then Return Nil
		  Var mb As MemoryBlock = raw
		  mb.LittleEndian = False
		  Return mb
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GenreNames() As String()
		  // ID3v1 genre list including the Winamp extensions, in index order.
		  Var list As String = "Blues|Classic Rock|Country|Dance|Disco|Funk|Grunge|Hip-Hop|Jazz|Metal|New Age|Oldies|Other|Pop|R&B|Rap|Reggae|Rock|Techno|Industrial|" + _
		  "Alternative|Ska|Death Metal|Pranks|Soundtrack|Euro-Techno|Ambient|Trip-Hop|Vocal|Jazz+Funk|Fusion|Trance|Classical|Instrumental|Acid|House|" + _
		  "Game|Sound Clip|Gospel|Noise|Alternative Rock|Bass|Soul|Punk|Space|Meditative|Instrumental Pop|Instrumental Rock|Ethnic|Gothic|Darkwave|" + _
		  "Techno-Industrial|Electronic|Pop-Folk|Eurodance|Dream|Southern Rock|Comedy|Cult|Gangsta|Top 40|Christian Rap|Pop/Funk|Jungle|" + _
		  "Native American|Cabaret|New Wave|Psychedelic|Rave|Showtunes|Trailer|Lo-Fi|Tribal|Acid Punk|Acid Jazz|Polka|Retro|Musical|Rock & Roll|" + _
		  "Hard Rock|Folk|Folk-Rock|National Folk|Swing|Fast Fusion|Bebop|Latin|Revival|Celtic|Bluegrass|Avantgarde|Gothic Rock|Progressive Rock|" + _
		  "Psychedelic Rock|Symphonic Rock|Slow Rock|Big Band|Chorus|Easy Listening|Acoustic|Humour|Speech|Chanson|Opera|Chamber Music|Sonata|" + _
		  "Symphony|Booty Bass|Primus|Porn Groove|Satire|Slow Jam|Club|Tango|Samba|Folklore|Ballad|Power Ballad|Rhythmic Soul|Freestyle|Duet|" + _
		  "Punk Rock|Drum Solo|A Cappella|Euro-House|Dance Hall"
		  Return list.Split("|")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function IsManagedFrame(id As String) As Boolean
		  // Frames rewritten from the editable fields on every save.
		  Select Case id
		  Case "TIT2", "TPE1", "TALB", "TPE2", "TCOM", "TCON", "TYER", "TDRC", "TRCK", "TPOS"
		    Return True
		  End Select
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function JoinParts(parts() As String, extraBytes As Integer) As MemoryBlock
		  // Builds binary data from parts without any text encoding conversion.
		  Var mb As New MemoryBlock(PartsSize(parts) + extraBytes)
		  CopyParts(parts, mb, 0)
		  Return mb
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Load(f As FolderItem) As ID3Tag
		  // Raises IOException when the file can't be read.
		  Var tag As New ID3Tag
		  tag.ReadFile(f)
		  Return tag
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function MapV22FrameID(id As String) As String
		  Select Case id
		  Case "TT2"
		    Return "TIT2"
		  Case "TP1"
		    Return "TPE1"
		  Case "TAL"
		    Return "TALB"
		  Case "TP2"
		    Return "TPE2"
		  Case "TCM"
		    Return "TCOM"
		  Case "TCO"
		    Return "TCON"
		  Case "TYE"
		    Return "TYER"
		  Case "TRK"
		    Return "TRCK"
		  Case "TPA"
		    Return "TPOS"
		  Case "COM"
		    Return "COMM"
		  Case "PIC"
		    Return "APIC"
		  End Select
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function NormalizeGenre(value As String) As String
		  // Resolves numeric genres: "(17)", "(17)Rock" (ID3v2.3) and "17" (ID3v2.4).
		  Var genreText As String = value.Trim
		  If genreText = "" Then Return ""

		  If genreText.BeginsWith("(") Then
		    Var closing As Integer = genreText.IndexOf(")")
		    If closing > 1 Then
		      Var refinement As String = genreText.Middle(closing + 1).Trim
		      If refinement <> "" Then Return refinement
		      genreText = genreText.Middle(1, closing - 1)
		    End If
		  End If

		  If IsNumeric(genreText) Then
		    Var genreIndex As Integer = genreText.ToInteger
		    Var names() As String = GenreNames
		    If genreIndex >= 0 And genreIndex <= names.LastIndex Then Return names(genreIndex)
		  End If
		  Return genreText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseTagBody(body As MemoryBlock, major As Integer, flags As Integer)
		  body.LittleEndian = False

		  // ID3v2.2/2.3 unsynchronisation applies to the whole tag.
		  If major <= 3 And (flags And &h80) <> 0 Then
		    Var s As String = body.StringValue(0, body.Size)
		    s = s.ReplaceAllBytes(ChrB(&hFF) + ChrB(0), ChrB(&hFF))
		    body = s
		    body.LittleEndian = False
		  End If

		  Var limit As Integer = body.Size
		  Var pos As Integer = 0

		  Try
		    // Skip the extended header
		    If major >= 3 And (flags And &h40) <> 0 And limit >= 4 Then
		      If major = 3 Then
		        pos = 4 + body.UInt32Value(0)
		      Else
		        pos = SyncSafe(body, 0)
		      End If
		    End If

		    If major = 2 Then
		      While pos + 6 <= limit
		        If body.UInt8Value(pos) = 0 Then Exit While // padding
		        Var id As String = body.StringValue(pos, 3).DefineEncoding(Encodings.ASCII)
		        Var frameSize As Integer = body.UInt8Value(pos + 3) * 65536 + body.UInt8Value(pos + 4) * 256 + body.UInt8Value(pos + 5)
		        pos = pos + 6
		        If frameSize <= 0 Or pos + frameSize > limit Then Exit While
		        Var data As String = body.StringValue(pos, frameSize)
		        pos = pos + frameSize

		        // Convert known ID3v2.2 frames so they can be saved as ID3v2.3.
		        Var newID As String = MapV22FrameID(id)
		        If newID <> "" Then
		          If newID = "APIC" Then data = ConvertPICToAPIC(data)
		          AddFrame(newID, 0, data)
		        End If
		      Wend
		    Else
		      While pos + 10 <= limit
		        If body.UInt8Value(pos) = 0 Then Exit While // padding
		        Var id As String = body.StringValue(pos, 4)
		        Var frameSize As Integer
		        If major = 4 Then
		          frameSize = SyncSafe(body, pos + 4)
		        Else
		          frameSize = body.UInt32Value(pos + 4)
		        End If
		        Var frameFlags As Integer = body.UInt16Value(pos + 8)
		        pos = pos + 10
		        If frameSize < 0 Or pos + frameSize > limit Then Exit While
		        If frameSize > 0 Then AddFrame(id, frameFlags, body.StringValue(pos, frameSize))
		        pos = pos + frameSize
		      Wend
		    End If
		  Catch e As OutOfBoundsException
		    // Malformed tag: keep the frames read so far.
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function PartsSize(parts() As String) As Integer
		  Var total As Integer = 0
		  For Each p As String In parts
		    total = total + p.Bytes
		  Next
		  Return total
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub PutLatin1(mb As MemoryBlock, offset As Integer, length As Integer, value As String)
		  Var s As String = value.ConvertEncoding(Encodings.ISOLatin1)
		  Var count As Integer = Min(s.Bytes, length)
		  If count > 0 Then mb.StringValue(offset, count) = s.LeftBytes(count)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReadFile(f As FolderItem)
		  mSourceVersion = 0
		  mMajorVersion = 3
		  mAudioStart = 0
		  mHasID3v1 = False

		  Var bs As BinaryStream = BinaryStream.Open(f, False)
		  bs.LittleEndian = False

		  Try
		    Var fileLength As Int64 = bs.Length

		    If fileLength >= 10 Then
		      Var header As MemoryBlock = bs.Read(10)
		      header.LittleEndian = False
		      If header.UInt8Value(0) = &h49 And header.UInt8Value(1) = &h44 And header.UInt8Value(2) = &h33 Then // "ID3"
		        Var major As Integer = header.UInt8Value(3)
		        Var flags As Integer = header.UInt8Value(5)
		        Var tagSize As Integer = SyncSafe(header, 6)
		        If major >= 2 And major <= 4 And 10 + tagSize <= fileLength Then
		          mSourceVersion = major
		          mMajorVersion = If(major = 4, 4, 3)
		          mAudioStart = 10 + tagSize
		          If (flags And &h10) <> 0 Then mAudioStart = mAudioStart + 10 // footer
		          If tagSize > 0 Then ParseTagBody(bs.Read(tagSize), major, flags)
		        End If
		      End If
		    End If

		    DecodeFields

		    If fileLength >= mAudioStart + 128 Then
		      bs.Position = fileLength - 128
		      Var v1 As MemoryBlock = bs.Read(128)
		      If v1.UInt8Value(0) = &h54 And v1.UInt8Value(1) = &h41 And v1.UInt8Value(2) = &h47 Then // "TAG"
		        ApplyID3v1(v1)
		      End If
		    End If
		  Finally
		    bs.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save(f As FolderItem)
		  // Writes the tag back to f, keeping all frames this class doesn't edit.
		  // Raises IOException on failure. Load the file again afterwards.
		  Const kPadding = 2048

		  Var major As Integer = mMajorVersion
		  Var frameParts() As String

		  AppendTextFrame(frameParts, "TIT2", Title, major)
		  AppendTextFrame(frameParts, "TPE1", Artist, major)
		  AppendTextFrame(frameParts, "TALB", Album, major)
		  AppendTextFrame(frameParts, "TPE2", AlbumArtist, major)
		  AppendTextFrame(frameParts, "TCOM", Composer, major)
		  AppendTextFrame(frameParts, "TCON", Genre, major)
		  If major = 4 Then
		    AppendTextFrame(frameParts, "TDRC", Year, major)
		  Else
		    AppendTextFrame(frameParts, "TYER", Year.Left(4), major)
		  End If
		  AppendTextFrame(frameParts, "TRCK", Track, major)
		  AppendTextFrame(frameParts, "TPOS", Disc, major)

		  If Comment.Trim <> "" Then
		    Var encoding As Integer = TextEncodingFor(Comment, major)
		    Var payload() As String
		    payload.Add(ChrB(encoding))
		    payload.Add("eng")
		    AppendEncoded(payload, "", encoding, True)
		    AppendEncoded(payload, Comment, encoding, False)
		    AppendFrame(frameParts, "COMM", 0, payload, major)
		  End If

		  If mArtworkChanged And mArtworkData.Bytes > 0 Then
		    Var payload() As String
		    payload.Add(ChrB(0))
		    payload.Add(mArtworkMIME.ConvertEncoding(Encodings.ASCII))
		    payload.Add(ChrB(0))
		    payload.Add(ChrB(3)) // front cover
		    payload.Add(ChrB(0)) // empty description
		    payload.Add(mArtworkData)
		    AppendFrame(frameParts, "APIC", 0, payload, major)
		  End If

		  // Keep every other frame untouched (lyrics, ReplayGain, chapters, ...).
		  For i As Integer = 0 To mFrameIDs.LastIndex
		    Var id As String = mFrameIDs(i)
		    If IsManagedFrame(id) Then Continue
		    If i = mCommentFrameIndex Then Continue
		    If i = mArtworkFrameIndex And mArtworkChanged Then Continue
		    Var payload() As String
		    payload.Add(mFrameData(i))
		    AppendFrame(frameParts, id, mFrameFlags(i), payload, major)
		  Next

		  // Overwrite the old tag in place when the new one fits; otherwise
		  // rewrite the file with some padding for future edits.
		  Var framesSize As Integer = PartsSize(frameParts)
		  Var inPlace As Boolean = mAudioStart > 0 And framesSize + 10 <= mAudioStart
		  Var bodySize As Integer = If(inPlace, mAudioStart - 10, framesSize + kPadding)

		  Var tagParts() As String
		  tagParts.Add("ID3")
		  tagParts.Add(ChrB(major))
		  tagParts.Add(ChrB(0))
		  tagParts.Add(ChrB(0))
		  tagParts.Add(SizeBytes(bodySize, True))
		  For Each p As String In frameParts
		    tagParts.Add(p)
		  Next
		  Var tagBlock As MemoryBlock = JoinParts(tagParts, 10 + bodySize - PartsSize(tagParts))

		  Var target As FolderItem = f
		  If inPlace Then
		    Var bs As BinaryStream = BinaryStream.Open(f, True)
		    Try
		      bs.Position = 0
		      bs.Write(tagBlock)
		    Finally
		      bs.Close
		    End Try
		  Else
		    Var originalName As String = f.Name
		    Var temp As FolderItem = f.Parent.Child(originalName + ".audiometa-tmp")
		    If temp.Exists Then temp.Remove

		    Var source As BinaryStream = BinaryStream.Open(f, False)
		    Var dest As BinaryStream
		    Try
		      dest = BinaryStream.Create(temp, True)
		      dest.Write(tagBlock)
		      source.Position = mAudioStart
		      While Not source.EndOfFile
		        dest.Write(source.Read(1048576))
		      Wend
		    Finally
		      source.Close
		      If dest <> Nil Then dest.Close
		    End Try

		    f.Remove
		    temp.Name = originalName
		    target = temp
		  End If

		  If mHasID3v1 Then
		    Var bs As BinaryStream = BinaryStream.Open(target, True)
		    Try
		      bs.Position = bs.Length - 128
		      bs.Write(BuildID3v1)
		    Finally
		      bs.Close
		    End Try
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetArtwork(data As String, mime As String)
		  // Pass empty strings to remove the artwork.
		  mArtworkData = data.DefineEncoding(Nil)
		  mArtworkMIME = mime
		  mArtworkChanged = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function SizeBytes(value As Integer, syncSafe As Boolean) As String
		  Var mb As New MemoryBlock(4)
		  mb.LittleEndian = False
		  If syncSafe Then
		    mb.UInt8Value(0) = Bitwise.ShiftRight(value, 21) And &h7F
		    mb.UInt8Value(1) = Bitwise.ShiftRight(value, 14) And &h7F
		    mb.UInt8Value(2) = Bitwise.ShiftRight(value, 7) And &h7F
		    mb.UInt8Value(3) = value And &h7F
		  Else
		    mb.UInt32Value(0) = value
		  End If
		  Return mb.StringValue(0, 4)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function SyncSafe(mb As MemoryBlock, offset As Integer) As Integer
		  Return (mb.UInt8Value(offset) And &h7F) * 2097152 + _
		  (mb.UInt8Value(offset + 1) And &h7F) * 16384 + _
		  (mb.UInt8Value(offset + 2) And &h7F) * 128 + _
		  (mb.UInt8Value(offset + 3) And &h7F)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function TerminatorLength(encoding As Integer) As Integer
		  Return If(encoding = 1 Or encoding = 2, 2, 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function TextEncodingFor(value As String, major As Integer) As Integer
		  // Plain ASCII as ISO-8859-1, otherwise UTF-8 (v2.4) or UTF-16 (v2.3).
		  If value.Bytes = value.Length Then Return 0
		  Return If(major = 4, 3, 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TextFrame(id As String) As String
		  For i As Integer = 0 To mFrameIDs.LastIndex
		    If mFrameIDs(i) <> id Then Continue
		    Var mb As MemoryBlock = FrameContent(i)
		    If mb Is Nil Or mb.Size < 2 Then Continue
		    Return DecodeString(mb, 1, mb.Size - 1, mb.UInt8Value(0))
		  Next
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function V1Text(mb As MemoryBlock, offset As Integer, length As Integer) As String
		  Var count As Integer = 0
		  While count < length And mb.UInt8Value(offset + count) <> 0
		    count = count + 1
		  Wend
		  If count = 0 Then Return ""
		  Return mb.StringValue(offset, count).DefineEncoding(Encodings.ISOLatin1).ConvertEncoding(Encodings.UTF8).Trim
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Album As String
	#tag EndProperty

	#tag Property, Flags = &h0
		AlbumArtist As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Artist As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mArtworkData
			End Get
		#tag EndGetter
		ArtworkData As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mArtworkMIME
			End Get
		#tag EndGetter
		ArtworkMIME As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Comment As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Composer As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Disc As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Genre As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mArtworkChanged As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mArtworkData As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mArtworkFrameIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mArtworkMIME As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAudioStart As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCommentFrameIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFrameData() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFrameFlags() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFrameIDs() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasID3v1 As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMajorVersion As Integer = 3
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSourceVersion As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Title As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Track As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Year As String
	#tag EndProperty


End Class
#tag EndClass
