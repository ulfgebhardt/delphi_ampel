object fAmpel: TfAmpel
  Left = 164
  Top = 133
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  AlphaBlend = True
  AutoScroll = False
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Ampel'
  ClientHeight = 723
  ClientWidth = 1063
  Color = clGrayText
  TransparentColor = True
  TransparentColorValue = clFuchsia
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Streetimg: TImage
    Left = 0
    Top = 0
    Width = 1063
    Height = 723
    Align = alClient
  end
  object FORAmpel: TImage
    Left = 397
    Top = 26
    Width = 21
    Height = 27
    Transparent = True
  end
  object FOGAmpel: TImage
    Left = 397
    Top = 52
    Width = 21
    Height = 27
    Transparent = True
  end
  object FURAmpel: TImage
    Left = 645
    Top = 642
    Width = 21
    Height = 27
    Transparent = True
  end
  object FUGAmpel: TImage
    Left = 645
    Top = 668
    Width = 21
    Height = 27
    Transparent = True
  end
  object ALGAmpel: TImage
    Left = 8
    Top = 680
    Width = 32
    Height = 32
    Stretch = True
    Transparent = True
  end
  object ALYAmpel: TImage
    Left = 44
    Top = 680
    Width = 32
    Height = 32
    Stretch = True
    Transparent = True
  end
  object ALRAmpel: TImage
    Left = 80
    Top = 680
    Width = 32
    Height = 32
    Stretch = True
    Transparent = True
  end
  object ARGAmpel: TImage
    Left = 1024
    Top = 16
    Width = 32
    Height = 32
    Stretch = True
    Transparent = True
  end
  object ARYAmpel: TImage
    Left = 988
    Top = 16
    Width = 32
    Height = 32
    Stretch = True
    Transparent = True
  end
  object ARRAmpel: TImage
    Left = 952
    Top = 16
    Width = 32
    Height = 32
    Stretch = True
    Transparent = True
  end
  object FUKnopf: TButton
    Left = 496
    Top = 656
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Hint = 'Fu'#223'g'#228'nger Knopf dr'#252'cken'
    Caption = 'Fu'#223'g'#228'nger'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Visible = False
    OnClick = FUKnopfClick
  end
  object FOKnopf: TButton
    Left = 496
    Top = 40
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Hint = 'Fu'#223'g'#228'nger Knopf dr'#252'cken'
    Caption = 'Fu'#223'g'#228'nger'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Visible = False
    OnClick = FOKnopfClick
  end
  object tAutoTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tAutoTimerTimer
    Left = 112
    Top = 120
  end
  object AmpelTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = AmpelTimerTimer
    Left = 200
    Top = 112
  end
  object tFussgaengerTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tFussgaengerTimerTimer
    Left = 280
    Top = 136
  end
end
