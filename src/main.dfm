object Form1: TForm1
  Left = 382
  Top = 259
  Width = 578
  Height = 400
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'GunZ Replay Ex(plorer|aminer)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    570
    354)
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 137
    Height = 337
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 16
    Items.Strings = (
      'Properties'
      'Settings'
      'Characters'
      'Statistics'
      'More Statistics'
      'Chat Logs')
    ParentFont = False
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object PageControl1: TPageControl
    Left = 152
    Top = 0
    Width = 409
    Height = 345
    ActivePage = tsProperties
    Anchors = [akLeft, akTop, akRight, akBottom]
    Style = tsButtons
    TabOrder = 1
    object tsProperties: TTabSheet
      Caption = 'tsProperties'
      TabVisible = False
      object Label1: TLabel
        Left = 88
        Top = 96
        Width = 31
        Height = 13
        Caption = 'Label1'
      end
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 44
        Height = 13
        Caption = 'General'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 39
        Top = 32
        Width = 42
        Height = 13
        Alignment = taRightJustify
        Caption = 'Filename'
      end
      object Label10: TLabel
        Left = 47
        Top = 48
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Filesize'
      end
      object Label11: TLabel
        Left = 8
        Top = 72
        Width = 85
        Height = 13
        Caption = 'Replay Specific'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 46
        Top = 96
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Version'
      end
      object Label13: TLabel
        Left = 17
        Top = 112
        Width = 64
        Height = 13
        Alignment = taRightJustify
        Caption = 'Running Time'
      end
      object Label14: TLabel
        Left = 49
        Top = 128
        Width = 32
        Height = 13
        Alignment = taRightJustify
        Caption = 'Owner'
      end
      object Label15: TLabel
        Left = 44
        Top = 144
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'Packets'
      end
      object Label16: TLabel
        Left = 88
        Top = 112
        Width = 37
        Height = 13
        Caption = 'Label16'
      end
      object Label17: TLabel
        Left = 88
        Top = 128
        Width = 37
        Height = 13
        Caption = 'Label17'
      end
      object Label18: TLabel
        Left = 88
        Top = 48
        Width = 37
        Height = 13
        Caption = 'Label18'
      end
      object Label19: TLabel
        Left = 88
        Top = 32
        Width = 37
        Height = 13
        Caption = 'Label19'
      end
      object Label20: TLabel
        Left = 88
        Top = 144
        Width = 37
        Height = 13
        Caption = 'Label20'
      end
      object Label42: TLabel
        Left = 46
        Top = 160
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Players'
      end
      object Label43: TLabel
        Left = 88
        Top = 160
        Width = 37
        Height = 13
        Caption = 'Label43'
      end
    end
    object tsSettings: TTabSheet
      Caption = 'tsSettings'
      ImageIndex = 1
      TabVisible = False
      object Label3: TLabel
        Left = 8
        Top = 8
        Width = 33
        Height = 13
        Caption = 'Stage'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label21: TLabel
        Left = 16
        Top = 32
        Width = 20
        Height = 13
        Caption = 'Map'
      end
      object Label22: TLabel
        Left = 88
        Top = 32
        Width = 37
        Height = 13
        Caption = 'Label22'
      end
      object Label23: TLabel
        Left = 16
        Top = 48
        Width = 49
        Height = 13
        Caption = 'Gametype'
      end
      object Label24: TLabel
        Left = 16
        Top = 96
        Width = 49
        Height = 13
        Caption = 'Level Limit'
      end
      object Label25: TLabel
        Left = 16
        Top = 64
        Width = 36
        Height = 13
        Caption = 'Rounds'
      end
      object Label26: TLabel
        Left = 16
        Top = 80
        Width = 46
        Height = 13
        Caption = 'Time Limit'
      end
      object Label27: TLabel
        Left = 16
        Top = 112
        Width = 54
        Height = 13
        Caption = 'Player Limit'
      end
      object Label28: TLabel
        Left = 16
        Top = 160
        Width = 59
        Height = 13
        Caption = 'Friendly Fire'
      end
      object Label29: TLabel
        Left = 8
        Top = 136
        Width = 79
        Height = 13
        Caption = 'Stage Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label30: TLabel
        Left = 88
        Top = 160
        Width = 37
        Height = 13
        Caption = 'Label30'
      end
      object Label31: TLabel
        Left = 16
        Top = 176
        Width = 43
        Height = 13
        Caption = 'Late Join'
      end
      object Label94: TLabel
        Left = 88
        Top = 48
        Width = 37
        Height = 13
        Caption = 'Label94'
      end
      object Label95: TLabel
        Left = 88
        Top = 64
        Width = 37
        Height = 13
        Caption = 'Label95'
      end
      object Label96: TLabel
        Left = 88
        Top = 80
        Width = 37
        Height = 13
        Caption = 'Label96'
      end
      object Label97: TLabel
        Left = 88
        Top = 96
        Width = 37
        Height = 13
        Caption = 'Label97'
      end
      object Label98: TLabel
        Left = 88
        Top = 112
        Width = 37
        Height = 13
        Caption = 'Label98'
      end
      object Label99: TLabel
        Left = 88
        Top = 176
        Width = 37
        Height = 13
        Caption = 'Label99'
      end
    end
    object tsCharacters: TTabSheet
      Caption = 'tsCharacters'
      ImageIndex = 2
      TabVisible = False
      object Label4: TLabel
        Left = 8
        Top = 16
        Width = 107
        Height = 13
        Caption = 'Player Information'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label32: TLabel
        Left = 16
        Top = 152
        Width = 25
        Height = 13
        Caption = 'Level'
      end
      object Label33: TLabel
        Left = 16
        Top = 72
        Width = 35
        Height = 13
        Caption = 'Gender'
      end
      object Label34: TLabel
        Left = 16
        Top = 88
        Width = 48
        Height = 13
        Caption = 'Character'
      end
      object Label35: TLabel
        Left = 88
        Top = 104
        Width = 64
        Height = 13
        Caption = 'Administrator'
      end
      object Label36: TLabel
        Left = 16
        Top = 104
        Width = 54
        Height = 13
        Caption = 'User Grade'
      end
      object Label59: TLabel
        Left = 16
        Top = 312
        Width = 91
        Height = 13
        Caption = 'Favorite Weapon ?'
      end
      object Label60: TLabel
        Left = 8
        Top = 128
        Width = 85
        Height = 13
        Caption = 'Session Details'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label61: TLabel
        Left = 16
        Top = 168
        Width = 21
        Height = 13
        Caption = 'Clan'
      end
      object Label63: TLabel
        Left = 88
        Top = 280
        Width = 22
        Height = 13
        Caption = '0.23'
      end
      object Label64: TLabel
        Left = 16
        Top = 200
        Width = 53
        Height = 13
        Caption = 'Experience'
      end
      object Label80: TLabel
        Left = 16
        Top = 248
        Width = 40
        Height = 13
        Caption = 'Playtime'
      end
      object Label81: TLabel
        Left = 16
        Top = 264
        Width = 17
        Height = 13
        Caption = 'Kills'
      end
      object Label65: TLabel
        Left = 16
        Top = 216
        Width = 27
        Height = 13
        Caption = 'Items'
      end
      object Label82: TLabel
        Left = 16
        Top = 232
        Width = 29
        Height = 13
        Caption = 'Visible'
      end
      object Label83: TLabel
        Left = 16
        Top = 184
        Width = 53
        Height = 13
        Caption = 'Clan Grade'
      end
      object Label84: TLabel
        Left = 16
        Top = 296
        Width = 34
        Height = 13
        Caption = 'Deaths'
      end
      object Label62: TLabel
        Left = 88
        Top = 88
        Width = 84
        Height = 13
        Caption = 'Axium Gun Knight'
      end
      object Label85: TLabel
        Left = 88
        Top = 216
        Width = 56
        Height = 13
        Caption = '0 / 12 items'
      end
      object Label86: TLabel
        Left = 88
        Top = 264
        Width = 142
        Height = 13
        Caption = 'total, per minute, per round ?'
      end
      object Label87: TLabel
        Left = 88
        Top = 296
        Width = 16
        Height = 13
        Caption = '^^'
      end
      object Label88: TLabel
        Left = 88
        Top = 248
        Width = 40
        Height = 13
        Caption = '46m 30s'
      end
      object Label89: TLabel
        Left = 240
        Top = 152
        Width = 100
        Height = 13
        Caption = 'Average Playtime HP'
      end
      object Label90: TLabel
        Left = 240
        Top = 184
        Width = 87
        Height = 13
        Caption = 'Experience per Kill'
      end
      object Label91: TLabel
        Left = 16
        Top = 280
        Width = 34
        Height = 13
        Caption = 'Kills PM'
      end
      object Label92: TLabel
        Left = 208
        Top = 120
        Width = 164
        Height = 13
        Caption = 'Next level at (experience amount)'
      end
      object Label100: TLabel
        Left = 88
        Top = 72
        Width = 43
        Height = 13
        Caption = 'Label100'
      end
      object Label101: TLabel
        Left = 88
        Top = 168
        Width = 43
        Height = 13
        Caption = 'Label101'
      end
      object Label102: TLabel
        Left = 88
        Top = 152
        Width = 43
        Height = 13
        Caption = 'Label102'
      end
      object Label103: TLabel
        Left = 88
        Top = 200
        Width = 43
        Height = 13
        Caption = 'Label103'
      end
      object Label104: TLabel
        Left = 88
        Top = 184
        Width = 43
        Height = 13
        Caption = 'Label104'
      end
      object Label105: TLabel
        Left = 88
        Top = 232
        Width = 43
        Height = 13
        Caption = 'Label105'
      end
      object ComboBox1: TComboBox
        Left = 72
        Top = 40
        Width = 185
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Text = 'ComboBox1'
      end
    end
    object tsStatistics: TTabSheet
      Caption = 'tsStatistics'
      ImageIndex = 3
      TabVisible = False
      object Label5: TLabel
        Left = 8
        Top = 8
        Width = 61
        Height = 13
        Caption = 'Player Kills'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label37: TLabel
        Left = 16
        Top = 32
        Width = 17
        Height = 13
        Caption = 'Kills'
      end
      object Label38: TLabel
        Left = 16
        Top = 80
        Width = 38
        Height = 13
        Caption = 'Suicides'
      end
      object Label39: TLabel
        Left = 16
        Top = 160
        Width = 27
        Height = 13
        Caption = 'Shots'
      end
      object Label40: TLabel
        Left = 8
        Top = 136
        Width = 83
        Height = 13
        Caption = 'Range Attacks'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label41: TLabel
        Left = 8
        Top = 184
        Width = 81
        Height = 13
        Caption = 'Melee Attacks'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label44: TLabel
        Left = 16
        Top = 208
        Width = 36
        Height = 13
        Caption = 'Slashes'
      end
      object Label45: TLabel
        Left = 16
        Top = 224
        Width = 43
        Height = 13
        Caption = 'Massives'
      end
      object Label46: TLabel
        Left = 16
        Top = 240
        Width = 34
        Height = 13
        Caption = 'Lunges'
      end
      object Label47: TLabel
        Left = 16
        Top = 256
        Width = 21
        Height = 13
        Caption = 'Flips'
      end
      object Label51: TLabel
        Left = 88
        Top = 256
        Width = 37
        Height = 13
        Caption = 'Label51'
      end
      object Label52: TLabel
        Left = 88
        Top = 160
        Width = 37
        Height = 13
        Caption = 'Label52'
      end
      object Label53: TLabel
        Left = 88
        Top = 48
        Width = 37
        Height = 13
        Caption = 'PlayerA'
      end
      object Label54: TLabel
        Left = 88
        Top = 224
        Width = 37
        Height = 13
        Caption = 'Label54'
      end
      object Label55: TLabel
        Left = 88
        Top = 208
        Width = 37
        Height = 13
        Caption = 'Label55'
      end
      object Label56: TLabel
        Left = 88
        Top = 240
        Width = 37
        Height = 13
        Caption = 'Label56'
      end
      object Label57: TLabel
        Left = 88
        Top = 32
        Width = 12
        Height = 13
        Caption = '20'
      end
      object Label68: TLabel
        Left = 16
        Top = 96
        Width = 50
        Height = 13
        Caption = 'Died Least'
      end
      object Label71: TLabel
        Left = 16
        Top = 112
        Width = 47
        Height = 13
        Caption = 'Died Most'
      end
      object Label69: TLabel
        Left = 16
        Top = 48
        Width = 46
        Height = 13
        Caption = 'Best Killer'
      end
      object Label73: TLabel
        Left = 16
        Top = 64
        Width = 54
        Height = 13
        Caption = 'Worst Killer'
      end
      object Label7: TLabel
        Left = 88
        Top = 64
        Width = 36
        Height = 13
        Caption = 'PlayerB'
      end
      object Label70: TLabel
        Left = 88
        Top = 80
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label72: TLabel
        Left = 88
        Top = 96
        Width = 37
        Height = 13
        Caption = 'PlayerA'
      end
      object Label74: TLabel
        Left = 88
        Top = 112
        Width = 36
        Height = 13
        Caption = 'PlayerB'
      end
      object Label75: TLabel
        Left = 136
        Top = 40
        Width = 34
        Height = 13
        Caption = 'Deaths'
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'TabSheet6'
      ImageIndex = 5
      TabVisible = False
      object Label76: TLabel
        Left = 8
        Top = 80
        Width = 71
        Height = 13
        Caption = 'Other Tallies'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label77: TLabel
        Left = 16
        Top = 104
        Width = 90
        Height = 13
        Caption = 'Most used weapon'
      end
      object Label78: TLabel
        Left = 128
        Top = 104
        Width = 37
        Height = 13
        Caption = 'Label78'
      end
      object Label48: TLabel
        Left = 8
        Top = 8
        Width = 67
        Height = 13
        Caption = 'Expressions'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label49: TLabel
        Left = 24
        Top = 32
        Width = 33
        Height = 13
        Caption = 'Taunts'
      end
      object Label58: TLabel
        Left = 24
        Top = 48
        Width = 50
        Height = 13
        Caption = 'Most Used'
      end
      object Label79: TLabel
        Left = 80
        Top = 48
        Width = 29
        Height = 13
        Caption = 'Laugh'
      end
      object Label50: TLabel
        Left = 88
        Top = 32
        Width = 18
        Height = 13
        Caption = '103'
      end
      object Label93: TLabel
        Left = 16
        Top = 120
        Width = 63
        Height = 13
        Caption = 'Chat Bubbles'
      end
    end
    object tsChatLogs: TTabSheet
      Caption = 'tsChatLogs'
      ImageIndex = 4
      TabVisible = False
      object Label6: TLabel
        Left = 8
        Top = 208
        Width = 113
        Height = 13
        Caption = 'Recorded Messages'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label106: TLabel
        Left = 8
        Top = 8
        Width = 94
        Height = 13
        Caption = 'Filter Characters'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label66: TLabel
        Left = 8
        Top = 112
        Width = 71
        Height = 13
        Caption = 'Chat Colours'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RichEdit1: TRichEdit
        Left = 8
        Top = 232
        Width = 289
        Height = 89
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HideScrollBars = False
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Button1: TButton
        Left = 312
        Top = 232
        Width = 83
        Height = 25
        Caption = 'Hi&ghlight'
        TabOrder = 1
        OnClick = Button1Click
      end
      object ListBox4: TListBox
        Left = 8
        Top = 136
        Width = 289
        Height = 57
        Style = lbOwnerDrawFixed
        Columns = 6
        ExtendedSelect = False
        ItemHeight = 16
        TabOrder = 2
        OnClick = ListBox4Click
        OnDrawItem = ListBox4DrawItem
      end
      object CheckListBox1: TCheckListBox
        Left = 8
        Top = 32
        Width = 289
        Height = 65
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 3
      end
      object Button2: TButton
        Left = 312
        Top = 32
        Width = 81
        Height = 25
        Caption = '&All'
        TabOrder = 4
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 312
        Top = 64
        Width = 81
        Height = 25
        Caption = '&None'
        TabOrder = 5
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 312
        Top = 136
        Width = 81
        Height = 25
        Caption = 'Add'
        TabOrder = 6
        OnClick = Button4Click
      end
      object CheckBox1: TCheckBox
        Left = 312
        Top = 264
        Width = 89
        Height = 17
        Caption = 'Keep markers'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'TabSheet7'
      ImageIndex = 6
      TabVisible = False
      object Label8: TLabel
        Left = 8
        Top = 8
        Width = 44
        Height = 13
        Caption = 'General'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 728
  end
  object MainMenu1: TMainMenu
    Left = 688
    Top = 8
    object File1: TMenuItem
      Caption = '&File'
      object GunZReplay1: TMenuItem
        Caption = '&Open GunZ Replay..'
        OnClick = GunZReplay1Click
      end
      object OpenGunZ2Replay1: TMenuItem
        Caption = 'O&pen GunZ 2 Replay..'
        Enabled = False
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        OnClick = Exit1Click
      end
    end
    object Scripts1: TMenuItem
      Caption = '&Scripts'
      object Reload1: TMenuItem
        Caption = '&Reload'
        OnClick = Reload1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object About2: TMenuItem
        Caption = '&About'
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object About1: TMenuItem
        Caption = '&About'
        OnClick = About1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'All Supported Formats|*.GZR;*.REC|GunZ: The Duel Replay (*.GZR)|' +
      '*.GZR|GunZ: The Duel Recording (*.REC)|*.REC'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Open Replay'
    Left = 476
    Top = 6
  end
  object OpenDialog2: TOpenDialog
    Filter = 
      'All Supported Formats|*.replay.command|GunZ 2 Replay Commands (*' +
      '.replay.command)|*.replay.command'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Open Replay'
    Left = 508
    Top = 6
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5
    OnTimer = Timer1Timer
    Left = 540
    Top = 6
  end
end
