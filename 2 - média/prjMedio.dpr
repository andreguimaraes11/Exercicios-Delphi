program prjMedio;

uses
  Vcl.Forms,
  uIMaquina in 'uIMaquina.pas',
  uMaquina in 'uMaquina.pas',
  uTroco in 'uTroco.pas',
  untPrincipal in 'untPrincipal.pas' {Form1};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
