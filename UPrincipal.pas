unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, dxGDIPlusClasses,
  Vcl.StdCtrls, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFPrincipal = class(TForm)
    pnlPrincipal: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Image1: TImage;
    pnlCentral: TPanel;
    Panel2: TPanel;
    lblConexao: TLabel;
    shpConexao: TShape;
    pnl_central_top: TPanel;
    Panel3: TPanel;
    Grid: TDBGrid;
    DS: TDataSource;
    Image2: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Panel4: TPanel;
    Label5: TLabel;
    Label2: TLabel;
    edtCodCliente: TEdit;
    edtCodProduto: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    pnlCliente: TPanel;
    Label8: TLabel;
    edtQtd: TEdit;
    edtValorUni: TEdit;
    Label9: TLabel;
    pnlNomeProduto: TPanel;
    btnIncluir: TBitBtn;
    pnlMsg: TPanel;
    Panel5: TPanel;
    Label10: TLabel;
    pnlTotal: TPanel;
    lblRS: TLabel;
    lblTotalCompra: TLabel;
    Label11: TLabel;
    btnGravar: TBitBtn;
    Panel6: TPanel;
    btnCancelar: TBitBtn;
    btnImportar: TBitBtn;
    MD: TFDMemTable;
    MDcodigo: TStringField;
    MDdescricao_produto: TStringField;
    MDqtd: TFloatField;
    MDvalor_unitario: TFloatField;
    MDvalor_total: TFloatField;
    lblTotalRegistro: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodClienteEnter(Sender: TObject);
    procedure edtCodProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtQtdKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtValorUniKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtValorUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorUniExit(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure GridEnter(Sender: TObject);
    procedure edtCodProdutoEnter(Sender: TObject);
    procedure edtCodClienteChange(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure btnIncluirEnter(Sender: TObject);
    procedure btnIncluirExit(Sender: TObject);
    procedure GridExit(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

  procedure PesquisaCliente;
  procedure InserirProduto;
  procedure Calcular;

  function BuscarProduto(CodigoProduto : string): String;

  public
    { Public declarations }

  codigo_pesquisa : integer;
  nome_pesquisa   : string;
  acao,AcaoPed            : string;
  TotalCompra     : Real;


  function Mascara(edt: String;str:String):string;
  function Arredonda(x : Real): Real;
  function ImportarPedido(Pedido : string): String;
  function CancelarPedido(Pedido : string): String;
  procedure InserirNasTabelas;

  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

uses UArquivos, UPesquisaCliente, UNumeroPedido;


function TFPrincipal.Arredonda(x : Real): Real;
var a : string;
    b : Real;
    c : Real;
begin
try
   a := FormatFloat('0.00000',Frac(x));
   b := x - Frac(x);
except
   result := x;
   Abort;
end;
if (x <> 0) Then
   begin
   if StrToInt(Copy(a,5,3)) >= 500 Then
      c := StrToFloat(Copy(a,1,4)) + 0.01
   else
      c := StrToFloat(Copy(a,1,4));
   result := b + c;
   end
else
   result := 0;
end;



procedure TFPrincipal.btnCancelarClick(Sender: TObject);
begin

AcaoPed := 'Can';

if FNumeroPedido = nil then
   FNumeroPedido := TFNumeroPedido.Create(Application);
FNumeroPedido.Caption := 'Cancelamento de Pedido';
FNumeroPedido.ShowModal;



end;

procedure TFPrincipal.btnGravarClick(Sender: TObject);
begin

//efetuando o pedido.
if MD.RecordCount > 0 then
   InserirNasTabelas;


end;

procedure TFPrincipal.btnImportarClick(Sender: TObject);
begin

AcaoPed := 'Imp';

if FNumeroPedido = nil then
   FNumeroPedido := TFNumeroPedido.Create(Application);
FNumeroPedido.Caption := 'Importação de Pedido';
FNumeroPedido.pnlTop.Color := $000791F5;
FNumeroPedido.ShowModal;



end;

procedure TFPrincipal.btnIncluirClick(Sender: TObject);
begin
InserirProduto;

end;

procedure TFPrincipal.btnIncluirEnter(Sender: TObject);
begin
pnlMsg.Caption := 'Clique para lançar o produto.';
Application.ProcessMessages;

end;

procedure TFPrincipal.btnIncluirExit(Sender: TObject);
begin
pnlMsg.Caption := '';
Application.ProcessMessages;

end;

function TFPrincipal.BuscarProduto(CodigoProduto: string): String;
begin

DM.Select.Close;
DM.Select.SQL.Text := 'select * from tbl_produtos where codigo_produto = :codigo';
DM.Select.Prepare;
DM.Select.ParamByName('codigo').AsString := Trim(CodigoProduto);
DM.Select.Open;


if DM.Select.RecordCount > 0 then
   begin
   pnlNomeProduto.Caption :=  DM.Select.FieldByName('descricao_produto').AsString;
   edtValorUni.Text       :=  DM.Select.FieldByName('preco_venda').AsString;
   end
else
   begin

   Application.MessageBox('Produto não Cadastrado!','Aviso',MB_OK+MB_ICONEXCLAMATION);
   edtCodProduto.SelectAll;
   Abort;

   end;

edtQtd.SetFocus;
btnIncluir.Enabled := true;

end;

procedure TFPrincipal.Calcular;
begin


TotalCompra := 0.00;
md.First;
MD.DisableControls;
while not MD.Eof do
      begin

      TotalCompra := Arredonda(TotalCompra + MDvalor_total.Value);
      MD.Next;

      end;

MD.EnableControls;
//MD.First;
lblTotalCompra.Caption    := FormatFloat('###,##0.00', TotalCompra);
lblTotalRegistro.Caption  := 'Total de Produtos: '+IntToStr(MD.RecordCount);
Application.ProcessMessages;
end;

function TFPrincipal.CancelarPedido(Pedido: string): String;
begin

//verifica se tem o pedido
DM.Select.Close;
DM.Select.SQL.Text := 'select * from tbl_PedidosDadosGerais where numero_pedido = :pedido';
DM.Select.ParamByName('pedido').AsString := Pedido;
DM.Select.Open;

if DM.Select.RecordCount > 0 then
   begin
    try

        dm.Transacao.StartTransaction;
        DM.Delete.Close;
        DM.Delete.SQL.Text := 'delete from tbl_pedidosdadosgerais where numero_pedido = :pedido';
        DM.Delete.ParamByName('pedido').AsString  := Pedido;
        DM.Delete.ExecSQL;
        dm.Transacao.CommitRetaining;

     except on E: Exception do
            begin

            Application.MessageBox(pwidechar('Erro ao Deletar Pedido'#13+ E.Message),'Aviso',MB_OK+MB_ICONERROR);
            Abort;
            end;


    end;
   end
else
   begin

   Application.MessageBox('Pedido inexistente!','Aviso',MB_OK+MB_ICONERROR);
   Abort;

   end;



Application.MessageBox('Pedido Cancelado com Sucesso!','Aviso',MB_OK+MB_ICONEXCLAMATION);
lblTotalRegistro.Caption := 'Total de Produtos: 0';
edtCodCliente.SetFocus;
Application.ProcessMessages







end;

procedure TFPrincipal.edtCodClienteChange(Sender: TObject);
begin

if Length(trim(edtCodCliente.Text)) = 0 then
   begin
   btnImportar.Visible := true;
   pnlCliente.Caption  := '';
   btnCancelar.Visible := true;
   end;



end;

procedure TFPrincipal.edtCodClienteEnter(Sender: TObject);
begin

pnlMsg.Caption := 'Aperte a tecla F5 para consultar os clientes!';
Application.ProcessMessages;


end;

procedure TFPrincipal.edtCodClienteExit(Sender: TObject);
begin

pnlMsg.Caption := '';
Application.ProcessMessages;



end;

procedure TFPrincipal.edtCodClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

btnImportar.Visible := false;
btnCancelar.Visible := false;

if Key = VK_ESCAPE then
   begin
   edtCodCliente.Clear;
   end;

if Key = VK_F5 then //Apertou f5 abrir a pesquisa de clientes
   begin

   if FPesquisaCliente = nil then
      FPesquisaCliente :=  TFPesquisaCliente.Create(Application);
   FPesquisaCliente.ShowModal;

   edtCodCliente.Text := IntToStr(codigo_pesquisa);
   pnlCliente.Caption := nome_pesquisa;

   end;

if Key = VK_RETURN then
   PesquisaCliente;
end;

procedure TFPrincipal.edtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in ['0'..'9',#8]) then
   Abort;

end;

procedure TFPrincipal.edtCodProdutoEnter(Sender: TObject);
begin

if MD.RecordCount = 0 then
   btnGravar.Enabled := false;

pnlMsg.Caption := 'Digite o Código do Produto!';
Application.ProcessMessages;


end;

procedure TFPrincipal.edtCodProdutoExit(Sender: TObject);
begin
pnlMsg.Caption := '';
Application.ProcessMessages;

end;

procedure TFPrincipal.edtCodProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

if Key = VK_RETURN then
   begin

   if Length(trim(edtCodProduto.Text)) > 0 then
      begin
      acao := 'Inc';
      BuscarProduto(edtCodProduto.Text)
      end
   else
      edtQtd.SetFocus;

   end;



end;

procedure TFPrincipal.edtQtdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

if Key = VK_RETURN then
   begin

   edtValorUni.SetFocus;

   end;


end;

procedure TFPrincipal.edtValorUniExit(Sender: TObject);
var valor : real;
begin
edtValorUni.Text:= FormatFloat('###,##0.00', StrtoFloat(edtValorUni.Text));

end;

procedure TFPrincipal.edtValorUniKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

if Key = VK_RETURN then
   begin
   if btnIncluir.Enabled = true then
      btnIncluir.SetFocus
   else
      Grid.SetFocus;
   end;




end;

procedure TFPrincipal.edtValorUniKeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in ['0'..'9',',','.',#8]) then
   Abort;
end;

procedure TFPrincipal.FormActivate(Sender: TObject);
begin
TotalCompra := 0.00;
try
//conexão do banco
if DM.Conexao.Connected = false then
   DM.Conexao.Connected := true;

lblConexao.Caption := 'Conectado';
lblConexao.Font.Color := clGreen;
shpConexao.Brush.Color:= clGreen;
shpConexao.Pen.Color  := clGreen;

except on E: Exception do //se der algum erro de conexão dará a mensagem para o usuário e logo apois fechará o programa
       begin
       lblConexao.Caption := 'Não Conectado';
       lblConexao.Font.Color := $001616FF;
       shpConexao.Brush.Color:= $001616FF;
       shpConexao.Pen.Color  := $001616FF;
       Application.MessageBox(pwidechar('Erro ao acessar o Banco de Dados: '#13+ E.Message),'Aviso',MB_OK+MB_ICONEXCLAMATION);

       Close;
       end;

end;



end;

procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin

FPrincipal := nil;
Action := caFree;


end;

procedure TFPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin


if Key = VK_F12 then
   WindowState := wsMinimized;

if Key = VK_ESCAPE then
   begin

   if Application.MessageBox('Deseja fechar o Sistema?','Pergunta', MB_YESNO+MB_ICONQUESTION) = ID_YES then
     close;

   end;



end;

procedure TFPrincipal.FormShow(Sender: TObject);
begin

Grid.Columns[0].Width := 250;
Grid.Columns[1].Width := 800;
Grid.Columns[2].Width := 60;
Grid.Columns[3].Width := 90;
Grid.Columns[4].Width := 100;
Application.ProcessMessages;


end;

procedure TFPrincipal.GridEnter(Sender: TObject);
begin


if MD.RecordCount > 0 then
   btnGravar.Enabled := true
else
   begin
   btnGravar.Enabled := false;
   edtCodProduto.SetFocus;
   end;


pnlMsg.Caption := 'Aperte a tecla ENTER para editar o produto.';
Application.ProcessMessages;

end;

procedure TFPrincipal.GridExit(Sender: TObject);
begin
pnlMsg.Caption := '';
Application.ProcessMessages;

end;

procedure TFPrincipal.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin


if Key = VK_RETURN then //alterar o produto
   begin
   if MD.RecordCount > 0 then
      begin

      acao := 'Alt';
      edtCodProduto.Text     := MDcodigo.Value;
      edtCodProduto.Enabled  := false;
      pnlNomeProduto.Caption := MDdescricao_produto.Value;
      edtQtd.Text            := MDqtd.Text;
      edtValorUni.Text       := MDvalor_unitario.Text;

      btnIncluir.Enabled := true;
      edtQtd.SetFocus;




      Application.ProcessMessages;
      end;

   end;


if Key = VK_DELETE then
   begin

   if Application.MessageBox('Deseja excluir produto?','Pergunta',MB_YESNO+MB_ICONQUESTION) = ID_YES then
      begin
      MD.Delete;
      Calcular;
      edtCodProduto.SetFocus;
      end;


   end;


end;


function TFPrincipal.ImportarPedido(Pedido: string): String;
begin

//importando da tabela pedidos dados gerais
try
DM.Select.Close;
DM.Select.SQL.Text := 'select a.id_cliente, a.valor_total, b.nome_cliente '+
                      'from tbl_pedidosdadosgerais a, tbl_clientes b where '+
                      '(a.numero_pedido = :pedido) and (a.id_cliente = b.id_cliente)';
DM.Select.ParamByName('pedido').AsString := Trim(Pedido);
DM.Select.Open;

except on E: Exception do
       begin
       Application.MessageBox(pwidechar('Erro ao Consultar Dados Pedido'#13+ E.Message),'Aviso',MB_OK+MB_ICONERROR);
       Abort;
       end;
end;

if DM.Select.RecordCount > 0 then
   begin

   edtCodCliente.Text     := DM.Select.FieldByName('id_cliente').AsString;
   pnlCliente.Caption     := DM.Select.FieldByName('nome_cliente').AsString;
   lblTotalCompra.Caption := DM.Select.FieldByName('valor_total').AsString;


   end
else
   begin

   Application.MessageBox('Pedido não localizado!','Mensagem',MB_OK+MB_ICONEXCLAMATION);
   Abort;


   end;



//importando da tabela Pedidos Produtos
try

DM.Select.Close;
DM.Select.SQL.Text := 'select a.codigo_produto, a.qtd, a.valor_unitario, a.valor_total, b.descricao_produto '+
                      'from tbl_pedidosprodutos a, tbl_produtos b where (a.idNumeroPedido = :pedido) and (a.codigo_produto = b.codigo_produto);';
DM.Select.ParamByName('pedido').AsString := Trim(Pedido);
DM.Select.Open;
DM.Select.FetchAll;
DM.Select.First;
except on E: Exception do
       begin
       Application.MessageBox(pwidechar('Erro ao Consultar Pedido'#13+ E.Message),'Aviso',MB_OK+MB_ICONERROR);
       Abort;
       end;


end;

if DM.Select.RecordCount > 0 then
   begin

   while not DM.Select.Eof do
         begin

         MD.Append;
         MDcodigo.Value                 := DM.Select.FieldByName('codigo_produto').AsString;
         MDdescricao_produto.Value      := DM.Select.FieldByName('descricao_produto').AsString;
         MDqtd.Value                    := DM.Select.FieldByName('qtd').AsFloat;
         MDvalor_unitario.Value         := DM.Select.FieldByName('valor_unitario').AsFloat;
         MDvalor_total.Value            := DM.Select.FieldByName('valor_total').AsFloat;
         MD.Post;


         DM.Select.Next;
         end;


   end
else
   begin

   Application.MessageBox('Pedido não localizado!','Mensagem',MB_OK+MB_ICONEXCLAMATION);
   Abort;


   end;


if MD.RecordCount > 0 then
   btnGravar.Enabled := true;

end;

procedure TFPrincipal.InserirNasTabelas;
var pedido : integer;
begin



//gravando na tabela Dados Gerais
try
DM.Transacao.StartTransaction;
DM.Insert.close;
DM.Insert.SQL.Text := 'insert into tbl_pedidosdadosgerais (data_emissao, id_cliente, valor_total) values '+
                      '(:data_emissao, :id_cliente, :valor_total)';
DM.Insert.ParamByName('data_emissao').AsDate     := now();
DM.Insert.ParamByName('id_cliente').AsInteger    := StrToInt(edtCodCliente.Text);
DM.Insert.ParamByName('valor_total').AsFloat     := StrToFloat(lblTotalCompra.Caption);
DM.Insert.ExecSQL;
DM.Transacao.CommitRetaining;

except on E: Exception do
       begin
       Application.MessageBox(pwidechar('Erro ao inserir os Dados na Tabela Pedidos Dados Gerais'#13+ E.Message),'Aviso',MB_OK+MB_ICONERROR);
       Abort;
       end;
end;

try
//selecionando o número gerado pelo sistema na tabela Pedidos Dados Gerais
DM.Select.Close;
DM.Select.SQL.Text := 'select numero_pedido from tbl_pedidosdadosgerais order by numero_pedido Desc';
DM.Select.Open;

pedido := DM.Select.FieldByName('numero_pedido').AsInteger;

except on E: Exception do
       begin
       Application.MessageBox(pwidechar('Erro ao Consultar Pedido.'#13+ E.Message),'Aviso',MB_OK+MB_ICONERROR);
       Abort;
       end;


end;


try
//gravando na tabela pedidosprodutos
MD.First;
while not MD.Eof do
      begin
      DM.Transacao.StartTransaction;
      DM.Insert.close;
      DM.Insert.SQL.Text := 'insert into tbl_pedidosprodutos'+
                            '(idNumeroPedido, codigo_produto, qtd, valor_unitario,valor_total) values '+
                            '(:idNumeroPedido, :codigo_produto, :qtd, :valor_unitario,:valor_total)';
      DM.Insert.ParamByName('idNumeroPedido').AsInteger     := pedido;
      DM.Insert.ParamByName('codigo_produto').AsString      := MDcodigo.AsString;
      DM.Insert.ParamByName('qtd').AsFloat                  := MDqtd.AsFloat;
      DM.Insert.ParamByName('valor_unitario').AsFloat       := MDvalor_unitario.AsFloat;
      DM.Insert.ParamByName('valor_total').AsFloat          := MDvalor_total.AsFloat;
      DM.Insert.ExecSQL;
      DM.Transacao.CommitRetaining;



      MD.Next;
      end;

except on E: Exception do
       begin
       Application.MessageBox(pwidechar('Erro ao inserir os Dados na Tabela Pedidos Produtos.'#13+ E.Message),'Aviso',MB_OK+MB_ICONERROR);
       Abort;
       end;



end;

Application.MessageBox('Pedido gravado com Sucesso!','Mensagem',MB_OK+MB_ICONEXCLAMATION);
MD.EmptyDataSet;
lblTotalCompra.Caption := '0,00';
pnlCliente.Caption     := '';
edtCodCliente.SetFocus;
edtCodCliente.Clear;
btnGravar.Enabled      := false;
Application.ProcessMessages;



end;

procedure TFPrincipal.InserirProduto;
var Tot : Real;
begin

tot := 0.00;


if acao = 'Inc' then //incluindo o produto
   begin
   MD.Append;
   MDcodigo.Value                       := edtCodProduto.Text;
   MDdescricao_produto.Value            := pnlNomeProduto.Caption;
   MDqtd.Value                          := StrToInt(edtQtd.Text);
   MDvalor_unitario.Value               := StrToFloat(edtValorUni.Text);
   Tot := StrToFloat(edtQtd.Text) * StrToFloat(edtValorUni.Text);
   MDvalor_total.Value := tot;
//   TotalCompra := TotalCompra + Tot;
//   lblTotalCompra.Caption := FormatFloat('###,##0.00', TotalCompra);
   MD.Post;
   end;


if acao = 'Alt' then //alterando o produto
   begin

   //TotalCompra := 0.00;

   MD.Edit;
   MDcodigo.Value                       := edtCodProduto.Text;
   MDdescricao_produto.Value            := pnlNomeProduto.Caption;
   MDqtd.Value                          := StrToInt(edtQtd.Text);
   MDvalor_unitario.Value               := StrToFloat(edtValorUni.Text);
   Tot := StrToFloat(edtQtd.Text) * StrToFloat(edtValorUni.Text);
   MDvalor_total.Value := tot;
//   TotalCompra := StrToFloat(lblTotalCompra.Caption) + Tot ;
//   lblTotalCompra.Caption := FormatFloat('###,##0.00', TotalCompra);
   MD.Post;

   end;


Calcular;
edtCodProduto.Clear;
edtQtd.Text := '1';
edtValorUni.Text := '0,00';
pnlNomeProduto.Caption := '';

edtCodProduto.Enabled := true;
edtCodProduto.SetFocus;


btnGravar.Enabled  := true;
btnIncluir.Enabled := False;
acao := '';
Application.ProcessMessages;


end;

function TFPrincipal.Mascara(edt, str: String): string;
var
  i : integer;
begin
  for i := 1 to Length(edt) do
  begin
     if (str[i] = '9') and not (edt[i] in ['0'..'9']) and (Length(edt)=Length(str)+1) then
        delete(edt,i,1);
     if (str[i] <> '9') and (edt[i] in ['0'..'9']) then
        insert(str[i],edt, i);
  end;
  result := edt;
end;

procedure TFPrincipal.PesquisaCliente;
begin

if Length(trim(edtCodCliente.Text)) > 0 then //fazendo o select para buscar o nome do cliente
   begin

   DM.Select.Close;
   DM.Select.SQL.Text := 'select nome_cliente from tbl_clientes where id_cliente = :id';
   DM.Select.Prepare;
   DM.Select.ParamByName('id').AsInteger := StrToInt(edtCodCliente.Text);
   DM.Select.Open;


   if DM.Select.RecordCount > 0 then
      begin
      pnlCliente.Caption := DM.Select.FieldByName('nome_cliente').AsString;
      edtCodProduto.SetFocus;
      end
   else
      begin
      Application.MessageBox('Código de Cliente inexistente!','Aviso',MB_OK+MB_ICONEXCLAMATION);
      edtCodCliente.SelectAll;
      Abort;
      end;



   end;





end;

end.
