object FNumeroPedido: TFNumeroPedido
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'N'#250'mero do Pedido'
  ClientHeight = 122
  ClientWidth = 304
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 304
    Height = 122
    Align = alClient
    BevelOuter = bvNone
    Color = 14277081
    ParentBackground = False
    TabOrder = 0
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 298
      Height = 116
      Align = alClient
      BevelOuter = bvNone
      Color = 13302524
      ParentBackground = False
      TabOrder = 0
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 298
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        Color = 1447679
        ParentBackground = False
        TabOrder = 0
        object lblPainelTop: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 290
          Height = 25
          Margins.Left = 5
          Margins.Top = 5
          Align = alClient
          Alignment = taCenter
          Caption = 'Informe o N'#250'mero do Pedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -17
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 235
          ExplicitHeight = 23
        end
      end
      object edtNumPedido: TEdit
        Left = 64
        Top = 60
        Width = 153
        Height = 31
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 496117
        Font.Height = -17
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnKeyDown = edtNumPedidoKeyDown
      end
    end
  end
end
