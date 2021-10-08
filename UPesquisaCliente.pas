unit UPesquisaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFPesquisaCliente = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    lblPainelTop: TLabel;
    Panel2: TPanel;
    rgTipo: TRadioGroup;
    Bevel1: TBevel;
    lblPesquisa: TLabel;
    edtPesquisa: TEdit;
    DBGrid1: TDBGrid;
    Panel4: TPanel;
    MD: TFDMemTable;
    DS: TDataSource;
    lblTotal: TLabel;
    MDID: TIntegerField;
    MDnome_cliente: TStringField;
    MDcidade_cliente: TStringField;
    MDuf_cliente: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private

  procedure ListarClientes;
  procedure PesquisaCliente;

  public



  end;

var
  FPesquisaCliente: TFPesquisaCliente;

implementation

{$R *.dfm}

uses UArquivos, UPrincipal;

procedure TFPesquisaCliente.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

if Key = VK_RETURN then
   begin
   FPrincipal.codigo_pesquisa := MDID.Value;
//   FPrincipal.nome_pesquisa   := MDnome_cliente.Value;
   Close;
   end;


end;

procedure TFPesquisaCliente.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

if Key = VK_RETURN then
   begin

   if Length(trim(edtPesquisa.Text)) = 0 then
      DBGrid1.SetFocus
   else
      PesquisaCliente;

   end;

if Key = VK_ESCAPE then
   begin
   close;
   end;

end;

procedure TFPesquisaCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
FPesquisaCliente := nil;
Action           := caFree;
end;

procedure TFPesquisaCliente.FormCreate(Sender: TObject);
begin
ListarClientes;
end;

procedure TFPesquisaCliente.FormShow(Sender: TObject);
begin

DBGrid1.Columns[0].Width := 408;
DBGrid1.Columns[1].Width := 86;
DBGrid1.Columns[2].Width := 33;
Application.ProcessMessages;




end;

procedure TFPesquisaCliente.ListarClientes;
begin
DM.Select.Close;
DM.Select.SQL.Text := 'select * from tbl_clientes order by nome_cliente';
DM.Select.Open;
DM.Select.FetchAll;

if DM.Select.RecordCount > 0 then //tem registro na tabela
   begin

   DM.Select.First;
   MD.EmptyDataSet;

   while not DM.Select.Eof do
         begin

         MD.Append;
         MDnome_cliente.Value    := DM.Select.FieldByName('nome_cliente').AsString;
         MDcidade_cliente.Value  := DM.Select.FieldByName('cidade_cliente').AsString;
         MDuf_cliente.Value      := DM.Select.FieldByName('uf_cliente').AsString;
         MDID.Value              := DM.Select.FieldByName('id_cliente').AsInteger;
         MD.Post;

         DM.Select.Next;
         end;

   lblTotal.Caption := 'Total de Clientes: '+ IntToStr(MD.RecordCount);
   MD.First;
   Application.ProcessMessages;
   end
else
   begin

   Application.MessageBox('Não existem clientes Cadastrados!','Aviso',MB_OK+MB_ICONEXCLAMATION);
   Abort;

   end;

end;

procedure TFPesquisaCliente.PesquisaCliente;
var
sentenca : string;
ordem    : string;
filtro   : string;
pesq_txt : string;
begin

sentenca := 'select * from tbl_clientes where ';

 case rgTipo.ItemIndex of
   0: ordem := 'id';
   1: ordem := 'nome_cliente';
 end;

filtro := '('+ordem+' like :'+ordem+') order by '+ordem;

pesq_txt := Trim(edtPesquisa.Text);

pesq_txt := StringReplace(pesq_txt,'*','%',[rfReplaceAll]);

DM.Select.Close;
DM.Select.SQL.Text := sentenca + filtro;
DM.Select.Prepare;

 case rgTipo.ItemIndex of
   0: DM.Select.ParamByName(ordem).AsString := pesq_txt + '%';
   1: DM.Select.ParamByName(ordem).AsString := pesq_txt + '%';
 end;

DM.Select.Open;
DM.Select.FetchAll;

if DM.Select.RecordCount > 0 then //tem registro na tabela
   begin

   DM.Select.First;
   MD.EmptyDataSet;

   while not DM.Select.Eof do
         begin

         MD.Append;
         MDnome_cliente.Value    := DM.Select.FieldByName('nome_cliente').AsString;
         MDcidade_cliente.Value  := DM.Select.FieldByName('cidade_cliente').AsString;
         MDuf_cliente.Value      := DM.Select.FieldByName('uf_cliente').AsString;
         MDID.Value              := DM.Select.FieldByName('id_cliente').AsInteger;
         MD.Post;

         DM.Select.Next;
         end;

   lblTotal.Caption := 'Total de Clientes: '+ IntToStr(MD.RecordCount);
   MD.First;
   DBGrid1.SetFocus;
   Application.ProcessMessages;
   end
else
   begin

   Application.MessageBox('Não existem clientes Cadastrados!','Aviso',MB_OK+MB_ICONEXCLAMATION);
   Abort;

   end;


end;

end.
