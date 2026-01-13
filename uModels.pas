unit uModels;

interface

uses
  System.JSON;

type
  TCliente = record
    Id: Integer;
    Nome: string;
    Email: string;
    Telefone: string;

    function ToJSON: TJSONObject;
    function JSONToCliente(J: TJSONObject): TCliente;
  end;

implementation

{ TCliente }

function TCliente.JSONToCliente(J: TJSONObject): TCliente;
begin
  Result.Id := J.GetValue<Integer>('Id');
  Result.Nome := J.GetValue<string>('Nome');
  Result.Email := J.GetValue<string>('Email');
  Result.Telefone := J.GetValue<string>('Telefone');
end;

function TCliente.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('Nome', Nome);
  Result.AddPair('Email', Email);
  Result.AddPair('Telefone', Telefone);
end;

end.
