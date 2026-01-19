with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with GNAT.Regpat; use GNAT.Regpat;

procedure Read_File_Content is

    type Ingredient is record
        Capacity : Integer;
        Durability : Integer;
        Flavor : Integer;
        Texture : Integer;
        Calories : Integer;
    end record;

    type Amount_List is array(1 .. 10) of Integer;

    Ingredients : array(1 .. 10) of Ingredient;
    Count : Natural := 0;
    File_Name : String := "../input";  
    File_Handle : File_Type;
    Line : String (1 .. 1024);      
    Last : Natural;                 
    Pattern : String := "(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)";
    Matcher : Pattern_Matcher (1024);
    Matches : Match_Array (0..6);
    Max : Long_Long_Integer := 0;
    function Val (Idx : Integer) return Integer is
        begin
            return Integer'Value (Line (Matches (Idx).First .. Matches (Idx).Last));
        end Val;
    procedure Cal(Amounts : Amount_List) is 
        Cap_Sum, Dur_Sum, Flav_Sum, Tex_Sum : Long_Long_Integer := 0;
        Sum : Long_Long_Integer := 0;
    begin
        for I in 1 .. Count loop
            Cap_Sum := Cap_Sum + Long_Long_Integer (Amounts (I)) * Long_Long_Integer (Ingredients (I).Capacity);
            Dur_Sum := Dur_Sum + Long_Long_Integer (Amounts (I)) * Long_Long_Integer (Ingredients (I).Durability);
            Flav_Sum := Flav_Sum + Long_Long_Integer (Amounts (I)) * Long_Long_Integer (Ingredients (I).Flavor);
            Tex_Sum := Tex_Sum + Long_Long_Integer (Amounts (I)) * Long_Long_Integer (Ingredients (I).Texture);
        end loop;

        if Cap_Sum < 0 then Cap_Sum := 0; end if;
        if Dur_Sum < 0 then Dur_Sum := 0; end if;
        if Flav_Sum < 0 then Flav_Sum := 0; end if;
        if Tex_Sum < 0 then Tex_Sum := 0; end if;
        Sum := Cap_Sum * Dur_Sum * Flav_Sum * Tex_Sum;

        if Sum > Max then 
            Max := Sum;
        end if;
    end Cal;

    procedure Find_Max(Idx: Integer; Remain: Integer; Amounts: in out Amount_List) is
    begin
        if Idx = Count then
            Amounts (Idx) := Remain;
            Cal(Amounts);
            return; 
        end if;
        for I in 0 .. Remain loop 
            Amounts (Idx) := I;
            Find_Max(Idx + 1, Remain - I, Amounts);
        end loop;
    end Find_Max;
    AList : Amount_List := (others => 0);
begin
    begin
        Open (File_Handle, In_File, File_Name);
    exception
        when Name_Error =>
            Put_Line ("Error: File not found - " & File_Name);
            return;
    when Use_Error =>
        Put_Line ("Error: Cannot open file - " & File_Name);
        return;
    end;

    Compile(Matcher, Pattern);
    while not End_Of_File (File_Handle) loop
        Get_Line (File_Handle, Line, Last);
        Match(Matcher, Line(1 .. Last), Matches);
        
        if Matches(0) /= No_Match then
            Count := Count + 1;
            Ingredients (Count).Capacity := Val(2);
            Ingredients (Count).Durability := Val(3);
            Ingredients (Count).Flavor := Val(4);
            Ingredients (Count).Texture := Val(5);
            Ingredients (Count).Calories := Val(6);
        end if;
    end loop;

    Close (File_Handle);
    Find_Max (1, 100, AList);

    Put_Line ("Max Score: " & Long_Long_Integer'Image (Max));

    exception
    when E : others =>
        Put_Line ("Unexpected error: " & Exception_Information (E));
end Read_File_Content;
