program SistemaVendas;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {FPrincipal},
  UArquivos in 'UArquivos.pas' {DM: TDataModule},
  UPesquisaCliente in 'UPesquisaCliente.pas' {FPesquisaCliente},
  UNumeroPedido in 'UNumeroPedido.pas' {FNumeroPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
