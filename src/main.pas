(*
  gzreplayex
  Written by x1nixmzeng

  Rewrite of the 'GunZ Replay Examiner' project
    See gzreplay.pas for revision notes
*)
unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls, ZLIBSTREAM, gzreplay, Menus, ComCtrls, Lua, LuaLib,
  LuaContextBase, gzrecFrmAbout, gzrecReader, ExtCtrls ;

type
  TPluginInfo = packed record
    Name,
    Info  : String;
  end;

  TForm1 = class(TForm)
    XPManifest1: TXPManifest;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    ListBox1: TListBox;
    PageControl1: TPageControl;
    tsProperties: TTabSheet;
    Label2: TLabel;
    tsSettings: TTabSheet;
    tsCharacters: TTabSheet;
    tsStatistics: TTabSheet;
    tsChatLogs: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    ComboBox1: TComboBox;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    OpenDialog1: TOpenDialog;
    RichEdit1: TRichEdit;
    Label66: TLabel;
    Label67: TLabel;
    Help1: TMenuItem;
    About1: TMenuItem;
    SetHooks1: TMenuItem;
    OpenDialog2: TOpenDialog;
    N2: TMenuItem;
    Plugins1: TMenuItem;
    Timer1: TTimer;
    GunZReplay1: TMenuItem;
    OpenGunZ2Replay1: TMenuItem;
    N3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure SetHooks1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure GunZReplay1Click(Sender: TObject);
  private
    replayInfo    : TReplayReaderInfo; // info
    replayStarted : TDateTime;         // to avoid reusing the time unit
    replayFile    : TMemoryStream;     // global (shared between 2 functions)
    replayThread  : TReplayReader;     // for threading

    procedure ReplayLoadedCallback(Sender: TObject); 

    procedure ApplyGunZChatter(ChatLog: String);
    procedure AddString(str:string;col:char);

    function ReloadPlugins() : integer;

  public
    PluginInfo : array of TPluginInfo;
    procedure ShowPluginInfo(Sender: TObject);
  published
    function HelloWorld(LuaState: TLuaState): Integer;
  end;

var
  Form1: TForm1;

implementation

uses gzrecFrmProg;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  ListBox1.ItemIndex := 0;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  PageControl1.Pages[ ListBox1.ItemIndex ].Show; 
end;

procedure TForm1.AddString(str:string;col:char);
begin
  case col of
    '0' : RichEdit1.SelAttributes.Color := $808080; // Grey
    '1' : RichEdit1.SelAttributes.Color := $0000FF; // Red
    '2' : RichEdit1.SelAttributes.Color := $00FF00; // Green
    '3' : RichEdit1.SelAttributes.Color := $FF0000; // Blue
    '4' : RichEdit1.SelAttributes.Color := $00FFFF; // Yellow
    '5' : RichEdit1.SelAttributes.Color := $000080; // Dark red
    '6' : RichEdit1.SelAttributes.Color := $008000; // Dark green
    '7' : RichEdit1.SelAttributes.Color := $800000; // Dark blue
    '8' : RichEdit1.SelAttributes.Color := $008080; // Dark yellow
    '9' : RichEdit1.SelAttributes.Color := $FFFFFF; // White
  else
    RichEdit1.SelAttributes.Color := clBlack;
  end;

  // Add the text
  RichEdit1.SelText := str;
end;

procedure TForm1.ApplyGunZChatter( ChatLog: String );
var
  i,l: integer;
  s: string;
  col:char;
const
  DEFAULT_COLOUR : char = 'x';
begin

  col := DEFAULT_COLOUR; // begin with default colour
  l:=length(ChatLog);    // pre-calculate the length of string
  s:='';                 // last colour string buffer
  i:=1;                  // delphi strings start from position 1

  // for each character in the string
  while i <= l do
  begin
    // if current char is '^'
    //  AND there is at least one more character in the string
    //  AND that character is a colour indicator 
    if (ChatLog[i] = '^') and (i<l) and (ChatLog[i+1] in ['0'..'9']) then
    begin
      AddString( s, col );         // Add the last string colour
      col := ChatLog[i+1];    // Get the new colour code
      s :='';                 // Empty the last colour string buffer
      inc(i);                 // Ignore the colour code (0-9)
    end
    // for anything else
    else
    begin
      // add the character to the buffer
      s:=s+ChatLog[i];
      // if the line has finished (reach newline character)
      if ChatLog[i] = #10 then
      begin
        if length(s) > 0 then
          AddString( s, col );     // Add the last string colour
          
        s := '';              // Empty the last colour string buffer
        col := DEFAULT_COLOUR;// Reset the default colour
      end;
    end;
    // lastly, increment the current character index
    inc(i);
  end;

  // Finally insert the trailing data
  if length(s) > 0 then
    AddString(s,col);              // Add the remaining string

end;




procedure TForm1.About1Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

type
  gz2battleinfo = {packed }record
    gsidMaster : gz2sid;
    nBattleType: gz2Battletype;
    nMapID,
    nPlayTime,
    nRoundCount,
    nBattleState : uint16;
  end;

  gz2replaydesc = record
    nTickCount : uint32;
    m_uidCapturePlayer : gz2sid;
    battleInfo : gz2battleinfo;
    nPlayerCount : uint32;
  end;

  {
procedure TForm1.Button1Click(Sender: TObject);
var
  gzrData, gzrCmdData : TMemoryStream;
  
  i : int32;
  replayInfo : gz2replaydesc;
begin

  gzrData := TMemoryStream.Create;
  gzrData.LoadFromFile('test.replay');

  gzrData.Read( replayInfo, sizeof( gz2replaydesc ) );

  for i := 1 to replayInfo.nPlayerCount do
  begin
    // OBJECT_CREATE_INFO
    gzrData.Seek($89, soCurrent);  // 137

    // $89
  end;

  for i := 1 to replayInfo.nPlayerCount do
  begin
    // GPLAYERINFO
    gzrData.Seek($130, soCurrent); // 304

    // Seen $140 / 320
  end;


  label43.Caption := IntToStr( replayinfo.nPlayerCount );

  gzrData.Free;
end;
  }
  
function TForm1.HelloWorld(LuaState: TLuaState): Integer;
var
  lb : TLuaContextBase;
  ArgCount : integer;
begin

  lb := TLuaContextBase.Create( LuaState );

  ArgCount := lb.countArguments();
  Result := ArgCount-ArgCount;
  
end;

procedure TForm1.SetHooks1Click(Sender: TObject);
begin
  ReloadPlugins();
end;

procedure TForm1.ShowPluginInfo(Sender: TObject);
var
  mindex : integer;
begin

  // Find subitem index from sender
  mindex := TMenuItem(Sender).MenuIndex;

  MessageBoxA
  (
    Handle,
    PChar( PluginInfo[mindex].Info ),
    PChar( PluginInfo[mindex].Name ),
    MB_OK or MB_ICONINFORMATION
  );
end;

{
procedure TForm1.Replay1Click(Sender: TObject);
var
  gzrData : TMemoryStream;
  gzr : gzrClass;
  i, tmp : uint32;
  loadResult : gzreplayState;
begin

  if not OpenDialog1.Execute then Exit;

  // quickfix: check gunz2 replay type

  gzrData := TMemoryStream.Create;
  gzrData.LoadFromFile( OpenDialog1.Files[0] );

  // Debug test
  gzrData.Read( tmp, sizeof( uint32 ) );
  gzrData.Position := 0;

  // Either an uncompressed replay (for my own purposes)
  // or not compressed (a REC file)

  if tmp <> gzreplay.GZR_MAGIC then
    if not DecompressZlib( gzrData ) then
    begin
      gzrData.Destroy;
      ShowMessage('Failed to decompress data');
      Exit;
    end;

  //gzrData.SaveToFile('debugRecording.gzr');


  gzr := gzrClass.Create;
  loadResult:= gzr.LoadReplay( gzrData  );
  if ( loadResult = GZR_SUCCESS) or ( loadResult = GZR_SUSPICIOUSPACKET ) then
  begin
    Label19.Caption := ExtractFileName( OpenDialog1.Files[0] );

    label18.Caption := inttostr(gzrData.size);
    Label1.Caption := gzr.GetVersionStr();//('%d.0',[ gzr.GetVersion() ]);

    Label16.Caption := Format('%.2f',[gzr.GetRunningTime()]);
    Label17.Caption := gzr.GetOwnerChar();

    Label20.Caption := inttostr(gzr.GetTotalPackets());

    tmp := gzr.GetTotalPlayers();
    Label43.Caption := inttostr(tmp);

    combobox1.Clear();
    for i := 1 to tmp do
    begin
      combobox1.Items.Add(gzr.getchar(i-1));
    end;

    // Stage
    Label22.Caption := gzr.GetMapName();

    // Chat Log
    RichEdit1.Clear;
    ApplyGunZChatter( gzr.GetChatLog() );

  end
  else
  begin
    ShowMessage('Did not load replay successfully..');
  end;
  gzr.Destroy;
  gzrData.Destroy;

end;

procedure TForm1.GunZ2Commands1Click(Sender: TObject);
var
  gzrData : TMemoryStream;
  gzr : gzrClass;
  i, tmp : uint32;
  loadResult : gzreplayState;
begin

 if not OpenDialog2.Execute then Exit;

  gzrData := TMemoryStream.Create;
  gzrData.LoadFromFile( OpenDialog2.Files[0] );

  gzr := gzrClass.Create;
  loadResult:= gzr.LoadReplay2( gzrData  );

  if ( loadResult = GZR_SUCCESS) then
  begin
    Label19.Caption := 'test';
    Label18.Caption := IntToStr( gzrData.Size );

    label1.Caption  := 'GunZ2 alpha';
    Label16.Caption := Format('%.2f',[gzr.GetRunningTime()]);

    Label17.Caption := '';
    Label20.Caption := inttostr(gzr.GetTotalPackets());
    Label43.Caption := '0';
  end
  else
  begin
    ShowMessage('Did not load replay successfully..');
  end;

  gzrData.Free;
  gzr.Free;

end;
   }
function TForm1.ReloadPlugins: Integer;
var
  i,  // result index
  LuaScriptRes : Integer;
  LuaSearch    : TSearchRec;
  l            : TLua;
  menu         : TMenuItem;
begin

  SetCurrentDirectory(PAnsiChar(ExtractFilePath(ParamStr(0))));

  if not Lua.IsLibraryOpened() then
  begin
    if not Lua.OpenLibrary() then
    begin
      ShowMessage('Cannot load Lua library');
      Exit;
    end;
  end;

  SetCurrentDirectory('.\Scripts');

  MainMenu1.Items[1].Items[2].Clear;
  SetLength( PluginInfo, 0 );

  LuaScriptRes := FindFirst('*.lua', faAnyFile, LuaSearch);

  i:=0;

  while LuaScriptRes = 0 do
  begin
    l := TLua.Create;

    l.SetFunctionHook('HelloWorld', 'HelloWorld', Form1);
    l.LoadScript(LuaSearch.Name);

    // Check for global function
    lua_getglobal(l.LuaContext, 'gzreplayRegister');
    if lua_isfunction(l.LuaContext, -1) then
    begin
      // It exists, so call it!
      lua_call(l.LuaContext, 0, 1);

      lua_pushnil( l.LuaContext );
      lua_next( l.LuaContext, -1 );

      SetLength(PluginInfo,i+1);
      PluginInfo[i].Name := luaL_checkstring( l.LuaContext, -1 );
      PluginInfo[i].Info := luaL_checkstring( l.LuaContext, 0 );

      menu := TMenuItem.Create( MainMenu1 );
      menu.Caption := ExtractFileName(LuaSearch.Name);
      menu.OnClick := ShowPluginInfo;
      MainMenu1.Items[1].Items[2].Add(menu);
    end;

    l.Free;

    inc(i);
    LuaScriptRes := FindNext(LuaSearch);
  end;

  Lua.CloseLibrary;  

end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.GunZReplay1Click(Sender: TObject);
begin

  // Assume the file has been closed
  //   (ie thread isn't running or hasn't crashed)
  if replayFile <> nil then
    exit;

  // Open dialog
  if not OpenDialog1.Execute then Exit;

  // Create stream (file must exist)
  replayFile := TMemoryStream.Create;
  replayFile.LoadFromFile( OpenDialog1.Files[0] );

  // Save start time
  replayStarted := Time;

  // Create the thead
  replayThread := TReplayReader.Create( replayFile, replayInfo );
  replayThread.OnTerminate := ReplayLoadedCallback;

  // Setup progress dialog
  Timer1.Enabled := True;
  Form3.Open;

  // .. end of part 1! 
end;

procedure TForm1.ReplayLoadedCallback(Sender: TObject);
begin
  // .. part 2! :

  // Free the replayFile data
  replayFile.Free;
  replayFile := nil;

  // We can now update the UI now

  if replayInfo.ReadResult = GZR_SUCCESS then
  begin
    // TODO: UI RESET

    // THEN
    Label19.Caption := ExtractFileName( OpenDialog1.Files[0] );

    label18.Caption := IntToStr( replayInfo.Size );
    Label1.Caption := replayInfo.Replay.GetVersionStr();

    Label16.Caption := Format('%.2f',[replayInfo.Replay.GetRunningTime()]);
    Label17.Caption := replayInfo.Replay.GetOwnerChar();

    Label20.Caption := inttostr(replayInfo.Replay.GetTotalPackets());

    {
    tmp := replayInfo.Replay.GetTotalPlayers();

    combobox1.Clear();
    for i := 1 to tmp do
    begin
      combobox1.Items.Add(replayInfo.Replay.getchar(i-1));
    end;

    }
    // Stage
    Label22.Caption := replayInfo.Replay.GetMapName();

    // Chat Log
    RichEdit1.Clear;
    ApplyGunZChatter( replayInfo.Replay.GetChatLog() );

  end;

  // Finally free the replay instance
  replayInfo.Replay.Free;
  replayInfo.Replay := nil;  

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

  Form3.Label1.Caption := replayInfo.Status;

  if replayInfo.ErrorMsg <> '' then
    Form3.Label8.Caption := 'Error: ' + replayInfo.ErrorMsg;

  // Temporary
  Form3.Label3.Caption := Format('%d b', [replayInfo.Size]);
  
  Form3.Label5.Caption := TimeToStr( Time - replayStarted );

  Form3.ProgressBar1.Position := replayInfo.Progress;

  if replayFile = nil then
  begin
    // Allow the progress bar to close
    Form3.allowClose      := True;
    Form3.Button1.Enabled := True;

    // Automatically close if there is no error
    // UPDATE: Added local session checkbox
    if ( replayInfo.ErrorMsg = '' ) and ( Form3.CheckBox1.Checked ) then
      Form3.Close;

    // Disable the update timer
    Timer1.Enabled        := False;
  end;
end;

end.

