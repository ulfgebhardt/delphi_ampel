unit Optionsu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TfOptions = class(TForm)
    GroupBox1: TGroupBox;
    CheckBox3: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Werbung: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fOptions: TfOptions;

implementation

{$R *.dfm}

uses functions;

procedure TfOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Application.Terminate;

end;

procedure TfOptions.Button2Click(Sender: TObject);
begin

  ProgrammBeenden;
  Application.Terminate;

end;

procedure TfOptions.CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  if checkbox3.Checked then checkbox2.Checked:=false else checkbox2.Checked:=true;

end;

procedure TfOptions.CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  if checkbox2.Checked then checkbox3.Checked:=false else checkbox3.Checked:=true;

end;

procedure TfOptions.Button1Click(Sender: TObject);
var tempb:boolean;
begin

  if checkbox2.Checked then tempb:=true else tempb:=false;

  setOptions(checkbox1.Checked,tempb);

end;

end.
