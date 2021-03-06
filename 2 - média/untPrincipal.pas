unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    edtVlrTroco: TLabeledEdit;
    Button1: TButton;
    memTroco: TMemo;
    procedure edtVlrTrocoKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }

    procedure ExibirTroco(ALista : TList);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
  StrUtils,
  uIMaquina,
  uMaquina, uTroco;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  _maquina : IMaquina;
  _vlrTroco: Double;

  _listaTroco : TList;
  _troco: TTroco;
begin
  _vlrTroco := StrToFloatDef(edtVlrTroco.Text, 0);
  if _vlrTroco <= 0 then
  begin
    ShowMessage('N?o h? troco a ser devolvido.');
    Exit;
  end;

  memTroco.Clear;

  _maquina := TMaquina.Create;
  _listaTroco := _maquina.MontarTroco(_vlrTroco);
  try
    ExibirTroco(_listaTroco);
  finally
    for _troco in _listaTroco do
      _troco.Free;

    _listaTroco.Free;
  end;
end;

procedure TForm1.edtVlrTrocoKeyPress(Sender: TObject; var Key: Char);
var
  _trocoStr : string;
  _trocoArr: TArray<string>;
begin
  if not (key in ['0'..'9',',', #8]) then
  begin
    key :=#0;
    Exit;
  end;

  if Key = #8 then
    Exit;

  _trocoStr := edtVlrTroco.Text;
  if _trocoStr.Contains(',') then
  begin
    if Key = ',' then
      Abort;

    _trocoArr := _trocoStr.Split([',']);
    if _trocoArr[1].Length = 2 then
      Abort;
  end;
end;

procedure TForm1.ExibirTroco(ALista: TList);
var
  _troco: TTroco;
begin
  memTroco.Lines.Add('---------------- TROCO ----------------');
  for _troco in ALista do
    memTroco.Lines.Add(_troco.GetTipo.toString + ': '+_troco.GetQuantidade.ToString);

  memTroco.Lines.Add('------------------------------------------');
end;

end.
