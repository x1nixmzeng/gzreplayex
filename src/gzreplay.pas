{
  GunZ Replay unit for Delphi (gzreplay.pas)

  Researched and coded by x1nixmzeng

  Throughout this process I have primarily worked from
  the raw replay files

  The later versions have been researched as a result
  of reverse-engineering the clients

  Thanks to kp93 for providing me with a v3 replay

  HISTORY
  =============================================================================
  August 3rd 2012
   Project branched from GunZ Replay Examiner 2 source

  December 30th 2012
   Added support for v9,v10,v11 replays

  January 3rd 2013
   Added support for GunZ2 commands
}
unit gzreplay;

interface

uses SysUtils, Classes;

{
  Known version changes:

  TODO: UPDATE THIS WITH NEW INFO

    0  First recording version with stage name, char list, and packets

      NOTE Packet description header might be different in early ~176 client

    1  Compressed data and more stage settings
    2  Admin flag
    3  UNKNOWN
    4  Duel mode added
    5  Duel Tournament mode added
    6  Consumable items
    7  Larger stage settings (relay?)
    8  Additional char info
    9  Support for Blitzkrieg ?? (no support for saving it)
         kgunz747 CAN save quest types - 6.7.c and d
    10 ??
    11 ?? But you can save Blitzkrieg replays (tested)

  support to record survival was added recently (apparently)
}

type
  uint32 = Cardinal;
  int32  = Integer;
  uint16 = Word;
  int16  = Smallint;
  float  = single;

const
  GZR_MAX_VER = 11;
  GZR_MAGIC : uint32 = $95B1308A;

type
  gzreplayState = (
    GZR_SUCCESS = 0,        // Worked fine
    GZR_BADREAD,            // Could not read from stream
    GZR_BADMAGIC,           // Wrong file version
    GZR_UNKNOWNVER,         // Unsupported replay version
    GZR_SUSPICIOUSPACKET,   // Bad packet (may be processed incorrectly)
    GZR_COMMAND_BADLENGTH,
    GZR_COMMAND_BADPACKET
  );

  gz2Battletype = (
    GZ2GAMETYPE_DEATHMATCH = 0,          // 0
    GZ2GAMETYPE_DEATHMATCH_EXTREME_TEAM, // 1
    GZ2GAMETYPE_SCENARIO,                // 2
    GZ2GAMETYPE_KOTH,                    // 3 King of the Hill
    GZ2GAMETYPE_DEATHMATCH_TEAM,         // 4
    GZ2GAMETYPE_CAPTURE_FLAG,            // 5 Capture the Flag
    GZ2GAMETYPE_DUEL                     // 6
  );

  gzreplayGametype = (
    GZGAMETYPE_DEATHMATCH_SOLO =0, // 0 DM
	  GZGAMETYPE_DEATHMATCH_TEAM,    // 1 DMT
	  GZGAMETYPE_GLADIATOR_SOLO,     // 2 GL
	  GZGAMETYPE_GLADIATOR_TEAM,     // 3 GLT
	  GZGAMETYPE_ASSASSINATE,        // 4 ASSA
	  GZGAMETYPE_TRAINING,           // 5 TR
	  GZGAMETYPE_SURVIVAL,           // 6 SURV
	  GZGAMETYPE_QUEST,              // 7 QST
	  GZGAMETYPE_BERSERKER,          // 8 DMTBSK
	  GZGAMETYPE_DEATHMATCH_TEAM2,   // 9 DMTE
	  GZGAMETYPE_DUEL,               // A DUEL
	  GZGAMETYPE_DUELTOURNAMENT,     // B DUELT
    GZGAMETYPE_CHALLENGEQUEST,     // C QSTC
    GZGAMETYPE_BLITZKRIEG          // D BLK

  );

  gzrUID = packed record
    high,
    low  : uint32;
  end;

  gz2sid = gzrUID; // session id

  gzrCharacter = packed record
    id    : gzrUID;
    Name  : String;
  end;

  gzrChatMessage = packed record
    id    : gzrUID;
    Where : uint32; // stage, clan, private?
    Time  : float;    
    Msg   : String;
  end;

  gzrDuelClass = (NODUELCLASS, // For versions that do not support it
                  CLASS01,     // Crossed Swords, Fireball x3
                  CLASS02,     // Crossed Swords, Fireball x1
                  CLASS03,     // Gold Dagger x4
                  CLASS04,     // Gold Dagger x3
                  CLASS05,     // Gold Dagger x2
                  CLASS06,     // Gold Dagger x1
                  CLASS07,     // Dagger x4
                  CLASS08,     // Dagger x3
                  CLASS09,     // Dagger x2
                  CLASS10);    // Dagger x1

  gzrClass = class
    private
      Version,
      Gametype,
      Owner,
      PacketCount
                : uint32;
      MapName   : String;
      StartedAt,
      StoppedAt : float;

      PlayerCount : uint32;
      Players   : array of gzrCharacter;

      ChatCount : uint32;
      ChatLogs  : array of gzrChatMessage;

      function GetPlayerFromUid( uid: gzrUID; elseMake: Boolean = false ): uint32;

      function ReadGzrHeader( gzrFile: TMemoryStream ): gzreplayState;
      function ReadGzrSettings( gzrFile: TMemoryStream ): gzreplayState;
      function ReadGzrPlayers( gzrFile: TMemoryStream ): gzreplayState;
      function ReadNpcData( gzrFile: TMemoryStream ): gzreplayState;
      function ParseGzrPackets( gzrFile: TMemoryStream ): gzreplayState;
      function ParseRecPackets( gzrFile: TMemoryStream ): gzreplayState;      

      procedure PushPacket( owner: gzrUID; packet: uint16; data: TMemoryStream );
    public
      constructor Create;
      destructor Destroy;

      function LoadReplay( gzrFile: TMemoryStream ): gzreplayState;
      function LoadReplay2( gzrFile: TMemoryStream ): gzreplayState;

      // constant accessor functions
      function GetVersion(): uint32;
      function GetVersionStr() : string; 
      function GetOwnerChar(): string;
      function GetRunningTime(): float;
      function GetTotalPackets(): uint32;

      function GetChar(index:uint32): String;
      function GetTotalPlayers(): uint32;
      function GetMapName(): String;
      function GetChatLog(): String;
  end;

implementation

constructor gzrClass.Create;
begin
  inherited Create;
  // setup stuff

  PlayerCount := 0;
  SetLength( Players, 0 );

  ChatCount := 0;
  SetLength( ChatLogs, 0 );
end;

destructor gzrClass.Destroy;
var
  i: uint32;
begin
  for i:=1 to PlayerCount do
    SetLength( Players[i-1].Name, 0 );
  SetLength(Players, 0);

  for i:=1 to ChatCount do
    SetLength( ChatLogs[i-1].Msg, 0 );
  SetLength(ChatLogs, 0);

  inherited Destroy;
end;

function gzrClass.GetPlayerFromUid( uid: gzrUID; elseMake: Boolean ): uint32;
var
  i: uint32;
begin
  Result := 0;

  for i := 1 to PlayerCount do
  begin
    if ( ( Players[i-1].id.high = uid.high )
     and ( Players[i-1].id.low  = uid.low ) ) then
    begin
      Result := i;
      Exit; // success!
    end;
  end;

  if elseMake then
  begin
    inc( PlayerCount );
    SetLength( Players, PlayerCount );
    Players[PlayerCount-1].id := uid;
    
    Result := PlayerCount; 
  end;

end;

function gzrClass.ReadGzrHeader( gzrFile: TMemoryStream ): gzreplayState;
var
  tmp       : uint32;
begin
  Result := GZR_SUCCESS;

  // Read GZR magic
  gzrFile.Read( tmp, sizeof( uint32 ) );

  if tmp <> GZR_MAGIC then
  begin
    Result := GZR_BADMAGIC;
    Exit;
  end;

  // Read version flag
  gzrFile.Read( tmp, sizeof( uint32 ) );

  if not( tmp <= GZR_MAX_VER ) then
  begin
    Result := GZR_UNKNOWNVER;
    Exit;
  end;

  Version := tmp;     

end;

type
  recStageSettings = packed record
    MapName : array[0..255] of char;
    GameType: uint32;
  end;

function gzrClass.ReadGzrSettings( gzrFile: TMemoryStream ): gzreplayState;
var
  v0Stage : recStageSettings;
  i, j, charRef: uint32;
begin

  if Version = 0 then
  begin

    gzrFile.Read( v0Stage, sizeof( recStageSettings ) );

    SetLength( MapName, StrLen( v0Stage.MapName ) );
    MapName := v0Stage.MapName;
    
  end
  else
  begin

    // stage uid + stage name (+ map index?)
    gzrFile.Position := gzrFile.Position + (8{+32+4});

    // Using stage 0 structure as string buffer here (TMP)!)!) 
    gzrFile.Read( v0Stage.MapName, 32 );
    SetLength( MapName, StrLen( v0Stage.MapName ) );
    MapName := v0Stage.MapName;

    gzrFile.Position := gzrFile.Position + ({8+32+}4);
    // = 44 bytes

    if Version >= 7 then // 100 total
    begin
      gzrFile.Position := gzrFile.Position + 32; // unknown extras
    end;

    // else, 68 total
    gzrFile.Read( GameType, sizeof( uint32 ) );

    gzrFile.Position := gzrFile.Position + 20;


    // NEW: GameType check

    if ( Version >= 4 ) and ( GameType = $A ) then
    begin
      // duel
      gzrFile.Position := gzrFile.Position + 131;
    end
    else
    if ( Version >= 5 ) and ( GameType = $B ) then
    begin
      // duel tournament
      gzrFile.Position := gzrFile.Position + 4;
      gzrFile.Position := gzrFile.Position + 4; // should be 8
      gzrFile.Position := gzrFile.Position + ( 8 * 44 );
      gzrFile.Position := gzrFile.Position + 96;
    end
    else
    if ( Version >= 9 ) then
    begin
      // when was this added?
      if ( GameType = $C ) then // challenge quest
      begin
        gzrFile.Read(j, 4); // round?
        j:=0;// challenge quest round #
      end
      else
      if ( GameType = $7 ) then // quest
      begin
        gzrFile.Seek( $52, soCurrent ); // unknown
      end
      else
      if ( GameType = $6 ) then // survival
      begin
        gzrFile.Seek( $52, soCurrent ); // unknown
      end
      else
      // OTHER STUFF
      if ( GameType = $D ) then // blitz
      begin
         // no longer skipable due to dynamic length char names!

         gzrFile.Seek(21, soCurrent); // not sure where the 1 comes from

         // read the int (char counter)

         gzrFile.Read(charRef, 4);

         for i:=1 to charRef do
         begin

           gzrFile.Seek(8, soCurrent);
           gzrFile.Read(j, 4);
           if Version > 10 then
             gzrFile.Seek(j+8 + 64 + 12, soCurrent)
           else
             gzrFile.Seek(j+8 + 52 + 12, soCurrent)
         
         // then structure is as follows:
         {
           muid
           int (namelen)
           char name[namelen];
           int a, b
           when ver > 10
             data[64]
           else
             data[52]
           misc[12]
          }

          end;

          // should now be at character data
      end;
    end;
  end;

  Result := GZR_SUCCESS;
end;

function gzrClass.ReadGzrPlayers( gzrFile: TMemoryStream ): gzreplayState;
const
  GZR_OWNER   : byte = 1;
var
  i : uint32;
  tmpName     : array[0..31] of char;
  charFlag    : byte;
begin
  Result := GZR_SUCCESS;

  gzrFile.Read( PlayerCount, sizeof( uint32 ) );

  SetLength( Players, PlayerCount );

  for i := 1 to PlayerCount do
  begin
    gzrFile.Read( charFlag, sizeof( byte ) );// isMyChar flag
    if charFlag = GZR_OWNER then Owner := i;

    // character detail (just reading name here)
    gzrFile.Read( tmpName, 32 );

    SetLength( Players[i-1].Name, StrLen( tmpName ) );
    Players[i-1].Name := tmpName;

    //##############################################################
    // read remaining character info

    // does not change from 8-11
    if version >= 8 then
      gzrFile.Position := gzrFile.Position +(382-32) // ??
    else
    if version >= 6 then
      gzrFile.Position := gzrFile.Position +(374-32) // ??
    else
    if version >= 5 then
      gzrFile.Position := gzrFile.Position +(150-32) // added lastGrade
    else
    if version >= 2 then
      gzrFile.Position := gzrFile.Position +(146-32) // added clanid
    else
    if version >= 1 then
      gzrFile.Position := gzrFile.Position +(142-32)
    else
//    if version = 0 then
      gzrFile.Position := gzrFile.Position +(116-32);

    //##############################################################

//  gzrFile.Position := gzrFile.Position +8; // uid

    gzrFile.Read( Players[i-1].id, sizeof( gzrUID ) ); // uid

    if Version = 0 then
    begin
      gzrFile.Position := gzrFile.Position +296;
      gzrFile.Position := gzrFile.Position +(12*(4+4));
      gzrFile.Position := gzrFile.Position +56;
    end
    else
    begin
      gzrFile.Position := gzrFile.Position +88;// old properties

      if Version = 1 then
      begin
        gzrFile.Position := gzrFile.Position +56;
      end
      else
      begin
        gzrFile.Position := gzrFile.Position +4; // hp
        gzrFile.Position := gzrFile.Position +4; // ap

//        // Not v3 as v2 is 48
//        if Version >= 2 then
          gzrFile.Position := gzrFile.Position +48
//        else
//          gzrFile.Position := gzrFile.Position +44;

      end;

      if Version >= 9 then
        gzrFile.Position := gzrFile.Position +(17*(4+4+4+4)) // increased ids
      else
      if Version >= 6 then
        gzrFile.Position := gzrFile.Position +(17*(4+4)) // increased inv. size
      else
        gzrFile.Position := gzrFile.Position +(12*(4+4));
    end;
          
    gzrFile.Position := gzrFile.Position +12;// pos
    gzrFile.Position := gzrFile.Position +12;// dir
    gzrFile.Position := gzrFile.Position +4; // teamid
    gzrFile.Position := gzrFile.Position +1; // is_dead

    // NOT in v1
    if Version >= 2 then
      gzrFile.Position := gzrFile.Position +1; // is_hidden (for invisible admin)

  end;

end;

function gzrClass.ReadNpcData( gzrFile: TMemoryStream ): gzreplayState;
var
  it, i : uint32;
begin
  Result := GZR_SUCCESS;

  case Gametype of

  // survival
    $6 :
    begin
      gzrFile.read( it, 4 );

      for i:=1 to it do
      begin
        // same as quest
        gzrFile.Seek(56, soCurrent);
      end;
    end;

  // quest
    $7 :
    begin
      gzrFile.read( it, 4 );

      for i:=1 to it do
      begin
        {
           56 bytes
             uid 8        npc identifier
             int 4        type?
             int 4        flag?
             float x9     position/rotation?
             int unknown  same for all npcs (owner?)
        }
        gzrFile.Seek(56, soCurrent);
      end;
    end;

  // challenge quest
    $C :
    begin
      // reads int (4 bytes) then 100 x n?)
      gzrFile.read( it, 4 ); // what does this represent?

      for i:=1 to it do
      begin

        // NPC mesh and position ? who knows
        gzrFile.Seek(100, soCurrent);

      end;      
    end;

  // blitz
    $D :
    begin
      // reads int (4 bytes) at least..

      gzrFile.read( it, 4 ); // what does this represent?

      for i:=1 to it do
      begin

        // read npc entry
        {
          contains the npc name (?)
          mesh index (?)
          positions
          current animation cycle, etc

        }
        if Version = 9 then
        begin
          // npc entry is only 176 bytes

          gzrFile.Seek( 176, soCurrent );

        end
        else // must be 10/11/newer
        begin
          // entry is 180
          gzrFile.Seek( 180, soCurrent );

        end;

      end;

    end;

  end;

  // test

end;

// 12 bytes
type gzrPacketHead = packed record
  time: float;
  owner: gzrUID;
  size: uint32;
end;

// 5 bytes
type gzrPacketDesc = packed record
  size,
  id      : uint16;
  padding : byte;
end;

function gzrClass.ParseGzrPackets( gzrFile: TMemoryStream ): gzreplayState;
const
  GZR_MAX_PACKETSIZE = (1 shl 11); // 2048 bytes
var
  pktHead : gzrPacketHead;
  pktDesc : gzrPacketDesc;
  pktData : TMemoryStream;
begin
  Result := GZR_SUCCESS;

  // Read the started at time
  gzrFile.Read( StartedAt, sizeof( float ) );
  StoppedAt := StartedAt;

  PacketCount := 0;

  pktData := TMemoryStream.Create;

  // Generic packet parser (all replay versions)
  while gzrFile.Position < gzrFile.Size do
  begin
    gzrFile.Read( pktHead, sizeof( gzrPacketHead ) );

    // Quick size check here
    if pktHead.size > GZR_MAX_PACKETSIZE then
    begin
      Result := GZR_SUSPICIOUSPACKET;
      pktData.Free;
      Exit;
    end;

    if pktHead.size > 5 then
    begin
      gzrFile.Read( pktDesc, sizeof( gzrPacketDesc ) );

      if ( pktDesc.size > GZR_MAX_PACKETSIZE )
       or( pktDesc.size <> ( pktHead.size and $FFFF ) ) then
      begin
        Result := GZR_SUSPICIOUSPACKET;
        pktData.Free;
        Exit;
      end;

      pktData.Clear;
//      pktData.Position := 0;
      pktData.CopyFrom( gzrFile, ( pktHead.size - sizeof( gzrPacketDesc ) ) );

      // todo: push the data to each plugin

      PushPacket( pktHead.owner, pktDesc.id, pktData );

    end
    else
      // warning that packet is empty?
      gzrFile.Position := gzrFile.Position + pktHead.size;

    StoppedAt := pktHead.time;
    inc(PacketCount);
  end;

  pktData.Free;

end;

{
  should only be 5 bytes

  word  size (5 + len)
  word  packet id
  byte  some shifting value >> 2
}


// 12 bytes
type recPacketDesc = packed record
  unknown,
  id,
  unknown_val2      // possible byte value with 4-byte structure alignment
          : uint32;
end;

function gzrClass.ParseRecPackets( gzrFile: TMemoryStream ): gzreplayState;
const
  GZR_MAX_PACKETSIZE = (1 shl 10); // 1024 bytes

  PKT_PEER_OBJECTCHANGEWEAPON = 90005;// Peer.ObjectChangeWeapon
  PKT_PEER_SHOT               = 90010;// Peer.Shot
  PKT_PEER_RELOAD             = 90011;// Peer.Reload
  PKT_PEER_DIE                = 90012;// Peer.Die
  PKT_PEER_SPAWN              = 90013;// Peer.Spawn
  PKT_PEER_OBJECTSKILL        = 90014;// Peer.ObjectSkill
  PKT_PEER_SHOT_SP            = 90016;// Peer.Shot.Sp
  PKT_PEER_OBJECTTAUNT        = 90017;// Peer.ObjectTaunt
  PKT_PEER_DASH               = 90018;// Peer.Dash
  PKT_PEER_CHARACTERBASICINFO = 90050;// Peer.CharacterBasicInfo
  PKT_PEER_CHARACTERHPINFO    = 90051;// Peer.CharacterHPInfo

var
  pktHead : gzrPacketHead;
  recDesc : recPacketDesc;
begin
  Result := GZR_SUCCESS;
  
  // Read the started at time
  gzrFile.Read( StartedAt, sizeof( float ) );
  StoppedAt := StartedAt;

  PacketCount := 0;

  while gzrFile.Position < gzrFile.Size do
  begin
    gzrFile.Read( pktHead, sizeof( gzrPacketHead ) );

    if pktHead.size > GZR_MAX_PACKETSIZE then
    begin
      Result := GZR_SUSPICIOUSPACKET;
      Exit;
    end;

    gzrFile.Read( recDesc, sizeof( recPacketDesc ) );

    // TODO:
    case recDesc.id of
      PKT_PEER_OBJECTCHANGEWEAPON :
      begin
      end;
      PKT_PEER_SHOT               :
      begin
      end;
      PKT_PEER_RELOAD             :
      begin
      end;
      PKT_PEER_DIE                :
      begin
      end;
      PKT_PEER_SPAWN              :
      begin
      end;
      PKT_PEER_OBJECTSKILL        :
      begin
      end;
      PKT_PEER_SHOT_SP            :
      begin
      end;
      PKT_PEER_OBJECTTAUNT        :
      begin
      end ;
      PKT_PEER_DASH               :
      begin
      end;
      PKT_PEER_CHARACTERBASICINFO :
      begin
      end;
      PKT_PEER_CHARACTERHPINFO    :
      begin
      end;
    end;

    // this should be else, but this is a test!
    gzrFile.Position := gzrFile.Position
                     + ( pktHead.size - sizeof( recPacketDesc ) );

    StoppedAt := pktHead.time;
    inc(PacketCount);
  end;

end;

function gzrClass.LoadReplay( gzrFile: TMemoryStream ): gzreplayState;
begin

  Result := ReadGzrHeader( gzrFile );     if Result <> GZR_SUCCESS then Exit;
  Result := ReadGzrSettings( gzrFile );   if Result <> GZR_SUCCESS then Exit;
  Result := ReadGzrPlayers( gzrFile );    if Result <> GZR_SUCCESS then Exit;

  if Version > 4 then
  begin
    Result := ReadNpcData( gzrFile );
    if Result <> GZR_SUCCESS then exit;
  end;

  // The packets are handled so differently it could do with 2 functions:

  if Version = 0 then  Result := ParseRecPackets( gzrFile )
  else                 Result := ParseGzrPackets( gzrFile );

  // todo: check position = size = finished parsing file?

end;

function gzrClass.LoadReplay2( gzrFile: TMemoryStream ): gzreplayState;
var
  localSize,
  totalSize  : uint32;

  firstTick,
  lastTick,
  cmdSize   : uint32;

  floatTick : single;
begin

  PacketCount := 0;
  localSize := 0;
  gzrFile.Read( totalSize, 4 );

  if totalSize +4 <> gzrFile.Size then
  begin
    Result := GZR_COMMAND_BADLENGTH;
    exit;
  end;

  firstTick := 0;

  // read first packet
  if totalSize > 0 then
  begin
    gzrFile.Read(firstTick, 4);
    gzrFile.Read(cmdSize, 4);

    if cmdSize >= 1024 then
    begin
      Result := GZR_COMMAND_BADPACKET;
      exit;
    end;

    gzrFile.Seek(cmdSize, soCurrent);
    inc(localSize,4+cmdSize);
    inc( PacketCount );
    lastTick := firstTick; // bugfix  
  end;

  // all other packets
  while localSize < totalSize do
  begin
    gzrFile.Read(lastTick, 4);
    gzrFile.Read(cmdSize, 4);

    if cmdSize >= 1024 then
    begin
      Result := GZR_COMMAND_BADPACKET;
      exit;
    end;

    gzrFile.Seek(cmdSize, soCurrent);
    inc(localSize,4+cmdSize);
    inc( PacketCount );
  end;

  StartedAt := firstTick / 1000; // convert to float
  StoppedAt := lastTick / 1000; // convert to float

  Result := GZR_SUCCESS;
end;

function gzrClass.GetVersion(): uint32;
begin
  Result := Version;
end;

function gzrClass.GetVersionStr() : string;
begin
  if Version = 0 then
    Result := 'REC'
  else
    Result := Format('GZR %d.0', [Version]);
end;

function gzrClass.GetChar(index:uint32): String;
begin
  Result := '';
  if index < PlayerCount then
    Result:= Players[index].Name;
end;

function gzrClass.GetOwnerChar(): string;
begin
  Result := '';

  if PlayerCount > 0 then
    Result := GetChar(owner-1);
end;

function gzrClass.GetRunningTime(): float;
begin
  Result := ( StoppedAt - StartedAt );
end;

function gzrClass.GetTotalPackets(): uint32;
begin
  Result := PacketCount;
end;

function gzrClass.GetTotalPlayers(): uint32;
begin
  Result := PlayerCount;
end;

procedure gzrClass.PushPacket( owner: gzrUID; packet: uint16; data: TMemoryStream );
var
  tmp32: uint32;
  tmpS : String;
begin
  // find all hooks asking for the packet id

  // owner:   
  // buffer: data.Memory^
  // size:   (uint32)data.size
  
  if ( packet = 10052 ) and ( Version = 1 ) then
  begin
    data.Seek(6, soBeginning);
    data.Read(tmp32, sizeof(uint32));

    if tmp32 > $400 then Exit; // badly!

    inc( ChatCount );    
    SetLength( ChatLogs, ChatCount );

    ChatLogs[ ChatCount-1 ].id := owner;
    SetLength( tmpS, tmp32 );
    data.Read( tmpS[1], tmp32 );
    

    ChatLogs[ ChatCount-1 ].Msg := tmpS;
    SetLength( tmpS, 0 );

  end;

end;

function gzrClass.GetMapName(): String;
begin
  Result := MapName;
end;

function gzrClass.GetChatLog(): String;
var
  i,pId: uint32;
begin
  Result := '';

  for i := 1 to ChatCount do
  begin
    pId := GetPlayerFromUid( ChatLogs[i-1].id, false );

    // Check player exists!
    if pId <> 0 then
    begin
      Result := Result
              + Format('%s : %s',
                  [
                    players[pId-1].Name,
                    ChatLogs[i-1].Msg
                  ])
              + #13#10;
    end;
  end;
end;

end.
