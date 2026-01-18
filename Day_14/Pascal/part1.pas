program Part1;

{$mode objfpc} 
{$H+}

uses 
    SysUtils, 
    RegExpr;

type 
Reindeer = record
    name: string;
    speed: integer;
    duration: integer;
    cur_duration: integer;
    rest: integer;
    kms: integer;
    stop: integer;
end;
Reindeers = array[0..100] of Reindeer;

const secs = 2503;

var f : Text;
    line : string;
    re : TRegExpr;
    reins : Reindeers;
    i, j, s, max : integer;

begin 
    assign(f, '../input');
    {$I-}
    reset(f);
    {$I+}

    if IOResult <> 0 then
    begin
        writeln('Error: Could not open file');
        halt(1);
    end;
    i := 0;
    re := TRegExpr.create;
    try 
        re.expression := '(\w+) .* fly (\d+) .* for (\d+) .* for (\d+)';
        while not EOF(f) do
        begin 
            readln(f, line);
            if re.exec(line) then 
            begin 
                reins[i].name := re.Match[1];
                reins[i].speed := StrToInt(re.Match[2]);
                reins[i].duration := StrToInt(re.Match[3]);
                reins[i].cur_duration := StrToInt(re.Match[3]);
                reins[i].rest := STrToInt(re.Match[4]);
                reins[i].kms := 0;
                reins[i].stop := 0;
            end;        
            i += 1;
        end;

    finally
        re.free;
    end;
    
    for s := 0 to secs do 
    begin
        for j := 0 to i - 1 do 
        begin
            if reins[j].stop > 0 then 
            begin 
                reins[j].stop -= 1;
                if reins[j].stop = 0 then 
                begin 
                    reins[j].cur_duration := reins[j].duration;
                end;
                continue;
            end;
            reins[j].kms += reins[j].speed;
            reins[j].cur_duration -= 1;
            if reins[j].cur_duration = 0 then 
            begin 
                reins[j].stop += reins[j].rest;
            end;
        end;
    end;

    max := 0;
    for j := 0 to i - 1 do 
    begin
        if reins[j].kms > max then
        begin 
            max := reins[j].kms;
        end;
    end;
    writeln(max);
    close(f);
end.

