(*


<STR id="UI_CC_LIST_03_01">Axium Gun Knight</STR>
<STR id="UI_CC_LIST_03_02">Travia Gun Fighter</STR>
<STR id="UI_CC_LIST_03_03">Axium Assassin</STR>
<STR id="UI_CC_LIST_03_04">Travia Scout</STR>
<STR id="UI_CC_LIST_03_05">Axium Gun Priest</STR>
<STR id="UI_CC_LIST_03_06">Travia Doctor</STR>


for decent heatmap examples see

http://www.bungie.net/Stats/Reach/Heatmaps.aspx?player= xx

more statistics examples

http://www.planetwot.com/playerStats/?name=azzlack_professor


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
  LuaContextBase, gzrecFrmAbout, gzrecReader, ExtCtrls, gzexperience ;

type
  TReplayPlugin = class
  public
    Name,
    Info  : String;
    L : TLua; // lua context
  end;

  PTReplayPlugin = ^TReplayPlugin;

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
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    OpenDialog1: TOpenDialog;
    RichEdit1: TRichEdit;
    Label66: TLabel;
    Label67: TLabel;
    Help1: TMenuItem;
    About1: TMenuItem;
    OpenDialog2: TOpenDialog;
    Timer1: TTimer;
    GunZReplay1: TMenuItem;
    OpenGunZ2Replay1: TMenuItem;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label65: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label62: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label58: TLabel;
    Label79: TLabel;
    Label50: TLabel;
    Label68: TLabel;
    Label71: TLabel;
    Label69: TLabel;
    Label73: TLabel;
    Label7: TLabel;
    Label70: TLabel;
    Label72: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label93: TLabel;
    Scripts1: TMenuItem;
    Reload1: TMenuItem;
    N4: TMenuItem;
    About2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure GunZReplay1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Plugins1Click(Sender: TObject);
    procedure Reload1Click(Sender: TObject);
  private
    replayInfo    : TReplayReaderInfo; // info
    replayStarted : TDateTime;         // to avoid reusing the time unit
    replayFile    : TMemoryStream;     // global (shared between 2 functions)
    replayThread  : TReplayReader;     // for threading

    procedure ReplayLoadedCallback(Sender: TObject); 

    procedure ApplyGunZChatter(ChatLog: String);
    procedure AddString(str:string;col:char);

    function ReloadPlugins() : integer;

    procedure ResetUI;

    procedure ShowErrorPopup( Msg: string; Title: String = '' );

  public
    Plugins : TList;
    procedure ShowPluginInfo(Sender: TObject);
  published
    function HelloWorld(LuaState: TLuaState): Integer;
    function LuaExpToNextLevel(LuaState: TLuaState): Integer;
    function LuaGetLevelFromExp(LuaState: TLuaState): Integer;        
  end;

var
  Form1: TForm1;

implementation

uses gzrecFrmProg;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  ListBox1.ItemIndex := 0;
  ResetUI;
end;

procedure TForm1.ShowErrorPopup( Msg: string; Title: String = '' );
begin
  if Title = '' then
    Title := Caption;

  MessageBoxA
  (
    Handle,
    PChar( Msg ),
    PChar( Title ),
    MB_OK or MB_ICONWARNING
  );
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

function TForm1.LuaExpToNextLevel(LuaState: TLuaState): Integer;
var
  exp : cardinal;
begin

  exp := luaL_checkinteger(LuaState, -1);

  CalculateExpTable;
  lua_pushinteger(luastate, ExpToNextLevel( exp ));

  Result := 1;
end;

function TForm1.LuaGetLevelFromExp(LuaState: TLuaState): Integer;
var
  exp : cardinal;
begin

  exp := luaL_checkinteger(LuaState, -1);

  CalculateExpTable;
  lua_pushinteger(luastate, GetLevelFromExp( exp ));
  
  Result := 1;
end;


procedure TForm1.ShowPluginInfo(Sender: TObject);
var
  pluginitem : TReplayPlugin;
begin

  // Find subitem index from sender
  pluginitem := Plugins.Items[ TMenuItem(Sender).MenuIndex ];

  MessageBoxA
  (
    Handle,
    PChar( pluginitem.Info ),
    PChar( pluginitem.Name ),
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
  LuaScriptRes : Integer;
  LuaSearch    : TSearchRec;

  menu         : TMenuItem;
  pluginitem   : TReplayPlugin;

  hasIssue     : Boolean;
begin

  SetCurrentDirectory(PAnsiChar(ExtractFilePath(ParamStr(0))));

  if not Lua.IsLibraryOpened() then
  begin
    if not Lua.OpenLibrary() then
    begin
      ShowErrorPopup('Cannot load Lua library');
      Exit;
    end;
  end;

  SetCurrentDirectory('.\Scripts');

  MainMenu1.Items[1].Items[2].Clear;

  // hopefully this clears some memory too!
  if plugins = nil then
    plugins := TList.Create
  else
    plugins.Clear;

  LuaScriptRes := FindFirst('*.lua', faAnyFile, LuaSearch);

  while LuaScriptRes = 0 do
  begin

    // Create new context

    pluginitem := TReplayPlugin.Create;
    pluginitem.L := TLua.Create;

    hasIssue := True; // guilty until otherwise proven (whitelisting)

    pluginitem.L.SetFunctionHook('ExpToNextLevel',  'LuaExpToNextLevel',  Form1);
    pluginitem.L.SetFunctionHook('GetLevelFromExp', 'LuaGetLevelFromExp', Form1);

    if pluginitem.L.LoadScript(LuaSearch.Name) <> 0 then
      ShowErrorPopup( luaL_checkstring(pluginitem.l.LuaContext, -1 ), 'Script Error' )
    else
    begin
      // Check for global function
      lua_getglobal(pluginitem.l.LuaContext, 'gzreplayRegister');
      if lua_isfunction(pluginitem.l.LuaContext, -1) then
      begin
        if lua_pcall(pluginitem.l.LuaContext, 0, 1, 0) <> 0 then
          ShowErrorPopup( luaL_checkstring(pluginitem.l.LuaContext, -1 ), 'Script Error' )
        else
        begin
          lua_pushnil( pluginitem.l.LuaContext );
          lua_next( pluginitem.l.LuaContext, -1 );

          pluginitem.Name := luaL_checkstring( pluginitem.l.LuaContext, -1 );
          pluginitem.Info := luaL_checkstring( pluginitem.l.LuaContext, 0 );

          plugins.Add(pluginitem);

          menu := TMenuItem.Create( MainMenu1 );
          menu.Caption := ExtractFileName(LuaSearch.Name);
          menu.OnClick := ShowPluginInfo;
          MainMenu1.Items[1].Items[2].Add(menu);

          hasIssue := False;
        end;
      end
      else
        // no register function
        ShowErrorPopup( LuaSearch.Name+ ': missing gzreplayRegister function', 'Script Error' )
    end;

    if hasIssue then
    begin
      // Clear unused Lua context
      pluginitem.L.Free;
      pluginitem.Free;
    end;

    LuaScriptRes := FindNext(LuaSearch);
  end;

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
var
  i: integer;
  rplugin : TReplayPlugin;
begin
  // .. part 2! :

  // Free the replayFile data
  replayFile.Free;
  replayFile := nil;

  // We can now update the UI now

  if replayInfo.ReadResult = GZR_SUCCESS then
  begin
    ResetUI;

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

    // NEW: Notify scripts
    if plugins <> nil then
    begin
      for i:=1 to plugins.Count do
      begin
        rplugin := plugins.Items[i-1];

        // attempt to call a special function
        lua_getglobal(rplugin.l.LuaContext, 'gzreplayNewFileLoaded');
        if lua_isfunction(rplugin.l.LuaContext, -1) then
        begin
          lua_call(rplugin.l.LuaContext, 0, 0);
        end;
      end;
    end;

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

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if Lua.IsLibraryOpened() then
    Lua.CloseLibrary;

  if plugins <> nil then
  begin
    plugins.Clear;
    plugins.Free;
    plugins := nil;
  end;

end;

procedure TForm1.ResetUI;
const
  NOMSG = '--';
begin
  // Properties
  // > General
  Label19.Caption  := NOMSG;
  Label18.Caption  := NOMSG;

  // > Replay Specific
  Label1.Caption   := NOMSG;
  Label16.Caption  := NOMSG;
  Label17.Caption  := NOMSG;
  Label20.Caption  := NOMSG;
  Label43.Caption  := NOMSG;

  // Settings

  // Characters

  // Statistics

  // More Statistics

  // Chat Logs
  
end;

procedure TForm1.Plugins1Click(Sender: TObject);
begin
  if TMenuItem(Sender).Count = 0 then
  begin
    ShowMessage('Plugin information');
  end;
end;

procedure TForm1.Reload1Click(Sender: TObject);
begin
  ReloadPlugins();
end;

end.

