unit FrmClienteEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormClienteEdit = class(TForm)
    edtNome: TEdit;
    edtTelefone: TEdit;
    edtEmail: TEdit;
    lblNome: TLabel;
    lblTelefone: TLabel;
    lblEmail: TLabel;
    btnOK: TButton;
    btnCancelar: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormClienteEdit: TFormClienteEdit;

implementation

{$R *.dfm}

procedure TFormClienteEdit.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormClienteEdit.btnOKClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

end.
