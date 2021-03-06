unit untNetwork.Element;

interface

uses
  System.Generics.Collections;
type
  TNetworkElement = class;

  TNetworkElementList = class
  strict private
    FElements : TObjectList<TNetworkElement>;

    procedure ValidarIndex(AIdx : integer);
  public
    procedure Add(AElement : TNetworkElement);
    procedure Remove(AElement : TNetworkElement); overload;
    procedure Remove(AIdx : integer); overload;

    function Count : integer;
    function Element(AIdx : integer) : TNetworkElement;

    constructor Create;
    destructor Destroy; override;
  end;

  TNetworkElement = class
  strict private
    FNumber : integer;
    FListaConnections : TNetworkElementList;

    function VerifyConnectionPrivate(ANumber : integer; AElement : TNetworkElement) : boolean;
  public
    property Number : integer read FNumber;
    property Connections : TNetworkElementList read FListaConnections;

    function VerifyConnection(ANumber : integer) : boolean;
    constructor Create(ANumber : integer);
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils, untNetwork.Exceptions;

{ TNetworkElement }

constructor TNetworkElement.Create(ANumber : integer);
begin
  Self.FNumber := ANumber;
  Self.FListaConnections := TNetworkElementList.Create;
end;

destructor TNetworkElement.Destroy;
begin
  if Assigned(FListaConnections) then
    FListaConnections.Free;
  inherited;
end;

function TNetworkElement.VerifyConnection(ANumber: integer): boolean;
begin
  VerifyConnectionPrivate(ANumber, Self);
end;

function TNetworkElement.VerifyConnectionPrivate(ANumber: integer;
  AElement: TNetworkElement): boolean;
var
  I: Integer;
begin
  for I := 0 to pred(AElement.Connections.Count) do
  begin
    if AElement.Connections.Element(i).Number = ANumber then
    begin
      Result := True;
      Break;
    end;
  end;
end;

{ TNetworkElementList }

procedure TNetworkElementList.Add(AElement: TNetworkElement);
var
  i : integer;
begin
  for i := 0 to pred(FElements.Count) do
  begin
    if AElement.Number = FElements.Items[i].Number then
      raise EElementoJaAdicionado.Create('[TNetworkElementList] - Elemento j? adicionado');
  end;

  FElements.Add(AElement);
  FElements.TrimExcess;
end;

function TNetworkElementList.Count: integer;
begin
  Result := FElements.Count;
end;

constructor TNetworkElementList.Create;
begin
  Self.FElements := TObjectList<TNetworkElement>.Create;
  Self.FElements.OwnsObjects := False;
end;

destructor TNetworkElementList.Destroy;
begin
  FElements.Free;
  inherited;
end;

function TNetworkElementList.Element(AIdx: integer): TNetworkElement;
begin
  ValidarIndex(AIdx);
  Result := FElements[AIdx];
end;

procedure TNetworkElementList.Remove(AElement: TNetworkElement);
begin
  FElements.Remove(AElement);
end;

procedure TNetworkElementList.Remove(AIdx: integer);
begin
  ValidarIndex(AIdx);
  FElements.Remove(FElements.Items[AIdx]);
end;

procedure TNetworkElementList.ValidarIndex(AIdx: integer);
begin
  if FElements.Count < AIdx then
    raise Exception.Create('[TNetworkElementList] - Index acessado inv?lido. Index ['+Aidx.ToString+'] '+
    '- Total da lista ['+FElements.Count.ToString+']');
end;

end.
