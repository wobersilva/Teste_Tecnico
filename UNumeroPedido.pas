unit UNumeroPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFNumeroPedido = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    pnlTop: TPanel;
    lblPainelTop: TLabel;
    edtNumPedido: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtNumPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNumeroPedido: TFNumeroPedido;

implementation

{$R *.dfm}

uses UArquivos, UPrincipal;

procedure TFNumeroPedido.edtNumPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

if Key = VK_RETURN then
   begin

   if Length(Trim(edtNumPedido.Text)) > 0 then //verifica se tem algo digitado
      begin

      if FPrincipal.AcaoPed = 'Imp' then //variavel de controle para ver se o botão apertado foi o de importar ou de cancelar
         begin
         FPrincipal.ImportarPedido(edtNumPedido.Text);
         Close;
         end;

      if FPrincipal.AcaoPed = 'Can' then //variavel de controle para ver se o botão apertado foi o de importar ou de cancelar
         begin

         if Application.MessageBox(pwidechar('Deseja Cancelar o Pedido: '+edtNumPedido.Text),'Pergunta',MB_YESNO+MB_ICONQUESTION) = IDYES then
            begin
            FPrincipal.CancelarPedido(edtNumPedido.text);
            Close;
            end;


         end;



      end
   else
      begin

      Application.MessageBox('Informe um Número de Pedido!','Aviso',MB_OK+MB_ICONEXCLAMATION);
      edtNumPedido.SelectAll;
      Abort;

      end;






   end;



end;

procedure TFNumeroPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin

FNumeroPedido := nil;
Action        := caFree;


end;

procedure TFNumeroPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_ESCAPE then
   close;

end;

end.
