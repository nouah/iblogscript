unit logdata;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, IBDatabase, StdCtrls, ExtCtrls,
  IBScript, IBSQL, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, Menus, cxButtons,
  cxGroupBox;

type
  TForm1 = class(TForm)
    IBDatabase1: TIBDatabase;
    IBlog_tables: TIBQuery;
    IBlog_fields: TIBQuery;
    IBlog_keys: TIBQuery;
    IBTransaction1: TIBTransaction;
    IBlog_fieldsLOG_TABLES_ID: TLargeintField;
    IBlog_fieldsFIELD_NAME: TIBStringField;
    IBlog_fieldsOLD_VALUE: TIBStringField;
    IBlog_fieldsNEW_VALUE: TIBStringField;
    DataSource1: TDataSource;
    IBlog_blob_fields: TIBQuery;
    IBlog_blob_fieldsLOG_TABLES_ID: TLargeintField;
    IBlog_blob_fieldsFIELD_NAME: TIBStringField;
    IBlog_blob_fieldsOLD_CHAR_VALUE: TIBStringField;
    IBlog_blob_fieldsNEW_CHAR_VALUE: TIBStringField;
    IBlog_blob_fieldsOLD_BLOB_VALUE: TBlobField;
    IBlog_blob_fieldsNEW_BLOB_VALUE: TBlobField;
    IBlog_keysLOG_TABLES_ID: TLargeintField;
    IBlog_keysKEY_FIELD: TIBStringField;
    IBlog_keysKEY_VALUE: TIBStringField;
    IBlog_tablesID: TLargeintField;
    IBlog_tablesTABLE_NAME: TIBStringField;
    IBlog_tablesOPERATION: TIBStringField;
    IBlog_tablesDATE_TIME: TDateTimeField;
    IBlog_tablesUSER_NAME: TIBStringField;
    Memo1: TMemo;
    IBDatabase2: TIBDatabase;
    IBTransaction2: TIBTransaction;
    IBScript1: TIBScript;
    Panel1: TcxGroupBox;
    Button1: TcxButton;
    Button2: TcxButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }

function nullif(VAL:Variant):Variant;
procedure UPDATE(id:Integer);
procedure INSERT(id:Integer);
procedure DELETE(id:Integer);
//function formatfield(field :TIBStringField):string;
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.nullif(VAL:Variant):Variant;
var
aval:Variant;
begin

   if VAL = ''''''  then
result:= 'null'
else
   result:=val;
end;

procedure TForm1.UPDATE(id:Integer);
var
line:string;
begin

IBlog_fields.Close;
IBlog_fields.ParamByName('AID').Value:=IntToStr( id);
IBlog_fields.Open;

line:='UPDATE '+IBlog_tablesTABLE_NAME.Value+' SET ';
IBlog_fields.First;
while not IBlog_fields.Eof  do begin

  line:= line+IBlog_fieldsFIELD_NAME.Value+' =' +nullif(QuotedStr(IBlog_fieldsNEW_VALUE.Value))+ ',' ;
  IBlog_fields.Next;
  end;
  //BLOB FIELD
IBlog_blob_fields.Close;
IBlog_blob_fields.ParamByName('AID').Value:=IntToStr( id);
IBlog_blob_fields.Open;
while not IBlog_blob_fields.Eof  do begin
  line:= line+IBlog_blob_fieldsFIELD_NAME.Value+' ='+nullif(QuotedStr( IBlog_blob_fieldsNEW_BLOB_VALUE.AsString))+ ',';
  IBlog_blob_fields.Next;
  end;


SetLength(line, Length(line) - 1) ;
line:=line+' where ';

IBlog_keys.Close;
IBlog_keys.ParamByName('AID').Value:=id;
IBlog_keys.Open;
 while not IBlog_keys.Eof  do begin
    line:=line +IBlog_keysKEY_FIELD.Value+' ='+nullif(QuotedStr(IBlog_keysKEY_VALUE.Value))+ ' and ';
     IBlog_keys.Next;
     end;
  SetLength(line, Length(line) - 4) ;
  Memo1.Lines.Add(line+';');
end;

procedure TForm1.INSERT(id:Integer);
var
line,line2:string;
begin

IBlog_fields.Close;
IBlog_fields.ParamByName('AID').Value:=IntToStr( id);
IBlog_fields.Open;

line:='INSERT INTO '+IBlog_tablesTABLE_NAME.Value+' ( ';
line2:='VALUES (';
IBlog_fields.First;
while not IBlog_fields.Eof  do begin

  line:= line+IBlog_fieldsFIELD_NAME.Value+',';
  line2:=line2+nullif(QuotedStr(IBlog_fieldsNEW_VALUE.Value))+',';
  IBlog_fields.Next;
  end;

  //BLOB FIELD
IBlog_blob_fields.Close;
IBlog_blob_fields.ParamByName('AID').Value:=IntToStr( id);
IBlog_blob_fields.Open;
while not IBlog_blob_fields.Eof  do begin

  line:= line+IBlog_blob_fieldsFIELD_NAME.Value+',';
  line2:=line2+nullif(QuotedStr(IBlog_blob_fieldsNEW_BLOB_VALUE.AsString))+ ',' ;
  IBlog_blob_fields.Next;
  end;


SetLength(line, Length(line) - 1);
SetLength(line2, Length(line2) - 1);
line:=line+')';
line2:=line2+')';
line:=line+line2;
Memo1.Lines.Add(line+';');
end;


procedure TForm1.Button2Click(Sender: TObject);
begin

IBDatabase2.Connected:=true;


IBScript1.Script.LoadFromFile((ExtractFilePath(Application.ExeName)+'export.sql'));
IBScript1.ExecuteScript;
IBScript1.Transaction.CommitRetaining;
ShowMessage('finish');
end;

procedure TForm1.DELETE(id:Integer);
var
line:string;
BEGIN

IBlog_keys.Close;
IBlog_keys.ParamByName('AID').Value:=IntToStr( id);;
IBlog_keys.Open ;
line:='DELETE FROM '+IBlog_tablesTABLE_NAME.Value+'  where ';

while not IBlog_keys.Eof  do begin
    line:=line +IBlog_keysKEY_FIELD.Value+' ='+QuotedStr(IBlog_keysKEY_VALUE.Value)+ ' and ';
    IBlog_keys.Next;
end;
  SetLength(line, Length(line) - 4) ;
  Memo1.Lines.Add(line+';');
line:='';

END;
procedure TForm1.Button1Click(Sender: TObject);

begin
IBDatabase1.Connected:=true;
Memo1.Clear;
IBlog_tables.Open;
IBlog_tables.First;
while not IBlog_tables.Eof do begin
//update
if  IBlog_tablesOPERATION.Value='U' then BEGIN
    UPDATE(IBlog_tablesID.Value);
    Application.ProcessMessages;
END;

if  IBlog_tablesOPERATION.Value='I' then BEGIN
    INSERT(IBlog_tablesID.Value);
    Application.ProcessMessages;
end;

if  IBlog_tablesOPERATION.Value='D' then BEGIN
    DELETE(IBlog_tablesID.Value);

end;

//fin niveau table
IBlog_tables.Next;
end;
 Memo1.Lines.SaveToFile((ExtractFilePath(Application.ExeName)+'export.sql'));
end;

end.
