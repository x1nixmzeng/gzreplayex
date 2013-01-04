unit gzrecFrmProg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
  public
    allowClose : Boolean;
    procedure Open;
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Open;
begin
  allowClose            := False;

  // Reset UI
  ProgressBar1.Position := 0;

  Button1.Enabled       := False;  // disable close button
  ShowModal;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Disallow closing of this window
  if not allowClose then
    Action := caNone;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
