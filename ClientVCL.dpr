program ClientVCL;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {FrmPrincipal},
  uModels in 'uModels.pas',
  uApiClient in 'uApiClient.pas',
  FrmClienteEdit in 'FrmClienteEdit.pas' {FormClienteEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
