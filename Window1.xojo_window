#tag DesktopWindow
Begin DesktopWindow Window1
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   HasTitleBar     =   True
   Height          =   620
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   341610495
   MenuBarVisible  =   False
   MinimumHeight   =   620
   MinimumWidth    =   860
   Resizeable      =   True
   Title           =   "Audio Meta"
   Type            =   0
   Visible         =   True
   Width           =   860
   Begin DesktopButton OpenButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#Localized.Button_OpenMP3"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   130
   End
   Begin DesktopLabel FileLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   162
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_NoFile"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   21
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   678
   End
   Begin DesktopCanvas WaveCanvas
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   180
      Index           =   -2147483648
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   56
      Transparent     =   True
      Visible         =   True
      Width           =   820
   End
   Begin DesktopButton PlayButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#Localized.Button_Play"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   244
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin DesktopButton PauseButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#Localized.Button_Pause"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   116
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   244
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin DesktopButton StopButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#Localized.Button_Stop"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   212
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   244
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin DesktopLabel SpeedLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   306
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_Speed"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   245
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   72
   End
   Begin DesktopPopupMenu SpeedMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   382
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   -1
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#Localized.Tooltip_Speed"
      Top             =   244
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopLabel TimeLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   470
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "0:00 / 0:00"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   245
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin DesktopLabel InfoLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   11.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   576
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   245
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   264
   End
   Begin DesktopLabel TitleLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_Title"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   281
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   130
   End
   Begin DesktopTextField TitleField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   280
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   352
   End
   Begin DesktopLabel ArtistLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_Artist"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   313
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   130
   End
   Begin DesktopTextField ArtistField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   312
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   352
   End
   Begin DesktopLabel AlbumLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_Album"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   345
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   130
   End
   Begin DesktopTextField AlbumField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   344
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   352
   End
   Begin DesktopLabel AlbumArtistLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_AlbumArtist"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   377
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   130
   End
   Begin DesktopTextField AlbumArtistField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   376
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   352
   End
   Begin DesktopLabel ComposerLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_Composer"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   409
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   130
   End
   Begin DesktopTextField ComposerField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   19
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   408
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   352
   End
   Begin DesktopLabel GenreLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   20
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_Genre"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   441
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   130
   End
   Begin DesktopComboBox GenreBox
      AllowAutoComplete=   True
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   -1
      TabIndex        =   21
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   440
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   220
   End
   Begin DesktopLabel YearLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   22
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_Year"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   473
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   130
   End
   Begin DesktopTextField YearField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   "#Localized.Hint_Year"
      Index           =   -2147483648
      Italic          =   False
      Left            =   158
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   23
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   472
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   70
   End
   Begin DesktopLabel TrackLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   232
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   24
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_Track"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   473
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   72
   End
   Begin DesktopTextField TrackField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   "1/12"
      Index           =   -2147483648
      Italic          =   False
      Left            =   308
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   25
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   472
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   60
   End
   Begin DesktopLabel DiscLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   372
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   26
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_Disc"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   473
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   70
   End
   Begin DesktopTextField DiscField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   "1/2"
      Index           =   -2147483648
      Italic          =   False
      Left            =   446
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   27
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   472
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   64
   End
   Begin DesktopLabel CommentLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   28
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_Comment"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   505
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   130
   End
   Begin DesktopTextArea CommentArea
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   64
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   158
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   29
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   504
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   1
      ValidationMask  =   ""
      Visible         =   True
      Width           =   352
   End
   Begin DesktopLabel ArtworkLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   530
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   30
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#Localized.Label_Artwork"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   280
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   200
   End
   Begin DesktopCanvas ArtworkCanvas
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   200
      Index           =   -2147483648
      Left            =   530
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   31
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#Localized.Tooltip_Artwork"
      Top             =   304
      Transparent     =   True
      Visible         =   True
      Width           =   310
   End
   Begin DesktopButton ChooseArtworkButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#Localized.Button_ChooseArtwork"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   530
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   32
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   512
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   110
   End
   Begin DesktopButton RemoveArtworkButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#Localized.Button_RemoveArtwork"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   648
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   33
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   512
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   110
   End
   Begin DesktopButton RevertButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#Localized.Button_Revert"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   570
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   34
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   578
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   110
   End
   Begin DesktopButton SaveButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#Localized.Button_SaveTags"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   690
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   35
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   578
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   150
   End
   Begin Thread WaveformThread
      DebugIdentifier =   ""
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   0
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
      Type            =   1
   End
   Begin Timer PlaybackTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   50
      RunMode         =   0
      Scope           =   0
      TabPanelIndex   =   0
   End
   Begin Timer ProgressTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   100
      RunMode         =   0
      Scope           =   0
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  SaveWindowBounds
		  If mAnalyzer <> Nil Then mAnalyzer.Cancelled = True
		  If mPlayer <> Nil Then mPlayer.Unload
		End Sub
	#tag EndEvent

	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  #Pragma Unused action
		  HandleFileDrop(obj)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RestoreWindowBounds
		  
		  mMP3Type = New FileType
		  mMP3Type.Name = Localized.FileType_MP3
		  mMP3Type.MimeType = "audio/mpeg"
		  mMP3Type.Extensions = "mp3"
		  
		  Self.AcceptFileDrop(mMP3Type)
		  WaveCanvas.AcceptFileDrop(mMP3Type)
		  
		  Var genres() As String = ID3Tag.GenreNames
		  genres.Sort
		  For Each genreName As String In genres
		    GenreBox.AddRow(genreName)
		  Next
		  
		  For Each speed As Double In Array(0.5, 0.75, 1.0, 1.25, 1.5, 2.0)
		    SpeedMenu.AddRow(Format(speed, "0.0#") + "×")
		    SpeedMenu.RowTagAt(SpeedMenu.LastAddedRowIndex) = speed
		  Next
		  SpeedMenu.SelectedRowIndex = 2 // 1.0×
		  
		  InfoLabel.TextColor = Color.DisabledTextColor
		  UpdateControlStates
		  UpdatePlaybackUI
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileOpen() As Boolean Handles FileOpen.Action
		  ChooseAndLoadFile
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSave() As Boolean Handles FileSave.Action
		  SaveTags
		  Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub ChooseAndLoadFile()
		  Var f As FolderItem = FolderItem.ShowOpenFileDialog(mMP3Type)
		  If f <> Nil Then LoadFile(f)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CollectFields()
		  If mTag Is Nil Then Return
		  mTag.Title = TitleField.Text.Trim
		  mTag.Artist = ArtistField.Text.Trim
		  mTag.Album = AlbumField.Text.Trim
		  mTag.AlbumArtist = AlbumArtistField.Text.Trim
		  mTag.Composer = ComposerField.Text.Trim
		  mTag.Genre = GenreBox.Text.Trim
		  mTag.Year = YearField.Text.Trim
		  mTag.Track = TrackField.Text.Trim
		  mTag.Disc = DiscField.Text.Trim
		  mTag.Comment = CommentArea.Text.Trim
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FinishWaveform()
		  // Called on the main thread once WaveformThread has finished.
		  Var analyzer As MP3Waveform = mAnalyzer
		  mAnalyzer = Nil
		  
		  // Another file was opened while this one was still being analyzed.
		  If mQueuedFile <> Nil Then
		    Var nextFile As FolderItem = mQueuedFile
		    mQueuedFile = Nil
		    StartWaveform(nextFile)
		    Return
		  End If
		  
		  If analyzer <> Nil And Not analyzer.Cancelled Then
		    If mAnalyzerSucceeded Then
		      mWaveform = analyzer
		    Else
		      mWaveformError = analyzer.ErrorMessage
		    End If
		  End If
		  
		  UpdateInfo
		  WaveCanvas.Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FormatTime(seconds As Double) As String
		  Var total As Integer = Floor(seconds)
		  Var minutes As Integer = total \ 60
		  Var secs As Integer = total Mod 60
		  Return minutes.ToString + ":" + If(secs < 10, "0", "") + secs.ToString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleFileDrop(obj As DragItem)
		  If obj.FolderItemAvailable And obj.FolderItem <> Nil Then
		    LoadFile(obj.FolderItem)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsVisibleOnAnyScreen(windowLeft As Integer, windowTop As Integer, windowWidth As Integer) As Boolean
		  // True when at least 100 points of the window's top edge are on a screen,
		  // so a window saved on a now-disconnected display isn't restored off screen.
		  For i As Integer = 0 To DesktopDisplay.DisplayCount - 1
		    Var display As DesktopDisplay = DesktopDisplay.DisplayAt(i)
		    Var overlap As Integer = Min(windowLeft + windowWidth, display.AvailableLeft + display.AvailableWidth) - Max(windowLeft, display.AvailableLeft)
		    If overlap >= 100 And windowTop >= display.AvailableTop And windowTop < display.AvailableTop + display.AvailableHeight - 40 Then
		      Return True
		    End If
		  Next
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadFile(f As FolderItem)
		  Var tag As ID3Tag
		  Try
		    tag = ID3Tag.Load(f)
		  Catch e As IOException
		    MessageBox(Localized.Msg_CouldNotRead.Replace("%1", f.Name) + EndOfLine + e.Message)
		    Return
		  End Try
		  
		  mFile = f
		  mTag = tag
		  
		  If mPlayer <> Nil Then mPlayer.Unload
		  mPlayer = New AudioPlayer
		  If mPlayer.Load(f) Then
		    mPlayer.Rate = SelectedSpeed
		  Else
		    mPlayer = Nil
		  End If
		  PlaybackTimer.RunMode = Timer.RunModes.Off
		  UpdatePlaybackUI
		  
		  mWaveform = Nil
		  mWaveformError = ""
		  StartWaveform(f)
		  
		  FileLabel.Text = f.Name
		  Self.Title = Localized.Window_TitleWithFile.Replace("%1", f.Name)
		  PopulateFields
		  UpdateInfo
		  WaveCanvas.Refresh
		  UpdateControlStates
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PlaybackDuration() As Double
		  If mPlayer <> Nil And mPlayer.Duration > 0 Then Return mPlayer.Duration
		  If mWaveform <> Nil Then Return mWaveform.DurationSeconds
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulateFields()
		  If mTag Is Nil Then Return
		  TitleField.Text = mTag.Title
		  ArtistField.Text = mTag.Artist
		  AlbumField.Text = mTag.Album
		  AlbumArtistField.Text = mTag.AlbumArtist
		  ComposerField.Text = mTag.Composer
		  GenreBox.Text = mTag.Genre
		  YearField.Text = mTag.Year
		  TrackField.Text = mTag.Track
		  DiscField.Text = mTag.Disc
		  CommentArea.Text = mTag.Comment
		  
		  mArtwork = Nil
		  If mTag.ArtworkData.Bytes > 0 Then
		    Try
		      mArtwork = Picture.FromData(mTag.ArtworkData)
		    Catch e As RuntimeException
		      mArtwork = Nil
		    End Try
		  End If
		  ArtworkCanvas.Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReloadTags()
		  If mFile Is Nil Then Return
		  Try
		    mTag = ID3Tag.Load(mFile)
		    PopulateFields
		    UpdateInfo
		    UpdateControlStates
		  Catch e As IOException
		    MessageBox(Localized.Msg_CouldNotRead.Replace("%1", mFile.Name) + EndOfLine + e.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RestoreWindowBounds()
		  Var f As FolderItem = SettingsFile
		  If f Is Nil Or Not f.Exists Then Return
		  
		  Try
		    Var input As TextInputStream = TextInputStream.Open(f)
		    Var json As New JSONItem(input.ReadAll)
		    input.Close
		    
		    Var newLeft As Integer = json.Lookup("left", Self.Left)
		    Var newTop As Integer = json.Lookup("top", Self.Top)
		    Var newWidth As Integer = json.Lookup("width", Self.Width)
		    Var newHeight As Integer = json.Lookup("height", Self.Height)
		    newWidth = Max(newWidth, Self.MinimumWidth)
		    newHeight = Max(newHeight, Self.MinimumHeight)
		    
		    If IsVisibleOnAnyScreen(newLeft, newTop, newWidth) Then
		      Self.Width = newWidth
		      Self.Height = newHeight
		      Self.Left = newLeft
		      Self.Top = newTop
		    End If
		  Catch e As IOException
		    // Unreadable settings: keep the default size and position.
		  Catch e As JSONException
		    // Damaged settings: keep the default size and position.
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveTags()
		  If mTag Is Nil Or mFile Is Nil Then Return
		  
		  CollectFields
		  Try
		    mTag.Save(mFile)
		    // Reload so the tag reflects exactly what is on disk now.
		    mFile = New FolderItem(mFile.NativePath, FolderItem.PathModes.Native)
		    mTag = ID3Tag.Load(mFile)
		    PopulateFields
		    UpdateInfo
		    UpdateControlStates
		  Catch e As IOException
		    MessageBox(Localized.Msg_SaveFailed + EndOfLine + e.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveWindowBounds()
		  Var f As FolderItem = SettingsFile
		  If f Is Nil Then Return
		  
		  Var json As New JSONItem
		  json.Value("left") = Self.Left
		  json.Value("top") = Self.Top
		  json.Value("width") = Self.Width
		  json.Value("height") = Self.Height
		  
		  Try
		    Var output As TextOutputStream = TextOutputStream.Create(f)
		    output.Write(json.ToString)
		    output.Close
		  Catch e As IOException
		    // Not being able to save the window position isn't worth bothering the user.
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SeekToX(x As Integer)
		  // Moves playback to the time under x in the waveform.
		  If mPlayer Is Nil Then Return
		  Var plotWidth As Double = WaveCanvas.Width - 2 * kWavePadding
		  If plotWidth <= 0 Then Return
		  Var fraction As Double = Max(0, Min(1, (x - kWavePadding) / plotWidth))
		  mPlayer.Position = fraction * PlaybackDuration
		  UpdatePlaybackUI
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectedSpeed() As Double
		  If SpeedMenu.SelectedRowIndex < 0 Then Return 1.0
		  Return SpeedMenu.RowTagAt(SpeedMenu.SelectedRowIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SettingsFile() As FolderItem
		  // ~/Library/Application Support/Audio Meta/WindowSettings.json on macOS,
		  // the roaming AppData folder on Windows.
		  Try
		    Var folder As FolderItem = SpecialFolder.ApplicationData.Child("Audio Meta")
		    If Not folder.Exists Then folder.CreateFolder
		    Return folder.Child("WindowSettings.json")
		  Catch e As IOException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartPlayback()
		  // Continues from the current position; starts over only at the end.
		  If mPlayer Is Nil Or mPlayer.IsPlaying Then Return
		  If mPlayer.Position >= PlaybackDuration - 0.05 Then mPlayer.Position = 0
		  mPlayer.Play
		  PlaybackTimer.RunMode = Timer.RunModes.Multiple
		  UpdatePlaybackUI
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartWaveform(f As FolderItem)
		  // Decoding runs on WaveformThread so the window stays responsive.
		  If WaveformThread.ThreadState <> Thread.ThreadStates.NotRunning Then
		    // Stop the current analysis; FinishWaveform starts the queued file.
		    mQueuedFile = f
		    If mAnalyzer <> Nil Then mAnalyzer.Cancelled = True
		    Return
		  End If
		  
		  mAnalyzer = New MP3Waveform
		  mAnalyzerFile = f
		  mAnalyzerSucceeded = False
		  WaveformThread.Start
		  ProgressTimer.RunMode = Timer.RunModes.Multiple
		  WaveCanvas.Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateControlStates()
		  Var hasFile As Boolean = mTag <> Nil
		  TitleField.Enabled = hasFile
		  ArtistField.Enabled = hasFile
		  AlbumField.Enabled = hasFile
		  AlbumArtistField.Enabled = hasFile
		  ComposerField.Enabled = hasFile
		  GenreBox.Enabled = hasFile
		  YearField.Enabled = hasFile
		  TrackField.Enabled = hasFile
		  DiscField.Enabled = hasFile
		  CommentArea.Enabled = hasFile
		  ChooseArtworkButton.Enabled = hasFile
		  RemoveArtworkButton.Enabled = hasFile And mArtwork <> Nil
		  RevertButton.Enabled = hasFile
		  SaveButton.Enabled = hasFile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateInfo()
		  Var parts() As String
		  If mWaveform <> Nil Then
		    parts.Add(Format(mWaveform.SampleRate / 1000, "0.0##") + " kHz")
		    parts.Add(If(mWaveform.Channels = 1, Localized.Info_Mono, Localized.Info_Stereo))
		    parts.Add(mWaveform.BitrateKbps.ToString + " kbps")
		  End If
		  If mTag <> Nil Then parts.Add(mTag.Description)
		  If mWaveform <> Nil And mWaveform.IsApproximate Then parts.Add(Localized.Info_Approximate)
		  InfoLabel.Text = String.FromArray(parts, "  ·  ")
		  UpdatePlaybackUI
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePlaybackUI()
		  Var playing As Boolean = mPlayer <> Nil And mPlayer.IsPlaying
		  PlayButton.Enabled = mPlayer <> Nil And Not playing
		  PauseButton.Enabled = playing
		  StopButton.Enabled = mPlayer <> Nil
		  SpeedMenu.Enabled = mPlayer <> Nil And mPlayer.CanChangeRate
		  Var position As Double = If(mPlayer <> Nil, mPlayer.Position, 0)
		  TimeLabel.Text = FormatTime(position) + " / " + FormatTime(PlaybackDuration)
		  WaveCanvas.Refresh(False)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAnalyzer As MP3Waveform
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAnalyzerFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAnalyzerSucceeded As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mArtwork As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHoverX As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMP3Type As FileType
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayer As AudioPlayer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueuedFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTag As ID3Tag
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWaveform As MP3Waveform
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWaveformError As String
	#tag EndProperty


	#tag Constant, Name = kWaveformBuckets, Type = Double, Dynamic = False, Default = \"1200", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kWavePadding, Type = Double, Dynamic = False, Default = \"10", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events OpenButton
	#tag Event
		Sub Pressed()
		  ChooseAndLoadFile
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WaveCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  #Pragma BoundsChecking False
		  
		  Var dark As Boolean = Color.IsDarkMode
		  Var lineColor As Color = If(dark, &c3A3A3C, &cD1D1D6)
		  
		  g.DrawingColor = If(dark, &c1C1C1E, &cF4F4F7)
		  g.FillRoundRectangle(0, 0, g.Width, g.Height, 10, 10)
		  g.DrawingColor = lineColor
		  g.DrawRoundRectangle(0, 0, g.Width, g.Height, 10, 10)
		  
		  Var midY As Double = g.Height / 2
		  
		  If mAnalyzer <> Nil Then
		    // Loading: message plus a small progress bar
		    Var percent As Integer = Round(mAnalyzer.Progress * 100)
		    Var loadingText As String = Localized.Wave_Loading.Replace("%1", percent.ToString)
		    g.DrawingColor = Color.DisabledTextColor
		    g.DrawText(loadingText, (g.Width - g.TextWidth(loadingText)) / 2, midY - 6)
		    Var barWidth As Double = Min(240, g.Width - 40)
		    Var barLeft As Double = (g.Width - barWidth) / 2
		    g.DrawingColor = lineColor
		    g.FillRoundRectangle(barLeft, midY + 4, barWidth, 6, 6, 6)
		    g.DrawingColor = If(dark, &c5AA2FF, &c2F7BF5)
		    g.FillRoundRectangle(barLeft, midY + 4, Max(6, barWidth * mAnalyzer.Progress), 6, 6, 6)
		    Return
		  End If
		  
		  If mWaveform Is Nil Or mWaveform.MaxPeaks.Count = 0 Then
		    Var message As String = Localized.Wave_DropHint
		    If mWaveformError <> "" Then message = Localized.Wave_Error.Replace("%1", mWaveformError)
		    g.DrawingColor = Color.DisabledTextColor
		    g.DrawText(message, (g.Width - g.TextWidth(message)) / 2, midY + g.FontAscent / 2 - 2)
		    Return
		  End If
		  
		  Var plotLeft As Double = kWavePadding
		  Var plotWidth As Double = g.Width - 2 * kWavePadding
		  Var amplitude As Double = midY - kWavePadding
		  
		  g.DrawingColor = lineColor
		  g.DrawLine(plotLeft, midY, plotLeft + plotWidth, midY)
		  
		  // Draw one column per device pixel so the waveform stays crisp on Retina displays.
		  Var scale As Double = Max(1, g.ScaleX)
		  Var columns As Integer = plotWidth * scale
		  Var count As Integer = mWaveform.MaxPeaks.Count
		  Var columnWidth As Double = 1 / scale
		  
		  // Columns left of the playhead are drawn in the played color.
		  Var waveColor As Color = If(dark, &c5AA2FF, &c2F7BF5)
		  Var playedColor As Color = If(dark, &cFFB340, &cF08A00)
		  Var duration As Double = PlaybackDuration
		  Var playedColumns As Integer = -1
		  If mPlayer <> Nil And duration > 0 Then playedColumns = mPlayer.Position / duration * columns
		  
		  g.DrawingColor = waveColor
		  For column As Integer = 0 To columns - 1
		    If column = 0 And playedColumns > 0 Then g.DrawingColor = playedColor
		    If column = playedColumns Then g.DrawingColor = waveColor
		    Var first As Integer = column * count \ columns
		    Var last As Integer = Min(count - 1, Max(first, (column + 1) * count \ columns - 1))
		    Var low As Double = 0
		    Var high As Double = 0
		    For i As Integer = first To last
		      If mWaveform.MinPeaks(i) < low Then low = mWaveform.MinPeaks(i)
		      If mWaveform.MaxPeaks(i) > high Then high = mWaveform.MaxPeaks(i)
		    Next
		    Var yTop As Double = midY - Min(1, high) * amplitude
		    Var yBottom As Double = midY - Max(-1, low) * amplitude
		    g.FillRectangle(plotLeft + column / scale, yTop, columnWidth, Max(columnWidth, yBottom - yTop))
		  Next
		  
		  // Playhead
		  If playedColumns > 0 Then
		    g.DrawingColor = playedColor
		    g.FillRectangle(plotLeft + playedColumns / scale - 1, kWavePadding - 4, 2, g.Height - 2 * kWavePadding + 8)
		  End If
		  
		  // Hover position with time readout
		  If mHoverX >= plotLeft And mHoverX <= plotLeft + plotWidth Then
		    Var seconds As Double = (mHoverX - plotLeft) / plotWidth * duration
		    Var label As String = FormatTime(seconds)
		    g.DrawingColor = If(dark, &cFFFFFF, &c000000)
		    g.DrawLine(mHoverX, kWavePadding, mHoverX, g.Height - kWavePadding)
		    g.FontSize = 11
		    Var labelX As Double = mHoverX + 5
		    If labelX + g.TextWidth(label) > g.Width - kWavePadding Then labelX = mHoverX - 5 - g.TextWidth(label)
		    g.DrawText(label, labelX, kWavePadding + g.FontAscent)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  #Pragma Unused y
		  If mPlayer Is Nil Or mWaveform Is Nil Then Return False
		  SeekToX(x)
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseDrag(x As Integer, y As Integer)
		  #Pragma Unused y
		  mHoverX = x
		  SeekToX(x)
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseMove(x As Integer, y As Integer)
		  #Pragma Unused y
		  mHoverX = x
		  Me.Refresh(False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  mHoverX = -1
		  Me.Refresh(False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  #Pragma Unused action
		  HandleFileDrop(obj)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PlayButton
	#tag Event
		Sub Pressed()
		  StartPlayback
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PauseButton
	#tag Event
		Sub Pressed()
		  If mPlayer Is Nil Then Return
		  mPlayer.Pause
		  UpdatePlaybackUI
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StopButton
	#tag Event
		Sub Pressed()
		  If mPlayer Is Nil Then Return
		  mPlayer.Stop
		  PlaybackTimer.RunMode = Timer.RunModes.Off
		  UpdatePlaybackUI
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SpeedMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  If mPlayer <> Nil Then mPlayer.Rate = SelectedSpeed
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ArtworkCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  Var dark As Boolean = Color.IsDarkMode
		  g.DrawingColor = If(dark, &c1C1C1E, &cF4F4F7)
		  g.FillRoundRectangle(0, 0, g.Width, g.Height, 8, 8)
		  
		  If mArtwork <> Nil And mArtwork.Width > 0 And mArtwork.Height > 0 Then
		    // Aspect fit, smoothly scaled
		    g.AntiAliasMode = Graphics.AntiAliasModes.HighQuality
		    Var factor As Double = Min(g.Width / mArtwork.Width, g.Height / mArtwork.Height)
		    Var w As Double = mArtwork.Width * factor
		    Var h As Double = mArtwork.Height * factor
		    g.DrawPicture(mArtwork, (g.Width - w) / 2, (g.Height - h) / 2, w, h, 0, 0, mArtwork.Width, mArtwork.Height)
		  Else
		    Var message As String = Localized.Artwork_None
		    g.DrawingColor = Color.DisabledTextColor
		    g.DrawText(message, (g.Width - g.TextWidth(message)) / 2, g.Height / 2 + g.FontAscent / 2 - 2)
		  End If
		  
		  g.DrawingColor = If(dark, &c3A3A3C, &cD1D1D6)
		  g.DrawRoundRectangle(0, 0, g.Width, g.Height, 8, 8)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChooseArtworkButton
	#tag Event
		Sub Pressed()
		  If mTag Is Nil Then Return
		  
		  Var imageType As New FileType
		  imageType.Name = Localized.FileType_Image
		  imageType.Extensions = "jpg;jpeg;png"
		  
		  Var f As FolderItem = FolderItem.ShowOpenFileDialog(imageType)
		  If f Is Nil Then Return
		  
		  Try
		    Var bs As BinaryStream = BinaryStream.Open(f, False)
		    Var data As String = bs.Read(bs.Length)
		    bs.Close
		    
		    Var pic As Picture = Picture.FromData(data)
		    If pic Is Nil Then
		      MessageBox(Localized.Msg_NotAnImage.Replace("%1", f.Name))
		      Return
		    End If
		    
		    mTag.SetArtwork(data, If(f.Name.EndsWith(".png"), "image/png", "image/jpeg"))
		    mArtwork = pic
		    ArtworkCanvas.Refresh
		    UpdateControlStates
		  Catch e As IOException
		    MessageBox(Localized.Msg_ImageReadFailed + EndOfLine + e.Message)
		  End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RemoveArtworkButton
	#tag Event
		Sub Pressed()
		  If mTag Is Nil Then Return
		  mTag.SetArtwork("", "")
		  mArtwork = Nil
		  ArtworkCanvas.Refresh
		  UpdateControlStates
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RevertButton
	#tag Event
		Sub Pressed()
		  ReloadTags
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SaveButton
	#tag Event
		Sub Pressed()
		  SaveTags
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WaveformThread
	#tag Event
		Sub Run()
		  // Only touches the analyzer, never the UI.
		  Var analyzer As MP3Waveform = mAnalyzer
		  If analyzer <> Nil Then mAnalyzerSucceeded = analyzer.Load(mAnalyzerFile, kWaveformBuckets)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PlaybackTimer
	#tag Event
		Sub Action()
		  UpdatePlaybackUI
		  If mPlayer Is Nil Or Not mPlayer.IsPlaying Then Me.RunMode = Timer.RunModes.Off
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ProgressTimer
	#tag Event
		Sub Action()
		  If WaveformThread.ThreadState <> Thread.ThreadStates.NotRunning Then
		    WaveCanvas.Refresh(False)
		    Return
		  End If
		  Me.RunMode = Timer.RunModes.Off
		  FinishWaveform
		End Sub
	#tag EndEvent
#tag EndEvents
