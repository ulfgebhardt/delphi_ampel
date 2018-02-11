program Ampel;

uses
  Forms,
  sysutils,
  dialogs,
  Splashu in 'Splashu.pas' {fSplash},
  Optionsu in 'Optionsu.pas' {fOptions},
  Ampelu in 'Ampelu.pas' {fAmpel},
  vars in 'vars.pas',
  functions in 'functions.pas',
  newclasses in 'newclasses.pas';

{$R *.res}

begin
  Application.Initialize;

  //Alle Bilder vorhanden?
  if (fileexists(ImgFAGruen)) and (fileexists(ImgFARot)) and (fileexists(ImgStreet)) and (fileexists(ImgAAGruen)) and (fileexists(ImgAAGelb)) and (fileexists(ImgAARot)) then else
    begin
    showmessage('Es sind nicht alle nötigen Bilder vorhanden! -> Programm wird geschlossen!');
    Application.Terminate;
    exit;
    end;

  Application.CreateForm(TfSplash, fSplash);
  Application.CreateForm(TfOptions, fOptions);
  Application.CreateForm(TfAmpel, fAmpel);
  fSplash.ShowModal;
  {Application.Run;}
end.
