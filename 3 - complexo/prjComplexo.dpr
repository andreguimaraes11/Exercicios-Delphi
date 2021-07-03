program prjComplexo;

uses
  Vcl.Forms,
  untNetwork in 'untNetwork.pas',
  untNetwork.Intf in 'untNetwork.Intf.pas',
  untPrincipal in 'untPrincipal.pas' {Form1},
  untNetwork.Element in 'untNetwork.Element.pas',
  untNetwork.Exceptions in 'untNetwork.Exceptions.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
