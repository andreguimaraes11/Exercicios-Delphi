unit untNetwork;

interface

uses
  untNetwork.Intf,
  System.Generics.Collections,
  untNetwork.Element;
Type
  TNetwork = class(TInterfacedObject, INetwork)
  strict private
    FTotalElements : integer;
    FElementos : TDictionary<integer, TNetworkElement>;

    procedure ValidarElementos(AFirstElement, ASecondElement : integer);
  private
    procedure Connect(AFirstElement, ASecondElement : integer);
    function Query(AFirstElement, ASecondElement : integer) : boolean;
    function Element(AIdx : integer) : TNetworkElement;
  public
    constructor Create(ATotalElements : integer);
    property Elementos : TDictionary<integer, TNetworkElement> read FElementos;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils,
  untNetwork.Exceptions;

{ TNetwork }

procedure TNetwork.Connect(AFirstElement, ASecondElement: integer);
begin
  ValidarElementos(AFirstElement, ASecondElement);
  try
    FElementos.
      Items[AFirstElement].
        Connections.
          Add(
            FElementos.
              Items[ASecondElement]
            );

    FElementos.
      Items[ASecondElement].
        Connections.
          Add(
            FElementos.
              Items[AFirstElement]
            );
  except
    on e:EElementoJaAdicionado do
      raise;
    on e:exception do
      raise Exception.Create('[TNetwork] - Erro ao conectar elementos. Erro: '+e.Message);
  end;
end;

constructor TNetwork.Create(ATotalElements: integer);
var
  I: Integer;
begin
  if Frac(ATotalElements) <> 0 then
    raise Exception.Create('[TNetwork] - O n?mero de elementos p/ a cria??o deve ser um inteiro.');

  FElementos := TDictionary<integer, TNetworkElement>.Create;
  Self.FTotalElements := ATotalElements;

  for I := 0 to ATotalElements do
    FElementos.Add(i, TNetworkElement.Create(i));

  FElementos.TrimExcess;
end;

destructor TNetwork.Destroy;
var
  _key: integer;
begin
  if Assigned(FElementos) then
  begin
    for _key in FElementos.Keys do
      FElementos.Items[_key].Free;

    FElementos.Free;
  end;
  inherited;
end;

function TNetwork.Element(AIdx: integer): TNetworkElement;
begin
  Result := FElementos.Items[AIdx];
end;

function TNetwork.Query(AFirstElement, ASecondElement: integer): boolean;
var
  _key: integer;
  _aux: Integer;
begin
  ValidarElementos(AFirstElement, ASecondElement);
  Result := False;
  for _key in FElementos.Keys do
  begin
    if FElementos.Items[_key].Number <> AFirstElement then
      Continue;

    for _aux := 0 to pred(FElementos.Items[AFirstElement].Connections.Count) do
    begin
      Result := FElementos.Items[_key].VerifyConnection(ASecondElement);
      if Result then
        Break;
    end;
  end;
end;

procedure TNetwork.ValidarElementos(AFirstElement, ASecondElement: integer);
begin
  if (AFirstElement > FTotalElements) or (ASecondElement > FTotalElements) then
    raise Exception.Create('[TNetwork] - Elemento inv?lido! Elementos passados '+
    '['+AFirstElement.ToString+','+ASecondElement.ToString+']. Total da Network: '+
    '['+FTotalElements.ToString+']');
end;

end.
