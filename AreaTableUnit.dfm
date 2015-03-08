object AreaTableForm: TAreaTableForm
  Left = 288
  Top = 245
  BorderStyle = bsDialog
  Caption = 'AreaTable'
  ClientHeight = 453
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 643
    Height = 412
    ActivePage = tsSearch
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 480
    object tsSearch: TTabSheet
      Caption = 'Search'
      ExplicitWidth = 472
      object pnSearch: TPanel
        Left = 0
        Top = 0
        Width = 635
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 472
        object edSearchMask: TLabeledEdit
          Left = 0
          Top = 14
          Width = 305
          Height = 21
          EditLabel.Width = 62
          EditLabel.Height = 13
          EditLabel.Caption = 'Search mask'
          TabOrder = 0
          OnChange = edSearchMaskChange
        end
      end
      object lvList: TListView
        Left = 0
        Top = 41
        Width = 635
        Height = 343
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'ID'
            Width = 40
          end
          item
            Caption = 'Map'
            Width = 190
          end
          item
            Caption = 'Parent Zone'
            Width = 190
          end
          item
            Caption = 'Zone'
            Width = 190
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '@Arial Unicode MS'
        Font.Style = []
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        SortType = stData
        TabOrder = 1
        ViewStyle = vsReport
        OnChange = lvListChange
        OnColumnClick = lvListColumnClick
        OnDblClick = lvListDblClick
        ExplicitWidth = 472
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 412
    Width = 643
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 480
    DesignSize = (
      643
      41)
    object btOK: TButton
      Left = 480
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Enabled = False
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 317
    end
    object btCancel: TButton
      Left = 563
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 400
    end
  end
end
