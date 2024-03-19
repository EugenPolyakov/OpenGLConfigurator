object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'fMain'
  ClientHeight = 577
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    720
    577)
  PixelsPerInch = 96
  TextHeight = 13
  object lFilter: TLabel
    Left = 8
    Top = 11
    Width = 28
    Height = 13
    Caption = 'Filter:'
  end
  object lAPI: TLabel
    Left = 8
    Top = 38
    Width = 17
    Height = 13
    Caption = 'API'
  end
  object lProfile: TLabel
    Left = 8
    Top = 65
    Width = 30
    Height = 13
    Caption = 'Profile'
  end
  object lCustomSets: TLabel
    Left = 552
    Top = 100
    Width = 118
    Height = 13
    Caption = 'Custom sets from enums'
  end
  object lExcludedSets: TLabel
    Left = 552
    Top = 245
    Width = 66
    Height = 13
    Caption = 'Excluded sets'
  end
  object bOpen: TButton
    Left = 552
    Top = 514
    Width = 160
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Open'
    TabOrder = 0
    OnClick = bOpenClick
  end
  object chlbList: TCheckListBox
    Left = 8
    Top = 89
    Width = 538
    Height = 481
    AllowGrayed = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 1
  end
  object bSelAll: TButton
    Left = 552
    Top = 421
    Width = 160
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Select All'
    TabOrder = 2
    OnClick = bSelAllClick
  end
  object bUnselAll: TButton
    Left = 552
    Top = 452
    Width = 160
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Unsel All'
    TabOrder = 3
    OnClick = bUnselAllClick
  end
  object bInverse: TButton
    Left = 552
    Top = 483
    Width = 160
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Inverse selections'
    TabOrder = 4
    OnClick = bInverseClick
  end
  object bSave: TButton
    Left = 552
    Top = 545
    Width = 160
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Generate'
    TabOrder = 5
    OnClick = bSaveClick
  end
  object eFilter: TEdit
    Left = 56
    Top = 8
    Width = 490
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
    OnChange = eFilterChange
  end
  object cbAPI: TComboBox
    Left = 56
    Top = 35
    Width = 490
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 7
    OnChange = eFilterChange
  end
  object cbUseEnumeratesAndSets: TCheckBox
    Left = 552
    Top = 8
    Width = 165
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Use enumerates and sets'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object cbProfile: TComboBox
    Left = 56
    Top = 62
    Width = 490
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 9
    OnChange = eFilterChange
  end
  object cbUseDelphiStyleAndTypes: TCheckBox
    Left = 552
    Top = 31
    Width = 165
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Use Delphi style and types'
    Checked = True
    State = cbChecked
    TabOrder = 10
    OnClick = cbUseDelphiStyleAndTypesClick
  end
  object cbCreateDefaultFunctions: TCheckBox
    Left = 568
    Top = 54
    Width = 149
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Create default functions'
    Checked = True
    State = cbChecked
    TabOrder = 11
  end
  object cbAddGetProcAddress: TCheckBox
    Left = 552
    Top = 77
    Width = 165
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Add GetProcAddress'
    Checked = True
    State = cbChecked
    TabOrder = 12
  end
  object mCustomSets: TMemo
    Left = 552
    Top = 119
    Width = 160
    Height = 120
    ScrollBars = ssBoth
    TabOrder = 13
  end
  object mExcludedSets: TMemo
    Left = 552
    Top = 264
    Width = 160
    Height = 120
    Lines.Strings = (
      'Boolean')
    ScrollBars = ssBoth
    TabOrder = 14
  end
  object bGenerateCommand: TButton
    Left = 552
    Top = 390
    Width = 160
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Generate console params'
    TabOrder = 15
    OnClick = bGenerateCommandClick
  end
  object fod: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'XML'
        FileMask = '*.xml'
      end
      item
        DisplayName = 'All'
        FileMask = '*'
      end>
    Options = [fdoFileMustExist]
    Left = 200
    Top = 104
  end
  object fsd: TFileSaveDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 240
    Top = 104
  end
end
