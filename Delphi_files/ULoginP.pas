unit ULoginP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,IdGlobal, IdHash, IdHashMessageDigest,
  Vcl.Buttons, Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList,ImageButton,
  System.Actions, Vcl.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Phys, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TFLoginP = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Image1: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Image2: TImage;
    ImageList1: TImageList;
    Button1: TButton;
    ActionList1: TActionList;
    SignIn: TAction;
    FDManager1: TFDManager;
    FDQuery1: TFDQuery;
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    DataSource1: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SignInExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label4MouseLeave(Sender: TObject);
  private
    { Private declarations }
    SignInBtn : TImageButton;
  public
    { Public declarations }
  end;

var
  FLoginP: TFLoginP;

implementation

{$R *.dfm}

uses UPrincP, USignUpP;

procedure TFLoginP.Button1Click(Sender: TObject);
var hashMessageDigest5 : TIdHashMessageDigest5;
begin
    hashMessageDigest5 := nil;
    try
        hashMessageDigest5 := TIdHashMessageDigest5.Create;
        //Memo1.Lines.Text := IdGlobal.IndyLowerCase(hashMessageDigest5.HashStringAsHex(Edit1.Text));
    finally
        hashMessageDigest5.Free;
    end;
end;

procedure TFLoginP.FormCreate(Sender: TObject);
begin
  //SpeedButton1.Glyph := ImageList1.GetIcon(0);

end;

procedure TFLoginP.FormShow(Sender: TObject);
begin
  SignInBtn := TImageButton.Create(self);
  SignInBtn.Images := ImageList1;
  SignInBtn.Index := 0;
  SignInBtn.HoverIndex := 2;
  SignInBtn.Width := ImageList1.Width;
  SignInBtn.Height := ImageList1.Height;
  SignInBtn.Parent := Panel1;
  SignInBtn.Top := 272;
  SignInBtn.Left := 229;
  SignInBtn.Action := SignIn;
end;

procedure TFLoginP.Label4Click(Sender: TObject);
begin
  FSignUpP.ShowModal;
end;

procedure TFLoginP.Label4MouseLeave(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TFLoginP.Label4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Screen.Cursor := crHandPoint;
end;

procedure TFLoginP.SignInExecute(Sender: TObject);
var hashMessageDigest5 : TIdHashMessageDigest5;
    hashedPassword : String;
begin

  hashMessageDigest5 := nil;
  try
      hashMessageDigest5 := TIdHashMessageDigest5.Create;
      hashedPassword := IdGlobal.IndyLowerCase(hashMessageDigest5.HashStringAsHex(Edit2.Text));
  finally
      hashMessageDigest5.Free;
  end;

  FDQuery1.Active := False;
  FDQuery1.ParamByName('username').AsString := Edit1.Text;
  FDQuery1.ParamByName('password').AsString := hashedPassword;
  FDQuery1.Active := True;

  if DataSource1.DataSet.RecordCount = 0 then
  begin
    //ShowMessage('Wrong username or password!');
    MessageDlg('Wrong username or password!', mtInformation,[mbOk], 0, mbOk);
    FLoginP.FormShow(FLoginP);
  end else begin
    FPrincP.username := Edit1.Text;
    FLoginP.Visible := False;
    FPrincP.ShowModal;
    FLoginP.Close;
    //FLoginP.FormShow(FLoginP);
  end;

  

end;

end.
