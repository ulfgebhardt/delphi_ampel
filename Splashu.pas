unit Splashu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TfSplash = class(TForm)
    Image1: TImage;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSplash: TfSplash;

implementation

uses Optionsu,functions;

{$R *.dfm}

procedure TfSplash.FormActivate(Sender: TObject);
begin

  Application.ProcessMessages;

  sleep(3000);

  fOptions.show;
  fSplash.Hide;

end;

end.
