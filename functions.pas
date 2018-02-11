unit functions;

interface

uses ampelu, splashu, optionsu, newclasses, vars, Windows, extctrls,dialogs,sysutils;

procedure setOptions(Autos,Fussgaenger:boolean);
procedure setAndCreateStandarts;
procedure bindImagesToAmpelSystem;
procedure setImagesToForm;
procedure FussgaengerKnopf;
procedure ProgrammBeenden;
procedure setAutosReadyToStart;
procedure stopAutoTimer;
procedure StartAutoTimer;
procedure AutoTimerR;
procedure AutoTimerL;
procedure setFussgaengerReadyToStart;
procedure FussgaengertimerO;
procedure setAmpelPlaetzeReadyToStart;

implementation

procedure FussgaengertimerO;
var i,j:integer;
begin

  for i:=0 to AnzahlDerFussgaengerO-1 do
    begin

    if (random(3)=0) and (fAmpel.FussgaengerO[i].Active=false) then
      begin
      j:=0;
      repeat
        if (fAmpel.FussgaengerO[i].Active=false) and (fAmpel.AmpelPlaetzeO[j].Besetzt=false) then
          begin
          fAmpel.AmpelPlaetzeO[j].Besetzt:=true;
          fAmpel.FussgaengerO[i].Active:=true;
          fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz:=j;
          fAmpel.FussgaengerO[i].Image.Top:=-40;
          fAmpel.FussgaengerO[i].Image.Left:=random(fAmpel.Width);
          fAmpel.FussgaengerO[i].momSpeedx:=(fAmpel.AmpelPlaetzeO[j].X-fAmpel.FussgaengerO[i].Image.Left) div fAmpel.FussgaengerO[i].Speed;
          fAmpel.FussgaengerO[i].momSpeedy:=(fAmpel.AmpelPlaetzeO[j].Y-fAmpel.FussgaengerO[i].Image.Top) div fAmpel.FussgaengerO[i].Speed;
          end;
        inc(j);
      until j>=AnzahlDerAmpelPlaetzeO;
      end;

    if (fAmpel.FussgaengerO[i].Active=true) and (fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz<>-1) then
      begin
      if (fAmpel.FussgaengerO[i].Image.left<fAmpel.AmpelPlaetzeO[fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz].X-5) or (fAmpel.FussgaengerO[i].Image.left>fAmpel.AmpelPlaetzeO[fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz].X+5) then
        begin
        if (fAmpel.FussgaengerO[i].Image.Top<fAmpel.AmpelPlaetzeO[fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz].Y-5) or (fAmpel.FussgaengerO[i].Image.Top>fAmpel.AmpelPlaetzeO[fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz].Y+5) then
          begin
          fAmpel.FussgaengerO[i].Image.Top:=fAmpel.FussgaengerO[i].Image.Top+fAmpel.FussgaengerO[i].momSpeedy;
          fAmpel.FussgaengerO[i].Image.Left:=fAmpel.FussgaengerO[i].Image.Left+fAmpel.FussgaengerO[i].momSpeedx;
          end else
            begin
            if fAmpel.AmpelSystem.FUAmpel.State=false then
              begin
              fAmpel.FussgaengerO[i].Image.Left:=fAmpel.AmpelPlaetzeO[fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz].X;
              fAmpel.FussgaengerO[i].Image.Top:=fAmpel.AmpelPlaetzeO[fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz].Y;
              if fAmpel.AmpelSystem.Changing=false then
                begin
                fussgaengerknopf;
                fAmpel.FussgaengerO[i].AufStrasse:=true;
                end
              end else
                begin
                fAmpel.FussgaengerO[i].Image.Top:=fAmpel.FussgaengerO[i].Image.Top+10;
                end;
            end;
        end;
      end;

    if (FAmpel.AmpelSystem.FUAmpel.State) and (fAmpel.FussgaengerO[i].active=true) and (fAmpel.FussgaengerO[i].AufStrasse=true) then
      begin
      fAmpel.FussgaengerO[i].Image.Top:=fAmpel.FussgaengerO[i].Image.Top+fAmpel.FussgaengerO[i].Speed div 5+3;
      if fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz<>-1 then
        begin
        fAmpel.AmpelPlaetzeO[fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz].Besetzt:=false;
        fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz:=-1;
        end;
      end;
    if (FAmpel.FussgaengerO[i].Image.top>FAmpel.Height+100) and (fAmpel.FussgaengerO[i].active=true) and (fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz=-1) then fAmpel.FussgaengerO[i].Active:=false else
      begin
      fAmpel.FussgaengerO[i].Active:=false;
      fAmpel.FussgaengerO[i].AufStrasse:=false;
      end;

    end;

end;

procedure StopAutoTimer;
begin

  fAmpel.tAutoTimer.Enabled:=false;

end;

procedure StartAutoTimer;
begin

  fAmpel.tAutoTimer.Enabled:=true;

end;

procedure ProgrammBeenden;
var i:integer;
begin

  stopAutoTimer;

  fAmpel.AmpelSystem.Free;

  for i:=0 to AnzahlDerAutosR-1 do fAmpel.AutosR[i].Free;
  for i:=0 to AnzahlDerAutosL-1 do fAmpel.AutosL[i].Free;
  for i:=0 to AnzahlDerFussgaengerO-1 do fAmpel.FussgaengerO[i].Free;
  for i:=0 to AnzahlDerFussgaengerU-1 do fAmpel.FussgaengerU[i].Free;
  for i:=0 to AnzahlDerAmpelPlaetzeO-1 do fAmpel.AmpelPlaetzeO[i].Free;

end;

procedure setAndCreateStandarts;
var i:integer;
begin

  randomize;

  fAmpel.AutoTimeri:=0;
  fAmpel.AmpelTimeri:=0;

  fAmpel.AmpelSystem:=TAmpelsystem.create;

  fAmpel.DoubleBuffered:=true;

  setlength(fAmpel.AutosR,AnzahlDerAutosR);
  for i:=0 to AnzahlDerAutosR-1 do fAmpel.AutosR[i]:=TAuto.Create;

  setlength(fAmpel.AutosL,AnzahlDerAutosL);
  for i:=0 to AnzahlDerAutosL-1 do fAmpel.AutosL[i]:=TAuto.Create;

  setlength(fAmpel.FussgaengerO,AnzahlDerFussgaengerO);
  for i:=0 to AnzahlDerFussgaengerO-1 do fAmpel.FussgaengerO[i]:=TFussgaenger.create;

  setlength(fAmpel.FussgaengerU,AnzahlDerFussgaengerU);
  for i:=0 to AnzahlDerFussgaengerU-1 do fAmpel.FussgaengerU[i]:=TFussgaenger.create;

  setlength(fAmpel.AmpelPlaetzeO,AnzahlDerAmpelPlaetzeO);
  for i:=0 to AnzahlDerAmpelPlaetzeO-1 do fAmpel.AmpelPlaetzeO[i]:=TAmpelPlatz.create;

end;

procedure AutoTimerR;
var i,j:integer;
    tempb:boolean;
begin

    for i:=0 to AnzahlDerAutosR-1 do
      begin

{      if (fAmpel.AutosR[i].momSpeed<>0) and (fAmpel.AutosR[i].momSpeed<>fAmpel.AutosR[i].Speed) and (fAmpel.AutosR[i].Fahrbahn=1) then
        begin
        fAmpel.AutosR[i].BlinkerL:=true;
        fAmpel.AutosR[i].BlinkerR:=false;
        //fAmpel.AutosR[i].Image.picture.loadfromfiel(...);
        end;}

      if fAmpel.Autotimeri>=i*50 then fAmpel.AutosR[i].Active:=true;

      if (fAmpel.AutosR[i].Image.Left<=-1700) and (fAmpel.AutosR[i].Fahrbahn=2) then fAmpel.AutosR[i].Image.Left:=fAmpel.Width+1500+random(500);
      if (fAmpel.AutosR[i].Image.Left<=-1000) and (fAmpel.AutosR[i].Fahrbahn=1) then fAmpel.AutosR[i].Image.Left:=fAmpel.Width+200+random(1200);

      if (fAmpel.AmpelSystem.ARAmpel.State>0) and (fAmpel.AutosR[i].Image.left>=680) and (fAmpel.AutosR[i].Image.left<=700) then fAmpel.AutosR[i].momSpeed:=0;
      if (fAmpel.AmpelSystem.ARAmpel.State=0) and (fAmpel.AutosR[i].momSpeed=0) then fAmpel.AutosR[i].momSpeed:=fAmpel.AutosR[i].speed;

      if fAmpel.AutosR[i].momSpeed<>0 then
        begin
        if (fAmpel.AutosR[i].Image.left<=fAmpel.width+100) and (fAmpel.AutosR[i].image.left>=-300) then
          begin
          for j:=0 to AnzahlDerAutosR-1 do
            begin
            if (fAmpel.AutosR[i].Image.left<=fAmpel.AutosR[j].Image.Left+fAmpel.AutosR[j].Image.Width+10) and (fAmpel.AutosR[i].Image.left>=fAmpel.AutosR[j].Image.Left-10) and (i<>j) then
              begin
              if (fAmpel.AutosR[j].Fahrbahn=fAmpel.AutosR[i].Fahrbahn){ or (fAmpel.AutosR[j].Fahrbahn=3) }then
                begin
                fAmpel.AutosR[i].Speed:=fAmpel.AutosR[j].Speed;
                if (fAmpel.AutosR[i].image.Left<=fAmpel.AutosR[j].image.Left+fAmpel.AutosR[j].image.Width) and (fAmpel.AutosR[i].image.Left>=fAmpel.AutosR[j].image.Left) then fAmpel.AutosR[i].image.Left:=fAmpel.AutosR[j].image.Left+fAmpel.AutosR[j].image.Width+10;
                end;
              end else
                begin
                if (fAmpel.AutosR[j].Fahrbahn=fAmpel.AutosR[i].Fahrbahn) or (fAmpel.AutosR[j].Fahrbahn=3) then
                  begin
                  if fAmpel.AutosR[i].Image.left>=fAmpel.AutosR[j].Image.Left+fAmpel.AutosR[j].Image.Width+10+fAmpel.AutosR[i].Speed then fAmpel.AutosR[i].momSpeed:=fAmpel.AutosR[i].Speed;
                  end;
                end;
            end;
        end else fAmpel.AutosR[i].momSpeed:=fAmpel.AutosR[i].Speed;
        end else
          begin
          for j:=0 to AnzahlDerAutosR-1 do
            begin
            if (fAmpel.AutosR[j].Image.left<=fAmpel.AutosR[i].Image.Left+fAmpel.AutosR[i].Image.Width+10) and (fAmpel.AutosR[j].Image.left>=fAmpel.AutosR[i].Image.Left) and (fAmpel.AutosR[j].Fahrbahn=fAmpel.AutosR[i].Fahrbahn) and (i<>j) then fAmpel.AutosR[j].momSpeed:=0;
            end;
          end;

{      tempb:=false;
      for j:=0 to AnzahlDerAutosR-1 do
        begin
        if (j<>i) then
          begin
          if (fAmpel.AutosR[i].BlinkerL) then
            begin
            if (fAmpel.AutosR[j].Fahrbahn=2) then
              begin
              if(fAmpel.AutosR[i].Image.Left>fAmpel.AutosR[j].Image.Left+fAmpel.AutosR[j].Image.width*1.5) then
                begin
                if(fAmpel.AutosR[i].Image.Left+fAmpel.AutosR[i].Image.Width<fAmpel.AutosR[j].Image.Left) then tempb:=true else tempb:=false;
                end else tempb:=false;
              end else tempb:=true;
            end;
          end;
        end; }

      {for j:=0 to AnzahlDerAutosR-1 do
        begin
        if (j<>i) then
          begin
          if (fAmpel.AutosR[i].BlinkerR) then
            begin
            if (fAmpel.AutosR[j].Fahrbahn=1) then
              begin
              if(fAmpel.AutosR[i].Image.Left>fAmpel.AutosR[j].Image.Left+fAmpel.AutosR[j].Image.width*1.5) then
                begin
                if(fAmpel.AutosR[i].Image.Left+fAmpel.AutosR[i].Image.Width<fAmpel.AutosR[j].Image.Left) then tempb:=true else tempb:=false;
                end else tempb:=false;
              end else tempb:=true;
            end;
          end;
        end;}

{      if tempb then
        begin
        fAmpel.AutosR[i].fahrbahn:=3;
        fAmpel.AutosR[i].momSpeed:=fAmpel.AutosR[i].Speed+7;
        end;}

{      if (fAmpel.AutosR[i].image.Top>=FahrbahnR2) and (fAmpel.AutosR[i].Fahrbahn=3) and (fAmpel.AutosR[i].BlinkerL) then
        begin
        fAmpel.AutosR[i].Fahrbahn:=2;
        fAmpel.AutosR[i].momSpeed:=fAmpel.AutosR[i].Speed+7;
        fAmpel.AutosR[i].Image.Top:=FahrbahnR2;
        fAmpel.AutosR[i].BlinkerR:=true;
        fAmpel.AutosR[i].BlinkerL:=false;
        end;}

{      if (fAmpel.AutosR[i].image.Top<=FahrbahnR1) and (fAmpel.AutosR[i].Fahrbahn=3) and (fAmpel.AutosR[i].BlinkerR) then
        begin
        fAmpel.AutosR[i].Fahrbahn:=1;
        fAmpel.AutosR[i].momSpeed:=fAmpel.AutosR[i].Speed;
        fAmpel.AutosR[i].Image.Top:=FahrbahnR1;
        fAmpel.AutosR[i].BlinkerR:=false;
        fAmpel.AutosR[i].BlinkerL:=false;
        end;}

{      if fAmpel.AutosR[i].Fahrbahn=3 then
        begin
        if fAmpel.AutosR[i].BlinkerL then fAmpel.AutosR[i].image.Top:=fAmpel.AutosR[i].image.Top+7;
        if fAmpel.AutosR[i].BlinkerR then fAmpel.AutosR[i].image.Top:=fAmpel.AutosR[i].image.Top-5;
        end;}

      if fAmpel.AutosR[i].Active then fAmpel.AutosR[i].Image.Left:=fAmpel.AutosR[i].Image.Left-fAmpel.AutosR[i].momSpeed;

      end;

end;

procedure AutoTimerL;
var i,j:integer;
    tempb:boolean;
begin

    for i:=0 to AnzahlDerAutosL-1 do
      begin

{      if (fAmpel.AutosL[i].momSpeed<>0) and (fAmpel.AutosL[i].momSpeed<>fAmpel.AutosL[i].Speed) and (fAmpel.AutosL[i].Fahrbahn=1) then
        begin
        fAmpel.AutosL[i].BlinkerL:=true;
        fAmpel.AutosL[i].BlinkerR:=false;
        //fAmpel.AutosL[i].Image.picture.loadfromfiel(...);
        end;}

      if fAmpel.Autotimeri>=i*50 then fAmpel.AutosL[i].Active:=true;

      if (fAmpel.AutosL[i].Image.Left>=FAmpel.Width+1500) and (fAmpel.AutosL[i].Fahrbahn=2) then fAmpel.AutosL[i].Image.Left:=-1700-random(500)-fAmpel.AutosL[i].Image.Width;
      if (fAmpel.AutosL[i].Image.Left>=FAmpel.Width+200) and (fAmpel.AutosL[i].Fahrbahn=1) then fAmpel.AutosL[i].Image.Left:=-1000-random(1200)-fAmpel.AutosL[i].Image.Width;

      if (fAmpel.AmpelSystem.ALAmpel.State>0) and (fAmpel.AutosL[i].Image.left>=148) and (fAmpel.AutosL[i].Image.left<=158) then fAmpel.AutosL[i].momSpeed:=0;
      if (fAmpel.AmpelSystem.ALAmpel.State=0) and (fAmpel.AutosL[i].momSpeed=0) then fAmpel.AutosL[i].momSpeed:=fAmpel.AutosL[i].speed;

      if fAmpel.AutosL[i].momSpeed<>0 then
        begin
        if (fAmpel.AutosL[i].Image.left<=fAmpel.width+100) and (fAmpel.AutosL[i].image.left>=-300) then
          begin
          for j:=0 to AnzahlDerAutosL-1 do
            begin
            if (fAmpel.AutosL[i].Image.left+fAmpel.AutosL[i].Image.Width+10>=fAmpel.AutosL[j].Image.Left) and (fAmpel.AutosL[i].Image.left<=fAmpel.AutosL[j].Image.Left+10) and (i<>j) then
              begin
              if (fAmpel.AutosL[j].Fahrbahn=fAmpel.AutosL[i].Fahrbahn){ or (fAmpel.AutosL[j].Fahrbahn=3) }then
                begin
                fAmpel.AutosL[i].Speed:=fAmpel.AutosL[j].Speed;
                if (fAmpel.AutosL[i].image.Left+fAmpel.AutosL[i].image.Width>=fAmpel.AutosL[j].image.Left) and (fAmpel.AutosL[i].image.Left<=fAmpel.AutosL[j].image.Left) then fAmpel.AutosL[i].image.Left:=fAmpel.AutosL[j].image.Left-fAmpel.AutosL[i].image.Width-10;
                end;
              end else
                begin
                if (fAmpel.AutosL[j].Fahrbahn=fAmpel.AutosL[i].Fahrbahn) or (fAmpel.AutosL[j].Fahrbahn=3) then
                  begin
                  if fAmpel.AutosL[i].Image.left+fAmpel.AutosL[i].Image.Width+10+fAmpel.AutosL[i].Speed<=fAmpel.AutosL[j].Image.Left then fAmpel.AutosL[i].momSpeed:=fAmpel.AutosL[i].Speed;
                  end;
                end;
            end;
          end else fAmpel.AutosL[i].momSpeed:=fAmpel.AutosL[i].Speed;
        end else
          begin
          for j:=0 to AnzahlDerAutosR-1 do
            begin
            if (fAmpel.AutosL[j].Image.left+fAmpel.AutosL[i].Image.Width+10>=fAmpel.AutosL[i].Image.Left) and (fAmpel.AutosL[j].Image.left<=fAmpel.AutosL[i].Image.Left) and (fAmpel.AutosL[j].Fahrbahn=fAmpel.AutosL[i].Fahrbahn) and (i<>j) then fAmpel.AutosL[j].momSpeed:=0;
            end;
          end;

{      tempb:=false;
      for j:=0 to AnzahlDerAutosR-1 do
        begin
        if (j<>i) then
          begin
          if (fAmpel.AutosL[i].BlinkerL) then
            begin
            if (fAmpel.AutosL[j].Fahrbahn=2) then
              begin
              if(fAmpel.AutosL[i].Image.Left>fAmpel.AutosL[j].Image.Left+fAmpel.AutosL[j].Image.width*1.5) then
                begin
                if(fAmpel.AutosL[i].Image.Left+fAmpel.AutosL[i].Image.Width<fAmpel.AutosL[j].Image.Left) then tempb:=true else tempb:=false;
                end else tempb:=false;
              end else tempb:=true;
            end;
          end;
        end; }

      {for j:=0 to AnzahlDerAutosR-1 do
        begin
        if (j<>i) then
          begin
          if (fAmpel.AutosL[i].BlinkerR) then
            begin
            if (fAmpel.AutosL[j].Fahrbahn=1) then
              begin
              if(fAmpel.AutosL[i].Image.Left>fAmpel.AutosL[j].Image.Left+fAmpel.AutosL[j].Image.width*1.5) then
                begin
                if(fAmpel.AutosL[i].Image.Left+fAmpel.AutosL[i].Image.Width<fAmpel.AutosL[j].Image.Left) then tempb:=true else tempb:=false;
                end else tempb:=false;
              end else tempb:=true;
            end;
          end;
        end;}

{      if tempb then
        begin
        fAmpel.AutosL[i].fahrbahn:=3;
        fAmpel.AutosL[i].momSpeed:=fAmpel.AutosL[i].Speed+7;
        end;}

{      if (fAmpel.AutosL[i].image.Top>=FahrbahnR2) and (fAmpel.AutosL[i].Fahrbahn=3) and (fAmpel.AutosL[i].BlinkerL) then
        begin
        fAmpel.AutosL[i].Fahrbahn:=2;
        fAmpel.AutosL[i].momSpeed:=fAmpel.AutosL[i].Speed+7;
        fAmpel.AutosL[i].Image.Top:=FahrbahnR2;
        fAmpel.AutosL[i].BlinkerR:=true;
        fAmpel.AutosL[i].BlinkerL:=false;
        end;}

{      if (fAmpel.AutosL[i].image.Top<=FahrbahnR1) and (fAmpel.AutosL[i].Fahrbahn=3) and (fAmpel.AutosL[i].BlinkerR) then
        begin
        fAmpel.AutosL[i].Fahrbahn:=1;
        fAmpel.AutosL[i].momSpeed:=fAmpel.AutosL[i].Speed;
        fAmpel.AutosL[i].Image.Top:=FahrbahnR1;
        fAmpel.AutosL[i].BlinkerR:=false;
        fAmpel.AutosL[i].BlinkerL:=false;
        end;}

{      if fAmpel.AutosL[i].Fahrbahn=3 then
        begin
        if fAmpel.AutosL[i].BlinkerL then fAmpel.AutosL[i].image.Top:=fAmpel.AutosL[i].image.Top+7;
        if fAmpel.AutosL[i].BlinkerR then fAmpel.AutosL[i].image.Top:=fAmpel.AutosL[i].image.Top-5;
        end;}

      if fAmpel.AutosL[i].Active then fAmpel.AutosL[i].Image.Left:=fAmpel.AutosL[i].Image.Left+fAmpel.AutosL[i].momSpeed;

      end;

end;

procedure setAmpelPlaetzeReadyToStart;
var i:integer;
begin

  for i:=0 to AnzahlDerAmpelPlaetzeO-1 do
    begin
    fAmpel.AmpelPlaetzeO[i].Y:=AmpelPlatzOY;
    fAmpel.AmpelPlaetzeO[i].X:=AmpelPlatzOX+i*20;
    fAmpel.AmpelPlaetzeO[i].Width:=10;
    fAmpel.AmpelPlaetzeO[i].Height:=10;
    fAmpel.AmpelPlaetzeO[i].Besetzt:=false;
    end;

end;

procedure setFussgaengerReadyToStart;
var i,tempi:integer;
begin

  for i:=0 to AnzahlDerFussgaengerO-1 do
    begin
    fAmpel.FussgaengerO[i].Speed:=random(40)+1;
    fAmpel.FussgaengerO[i].momSpeedx:=fAmpel.FussgaengerO[i].Speed;
    fAmpel.FussgaengerO[i].momSpeedy:=fAmpel.FussgaengerO[i].Speed;
    fAmpel.FussgaengerO[i].Active:=false;
    fAmpel.FussgaengerO[i].Image.Parent:=fAmpel;
    fAmpel.FussgaengerO[i].Image.Top:=0;
    fAmpel.FussgaengerO[i].Image.Left:=-300;
    fAmpel.FussgaengerO[i].Image.Width:=20;
    fAmpel.FussgaengerO[i].Image.Height:=20;
    fAmpel.FussgaengerO[i].Image.Stretch:=true;
    fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz:=-1;
    fAmpel.FussgaengerO[i].Image.Transparent:=true;
    fAmpel.FussgaengerO[i].AufStrasse:=false;
    tempi:=random(4);
    if tempi=0 then fAmpel.FussgaengerO[i].Image.Picture.LoadFromFile(ImgFussgaengerO1);
    if tempi=1 then fAmpel.FussgaengerO[i].Image.Picture.LoadFromFile(ImgFussgaengerO2);
    if tempi=2 then fAmpel.FussgaengerO[i].Image.Picture.LoadFromFile(ImgFussgaengerO3);
    if tempi=3 then fAmpel.FussgaengerO[i].Image.Picture.LoadFromFile(ImgFussgaengerO4);
    end;

  for i:=0 to AnzahlDerFussgaengerU-1 do
    begin
    fAmpel.FussgaengerU[i].Speed:=random(40)+1;
    fAmpel.FussgaengerU[i].momSpeedx:=fAmpel.FussgaengerU[i].Speed;
    fAmpel.FussgaengerU[i].momSpeedy:=fAmpel.FussgaengerU[i].Speed;
    fAmpel.FussgaengerU[i].Active:=false;
    fAmpel.FussgaengerU[i].Image.Parent:=fAmpel;
    fAmpel.FussgaengerU[i].Image.Top:=0;
    fAmpel.FussgaengerU[i].Image.Left:=-300;
    fAmpel.FussgaengerU[i].Image.Width:=20;
    fAmpel.FussgaengerU[i].Image.Height:=20;
    fAmpel.FussgaengerU[i].Image.Stretch:=true;
    fAmpel.FussgaengerU[i].AngesteuerterAmpelPlatz:=-1;
    fAmpel.FussgaengerU[i].Image.Transparent:=true;
    fAmpel.FussgaengerU[i].AufStrasse:=false;
    tempi:=random(4);
    if tempi=0 then fAmpel.FussgaengerU[i].Image.Picture.LoadFromFile(ImgFussgaengerU1);
    if tempi=1 then fAmpel.FussgaengerU[i].Image.Picture.LoadFromFile(ImgFussgaengerU2);
    if tempi=2 then fAmpel.FussgaengerU[i].Image.Picture.LoadFromFile(ImgFussgaengerU3);
    if tempi=3 then fAmpel.FussgaengerU[i].Image.Picture.LoadFromFile(ImgFussgaengerU4);
    end;

end;

procedure setAutosReadyToStart;
var i,tempi:integer;
begin

  for i:=0 to AnzahlDerAutosR-1 do
    begin
    fAmpel.AutosR[i].Image:=TImage.create(fAmpel);
    fAmpel.AutosR[i].Speed:=4+random(8);
    fAmpel.AutosR[i].momSpeed:=fAmpel.AutosR[i].Speed;
    fAmpel.AutosR[i].BlinkerL:=false;
    fAmpel.AutosR[i].BlinkerR:=false;
    fAmpel.AutosR[i].active:=false;
    if fAmpel.AutosR[i].speed>7 then fAmpel.AutosR[i].Fahrbahn:=2 else fAmpel.AutosR[i].Fahrbahn:=1;
    tempi:=random(4);
    if tempi=0 then fAmpel.AutosR[i].Image.Picture.LoadFromFile(ImgAutoRotR);
    if tempi=1 then fAmpel.AutosR[i].Image.Picture.LoadFromFile(ImgAutoGelbR);
    if tempi=2 then fAmpel.AutosR[i].Image.Picture.LoadFromFile(ImgAutoBlauR);
    if tempi=3 then fAmpel.AutosR[i].Image.Picture.LoadFromFile(ImgAutoGruenR);
    fAmpel.AutosR[i].Image.Width:=fAmpel.AutosR[i].Image.Picture.Width;
    fAmpel.AutosR[i].Image.Parent:=fAmpel;
    fAmpel.AutosR[i].Image.Transparent:=true;
    fAmpel.AutosR[i].Image.Left:=fAmpel.Width+1000;
    if fAmpel.AutosR[i].Fahrbahn=1 then fAmpel.AutosR[i].Image.Top:=FahrbahnR1 else fAmpel.AutosR[i].Image.Top:=FahrbahnR2;
    end;

  for i:=0 to AnzahlDerAutosL-1 do
    begin
    fAmpel.AutosL[i].Image:=TImage.create(fAmpel);
    fAmpel.AutosL[i].Speed:=4+random(8);
    fAmpel.AutosL[i].momSpeed:=fAmpel.AutosL[i].Speed;
    fAmpel.AutosL[i].BlinkerL:=false;
    fAmpel.AutosL[i].BlinkerR:=false;
    fAmpel.AutosL[i].active:=false;
    if fAmpel.AutosL[i].speed>7 then fAmpel.AutosL[i].Fahrbahn:=2 else fAmpel.AutosL[i].Fahrbahn:=1;
    tempi:=random(4);
    if tempi=0 then fAmpel.AutosL[i].Image.Picture.LoadFromFile(ImgAutoRotL);
    if tempi=1 then fAmpel.AutosL[i].Image.Picture.LoadFromFile(ImgAutoGelbL);
    if tempi=2 then fAmpel.AutosL[i].Image.Picture.LoadFromFile(ImgAutoBlauL);
    if tempi=3 then fAmpel.AutosL[i].Image.Picture.LoadFromFile(ImgAutoGruenL);
    fAmpel.AutosL[i].Image.Width:=fAmpel.AutosL[i].Image.Picture.Width;
    fAmpel.AutosL[i].Image.Parent:=fAmpel;
    fAmpel.AutosL[i].Image.Transparent:=true;
    fAmpel.AutosL[i].Image.Left:=-1000;
    if fAmpel.AutosL[i].Fahrbahn=1 then fAmpel.AutosL[i].Image.Top:=FahrbahnL1 else fAmpel.AutosL[i].Image.Top:=FahrbahnL2;
    end;

end;

procedure FussgaengerKnopf;
begin

  FAmpel.AmpelSystem.changeToF;

end;

procedure setImagesToForm;
begin

  //Bilder laden

  fAmpel.FOGAmpel.Picture.LoadFromFile(ImgFAGruen);
  fAmpel.FORAmpel.Picture.LoadFromFile(ImgFARot);
  fAmpel.FURAmpel.Picture.LoadFromFile(ImgFARot);
  fAmpel.FUGAmpel.Picture.LoadFromFile(ImgFAGruen);

  fAmpel.ARGAmpel.Picture.LoadFromFile(ImgAAGruen);
  fAmpel.ARYAmpel.Picture.LoadFromFile(ImgAAGelb);
  fAmpel.ARRAmpel.Picture.LoadFromFile(ImgAARot);
  fAmpel.ALGAmpel.Picture.LoadFromFile(ImgAAGruen);
  fAmpel.ALYAmpel.Picture.LoadFromFile(ImgAAGelb);
  fAmpel.ALRAmpel.Picture.LoadFromFile(ImgAARot);

  fAmpel.Streetimg.Picture.LoadFromFile(ImgStreet);

end;

procedure bindImagesToAmpelSystem;
begin

  fAmpel.Ampelsystem.ARAmpel.Gruen:=fAmpel.ARGAmpel;
  fAmpel.Ampelsystem.ARAmpel.Gelb:=fAmpel.ARYAmpel;
  fAmpel.Ampelsystem.ARAmpel.Rot:=fAmpel.ARRAmpel;

  fAmpel.Ampelsystem.ALAmpel.Gruen:=fAmpel.ALGAmpel;
  fAmpel.Ampelsystem.ALAmpel.Gelb:=fAmpel.ALYAmpel;
  fAmpel.Ampelsystem.ALAmpel.Rot:=fAmpel.ALRAmpel;

  fAmpel.AmpelSystem.FOAmpel.Gruen:=fAmpel.FOGAmpel;
  fAmpel.AmpelSystem.FOAmpel.Rot:=fAmpel.FORAmpel;

  fAmpel.AmpelSystem.FUAmpel.Gruen:=fAmpel.FUGAmpel;
  fAmpel.AmpelSystem.FUAmpel.Rot:=fAmpel.FURAmpel;

end;

procedure setOptions(Autos,Fussgaenger:boolean);
begin

  //Optionen verwerten...
  fAmpel.show;
  fOptions.Hide;

  if Fussgaenger then
    begin
    fAmpel.FOKnopf.Visible:=false;
    fAmpel.FUKnopf.Visible:=false;
    fAmpel.tFussgaengerTimer.enabled:=true;
    end else
      begin
      fAmpel.FOKnopf.Visible:=true;
      fAmpel.FUKnopf.Visible:=true;
      end;

  if Autos then
    begin
    StartAutoTimer;
    end;

  {fAmpel.showmodal;}

end;

end.
