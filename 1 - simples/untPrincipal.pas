unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    lblString: TLabeledEdit;
    lblStringVelha: TLabeledEdit;
    lblStringNova: TLabeledEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  uISubstitui, uSubstitui;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  _substituidor : ISubstitui;
begin
  _substituidor := TSubstitui.Create;

  ShowMessage(
    _substituidor.Substituir(
      lblString.Text,
      lblStringVelha.Text,
      lblStringNova.Text
    )
  );
end;

end.
