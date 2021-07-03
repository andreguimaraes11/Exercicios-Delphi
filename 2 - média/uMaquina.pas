unit uMaquina;

interface

uses
  uIMaquina, Classes, uTroco;

type
  TMaquina = class(TInterfacedObject, IMaquina)
  strict private
    FValorTroco : Double;

    procedure PreencherCedulas(ALista : TList);
    procedure PreencherMoedas(ALista : TList);
  public
    function MontarTroco(Troco: Double): TList;
  end;

implementation

uses
  math, Vcl.Dialogs, System.SysUtils;

function TMaquina.MontarTroco(Troco: Double): TList;
begin
  Result := TList.Create;
  if Troco = 0 then
    Exit;

  FValorTroco := Troco;

  PreencherCedulas(Result);
  PreencherMoedas(Result);
end;

procedure TMaquina.PreencherCedulas(ALista: TList);
  procedure GerarTrocoCedula(var ALista : TList; var ATrocoValor : integer; ACedula : TCedula);
  var
    _vlrCedula: integer;
    _div: integer;
  begin
    _vlrCedula := Trunc(CValorCedula[ACedula]);
    _div := ATrocoValor div _vlrCedula;
    ATrocoValor := ATrocoValor - (_div * _vlrCedula);

    if _div > 0 then
      ALista.Add(TTroco.Create(ACedula, _div));
  end;
var
  _vlrRestanteTroco : integer;
begin
  _vlrRestanteTroco := Trunc(FValorTroco);

  while _vlrRestanteTroco > 0 do
  begin
    GerarTrocoCedula(ALista, _vlrRestanteTroco, ceNota100);
    GerarTrocoCedula(ALista, _vlrRestanteTroco, ceNota50);
    GerarTrocoCedula(ALista, _vlrRestanteTroco, ceNota20);
    GerarTrocoCedula(ALista, _vlrRestanteTroco, ceNota10);
    GerarTrocoCedula(ALista, _vlrRestanteTroco, ceNota5);
    GerarTrocoCedula(ALista, _vlrRestanteTroco, ceNota2);
    GerarTrocoCedula(ALista, _vlrRestanteTroco, ceMoeda100);
  end;
end;

procedure TMaquina.PreencherMoedas(ALista: TList);
  procedure GerarTrocoMoeda(var ALista : TList; var ATrocoValor : integer; ACedula : TCedula);
  var
    _vlrMoeda: integer;
    _div: integer;
  begin
    _vlrMoeda := Trunc(CValorCedula[ACedula] * 100);
    _div := ATrocoValor div _vlrMoeda;
    ATrocoValor := ATrocoValor - (_div * _vlrMoeda);

    if _div > 0 then
      ALista.Add(TTroco.Create(ACedula, _div));
  end;
var
  _vlrRestanteTroco : Double;
  _vlrRestanteTrocoMoedas : integer;
begin
  _vlrRestanteTroco := FValorTroco - Trunc(FValorTroco);
  _vlrRestanteTrocoMoedas := Trunc(_vlrRestanteTroco * 100);

  while _vlrRestanteTrocoMoedas > 0 do
  begin
    GerarTrocoMoeda(ALista, _vlrRestanteTrocoMoedas, ceMoeda50);
    GerarTrocoMoeda(ALista, _vlrRestanteTrocoMoedas, ceMoeda25);
    GerarTrocoMoeda(ALista, _vlrRestanteTrocoMoedas, ceMoeda10);
    GerarTrocoMoeda(ALista, _vlrRestanteTrocoMoedas, ceMoeda5);
    GerarTrocoMoeda(ALista, _vlrRestanteTrocoMoedas, ceMoeda1);
  end;
end;

end.

