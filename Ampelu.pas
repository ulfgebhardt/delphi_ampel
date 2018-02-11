unit Ampelu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, vars, newclasses, StdCtrls;

type
  TfAmpel = class(TForm)
    Streetimg: TImage;
    FORAmpel: TImage;
    FOGAmpel: TImage;
    FURAmpel: TImage;
    FUGAmpel: TImage;
    ALGAmpel: TImage;
    ALYAmpel: TImage;
    ALRAmpel: TImage;
    ARGAmpel: TImage;
    ARYAmpel: TImage;
    ARRAmpel: TImage;
    FUKnopf: TButton;
    FOKnopf: TButton;
    tAutoTimer: TTimer;
    AmpelTimer: TTimer;
    tFussgaengerTimer: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FOKnopfClick(Sender: TObject);
    procedure FUKnopfClick(Sender: TObject);
    procedure setProcessMessages;
    procedure tAutoTimerTimer(Sender: TObject);
    procedure AmpelTimerTimer(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure tFussgaengerTimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    AmpelSystem:TAmpelSystem;
    AutosR,AutosL:array of TAuto;
    FussgaengerO, FussgaengerU:array of TFussgaenger;
    AmpelPlaetzeO, AmpelPlaetzeU: array of TAmpelPlatz;
    AutoTimeri:integer;
    AmpelTimeri:integer;
  end;

var
  fAmpel: TfAmpel;

implementation

{$R *.dfm}

uses functions;

procedure TfAmpel.setProcessMessages;
begin

  Application.ProcessMessages;

end;

procedure TfAmpel.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  ProgrammBeenden;
  Application.Terminate;

end;

procedure TfAmpel.FormCreate(Sender: TObject);
begin

  setAndCreateStandarts;
  bindImagesToAmpelSystem;
  setImagesToForm;
  setAutosReadyToStart;
  setFussgaengerReadyToStart;
  setAmpelPlaetzeReadyToStart;
  fAmpel.AmpelSystem.setFRot;
  fAmpel.AmpelSystem.setAGruen;

end;

procedure TfAmpel.FOKnopfClick(Sender: TObject);
begin

  FussgaengerKnopf;

end;

procedure TfAmpel.FUKnopfClick(Sender: TObject);
begin

  FussgaengerKnopf;

end;

procedure TfAmpel.tAutoTimerTimer(Sender: TObject);
begin

  AutoTimeri:=fAmpel.AutoTimeri+1;
  AutoTimerR;
  AutoTimerL;

end;

procedure TfAmpel.AmpelTimerTimer(Sender: TObject);
var i:integer;
begin

  AmpelTimeri:=AmpelTimeri+1;

  //FussgaengertimerO;

{  for i:=0 to AnzahlDerFussgaengerO-1 do
    begin
    if (FAmpel.AmpelSystem.FUAmpel.State) and (fAmpel.FussgaengerO[i].active=true) then
      begin
      fAmpel.FussgaengerO[i].Image.Top:=fAmpel.FussgaengerO[i].Image.Top+10;
      if fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz<>-1 then
        begin
        fAmpel.AmpelPlaetzeO[fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz].Besetzt:=false;
        fAmpel.FussgaengerO[i].AngesteuerterAmpelPlatz:=-1;
        end;
      end;
    if FAmpel.FussgaengerO[i].Image.top>FAmpel.Height+100 then fAmpel.FussgaengerO[i].Active:=false;
    end;}

  if AmpelTimeri=30 then AmpelSystem.setAGelb;
  if AmpelTimeri=60 then AmpelSystem.setARot;
  if AmpelTimeri=100 then AmpelSystem.setFGruen;
  if AmpelTimeri=300 then AmpelSystem.setFRot;
  if AmpelTimeri=340 then AmpelSystem.setARotGelb;
  if AmpelTimeri=380 then AmpelSystem.setAGruen;
  if AmpelTimeri>380 then
    begin
    AmpelTimeri:=0;
    fAmpel.AmpelSystem.Changing:=false;
    AmpelTimer.Enabled:=false;
    end;

end;

procedure TfAmpel.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin

  resize:=false;

end;

procedure TfAmpel.tFussgaengerTimerTimer(Sender: TObject);
begin

  FussgaengertimerO;

end;

end.
