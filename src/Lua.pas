{
  Lua.pas

  Based on Lua unit by Dennis D. Spreen

  ** REWRITE IN PROGRESS **
}
unit Lua;

interface

uses
  Classes,
  SysUtils,
  LuaLib;

function OpenLibrary()     : Boolean;
function CloseLibrary()    : Boolean;
function IsLibraryOpened() : Boolean;

type
  TLuaState = Lua_State;

  TLua = class(TObject)
  private
    fAutoRegister: Boolean;
    CallbackList: TList;
  public
    LuaContext: TLuaState;
    
    constructor Create; virtual;
    destructor Destroy; override;

    function LoadScript(Filename: String): Integer; virtual;

    procedure SetFunctionHook(FuncName: AnsiString; MethodName: AnsiString = ''; Obj: TObject = NIL); virtual;
  end;

implementation

type
  TProc = function(L: TLuaState): Integer of object; // Lua Function

  TCallback = class
    Routine: TMethod;  // Code and Data for the method
    Exec: TProc;       // Resulting execution function
  end;

function IsLibraryOpened() : Boolean;
begin
  Result := LuaLibLoaded();
end;

function OpenLibrary() : Boolean;
begin
  Result := false;

  if not LuaLibLoaded() then
    Result := LoadLuaLib() > 0;
end;

function CloseLibrary() : Boolean;
begin
  FreeLuaLib();
end;

function LuaCallBack(L: Lua_State): Integer; cdecl;
var
  CallBack: TCallBack;       // The Object stored in the Object Table
begin
  // Retrieve first Closure Value (=Object Pointer)
  CallBack := lua_topointer(L, lua_upvalueindex(1));

  // Execute only if Object is valid
  if (assigned(CallBack) and assigned(CallBack.Exec)) then
    Result := CallBack.Exec(L)
  else
    Result := 0;
end;

constructor TLua.Create();
begin
  inherited Create;

  if LuaLibLoaded then
  begin
    // Open Library
    LuaContext := Lua_Open();
    luaopen_base(LuaContext);
    luaopen_math(LuaContext); // new

    // Create Object List on initialization
    CallBackList := TList.Create;
  end
  else
    raise Exception.Create(GetLuaLibFileName()+' has not been loaded!');

end;

destructor TLua.Destroy;
begin
  // dispose Object List on finalization
  CallBackList.Free;

  // Close instance
  Lua_Close(LuaContext);
  inherited;
end;

function TLua.LoadScript(Filename: String): Integer;
begin
  Result := lual_dofile(LuaContext, PAnsiChar(AnsiString(Filename)));
end;

procedure TLua.SetFunctionHook(FuncName: AnsiString; MethodName: AnsiString = ''; Obj: TObject = NIL);
var
  CallBack: TCallBack; // Callback Object
begin
  // if method name not specified use Lua function name
  if (MethodName = '') then
    MethodName := FuncName;

  // if not object specified use this object
  if (Obj = NIL) then
    Obj := Self;

  // Add Callback Object to the Object Index
  CallBack := TCallBack.Create;
  CallBack.Routine.Data := Obj;
  CallBack.Routine.Code := Obj.MethodAddress(String(MethodName));
  CallBack.Exec := TProc(CallBack.Routine);
  CallbackList.Add(CallBack);

  // prepare Closure value (Method Name)
  lua_pushstring(LuaContext, PAnsiChar(FuncName));

  // prepare Closure value (CallBack Object Pointer)
  lua_pushlightuserdata(LuaContext, CallBack);

  // set new Lua function with Closure value
  lua_pushcclosure(LuaContext, LuaCallBack, 1);
  lua_settable(LuaContext, LUA_GLOBALSINDEX);
end;

end.
