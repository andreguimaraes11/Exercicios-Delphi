unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXPanels,
  Vcl.ExtCtrls, untNetwork.Intf, untNetwork.Element;

type
  TPanelComElemento = class(TPanel)
  private
    FElemento: TNetworkElement;
    FMarcado: boolean;
    procedure SetElemento(const Value: TNetworkElement);
    procedure SetMarcado(const Value: boolean);
  published
    property Elemento : TNetworkElement read FElemento write SetElemento;
    property Marcado : boolean read FMarcado write SetMarcado;
    destructor destroy; override;
  end;

  TForm1 = class(TForm)
    cpNetwork: TCardPanel;
    cardWaiting: TCard;
    cardNetwork: TCard;
    Label1: TLabel;
    ScrollBox1: TScrollBox;
    flowElementos: TFlowPanel;
    btnVerificarConexao: TButton;
    btnConectarElementos: TButton;
    Panel1: TPanel;
    btnCriarNetwork: TButton;
    edtNumeroElementos: TEdit;
    Label2: TLabel;
    memConexoes2: TMemo;
    memConexoes1: TMemo;
    procedure btnCriarNetworkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConectarElementosClick(Sender: TObject);
    procedure btnVerificarConexaoClick(Sender: TObject);
  private
    { Private declarations }

    FNetwork : INetwork;

    procedure CriarPaineisElementos;
    procedure LimparElementos;

    procedure ElementoPnlMouseEnter(Sender : TObject);
    procedure ElementoPnlMouseLeave(Sender : TObject);
    procedure ElementoPnlClick(Sender : TObject);

    procedure ExecutarListagem(APnl : TPanelComElemento);
    procedure ListarConexoes(AMemo : TMemo; ANetworkElement : TNetworkElement);

    procedure GetSelecionados(var AElemento1, AElemento2 : integer);
  public
    { Public declarations }

    FCountMarcados : integer;
  end;

var
  Form1: TForm1;

implementation

uses
  untNetwork, untNetwork.Exceptions;

{$R *.dfm}

procedure TForm1.btnConectarElementosClick(Sender: TObject);
var
  _marcado1, _marcado2 : integer;
  I: Integer;
begin
  GetSelecionados(_marcado1, _marcado2);

  try
    FNetwork.Connect(_marcado1, _marcado2);
  except
    on e:EElementoJaAdicionado do
    begin
      ShowMessage('Elementos já conectados.');
      Exit;
    end;
    on e:exception do
      raise Exception.Create('[TNetwork] - Erro ao conectar elementos. Erro: '+e.Message);
  end;
  memConexoes1.Clear;
  memConexoes2.Clear;
  ShowMessage('Elementos conectados.');
end;

procedure TForm1.btnCriarNetworkClick(Sender: TObject);
begin
  FNetwork := TNetwork.Create(StrToIntDef(edtNumeroElementos.Text, 0));
  ShowMessage('Network criada com ['+edtNumeroElementos.Text+'] elementos.');
  CriarPaineisElementos();

  cpNetwork.ActiveCard := cardNetwork;
end;

procedure TForm1.btnVerificarConexaoClick(Sender: TObject);
var
  _marcado2: Integer;
  _marcado1: Integer;
begin
  GetSelecionados(_marcado1, _marcado2);

  if (_marcado2 + _marcado2) <= 0 then
  begin
    ShowMessage('Selecione dois elementos.');
    Exit;
  end;

  if FNetwork.Query(_marcado1, _marcado2) then
    ShowMessage('Estão conectados (Direta ou indiretamente.')
  else
    ShowMessage('Não estão conectados.');
end;

procedure TForm1.CriarPaineisElementos;
var
  I: Integer;
  _totElementos: Integer;

  _pnl : TPanelComElemento;
  _elemento: TNetworkElement;
begin
  LimparElementos();

  _totElementos := StrToInt(edtNumeroElementos.Text);
  for I := 1 to _totElementos do
  begin
    _pnl := TPanelComElemento.Create(nil);

    _elemento := TNetworkElement.Create(i);
    with _pnl do
    begin
      width := 51;
      Height := 41;
      Parent := flowElementos;
      BevelInner := bvRaised;
      BevelOuter := bvLowered;

      ParentBackground := False;
      Cursor := crHandPoint;

      Color := clWhite;
      Caption := i.ToString;

      font.Name := 'segoe ui semibold';
      font.Size := 10;
      font.Color := clWindowText;

      Elemento := _elemento;

      OnMouseEnter := ElementoPnlMouseEnter;
      OnMouseLeave := ElementoPnlMouseLeave;
      OnClick      := ElementoPnlClick;
    end;
  end;
  Application.ProcessMessages;
end;

procedure TForm1.ElementoPnlClick(Sender: TObject);
begin
  ExecutarListagem(TPanelComElemento(Sender));

  if (FCountMarcados = 2) and (not TPanelComElemento(Sender).Marcado) then
  begin
    ShowMessage('Dois elementos já foram marcados. Selecione uma opção ou desmarque um dos dois p/ poder selecionar um novo elemento.');
    Exit;
  end;

  if TPanel(Sender).Color = clWhite then
  begin
    TPanel(Sender).Color := clHighlight;
    TPanelComElemento(Sender).Marcado := True;
    Inc(FCountMarcados);
    Exit;
  end;

  TPanelComElemento(Sender).Marcado := False;
  TPanel(Sender).Color := clWhite;
  Dec(FCountMarcados);
end;

procedure TForm1.ElementoPnlMouseEnter(Sender: TObject);
begin
  TPanel(Sender).BevelOuter := bvRaised;
end;

procedure TForm1.ElementoPnlMouseLeave(Sender: TObject);
begin
  TPanel(Sender).BevelOuter := bvLowered;
end;

procedure TForm1.ExecutarListagem(APnl : TPanelComElemento);
begin
  if FCountMarcados = 0 then
    ListarConexoes(memConexoes1, FNetwork.Element(Apnl.Elemento.Number))
  else
  if (FCountMarcados = 1) and (Apnl.Marcado) then
    memConexoes1.Clear
  else
  if (FCountMarcados = 1) and (not Apnl.Marcado) then
    ListarConexoes(memConexoes2, FNetwork.Element(Apnl.Elemento.Number))
  else
  if (FCountMarcados = 2) and (Apnl.Marcado) then
  begin
    if memConexoes1.Lines.Text.Contains('['+APnl.Elemento.Number.ToString+']') then
      memConexoes1.Clear
    else
      memConexoes2.Clear;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FCountMarcados := 0;
end;

procedure TForm1.GetSelecionados(var AElemento1, AElemento2: integer);
var
  I: Integer;
begin
  AElemento1 := 0;
  AElemento2 := 0;
  for I := 0 to pred(flowElementos.ControlCount) do
  begin
    if TPanelComElemento(flowElementos.Controls[i]).Marcado then
    begin
      if AElemento1 = 0 then
        AElemento1 := TPanelComElemento(flowElementos.Controls[i]).Elemento.Number
      else
        AElemento2 := TPanelComElemento(flowElementos.Controls[i]).Elemento.Number;

      TPanelComElemento(flowElementos.Controls[i]).Marcado := False;
      TPanelComElemento(flowElementos.Controls[i]).Color := clWhite;
      FCountMarcados := 0;
    end;
  end;
end;

procedure TForm1.LimparElementos;
var
  i: Integer;
begin
  for i := pred(flowElementos.ControlCount) downto 0 do
    flowElementos.Controls[i].Free;

  Application.ProcessMessages;
end;

procedure TForm1.ListarConexoes(AMemo: TMemo; ANetworkElement: TNetworkElement);
var
  I: Integer;
begin
  AMemo.Clear;
  AMemo.Lines.Add('--------------- CONEXÕES DO ELEMENTO ['+ANetworkElement.Number.ToString+'] ---------------');

  for I := 0 to pred(ANetworkElement.Connections.Count) do
  begin
    AMemo.Lines.Add(
      ANetworkElement.Number.ToString + ' - ' +
      ANetworkElement.Connections.Element(i).Number.ToString
    );
  end;
end;

{ TPanelComElemento }

destructor TPanelComElemento.destroy;
begin
  Self.FElemento.Free;
  inherited;
end;

procedure TPanelComElemento.SetElemento(const Value: TNetworkElement);
begin
  FElemento := Value;
end;

procedure TPanelComElemento.SetMarcado(const Value: boolean);
begin
  FMarcado := Value;
end;

end.
