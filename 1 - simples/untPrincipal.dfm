object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exerc'#237'cio Simples'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblString: TLabeledEdit
    Left = 32
    Top = 42
    Width = 177
    Height = 21
    EditLabel.Width = 81
    EditLabel.Height = 13
    EditLabel.Caption = 'String par'#226'metro'
    TabOrder = 0
    Text = 'O rato roeu a roupa do rei de roma'
  end
  object lblStringVelha: TLabeledEdit
    Left = 32
    Top = 88
    Width = 177
    Height = 21
    EditLabel.Width = 57
    EditLabel.Height = 13
    EditLabel.Caption = 'String velha'
    TabOrder = 1
    Text = 'ro'
  end
  object lblStringNova: TLabeledEdit
    Left = 32
    Top = 136
    Width = 177
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 13
    EditLabel.Caption = 'String nova'
    TabOrder = 2
    Text = 'teste'
  end
  object Button1: TButton
    Left = 232
    Top = 42
    Width = 185
    Height = 113
    Caption = 'Substituir'
    TabOrder = 3
    OnClick = Button1Click
  end
end
