program prjSimples;

uses
  Vcl.Forms,
  uISubstitui in 'uISubstitui.pas',
  untPrincipal in 'untPrincipal.pas' {Form1},
  uSubstitui in 'uSubstitui.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
