#tag Class
Protected Class App
Inherits DesktopApplication
	#tag Event
		Sub Opening()
		  // Quit when the main window is closed (macOS keeps apps running by default).
		  AllowAutoQuit = True
		End Sub
	#tag EndEvent


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = True, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Beenden"
		#Tag Instance, Platform = Any, Language = fr, Definition  = \"Quitter"
		#Tag Instance, Platform = Any, Language = es, Definition  = \"Salir"
		#Tag Instance, Platform = Any, Language = it, Definition  = \"Esci"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


End Class
#tag EndClass
