{
  LuaContext
  Written by x1nixmzeng

  Ported from C++ (luaexpose project)
  Base encapsulated for minimum manipulation
}
unit LuaContextBase;

interface

uses Classes, Lua, LuaLib;

type
  TLuaState = Lua_State;

  TLuaContextBase = class(TObject)
  private
    m_stackPos : integer;
  protected
    m_L : TLuaState;
  public
    constructor Create; overload;
    constructor Create( existingL : TLuaState ); overload;
    destructor Destroy; override;
    function countArguments() : integer;

{
	// -- Get items from the stack
const char *getCStr( int );
float getNum( int );
int getInt( int );

// -- Remove item from the stack
void pop( );

// --
void call( const char * );
bool hasFunction( const char * );

// -- Get global values (must exist)
int getGlobalInteger( const char * );
const char *getGlobalString( const char * );

// -- Push item to the stack
void pushStr( const string& );
void pushCStr( const char * );
void pushNum( float );
void pushInt( int );
void pushNil( );

int pushedItemCount() const;

// -- Type asserts (could return values)
void assertString( );
void assertNumber( );
void assertTable( );

// -- Error routines
const char *errorString( );

void exception( const string & );
void exception( const char * );
}

  end;

implementation

constructor TLuaContextBase.Create;
begin
  m_stackPos := 0;
  m_L := nil;
end;

constructor TLuaContextBase.Create( existingL : TLuaState );
begin
  m_stackPos := 0;
  m_L := existingL;
end;

destructor TLuaContextBase.Destroy;
begin
  inherited;
end;

function TLuaContextBase.countArguments() : integer;
begin
  Result := lua_gettop( m_L );
end;

end.
