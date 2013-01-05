object Form1: TForm1
  Left = 296
  Top = 169
  Width = 578
  Height = 400
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'gzreplayex (working title)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
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
        Left = 16
        Top = 32
        Width = 42
        Height = 13
        Caption = 'Filename'
      end
      object Label10: TLabel
        Left = 16
        Top = 48
        Width = 34
        Height = 13
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
        Left = 16
        Top = 96
        Width = 35
        Height = 13
        Caption = 'Version'
      end
      object Label13: TLabel
        Left = 16
        Top = 112
        Width = 64
        Height = 13
        Caption = 'Running Time'
      end
      object Label14: TLabel
        Left = 16
        Top = 128
        Width = 32
        Height = 13
        Caption = 'Owner'
      end
      object Label15: TLabel
        Left = 16
        Top = 144
        Width = 37
        Height = 13
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
        Left = 16
        Top = 160
        Width = 35
        Height = 13
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
        Left = 80
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
        Left = 80
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
    end
    object tsCharacters: TTabSheet
      Caption = 'tsCharacters'
      ImageIndex = 2
      TabVisible = False
      object Label4: TLabel
        Left = 8
        Top = 48
        Width = 100
        Height = 13
        Caption = 'Basic Information'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label32: TLabel
        Left = 16
        Top = 168
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
        Width = 22
        Height = 13
        Caption = 'User'
      end
      object Label35: TLabel
        Left = 80
        Top = 88
        Width = 64
        Height = 13
        Caption = 'Administrator'
      end
      object Label36: TLabel
        Left = 16
        Top = 104
        Width = 37
        Height = 13
        Caption = 'Label36'
      end
      object Label59: TLabel
        Left = 16
        Top = 216
        Width = 30
        Height = 13
        Caption = 'Speed'
      end
      object Label60: TLabel
        Left = 8
        Top = 144
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
        Top = 200
        Width = 21
        Height = 13
        Caption = 'Clan'
      end
      object Label62: TLabel
        Left = 80
        Top = 72
        Width = 37
        Height = 13
        Caption = 'Label62'
      end
      object Label63: TLabel
        Left = 88
        Top = 216
        Width = 167
        Height = 13
        Caption = '1.3 units/ps (distance on XY plane)'
      end
      object Label64: TLabel
        Left = 16
        Top = 232
        Width = 37
        Height = 13
        Caption = 'Label64'
      end
      object Label65: TLabel
        Left = 16
        Top = 184
        Width = 31
        Height = 13
        Caption = 'Joined'
      end
      object ComboBox1: TComboBox
        Left = 72
        Top = 16
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
        Width = 40
        Height = 13
        Caption = 'Deaths'
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
        Width = 42
        Height = 13
        Caption = '.. by kills'
      end
      object Label38: TLabel
        Left = 16
        Top = 48
        Width = 63
        Height = 13
        Caption = '.. by suicides'
      end
      object Label39: TLabel
        Left = 24
        Top = 96
        Width = 27
        Height = 13
        Caption = 'Shots'
      end
      object Label40: TLabel
        Left = 8
        Top = 72
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
        Top = 120
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
        Left = 24
        Top = 144
        Width = 36
        Height = 13
        Caption = 'Slashes'
      end
      object Label45: TLabel
        Left = 24
        Top = 160
        Width = 43
        Height = 13
        Caption = 'Massives'
      end
      object Label46: TLabel
        Left = 24
        Top = 176
        Width = 34
        Height = 13
        Caption = 'Lunges'
      end
      object Label47: TLabel
        Left = 24
        Top = 192
        Width = 21
        Height = 13
        Caption = 'Flips'
      end
      object Label48: TLabel
        Left = 8
        Top = 216
        Width = 32
        Height = 13
        Caption = 'Other'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label49: TLabel
        Left = 24
        Top = 240
        Width = 33
        Height = 13
        Caption = 'Taunts'
      end
      object Label50: TLabel
        Left = 88
        Top = 240
        Width = 18
        Height = 13
        Caption = '103'
      end
      object Label51: TLabel
        Left = 88
        Top = 192
        Width = 37
        Height = 13
        Caption = 'Label51'
      end
      object Label52: TLabel
        Left = 88
        Top = 96
        Width = 37
        Height = 13
        Caption = 'Label52'
      end
      object Label53: TLabel
        Left = 88
        Top = 48
        Width = 37
        Height = 13
        Caption = 'Label53'
      end
      object Label54: TLabel
        Left = 88
        Top = 160
        Width = 37
        Height = 13
        Caption = 'Label54'
      end
      object Label55: TLabel
        Left = 88
        Top = 144
        Width = 37
        Height = 13
        Caption = 'Label55'
      end
      object Label56: TLabel
        Left = 88
        Top = 176
        Width = 37
        Height = 13
        Caption = 'Label56'
      end
      object Label57: TLabel
        Left = 88
        Top = 32
        Width = 37
        Height = 13
        Caption = 'Label57'
      end
      object Label58: TLabel
        Left = 24
        Top = 256
        Width = 101
        Height = 13
        Caption = 'Popular taunt: Laugh'
      end
    end
    object tsChatLogs: TTabSheet
      Caption = 'tsChatLogs'
      ImageIndex = 4
      TabVisible = False
      object Label6: TLabel
        Left = 8
        Top = 8
        Width = 73
        Height = 13
        Caption = 'All Messages'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label66: TLabel
        Left = 8
        Top = 224
        Width = 113
        Height = 13
        Caption = 'Save chat via the menu'
      end
      object Label67: TLabel
        Left = 8
        Top = 248
        Width = 68
        Height = 13
        Caption = 'Filter by user?'
      end
      object RichEdit1: TRichEdit
        Left = 8
        Top = 32
        Width = 321
        Height = 177
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Lucida Console'
        Font.Style = []
        HideScrollBars = False
        Lines.Strings = (
          'RichEdit1')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'TabSheet6'
      ImageIndex = 5
      TabVisible = False
      object Label7: TLabel
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
  object Button1: TButton
    Left = 48
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object XPManifest1: TXPManifest
    Left = 728
  end
  object MainMenu1: TMainMenu
    Left = 688
    Top = 8
    object File1: TMenuItem
      Caption = '&File'
      object Open1: TMenuItem
        Caption = '&Open'
        object Replay1: TMenuItem
          Caption = '&Replay..'
          OnClick = Replay1Click
        end
        object GunZ2Commands1: TMenuItem
          Caption = 'R&eplay (GunZ2)..'
          OnClick = GunZ2Commands1Click
        end
      end
      object SetHooks1: TMenuItem
        Caption = '&Reload Scripts'
        OnClick = SetHooks1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        OnClick = Exit1Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object About1: TMenuItem
        Caption = '&About'
        OnClick = About1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Plugins1: TMenuItem
        Caption = '&Scripts'
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'All Supported Formats|*.GZR;*.REC|GunZ: The Duel Replay (*.GZR)|' +
      '*.GZR|GunZ: The Duel Recording (*.REC)|*.REC'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Open Replay'
    Left = 340
    Top = 14
  end
  object OpenDialog2: TOpenDialog
    Filter = 
      'All Supported Formats|*.replay.command|GunZ 2 Replay Commands (*' +
      '.replay.command)|*.replay.command'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Open Replay'
    Left = 340
    Top = 38
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5
    OnTimer = Timer1Timer
    Left = 340
    Top = 70
  end
end
