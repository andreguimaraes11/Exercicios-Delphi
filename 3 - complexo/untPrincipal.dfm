object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Exerc'#237'cio Complexo'
  ClientHeight = 439
  ClientWidth = 706
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cpNetwork: TCardPanel
    Left = 295
    Top = 0
    Width = 411
    Height = 439
    Align = alRight
    ActiveCard = cardNetwork
    Caption = 'cpNetwork'
    TabOrder = 0
    object cardWaiting: TCard
      Left = 1
      Top = 1
      Width = 409
      Height = 437
      Caption = 'cardWaiting'
      CardIndex = 0
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 185
      ExplicitHeight = 41
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 409
        Height = 437
        Align = alClient
        Alignment = taCenter
        Caption = 'Crie uma Network para utilizar.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 247
        ExplicitHeight = 62
      end
    end
    object cardNetwork: TCard
      Left = 1
      Top = 1
      Width = 409
      Height = 437
      Caption = 'cardNetwork'
      CardIndex = 1
      TabOrder = 1
      ExplicitWidth = 416
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 409
        Height = 377
        Align = alTop
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        ExplicitWidth = 416
        object flowElementos: TFlowPanel
          Left = 0
          Top = 0
          Width = 409
          Height = 377
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          ExplicitLeft = 216
          ExplicitTop = 120
          ExplicitWidth = 185
          ExplicitHeight = 41
        end
      end
      object btnVerificarConexao: TButton
        Left = 205
        Top = 377
        Width = 205
        Height = 60
        Align = alLeft
        Caption = 'Verificar Conex'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Segoe UI Semilbold'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnVerificarConexaoClick
        ExplicitLeft = 211
      end
      object btnConectarElementos: TButton
        Left = 0
        Top = 377
        Width = 205
        Height = 60
        Align = alLeft
        Caption = 'Conectar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Segoe UI Semilbold'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnConectarElementosClick
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 295
    Height = 439
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 56
    ExplicitTop = 248
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Label2: TLabel
      Left = 56
      Top = 8
      Width = 136
      Height = 17
      Caption = 'N'#250'mero de Elementos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object btnCriarNetwork: TButton
      Left = 8
      Top = 72
      Width = 265
      Height = 81
      Caption = 'Criar Network'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Segoe UI Semilbold'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCriarNetworkClick
    end
    object edtNumeroElementos: TEdit
      Left = 56
      Top = 25
      Width = 136
      Height = 41
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 2
      NumbersOnly = True
      ParentFont = False
      TabOrder = 1
      Text = '50'
    end
    object memConexoes2: TMemo
      Left = 0
      Top = 299
      Width = 295
      Height = 140
      Align = alBottom
      ReadOnly = True
      TabOrder = 2
      ExplicitTop = 329
    end
    object memConexoes1: TMemo
      Left = 0
      Top = 159
      Width = 295
      Height = 140
      Align = alBottom
      ReadOnly = True
      TabOrder = 3
      ExplicitTop = 219
    end
  end
end
