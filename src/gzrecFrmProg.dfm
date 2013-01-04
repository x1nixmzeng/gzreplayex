object Form3: TForm3
  Left = 394
  Top = 308
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = 'Processing Replay File'
  ClientHeight = 177
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
      Caption = 'Decompressing replay..'
    end
    object Label2: TLabel
      Left = 52
      Top = 72
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'Read'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 96
      Top = 72
      Width = 8
      Height = 13
      Caption = '--'
    end
    object Label4: TLabel
      Left = 21
      Top = 88
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Remaining'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 96
      Top = 88
      Width = 8
      Height = 13
      Caption = '--'
    end
    object Label6: TLabel
      Left = 21
      Top = 104
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Total Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 96
      Top = 104
      Width = 8
      Height = 13
      Caption = '--'
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
end
