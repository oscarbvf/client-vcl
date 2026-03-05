unit uApiClient;

interface

uses
  System.SysUtils, System.Classes, System.JSON, REST.Types, REST.Client,
  IPPeerClient, System.Generics.Collections, uModels, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.Net.URLClient, System.Math;


type
  TApiClient = class
  private
    FBaseUrl: string;
    FHttp: TNetHTTPClient;
  public
    constructor Create(const ABaseUrl: string);
    destructor Destroy; override;
    function GetClientesJson: TJSONArray;
    function CreateCliente(const AJson: TJSONObject): Integer;
    function UpdateCliente(Id: Integer; const AJson: TJSONObject): Boolean;
    function DeleteCliente(Id: Integer): Boolean;
  end;

implementation

{ TApiClient }

constructor TApiClient.Create(const ABaseUrl: string);
begin
  FBaseUrl := ABaseUrl;
  FHttp := TNetHTTPClient.Create(nil);
  FHttp.Accept := 'application/json';
  // Timeout e headers podem ser configurados aqui
end;

destructor TApiClient.Destroy;
begin
  FHttp.Free;
  inherited;
end;

function TApiClient.GetClientesJson: TJSONArray;
var
  res: IHTTPResponse;
  s: string;
  JsonValue: TJSONValue;
begin
  res := FHttp.Get(FBaseUrl + '/clientes');
  s := res.ContentAsString(TEncoding.UTF8);

  JsonValue := TJSONObject.ParseJSONValue(s);
  if not Assigned(JsonValue) then
    raise Exception.Create('JSON inválido');

  if not (JsonValue is TJSONArray) then
    raise Exception.Create('JSON retornado não é um array');

  Result := JsonValue as TJSONArray;
end;

function TApiClient.CreateCliente(const AJson: TJSONObject): Integer;
var
  Res: IHTTPResponse;
  Body: string;
  Json: TJSONValue;
  Obj: TJSONObject;
begin
  Result := 0;

  Res := FHttp.Post(
    FBaseUrl + '/clientes',
    TStringStream.Create(AJson.ToString, TEncoding.UTF8),
    nil,
    [TNetHeader.Create('Content-Type', 'application/json')]
  );

  Body := Res.ContentAsString(TEncoding.UTF8);

  if not InRange(Res.StatusCode, 200, 299) then
    raise Exception.CreateFmt(
      'Erro ao criar cliente (%d): %s',
      [Res.StatusCode, Body]
    );

  Json := TJSONObject.ParseJSONValue(Body);
  if not Assigned(Json) then
    raise Exception.Create('Resposta não é um JSON válido');

  try
    if not (Json is TJSONObject) then
      raise Exception.Create('JSON retornado não é um objeto');

    Obj := Json as TJSONObject;

    if not Obj.TryGetValue<Integer>('id', Result) then
      raise Exception.Create('Campo "Id" não encontrado no JSON');
  finally
    Json.Free;
  end;
end;

function TApiClient.UpdateCliente(Id: Integer; const AJson: TJSONObject): Boolean;
var
  Resp: IHTTPResponse;
  Body: string;
begin
  Resp := FHttp.Put(FBaseUrl + '/clientes/' + Id.ToString, TStringStream.Create(AJson.ToString, TEncoding.UTF8), nil, [TNetHeader.Create('Content-Type','application/json')]);

  Body := Resp.ContentAsString(TEncoding.UTF8);

  if not (Resp.StatusCode in [200, 204]) then
    raise Exception.CreateFmt(
      'Erro ao atualizar cliente (%d): %s',
      [Resp.StatusCode, Body]
    );

  Result := True;
end;

function TApiClient.DeleteCliente(Id: Integer): Boolean;
var
  Resp: IHTTPResponse;
  Body: string;
begin
  Resp := FHttp.Delete(FBaseUrl + '/clientes/' + Id.ToString);

  Body := Resp.ContentAsString(TEncoding.UTF8);

  if not (Resp.StatusCode in [200, 204]) then
    raise Exception.CreateFmt(
      'Erro ao excluir cliente (%d): %s',
      [Resp.StatusCode, Body]
    );

  Result := True;
end;

end.
