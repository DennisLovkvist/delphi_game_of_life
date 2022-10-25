


program GameOfLife;

uses System.SysUtils;

{$APPTYPE CONSOLE}

function WithinBounds(x:Integer): Integer;
begin
  if x < 0 then
    begin
      WithinBounds := 0;
    end
  else if x > 399 then
    begin
      WithinBounds := 0;
    end
  else
    WithinBounds := 1;
end;


procedure Step(var cells:Array of Integer; var cells_next:Array of Integer);

const kernel:Array[0..8] of Integer = (-20-1,-20,-20+1,-1,0,1,20-1,20,20+1);
var i:Integer;
var j:Integer;
var ki:Integer;
var wb:Integer;
var n_count:Integer;

begin
  for i := 0 to 399 do  
  begin 
    n_count := 0;
    //---Count neighbours---
    for j := 0 to 8 do  
    begin
      ki:= i + kernel[j];
      if ki <> i then
      begin
        wb := WithinBounds(ki); 
        if wb = 1 then
        begin
          if cells[ki] = 1 then
          begin
            n_count := n_count +1;
          end;
        end;
      end;
    end;
    //---Count neighbours---
    //---Apply rule for next generation---
    if cells[i] = 0 then
      begin
        if n_count = 3 then
        begin
          cells_next[i] := 1;
        end
      end
      else if cells[i] = 1 then
      begin
        if (n_count < 2) or (n_count > 3) then
        begin
          cells_next[i] := 0;
        end
      end
    //---Apply rule for next generation---
  end;//End loop 0..399

  //---Update cells to the alterd state---//
  for i := 0 to 399 do  
  begin
    cells[i] := cells_next[i];
  end;
  //---Update cells to the alterd state---//

end;


procedure PrintBuffered(cells:Array of Integer);
var i:Integer;
var n:Integer;
var buffer:WideString;
begin  

  n := 0;
  //---Loop cells---
  for i := 0 to 399 do  
  begin 
    //---Print blakspace if cell = 0 and # if cell = 1---
    if cells[i] = 0 then
    begin
      buffer := buffer + ' ';
    end
    else
    begin
      buffer := buffer + '#';
    end;
    buffer := buffer + ' ';//Extra space to padd horizontally
    //---Print blakspace if cell = 0 and # if cell = 1---

    //---Print line break---
    n:=n+1;   
    if n = 20 then
    begin
      buffer := buffer + #13#10;
      n:=0;
    end;
    //---Print line break---

  end;
  //---Loop cells---

  WriteLn(buffer);
end;

procedure PrintImmediate(cells:Array of Integer);
var i:Integer;
var n:Integer;
begin
  n := 0;
  //---Loop cells---
  for i := 0 to 399 do  
  begin 
    //---Print blakspace if cell = 0 and # if cell = 1---
    if cells[i] = 0 then
    begin
      Write(' ');
    end
    else
    begin
      Write('#');
    end;
    Write(' ');//Extra space to padd horizontally
    //---Print blakspace if cell = 0 and # if cell = 1---

    //---Print line break---
    n:=n+1;   
    if n = 20 then
    begin
      WriteLn(' ');
      n:=0;
    end;
    //---Print line break---

  end;
  //---Loop cells---
end;


//main-------------------------
var cells : array[0..399] of Integer;
var cells_next : array[0..399] of Integer;
var i:Integer;
var generation:Integer;
begin
  for i := 0 to 399 do  
    begin
    if Random(100) > 50 then
      begin
          cells[i] := 1;
          cells_next[i] := 1;
      end
    else
      begin
          cells[i] := 0;
          cells_next[i] := 0;
      end;     
  end;


  while true do
  begin
    
  Step(cells,cells_next);
  generation := generation + 1;
  PrintBuffered(cells);
  Write('_____________ ');  
  Write('Generation ');  
  Write(generation);  
  WriteLn(' _____________');  
  Sleep(500);
  end;
  
  
end.



