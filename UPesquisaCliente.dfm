object FPesquisaCliente: TFPesquisaCliente
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pesquisa Cliente'
  ClientHeight = 328
  ClientWidth = 569
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 569
    Height = 328
    Align = alClient
    Color = 14277081
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 192
    ExplicitTop = 160
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 44
      Width = 561
      Height = 280
      Align = alClient
      Color = 13302524
      ParentBackground = False
      TabOrder = 1
      ExplicitLeft = 192
      ExplicitTop = 144
      ExplicitWidth = 185
      ExplicitHeight = 41
      object Bevel1: TBevel
        Left = 167
        Top = 15
        Width = 378
        Height = 36
        Shape = bsFrame
      end
      object lblPesquisa: TLabel
        Left = 177
        Top = 24
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Nome:'
        Color = 13302524
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9288
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object rgTipo: TRadioGroup
        Left = 15
        Top = 10
        Width = 146
        Height = 41
        Caption = 'Consultar por:'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9288
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ItemIndex = 1
        Items.Strings = (
          '&C'#243'digo'
          '&Nome')
        ParentFont = False
        TabOrder = 2
      end
      object edtPesquisa: TEdit
        Left = 218
        Top = 21
        Width = 303
        Height = 21
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16512
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 49
        ParentFont = False
        TabOrder = 0
        OnKeyDown = edtPesquisaKeyDown
      end
      object DBGrid1: TDBGrid
        AlignWithMargins = True
        Left = 4
        Top = 57
        Width = 553
        Height = 196
        Align = alBottom
        DataSource = DS
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnKeyDown = DBGrid1KeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'nome_cliente'
            Title.Alignment = taCenter
            Title.Caption = 'Nome do Cliente'
            Width = 408
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cidade_cliente'
            Title.Alignment = taCenter
            Title.Caption = 'Cidade'
            Width = 86
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'uf_cliente'
            Title.Alignment = taCenter
            Title.Caption = 'UF'
            Width = 33
            Visible = True
          end>
      end
      object Panel4: TPanel
        Left = 1
        Top = 256
        Width = 559
        Height = 23
        Align = alBottom
        BevelOuter = bvNone
        Color = 13302524
        ParentBackground = False
        TabOrder = 3
        ExplicitLeft = 2
        ExplicitTop = 259
        object lblTotal: TLabel
          Left = 3
          Top = 3
          Width = 97
          Height = 13
          Caption = 'Total de Clientes: 0'
          Color = 13302524
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9288
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 567
      Height = 40
      Align = alTop
      BevelOuter = bvNone
      Color = 1447679
      ParentBackground = False
      TabOrder = 0
      object lblPainelTop: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 10
        Width = 559
        Height = 27
        Margins.Left = 5
        Margins.Top = 10
        Align = alClient
        Caption = 'Pesquisa de Clientes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -17
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 160
        ExplicitHeight = 23
      end
    end
  end
  object MD: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'nome_cliente'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cidade_cliente'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'uf_cliente'
        DataType = ftString
        Size = 2
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 292
    Top = 156
    object MDID: TIntegerField
      FieldName = 'ID'
    end
    object MDnome_cliente: TStringField
      FieldName = 'nome_cliente'
      Size = 100
    end
    object MDcidade_cliente: TStringField
      FieldName = 'cidade_cliente'
      Size = 50
    end
    object MDuf_cliente: TStringField
      FieldName = 'uf_cliente'
      Size = 2
    end
  end
  object DS: TDataSource
    DataSet = MD
    Left = 332
    Top = 156
  end
end
