unit gzrecReader;

interface

uses SysUtils, classes, ZLIBSTREAM, gzreplay, gzrecFrmProg;

type
  TReplayReaderInfo = record
  // could also hold the TMemoryStreams?
    Status   : String;
    ErrorMsg : String;
    Size,
    Time   : integer;
  end;

  TReplayReader = class(TThread)
  private
    gzFilePos,
    gzFilesize : integer;

    gzr : gzrClass; // todo: also make a pointer
    gzrStream : ^TMemoryStream;
    gzrInfo   : ^TReplayReaderInfo;

  public
    constructor Create( var gzrData : TMemoryStream ;
                        var info    : TReplayReaderInfo ); overload; 
    destructor Destroy; override;
    procedure Execute; override;
  end;

implementation

constructor TReplayReader.Create( var gzrData : TMemoryStream ;
                                  var info    : TReplayReaderInfo);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  gzrStream := @gzrData;
  gzrInfo   := @info;

  gzrInfo.ErrorMsg := '';
  gzrInfo.Status   := 'Waiting..';
//  gzrInfo.Pos      := 0;
  gzrInfo.Size     := 0;
  gzrInfo.Time     := 0;

end;

destructor TReplayReader.Destroy;
begin
  gzrInfo.Status   := 'Finished';
  gzr.Free;
  gzrStream := nil;
  inherited;
end;

procedure TReplayReader.Execute;
var
  tmp : uint32;
  loadResult : gzreplaystate;
begin

  gzrInfo.Status   := 'Checking file..';

  gzrStream.Read( tmp, sizeof( uint32 ) );
  gzrStream.Position := 0;

  // Either an uncompressed replay (for my own purposes)
  // or not compressed (a REC file)

  if tmp <> gzreplay.GZR_MAGIC then
  begin
    gzrInfo.Status   := 'Decompressing..';

    if not DecompressZlib( gzrStream^ ) then
    begin
      gzrInfo.ErrorMsg := 'Failed to decompress file!';
      Exit;
    end;
  end;

  gzrInfo.Size     := gzrStream.Size;
  gzrInfo.Status   := 'Processing..';

  gzr := gzrClass.Create;
  loadResult:= gzr.LoadReplay( gzrStream^ );
  if loadResult <> GZR_SUCCESS then
  begin
    gzrInfo.ErrorMsg := 'Failed to read replay';
  end;

end;

end.
