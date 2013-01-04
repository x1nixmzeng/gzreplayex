{
  TMemoryStream wrappers for selected ZLibEx functions
  WRS
  
  v0.02
    Temporary buffer is now used in some functions
}

unit ZLIBSTREAM;

interface

uses Classes, ZLibEx;

function DecompressZLib( var buffer: TMemoryStream ):Boolean;
function CompressZLib( var buffer: TMemoryStream ):Boolean;
function CRC32( var buffer: TMemoryStream ): Cardinal;

implementation

function DecompressZLib( var buffer: TMemoryStream ):Boolean;
var
  dStrm   : TZDecompressionStream;
  tmp     : TMemoryStream;
begin
  Result := False;
  dStrm  := TZDecompressionStream.Create( buffer );
  tmp    := TMemoryStream.Create;

  try
    tmp.CopyFrom( dStrm, 0 );
    dStrm.Free;

    buffer.Free;
    buffer := TMemoryStream.Create;
    buffer.LoadFromStream( tmp );
    buffer.Position := 0;
    tmp.Free;
    
    Result := True;
  except
    dStrm.Free;
    tmp.Free;
  end;

end;

function CompressZLib( var buffer: TMemoryStream ):Boolean;
var
  cStrm   : TZCompressionStream;
  tmp     : TMemoryStream;
begin
  Result := False;
  tmp    := TMemoryStream.Create;
  cStrm  := TZCompressionStream.Create( tmp );

  try
    cStrm.CopyFrom( buffer, buffer.Size );
    cStrm.Free;

    buffer.Free;
    buffer := TMemoryStream.Create;
    buffer.LoadFromStream( tmp );
    buffer.Position := 0;
    tmp.Free;

    Result := True;
  except
    tmp.Free;
    cStrm.Free;
  end;

end;

function CRC32( var buffer: TMemoryStream ): Cardinal;
begin
  Result := ZCrc32(0, buffer.Memory^, buffer.Size);
end;

end.
 