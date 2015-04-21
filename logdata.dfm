object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 458
  ClientWidth = 938
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 938
    Height = 417
    Align = alClient
    TabOrder = 0
  end
  object Panel1: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    ParentColor = False
    Style.Color = clBtnFace
    TabOrder = 1
    Height = 41
    Width = 938
    object Button1: TcxButton
      Left = 40
      Top = 10
      Width = 75
      Height = 25
      Caption = 'excecut'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TcxButton
      Left = 168
      Top = 10
      Width = 75
      Height = 25
      Caption = 'load'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = 'D:\projets\iblogscript\data\TEST1.GDB'
    Params.Strings = (
      'password=masterkey'
      'user_name=sysdba')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    Left = 32
    Top = 104
  end
  object IBlog_tables: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select '
      '    ibe$log_tables.id,'
      '    ibe$log_tables.table_name,'
      '    ibe$log_tables.operation,'
      '    ibe$log_tables.date_time,'
      '    ibe$log_tables.user_name'
      'from ibe$log_tables'
      'order by  ibe$log_tables.date_time  ASC')
    Left = 360
    Top = 24
    object IBlog_tablesID: TLargeintField
      FieldName = 'ID'
      Origin = '"IBE$LOG_TABLES"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object IBlog_tablesTABLE_NAME: TIBStringField
      FieldName = 'TABLE_NAME'
      Origin = '"IBE$LOG_TABLES"."TABLE_NAME"'
      Required = True
      Size = 67
    end
    object IBlog_tablesOPERATION: TIBStringField
      FieldName = 'OPERATION'
      Origin = '"IBE$LOG_TABLES"."OPERATION"'
      Required = True
      Size = 4
    end
    object IBlog_tablesDATE_TIME: TDateTimeField
      FieldName = 'DATE_TIME'
      Origin = '"IBE$LOG_TABLES"."DATE_TIME"'
      Required = True
    end
    object IBlog_tablesUSER_NAME: TIBStringField
      FieldName = 'USER_NAME'
      Origin = '"IBE$LOG_TABLES"."USER_NAME"'
      Required = True
      Size = 268
    end
  end
  object IBlog_fields: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select '
      '    ibe$log_fields.log_tables_id,'
      '    ibe$log_fields.field_name,'
      '    ibe$log_fields.old_value,'
      '    ibe$log_fields.new_value'
      'from ibe$log_fields'
      'where log_tables_id=:AID')
    Left = 416
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AID'
        ParamType = ptUnknown
      end>
    object IBlog_fieldsLOG_TABLES_ID: TLargeintField
      FieldName = 'LOG_TABLES_ID'
      Origin = '"IBE$LOG_FIELDS"."LOG_TABLES_ID"'
      Required = True
    end
    object IBlog_fieldsFIELD_NAME: TIBStringField
      FieldName = 'FIELD_NAME'
      Origin = '"IBE$LOG_FIELDS"."FIELD_NAME"'
      Required = True
      Size = 67
    end
    object IBlog_fieldsOLD_VALUE: TIBStringField
      FieldName = 'OLD_VALUE'
      Origin = '"IBE$LOG_FIELDS"."OLD_VALUE"'
      Size = 255
    end
    object IBlog_fieldsNEW_VALUE: TIBStringField
      FieldName = 'NEW_VALUE'
      Origin = '"IBE$LOG_FIELDS"."NEW_VALUE"'
      Size = 255
    end
  end
  object IBlog_keys: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select '
      '    ibe$log_keys.log_tables_id,'
      '    ibe$log_keys.key_field,'
      '    ibe$log_keys.key_value'
      'from ibe$log_keys'
      'where  ibe$log_keys.log_tables_id=:AID')
    Left = 472
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AID'
        ParamType = ptUnknown
      end>
    object IBlog_keysLOG_TABLES_ID: TLargeintField
      FieldName = 'LOG_TABLES_ID'
      Origin = '"IBE$LOG_KEYS"."LOG_TABLES_ID"'
      Required = True
    end
    object IBlog_keysKEY_FIELD: TIBStringField
      FieldName = 'KEY_FIELD'
      Origin = '"IBE$LOG_KEYS"."KEY_FIELD"'
      Required = True
      Size = 67
    end
    object IBlog_keysKEY_VALUE: TIBStringField
      FieldName = 'KEY_VALUE'
      Origin = '"IBE$LOG_KEYS"."KEY_VALUE"'
      Size = 255
    end
  end
  object IBTransaction1: TIBTransaction
    Left = 112
    Top = 104
  end
  object DataSource1: TDataSource
    DataSet = IBlog_fields
    Left = 624
    Top = 16
  end
  object IBlog_blob_fields: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      ' select '
      '    ibe$log_blob_fields.log_tables_id,'
      '    ibe$log_blob_fields.field_name,'
      '    ibe$log_blob_fields.old_char_value,'
      '    ibe$log_blob_fields.new_char_value,'
      '    ibe$log_blob_fields.old_blob_value,'
      '    ibe$log_blob_fields.new_blob_value'
      'from ibe$log_blob_fields'
      'where    ibe$log_blob_fields.log_tables_id=:AID')
    Left = 536
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AID'
        ParamType = ptUnknown
      end>
    object IBlog_blob_fieldsLOG_TABLES_ID: TLargeintField
      FieldName = 'LOG_TABLES_ID'
      Origin = '"IBE$LOG_BLOB_FIELDS"."LOG_TABLES_ID"'
      Required = True
    end
    object IBlog_blob_fieldsFIELD_NAME: TIBStringField
      FieldName = 'FIELD_NAME'
      Origin = '"IBE$LOG_BLOB_FIELDS"."FIELD_NAME"'
      Required = True
      Size = 67
    end
    object IBlog_blob_fieldsOLD_CHAR_VALUE: TIBStringField
      FieldName = 'OLD_CHAR_VALUE'
      Origin = '"IBE$LOG_BLOB_FIELDS"."OLD_CHAR_VALUE"'
      Size = 10000
    end
    object IBlog_blob_fieldsNEW_CHAR_VALUE: TIBStringField
      FieldName = 'NEW_CHAR_VALUE'
      Origin = '"IBE$LOG_BLOB_FIELDS"."NEW_CHAR_VALUE"'
      Size = 10000
    end
    object IBlog_blob_fieldsOLD_BLOB_VALUE: TBlobField
      FieldName = 'OLD_BLOB_VALUE'
      Origin = '"IBE$LOG_BLOB_FIELDS"."OLD_BLOB_VALUE"'
      ProviderFlags = [pfInUpdate]
      Size = 8
    end
    object IBlog_blob_fieldsNEW_BLOB_VALUE: TBlobField
      FieldName = 'NEW_BLOB_VALUE'
      Origin = '"IBE$LOG_BLOB_FIELDS"."NEW_BLOB_VALUE"'
      ProviderFlags = [pfInUpdate]
      Size = 8
    end
  end
  object IBDatabase2: TIBDatabase
    DatabaseName = 'D:\projets\iblogscript\data\TEST2.GDB'
    Params.Strings = (
      'password=masterkey'
      'user_name=sysdba')
    LoginPrompt = False
    DefaultTransaction = IBTransaction2
    Left = 24
    Top = 200
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = IBDatabase2
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 112
    Top = 200
  end
  object IBScript1: TIBScript
    Database = IBDatabase2
    Transaction = IBTransaction2
    Terminator = ';'
    Left = 248
    Top = 112
  end
end
