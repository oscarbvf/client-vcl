object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Clientes'
  ClientHeight = 394
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object GridClientes: TStringGrid
    Left = 8
    Top = 8
    Width = 608
    Height = 345
    TabOrder = 0
  end
  object btnLoad: TButton
    Left = 8
    Top = 364
    Width = 75
    Height = 21
    Caption = 'Carregar'
    TabOrder = 1
    OnClick = btnLoadClick
  end
  object btnCreate: TButton
    Left = 89
    Top = 364
    Width = 75
    Height = 21
    Caption = 'Novo'
    TabOrder = 2
    OnClick = btnCreateClick
  end
  object btnEdit: TButton
    Left = 170
    Top = 364
    Width = 75
    Height = 21
    Caption = 'Editar'
    TabOrder = 3
    OnClick = btnEditClick
  end
  object btnDelete: TButton
    Left = 251
    Top = 364
    Width = 75
    Height = 21
    Caption = 'Excluir'
    TabOrder = 4
    OnClick = btnDeleteClick
  end
  object NetHTTPClient1: TNetHTTPClient
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 560
    Top = 16
  end
  object DataSource1: TDataSource
    Left = 560
    Top = 72
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 560
    Top = 136
  end
end
