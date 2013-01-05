program gzreplayex;

uses
  Forms,
  main in 'main.pas' {Form1},
  gzreplay in 'gzreplay.pas',
  LuaLib in 'LuaLib.pas',
  Lua in 'Lua.pas',
  LuaContext in 'LuaContext.pas',
  LuaContextBase in 'LuaContextBase.pas',
  gzrecFrmAbout in 'gzrecFrmAbout.pas' {Form2},
  gzrecFrmProg in 'gzrecFrmProg.pas' {Form3},
  gzrecReader in 'gzrecReader.pas',
  gzexperience in 'gzexperience.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
