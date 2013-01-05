object Form3: TForm3
  Left = 448
  Top = 328
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = 'Processing Replay File'
  ClientHeight = 175
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 305
    Height = 129
    Caption = 'Status'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 48
      Width = 273
      Height = 13
      AutoSize = False
    end
    object Label2: TLabel
      Left = 52
      Top = 80
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data Size'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 120
      Top = 80
      Width = 8
      Height = 13
      Caption = '--'
    end
    object Label4: TLabel
      Left = 13
      Top = 96
      Width = 92
      Height = 13
      Alignment = taRightJustify
      Caption = 'Processing Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 120
      Top = 96
      Width = 8
      Height = 13
      Caption = '--'
    end
    object Label8: TLabel
      Left = 16
      Top = 64
      Width = 273
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ProgressBar1: TProgressBar
      Left = 16
      Top = 24
      Width = 273
      Height = 16
      Position = 25
      Smooth = True
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 240
    Top = 144
    Width = 75
    Height = 25
    Caption = '&Close'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 148
    Width = 217
    Height = 17
    Caption = 'Always close when loaded successfully'
    TabOrder = 2
  end
end
