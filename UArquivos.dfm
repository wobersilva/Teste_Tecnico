object DM: TDM
  OldCreateOrder = False
  Height = 270
  Width = 346
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=db_teste'
      'User_Name=root'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    Transaction = Transacao
    Left = 120
    Top = 72
  end
  object Select: TFDQuery
    Connection = Conexao
    Left = 192
    Top = 72
  end
  object Insert: TFDQuery
    Connection = Conexao
    Left = 232
    Top = 72
  end
  object Update: TFDQuery
    Connection = Conexao
    Left = 272
    Top = 72
  end
  object Delete: TFDQuery
    Connection = Conexao
    Left = 192
    Top = 32
  end
  object Transacao: TFDTransaction
    Connection = Conexao
    Left = 144
    Top = 136
  end
end
