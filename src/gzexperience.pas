{
  Based on the formula I posted in 2010:
    http://forum.ragezone.com/f245/experience-table-formula-683451/

  Written by x1nixmzeng
}

unit gzexperience;

interface

const
  MAX_LEVEL = 99;

type
  uint32 = longword;

var
  reqExp : array[1..MAX_LEVEL] of uint32;

  procedure CalculateExpTable();
  function ExpToNextLevel(exp: uint32): uint32;
  function GetLevelFromExp(exp: uint32): uint32;

implementation

type
  LevelRate = record
    min,max,val : uint32;
  end;

const
  // level multipliers (x100) from 'formula.xml'
  NeedExpLM : array[0..12] of LevelRate =
  (
    (min:1;max:20;val:100),   //<LM lower="1" upper="20">1</LM>
    (min:21;max:30;val:110),  //<LM lower="21" upper="30">1.1</LM>
    (min:31;max:40;val:120),  //<LM lower="31" upper="40">1.2</LM>
    (min:41;max:45;val:140),  //<LM lower="41" upper="45">1.4</LM>
    (min:46;max:50;val:160),  //<LM lower="46" upper="50">1.6</LM>
    (min:51;max:55;val:180),  //<LM lower="51" upper="55">1.8</LM>
    (min:56;max:60;val:200),  //<LM lower="56" upper="60">2</LM>
    (min:61;max:65;val:400),  //<LM lower="61" upper="65">4</LM>
    (min:66;max:70;val:800),  //<LM lower="66" upper="70">8</LM>
    (min:71;max:75;val:1200), //<LM lower="71" upper="75">12</LM>
    (min:76;max:80;val:1600), //<LM lower="76" upper="80">16</LM>
    (min:81;max:90;val:2000), //<LM lower="81" upper="85">20</LM>
                              //<LM lower="86" upper="90">20</LM>
    (min:91;max:99;val:4000)  //<LM lower="91" upper="95">40</LM>
                              //<LM lower="96" upper="99">40</LM>
  );

procedure CalculateExpTable();
var
  LMTable : array[1..MAX_LEVEL] of uint32;
  i, j, lvl: uint32;
begin

  // fill out level multipliers
  for i:=0 to length( NeedExpLM ) -1 do
  begin
    assert( ( NeedExpLM[i].min >= 1 ) and (NeedExpLM[i].min <= MAX_LEVEL ) );
    assert( ( NeedExpLM[i].max >= 1 ) and (NeedExpLM[i].max <= MAX_LEVEL ) );
    assert( NeedExpLM[i].min < NeedExpLM[i].max );    

    for j:= NeedExpLM[i].min to NeedExpLM[i].max do
      LMTable[j] := NeedExpLM[i].val;
  end;

  // calculate exp for level 1
  reqExp[1] := LMTable[1]*2;

  // calculate all other levels
  for lvl:=2 to MAX_LEVEL do
  begin
    reqExp[lvl] := reqExp[lvl-1]
                    + ( lvl*lvl*LMTable[lvl]*2 );
  end;

end;

function ExpToNextLevel(exp: uint32):uint32;
var lvl: uint32;
begin
  Result := 0; // no more exp at level 99+

  for lvl:=1 to MAX_LEVEL do
  begin
    if reqExp[lvl] > exp then
    begin
      Result := reqExp[lvl] - exp;
      Exit;
    end;
  end;
end;

function GetLevelFromExp(exp: uint32): uint32;
begin
  Result := MAX_LEVEL;

  while Result > 1 do
  begin
    if reqExp[Result-1] <= exp then
      Exit;

    dec(Result);
  end;

end;

end.
