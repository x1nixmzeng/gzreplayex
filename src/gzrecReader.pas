unit gzrecReader;

interface

uses SysUtils, classes, ZLIBSTREAM, gzreplay, gzrecFrmProg;

type
  TReplayReaderInfo = record
    Status   : String;
    ErrorMsg : String;
    Progress,
    Size     : integer;
    Replay   : gzrClass;
    ReadResult : gzreplaystate;
  end;

  TReplayReader = class(TThread)
  private
    gzFilePos,
    gzFilesize : integer;

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
  gzrInfo.Progress := 0;
  gzrInfo.Size     := 0;

end;

destructor TReplayReader.Destroy;
begin
  gzrInfo.Status   := 'Finished';
  gzrInfo.Progress := 100;
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
    gzrInfo.Progress := 10;
    gzrInfo.Status   := 'Decompressing..';

    if not DecompressZlib( gzrStream^ ) then
    begin
      gzrInfo.Progress := 100;
      gzrInfo.ErrorMsg := 'Could not decompress this replay file';
      Exit;
    end;
  end;

  gzrStream.SaveToFile('gzrdebug.gzr');

  gzrInfo.Progress := 50;
  gzrInfo.Size     := gzrStream.Size;
  gzrInfo.Status   := 'Processing..';
  gzrInfo.Replay   := gzrClass.Create;
  gzrInfo.ReadResult := gzrInfo.Replay.LoadReplay( gzrStream^ );

  if gzrInfo.ReadResult <> GZR_SUCCESS then
  begin
    // TODO: Expand on the error messages from the read result
    //  .. but keep the case statement here
    gzrInfo.ErrorMsg := 'Could not parse this replay file';
  end;

  gzrInfo.Progress := 100;
  Sleep(100);

end;

end.
