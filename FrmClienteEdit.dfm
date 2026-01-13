object FormClienteEdit: TFormClienteEdit
  Left = 0
  Top = 0
  Caption = 'Cliente'
  ClientHeight = 211
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object lblNome: TLabel
    Left = 18
    Top = 51
    Width = 35
    Height = 15
    Caption = 'Nome'
  end
  object lblTelefone: TLabel
    Left = 17
    Top = 80
    Width = 46
    Height = 15
    Caption = 'Telefone'
  end
  object lblEmail: TLabel
    Left = 19
    Top = 109
    Width = 34
    Height = 15
    Caption = 'E-mail'
  end
  object edtNome: TEdit
    Left = 72
    Top = 48
    Width = 225
    Height = 23
    TabOrder = 0
  end
  object edtTelefone: TEdit
    Left = 72
    Top = 77
    Width = 121
    Height = 23
    TabOrder = 1
    Text = '(nn) nnnn-nnnn'
  end
  object edtEmail: TEdit
    Left = 72
    Top = 106
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object btnOK: TButton
    Left = 72
    Top = 168
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = btnOKClick
  end
  object btnCancelar: TButton
    Left = 176
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = btnCancelarClick
  end
end
