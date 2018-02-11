unit newclasses;

interface

uses ExtCtrls;

type TAmpelPlatz = class
       public
       X:integer;
       Y:Integer;
       Width:integer;
       Height:integer;
       Besetzt:boolean;
end;

type TFussgaenger = class
       public
       Image:TImage;
       Speed:integer;
       momSpeedx:integer;
       momSpeedy:integer;
       Active:boolean;
       AngesteuerterAmpelPlatz:integer;
       AufStrasse:boolean;

       constructor create;
       destructor destroy;
end;

type TAuto = class
       public
       Image:TImage;
       Speed:integer;
       momSpeed:integer;
       BlinkerL:boolean;
       BlinkerR:boolean;
       Fahrbahn:integer;
       Active:boolean;
end;

type TAutoAmpel = class
       public
       Rot:TImage;
       Gruen:TImage;
       Gelb:TImage;
       
       State:integer;
end;

type TFussgaengerAmpel = class
       public
       Rot:TImage;
       Gruen:TImage;

       State:boolean;
end;

type TAmpelSystem = class
       public
       ARAmpel:TAutoAmpel;
       ALAmpel:TAutoAmpel;
       FOAmpel:TFussgaengerAmpel;
       FUAmpel:TFussgaengerAmpel;
       FOKnopf:boolean; //Fuﬂg‰ngerknopf Oben
       FUKnopf:boolean;
       Changing:boolean;

       constructor create;
       destructor destroy;

       procedure setFGruen;
       procedure setFRot;
       procedure setAGruen;
       procedure setAGelb;
       procedure setARotGelb;
       procedure setARot;

       procedure changeToF;

end;

implementation

uses ampelu,functions;

procedure TAmpelSystem.changeToF;
begin

  changing:=true;
  fAmpel.AmpelTimer.enabled:=true;

end;

procedure TAmpelSystem.setFGruen;
begin

  FOAmpel.Gruen.Visible:=true;
  FOAmpel.Rot.Visible:=false;
  FOAmpel.State:=true;

  FUAmpel.Gruen.Visible:=true;
  FUAmpel.Rot.Visible:=false;
  FUAmpel.State:=true;

end;

procedure TAmpelSystem.setFRot;
begin

  FOAmpel.Gruen.Visible:=false;
  FOAmpel.Rot.Visible:=true;
  FOAmpel.State:=false;

  FUAmpel.Gruen.Visible:=false;
  FUAmpel.Rot.Visible:=true;
  FUAmpel.State:=false;

end;

procedure TAmpelSystem.setAGruen;
begin

  ARAmpel.Gruen.Visible:=true;
  ARAmpel.Gelb.Visible:=false;
  ARAmpel.Rot.Visible:=false;
  ARAmpel.State:=0;
  ALAmpel.Gruen.Visible:=true;
  ALAmpel.Gelb.Visible:=false;
  ALAmpel.Rot.Visible:=false;
  ALAmpel.State:=0;


end;

procedure TAmpelSystem.setAGelb;
begin

  ARAmpel.Gruen.Visible:=false;
  ARAmpel.Gelb.Visible:=true;
  ARAmpel.Rot.Visible:=false;
  ARAmpel.State:=1;
  ALAmpel.Gruen.Visible:=false;
  ALAmpel.Gelb.Visible:=true;
  ALAmpel.Rot.Visible:=false;
  ALAmpel.State:=1;

end;

procedure TAmpelSystem.setARot;
begin

  ARAmpel.Gruen.Visible:=false;
  ARAmpel.Gelb.Visible:=false;
  ARAmpel.Rot.Visible:=true;
  ARAmpel.State:=2;
  ALAmpel.Gruen.Visible:=false;
  ALAmpel.Gelb.Visible:=false;
  ALAmpel.Rot.Visible:=true;
  ALAmpel.State:=2;

end;

procedure TAmpelSystem.setARotGelb;
begin

  ARAmpel.Gruen.Visible:=false;
  ARAmpel.Gelb.Visible:=true;
  ARAmpel.Rot.Visible:=true;
  ARAmpel.State:=3;
  ALAmpel.Gruen.Visible:=false;
  ALAmpel.Gelb.Visible:=true;
  ALAmpel.Rot.Visible:=true;
  ALAmpel.State:=3;

end;

constructor TAmpelSystem.create;
begin

  ARAmpel:=TAutoAmpel.Create;
  ALAmpel:=TAutoAmpel.Create;

  FOAmpel:=TFussgaengerAmpel.Create;
  FUAmpel:=TFussgaengerAmpel.Create;

  changing:=false;

end;

destructor TAmpelSystem.destroy;
begin

  ARAmpel.free;
  ALAmpel.free;
  FOAmpel.free;
  FUAmpel.free;

end;

constructor TFussgaenger.create;
begin

  Image:=TImage.Create(fAmpel);

end;

destructor TFussgaenger.destroy;
begin

  Image.Free;

end;

end.

