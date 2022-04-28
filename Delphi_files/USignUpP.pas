unit USignUpP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Imaging.pngimage,ImageButton, System.ImageList, Vcl.ImgList,
  System.Actions, Vcl.ActnList,IdHash, IdHashMessageDigest,IdGlobal,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,Jpeg;

type
  TFSignUpP = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    SpeedButton1: TSpeedButton;
    Panel3: TPanel;
    Image2: TImage;
    Image3: TImage;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    SpeedButton2: TSpeedButton;
    ImageList1: TImageList;
    ImageList2: TImageList;
    SpeedButton3: TSpeedButton;
    ActionList1: TActionList;
    SignUp: TAction;
    Clear: TAction;
    Image1: TImage;
    ChooseImg: TAction;
    OpenDialog1: TOpenDialog;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure SignUpExecute(Sender: TObject);
    procedure ClearExecute(Sender: TObject);
    procedure ChooseImgExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    SignUpBtn : TImageButton;
    ChooseImgBtn : TImageButton;
    ClearBtn : TImageButton;
  public
    { Public declarations }
  end;

var
  FSignUpP: TFSignUpP;

implementation

{$R *.dfm}

uses UPrincP;

procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   ListOfStrings.DelimitedText   := Str;
end;

procedure TFSignUpP.ChooseImgExecute(Sender: TObject);
var extension : String;
    fileName : String;
    OutputList : TStringList;
begin
  //ShowMessage('Choose image');

  OpenDialog1.InitialDir := 'C:\Users\Marius\Desktop';
  if OpenDialog1.Execute then
  begin
        fileName := OpenDialog1.FileName;

        OutPutList := TStringList.Create;
        try
           Split('.',filename, OutPutList) ;
           extension := OutputList[OutputList.Count - 1];
        finally
           OutPutList.Free;
        end;

        if extension <> 'png' then
        begin
          //ShowMessage('The image must have a png extension!');
          MessageDlg('The image must have a png extension!', mtInformation,[mbOk], 0, mbOk);
          FSignUpP.FormShow(FSignUpP);
          exit;
        end;

        Image1.Picture.LoadFromFile(OpenDialog1.FileName);
        Image1.Stretch := True;
        Image1.Proportional := True;
  end;

  FSignUpP.FormShow(FSignUpP);

end;

procedure TFSignUpP.ClearExecute(Sender: TObject);
begin
  //ShowMessage('Clear');
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit4.Text := '';
  FSignUpP.FormShow(FSignUpP);

end;

procedure TFSignUpP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit4.Text := '';
  Image1.Picture.LoadFromFile('images/avatar.png');
end;

procedure TFSignUpP.FormShow(Sender: TObject);
begin
  SignUpBtn := TImageButton.Create(self);
  SignUpBtn.Images := ImageList1;
  SignUpBtn.Index := 0;
  SignUpBtn.HoverIndex := 1;
  SignUpBtn.Width := ImageList1.Width;
  SignUpBtn.Height := ImageList1.Height;
  SignUpBtn.Parent := Panel1;
  SignUpBtn.Top := 332;
  SignUpBtn.Left := 186;
  SignUpBtn.Action := SignUp;

  ChooseImgBtn := TImageButton.Create(self);
  ChooseImgBtn.Images := ImageList2;
  ChooseImgBtn.Index := 0;
  ChooseImgBtn.HoverIndex := 1;
  ChooseImgBtn.Width := ImageList2.Width;
  ChooseImgBtn.Height := ImageList2.Height;
  ChooseImgBtn.Parent := GroupBox2;
  ChooseImgBtn.Top := 142;
  ChooseImgBtn.Left := 22;
  ChooseImgBtn.Action := ChooseImg;

  ClearBtn := TImageButton.Create(self);
  ClearBtn.Images := ImageList1;
  ClearBtn.Index := 2;
  ClearBtn.HoverIndex := 3;
  ClearBtn.DownIndex := 2;
  ClearBtn.Width := ImageList1.Width;
  ClearBtn.Height := ImageList1.Height;
  ClearBtn.Parent := Panel1;
  ClearBtn.Top := 332;
  ClearBtn.Left := 342;
  ClearBtn.Action := Clear;
end;

procedure TFSignUpP.SignUpExecute(Sender: TObject);
var hashMessageDigest5 : TIdHashMessageDigest5;
    hashedPassword : String;
    BlobField : TBlobField;
    AStream:TmemoryStream;
    Stream: TStream;
begin
   //ShowMessage('SignUp');

  if (Edit1.Text = '') or (Edit2.Text = '') or (Edit3.Text = '') or (Edit4.Text = '') then
  begin
    //ShowMessage('All the fields must be completed!');
    MessageDlg('All the fields must be completed!', mtInformation,[mbOk], 0, mbOk);
    FSignUpP.FormShow(FSignUpP);
    exit;
  end;

  if length(Edit3.Text) < 4 then
  begin
    //ShowMessage('Username must have at least 4 characters!');
    MessageDlg('Username must have at least 4 characters!', mtInformation,[mbOk], 0, mbOk);
    FSignUpP.FormShow(FSignUpP);
    exit;
  end;

  if length(Edit4.Text) < 4 then
  begin
    //ShowMessage('Password must have at least 4 characters!');
    MessageDlg('Password must have at least 4 characters!', mtInformation,[mbOk], 0, mbOk);
    FSignUpP.FormShow(FSignUpP);
    exit;
  end;



  hashMessageDigest5 := nil;
  try
      hashMessageDigest5 := TIdHashMessageDigest5.Create;
      hashedPassword := IdGlobal.IndyLowerCase(hashMessageDigest5.HashStringAsHex(Edit4.Text));
  finally
      hashMessageDigest5.Free;
  end;

  fdQuery1.Active := True;
  fdQuery1.Filtered := False;
  fdQuery1.Filter := 'username = '''+ Edit3.Text +'''';
  fdQuery1.Filtered := True;


  if DataSource1.DataSet.RecordCount > 0 then
  begin
    //ShowMessage('Username already exists! Choose another one!');
    MessageDlg('Username already exists! Choose another one!', mtInformation,[mbOk], 0, mbOk);
    FSignUpP.FormShow(FSignUpP);
    exit;
  end;

  fdQuery1.Active := False;
  fdQuery1.Filter := 'password like '''+ hashedPassword +'''';
  fdQuery1.Active := True;

  if DataSource1.DataSet.RecordCount <> 0 then
  begin
    //ShowMessage('Password already exists! Choose another one!');
    MessageDlg('Password already exists! Choose another one!', mtInformation,[mbOk], 0, mbOk);
    FSignUpP.FormShow(FSignUpP);
    exit;
  end;

  AStream := TMemoryStream.Create;
  Image1.Picture.Graphic.SaveToStream(AStream);

  fdQuery1.Insert;
  fdQuery1.FieldByName('username').AsString := Edit3.Text;
  fdQuery1.FieldByName('password').AsString := hashedPassword;
  fdQuery1.FieldByName('firstName').AsString := Edit1.Text;
  fdQuery1.FieldByName('lastName').AsString := Edit2.Text;
  TBlobField(fdQuery1.FieldByName('picture')).LoadFromStream(AStream);
  fdQuery1.Post;

  AStream.Free;

  //ShowMessage('Signed up successfully!');
  MessageDlg('Signed up successfully!', mtInformation,[mbOk], 0, mbOk);

  FPrincP.username := Edit3.Text;

  FSignUpP.FormShow(FSignUpP);

  FPrincP.ShowModal;

  FSignUpP.Close;

end;

end.
