unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.UITypes,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uApiClient, uModels,
  System.JSON, System.Threading, System.Generics.Collections, FrmClienteEdit;

type
  TFrmPrincipal = class(TForm)
    GridClientes: TStringGrid;
    btnLoad: TButton;
    btnCreate: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    NetHTTPClient1: TNetHTTPClient;
    DataSource1: TDataSource;
    FDMemTable1: TFDMemTable;
    procedure FormCreate(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
  private
    { Private declarations }
    FApi: TApiClient;
    procedure LoadClientesAsync;
    procedure PopulateGridFromJson(AJson: TJSONArray);
    procedure CreateClienteAsync(const Cliente: TCliente);
    function  GetSelectedClienteId: Integer;
    procedure UpdateClienteAsync(Id: Integer; const Cliente: TCliente);
    procedure DeleteClienteAsync(Id: Integer);
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.btnCreateClick(Sender: TObject);
var
  Frm: TFormClienteEdit;
  Cliente: TCliente;
begin
  Frm := TFormClienteEdit.Create(Self);
  try
    if Frm.ShowModal = mrOk then
    begin
      Cliente.Nome     := Frm.edtNome.Text;
      Cliente.Email    := Frm.edtEmail.Text;
      Cliente.Telefone := Frm.edtTelefone.Text;

      CreateClienteAsync(Cliente);
    end;
  finally
    Frm.Free;
  end;
end;

procedure TFrmPrincipal.btnDeleteClick(Sender: TObject);
var
  ClienteId: Integer;
begin
  try
    ClienteId := GetSelectedClienteId;

    if MessageDlg(
         'Confirma a exclusão do cliente?',
         mtConfirmation,
         [mbYes, mbNo],
         0
       ) <> mrYes then
      Exit;

    DeleteClienteAsync(ClienteId);

  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TFrmPrincipal.btnEditClick(Sender: TObject);
var
  Cliente: TCliente;
  ClienteId: Integer;
  Frm: TFormClienteEdit;
begin
  try
    ClienteId := GetSelectedClienteId;
    Frm := TFormClienteEdit.Create(Self);
    try
      Frm.edtNome.Text     := GridClientes.Cells[1, GridClientes.Row];
      Frm.edtEmail.Text    := GridClientes.Cells[2, GridClientes.Row];
      Frm.edtTelefone.Text := GridClientes.Cells[3, GridClientes.Row];

      if Frm.ShowModal = mrOk then begin
        Cliente.Nome     := Frm.edtNome.Text;
        Cliente.Email    := Frm.edtEmail.Text;
        Cliente.Telefone := Frm.edtTelefone.Text;

        UpdateClienteAsync(ClienteId, Cliente);
      end;

    finally
      Frm.Free;
    end;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TFrmPrincipal.btnLoadClick(Sender: TObject);
begin
  // Carrega assincronamente para não travar UI
  LoadClientesAsync;
end;

procedure TFrmPrincipal.CreateClienteAsync(const Cliente: TCliente);
begin
  TTask.Run(
    procedure
    var
      Json: TJSONObject;
      NewId: Integer;
    begin
      Json := Cliente.ToJSON;
      try
        NewId := FApi.CreateCliente(Json);

        TThread.Queue(nil,
          procedure
          begin
            ShowMessage('Cliente criado. Id = ' + NewId.ToString);
            LoadClientesAsync;
          end
        );
      except
        on E: Exception do begin
          var Msg := E.Message;
          TThread.Queue(nil,
            procedure
            begin
              ShowMessage(Msg);
            end
          );
        end;
      end;
      Json.Free;
    end
  );
end;

procedure TFrmPrincipal.DeleteClienteAsync(Id: Integer);
begin
  TTask.Run(
    procedure
    begin
      try
        FApi.DeleteCliente(Id);

        TThread.Queue(nil,
          procedure
          begin
            LoadClientesAsync; // refresh correto
          end
        );
      except
        on E: Exception do begin
          var Msg := E.Message;
          TThread.Queue(nil,
            procedure
            begin
              ShowMessage(Msg);
            end
          );
        end;
      end;
    end
  );
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  FApi := TApiClient.Create('http://localhost:9000');
  GridClientes.RowCount := 1;
  GridClientes.ColCount := 4;
  GridClientes.Cells[0,0] := 'Id';
  GridClientes.Cells[1,0] := 'Nome';
  GridClientes.Cells[2,0] := 'Email';
  GridClientes.Cells[3,0] := 'Telefone';
end;

function TFrmPrincipal.GetSelectedClienteId: Integer;
begin
  if GridClientes.Row <= 0 then
    raise Exception.Create('Selecione um cliente.');

  Result := StrToInt(GridClientes.Cells[0, GridClientes.Row]); // coluna Id
end;

procedure TFrmPrincipal.LoadClientesAsync;
begin
  TTask.Run(procedure
  var
    arr: TJSONArray;
  begin
    try
      arr := FApi.GetClientesJson;
      TThread.Queue(nil, procedure
      begin
        PopulateGridFromJson(arr);
      end);
    except
      on E: Exception do
        TThread.Queue(nil, procedure begin ShowMessage('Erro: ' + E.Message); end);
    end;
  end);
end;

procedure TFrmPrincipal.PopulateGridFromJson(AJson: TJSONArray);
var
  i, row: Integer;
  obj: TJSONObject;
begin
  try
    GridClientes.RowCount := AJson.Count + 1;
    for i := 0 to AJson.Count - 1 do
    begin
      obj := AJson.Items[i] as TJSONObject;
      row := i + 1;
      GridClientes.Cells[0,row] := obj.GetValue('Id').Value;
      GridClientes.Cells[1,row] := obj.GetValue('Nome').Value;
      GridClientes.Cells[2,row] := obj.GetValue('Email').Value;
      GridClientes.Cells[3,row] := obj.GetValue('Telefone').Value;
    end;
  finally
    AJson.Free;
  end;
end;

procedure TFrmPrincipal.UpdateClienteAsync(Id: Integer; const Cliente: TCliente);
begin
  TTask.Run(
    procedure
    var
      Json: TJSONObject;
    begin
      Json := Cliente.ToJSON;
      try
        FApi.UpdateCliente(Id, Json);

        TThread.Queue(nil,
          procedure
          begin
            LoadClientesAsync; // refresh correto
          end
        );
      except
        on E: Exception do begin
          var Msg := E.Message;
          TThread.Queue(nil,
            procedure
            begin
              ShowMessage(Msg);
            end
          );
        end;
      end;
    end
  );
end;

end.
