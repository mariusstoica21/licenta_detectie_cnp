unit UPrincP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons,ImageButton,
  System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList,ShellAPI,
  Vcl.Imaging.jpeg;

type
  TFPrincP = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Image2: TImage;
    DBText1: TDBText;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    DBText2: TDBText;
    DBImage1: TDBImage;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    ImageList1: TImageList;
    ActionList1: TActionList;
    TakePhoto: TAction;
    LoadImage: TAction;
    Libraryy: TAction;
    History: TAction;
    Exitt: TAction;
    Panel3: TPanel;
    Panel7: TPanel;
    Label1: TLabel;
    Image1: TImage;
    Panel5: TPanel;
    Label2: TLabel;
    Image3: TImage;
    Panel6: TPanel;
    Panel8: TPanel;
    Label4: TLabel;
    Image5: TImage;
    ImageList2: TImageList;
    Image4: TImage;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Image6: TImage;
    Image7: TImage;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    ActionList2: TActionList;
    Choose: TAction;
    Send: TAction;
    Save: TAction;
    Remove: TAction;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    FDQuery2: TFDQuery;
    DataSource2: TDataSource;
    Image8: TImage;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn10: TBitBtn;
    DBGrid3: TDBGrid;
    Image9: TImage;
    Image10: TImage;
    DBGrid1: TDBGrid;
    FDQuery3: TFDQuery;
    DataSource3: TDataSource;
    FDQuery4: TFDQuery;
    DataSource4: TDataSource;
    DBImage2: TDBImage;
    Load: TAction;
    ImageList3: TImageList;
    FDQuery5: TFDQuery;
    DataSource5: TDataSource;
    DBGrid2: TDBGrid;
    ImageList4: TImageList;
    FDQuery6: TFDQuery;
    DataSource6: TDataSource;
    BitBtn13: TBitBtn;
    Open: TAction;
    Panel9: TPanel;
    Image11: TImage;
    Label9: TLabel;
    Image31: TImage;
    Image32: TImage;
    Image33: TImage;
    Image34: TImage;
    Image35: TImage;
    Image36: TImage;
    ScrollBox1: TScrollBox;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    BitBtn11: TBitBtn;
    Results: TAction;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Label25: TLabel;
    Shape10: TShape;
    Shape11: TShape;
    Shape14: TShape;
    Label26: TLabel;
    Shape15: TShape;
    Label27: TLabel;
    Shape16: TShape;
    Label28: TLabel;
    Shape17: TShape;
    Label29: TLabel;
    Shape18: TShape;
    Label30: TLabel;
    Shape19: TShape;
    Label31: TLabel;
    Shape20: TShape;
    Label32: TLabel;
    Shape21: TShape;
    Label33: TLabel;
    Label34: TLabel;
    Shape22: TShape;
    Shape23: TShape;
    Label35: TLabel;
    Shape24: TShape;
    Label36: TLabel;
    Shape25: TShape;
    Label37: TLabel;
    Shape26: TShape;
    Label38: TLabel;
    Label39: TLabel;
    procedure FormShow(Sender: TObject);
    procedure TakePhotoExecute(Sender: TObject);
    procedure LoadImageExecute(Sender: TObject);
    procedure LibraryyExecute(Sender: TObject);
    procedure HistoryExecute(Sender: TObject);
    procedure ExittExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChooseExecute(Sender: TObject);
    procedure SendExecute(Sender: TObject);
    procedure SaveExecute(Sender: TObject);
    procedure RemoveExecute(Sender: TObject);
    procedure DataSource3DataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid3CellClick(Column: TColumn);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure LoadExecute(Sender: TObject);
    procedure DBGrid3DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure OpenExecute(Sender: TObject);
    procedure populateImages();
    procedure removeImages();
    procedure ResultsExecute(Sender: TObject);
    procedure showExpectedCnp(expected_cnp : String);
    procedure showResultedCnp(resulted_cnp : String);
    procedure drawRect(expected_cnp,resulted_cnp:String);
    procedure drawLabelShapeRed();
  private
    { Private declarations }
    TakePhotoBtn : TImageButton;
    LoadImageBtn : TImageButton;
    LibraryBtn : TImageButton;
    HistoryBtn : TImageButton;
    ExitBtn : TImageButton;
    ChooseImgBtn : TImageButton;
    SendImgBtn : TImageButton;
    SaveImgBtn : TImageButton;
    RemoveImgBtn : TImageButton;
    LoadImageBtn1 : TImageButton;
    OpenImgBtn : TImageButton;
    ResultsImgBtn : TImageButton;
    path : string;
    //fileName : string;
    userId : integer;
    procedure labelsFalse;
    procedure labelsTrue;


  public
    { Public declarations }
    username : String;
  end;

var
  FPrincP: TFPrincP;

implementation

{$R *.dfm}

uses UImageP;

procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   ListOfStrings.DelimitedText   := Str;
end;


procedure TFPrincP.BitBtn11Click(Sender: TObject);
begin
  DBImage2.Stretch := False;
  DBImage2.Proportional := True;
end;

procedure TFPrincP.BitBtn12Click(Sender: TObject);
begin
  DBImage2.Stretch := True;
  DBImage2.Proportional := True;
end;

procedure TFPrincP.BitBtn13Click(Sender: TObject);
begin
  FImageP.DBImage1.Picture.Graphic := DBImage2.Picture.Graphic;
  FImageP.ShowModal;
end;

procedure TFPrincP.ChooseExecute(Sender: TObject);
var OutputList : TStringList;
    fileName : string;
begin
  //ShowMessage('Choose');
  OpenDialog1 := TOpenDialog.Create(self);

  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);

  if OpenDialog1.Execute then
  begin
    Image6.Picture.LoadFromFile(OpenDialog1.FileName);
    path := OpenDialog1.FileName;
  end else begin
    //ShowMessage('No file selected!');
    MessageDlg('No file selected!', mtInformation,[mbOk], 0, mbOk);
    FPrincP.FormShow(FPrincP);
    exit;
  end;

  OutPutList := TStringList.Create;
  try
     Split('\',path, OutPutList) ;
     filename := OutputList[OutputList.Count - 1];
  finally
     OutPutList.Free;
  end;

  OpenDialog1.Free;

  Edit1.Text := filename;

  fdQuery5.Active := True;
  fdQuery5.Insert;
  fdQuery5.FieldByName('event').AsString := 'Choose image';
  fdQuery5.FieldByName('o_filename').AsString := Edit1.Text;
  fdQuery5.FieldByName('e_filename').AsString := '-';
  fdQuery5.FieldByName('users_id').AsInteger := userId;
  fdQuery5.FieldByName('tdate').AsDateTime := now();
  fdQuery5.Post;


  FPrincP.FormShow(FPrincP);
end;

procedure TFPrincP.DataSource3DataChange(Sender: TObject; Field: TField);
var BlobStream : TStream;
begin


end;

procedure TFPrincP.DBGrid1CellClick(Column: TColumn);
begin
  //BitBtn10.Visible := False;
  DbImage2.DataSource := DataSource4;
  //FPrincP.FormShow(FPrincP);
end;

procedure TFPrincP.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var bmpImage: tBitmap;
    intX, intY: Integer;
begin
  if DataSource4.DataSet.RecNo > 0 then
  begin
    if Column.FieldName = 'extension' then
      with DBGrid1.Canvas do
      begin
        fillRect(rect);
        bmpImage := tBitmap.Create;
        try
          if DBGrid1.DataSource.DataSet.FieldByName('extension').AsString = 'jpg' then
          begin
            //bmpImage.Assign(ImageList3.GetIcon(0));
            //bmpImage.Assign(Image11.Picture.Bitmap);
            //bmpImage := IMage11.Picture.Bitmap;
            ImageList3.GetBitmap(0,bmpImage);
          end;
          intX := ((rect.Right - rect.Left) div 2) - (bmpImage.Width div 2);
          intY := ((rect.Bottom - rect.Top) div 2) - (bmpImage.Height div 2);
          draw(rect.Left + intX, rect.Top + intY, bmpImage);
        finally
          bmpimage.Free;
        end;
      end;
  end;
end;

procedure TFPrincP.DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var bmpImage: tBitmap;
    intX, intY: Integer;
begin
  if DataSource5.DataSet.RecNo > 0 then
  begin
    if Column.Index = 0 then
      with DBGrid2.Canvas do
      begin
        fillRect(rect);
        bmpImage := tBitmap.Create;
        try
          if DBGrid2.DataSource.DataSet.FieldByName('event').AsString = 'Choose image' then
          begin
            ImageList4.GetBitmap(0,bmpImage);
          end else if DBGrid2.DataSource.DataSet.FieldByName('event').AsString = 'Send image' then
          begin
            ImageList4.GetBitmap(1,bmpImage);
          end else if DBGrid2.DataSource.DataSet.FieldByName('event').AsString = 'Save images' then
          begin
            ImageList4.GetBitmap(2,bmpImage);
          end else if DBGrid2.DataSource.DataSet.FieldByName('event').AsString = 'Remove images' then
          begin
            ImageList4.GetBitmap(3,bmpImage);
          end else if DBGrid2.DataSource.DataSet.FieldByName('event').AsString = 'Load image' then
          begin
            ImageList4.GetBitmap(4,bmpImage);
          end;

          intX := ((rect.Right - rect.Left) div 2) - (bmpImage.Width div 2);
          intY := ((rect.Bottom - rect.Top) div 2) - (bmpImage.Height div 2);
          draw(rect.Left + intX, rect.Top + intY, bmpImage);
        finally
          bmpimage.Free;
        end;
      end;
  end;
end;

procedure TFPrincP.DBGrid3CellClick(Column: TColumn);
begin
  DBImage2.DataSource := DataSource3;

end;

procedure TFPrincP.DBGrid3DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var bmpImage: tBitmap;
    intX, intY: Integer;
begin
  if DataSource3.DataSet.RecNo > 0 then
  begin
    if Column.FieldName = 'extension' then
      with DBGrid3.Canvas do
      begin
        fillRect(rect);
        bmpImage := tBitmap.Create;
        try
          if DBGrid3.DataSource.DataSet.FieldByName('extension').AsString = 'jpg' then
          begin
            //bmpImage.Assign(ImageList3.GetIcon(0));
            //bmpImage.Assign(Image11.Picture.Bitmap);
            //bmpImage := IMage11.Picture.Bitmap;
            ImageList3.GetBitmap(0,bmpImage);

          end;
          intX := ((rect.Right - rect.Left) div 2) - (bmpImage.Width div 2);
          intY := ((rect.Bottom - rect.Top) div 2) - (bmpImage.Height div 2);
          draw(rect.Left + intX, rect.Top + intY, bmpImage);
        finally
          bmpimage.Free;
        end;
      end;
  end;
end;

procedure TFPrincP.drawLabelShapeRed;
begin
    Shape14.Pen.Color := clRed;
    Label26.Font.Color := clRed;

    Shape15.Pen.Color := clRed;
    Label27.Font.Color := clRed;

    Shape16.Pen.Color := clRed;
    Label28.Font.Color := clRed;

    Shape17.Pen.Color := clRed;
    Label29.Font.Color := clRed;

    Shape18.Pen.Color := clRed;
    Label30.Font.Color := clRed;

    Shape19.Pen.Color := clRed;
    Label31.Font.Color := clRed;

    Shape20.Pen.Color := clRed;
    Label32.Font.Color := clRed;

    Shape21.Pen.Color := clRed;
    Label33.Font.Color := clRed;

    Shape22.Pen.Color := clRed;
    Label39.Font.Color := clRed;

    Shape23.Pen.Color := clRed;
    Label35.Font.Color := clRed;

    Shape24.Pen.Color := clRed;
    Label36.Font.Color := clRed;

    Shape25.Pen.Color := clRed;
    Label37.Font.Color := clRed;

    Shape26.Pen.Color := clRed;
    Label38.Font.Color := clRed;
end;

procedure TFPrincP.drawRect(expected_cnp, resulted_cnp: String);
begin
  if expected_cnp[1] = resulted_cnp[1] then
  begin
    Shape14.Pen.Color := clGreen;
    Label26.Font.Color := clGreen;
  end;

  if expected_cnp[2] = resulted_cnp[2] then
  begin
    Shape15.Pen.Color := clGreen;
    Label27.Font.Color := clGreen;
  end;

  if expected_cnp[3] = resulted_cnp[3] then
  begin
    Shape16.Pen.Color := clGreen;
    Label28.Font.Color := clGreen;
  end;

  if expected_cnp[4] = resulted_cnp[4] then
  begin
    Shape17.Pen.Color := clGreen;
    Label29.Font.Color := clGreen;
  end;

  if expected_cnp[5] = resulted_cnp[5] then
  begin
    Shape18.Pen.Color := clGreen;
    Label30.Font.Color := clGreen;
  end;

  if expected_cnp[6] = resulted_cnp[6] then
  begin
    Shape19.Pen.Color := clGreen;
    Label31.Font.Color := clGreen;
  end;

  if expected_cnp[7] = resulted_cnp[7] then
  begin
    Shape20.Pen.Color := clGreen;
    Label32.Font.Color := clGreen;
  end;

  if expected_cnp[8] = resulted_cnp[8] then
  begin
    Shape21.Pen.Color := clGreen;
    Label33.Font.Color := clGreen;
  end;

  if expected_cnp[9] = resulted_cnp[9] then
  begin
    Shape22.Pen.Color := clGreen;
    Label39.Font.Color := clGreen;
  end;

  if expected_cnp[10] = resulted_cnp[10] then
  begin
    Shape23.Pen.Color := clGreen;
    Label35.Font.Color := clGreen;
  end;

  if expected_cnp[11] = resulted_cnp[11] then
  begin
    Shape24.Pen.Color := clGreen;
    Label36.Font.Color := clGreen;
  end;

  if expected_cnp[12] = resulted_cnp[12] then
  begin
    Shape25.Pen.Color := clGreen;
    Label37.Font.Color := clGreen;
  end;

  if expected_cnp[13] = resulted_cnp[13] then
  begin
    Shape26.Pen.Color := clGreen;
    Label38.Font.Color := clGreen;
  end;


end;

procedure TFPrincP.ExittExecute(Sender: TObject);
begin

  FPrincP.Close();
end;

procedure TFPrincP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  deletefile(ExtractFilePath(Application.ExeName)+'\edited_image\edited.jpg');
  deletefile(ExtractFilePath(Application.ExeName)+'\chosen_image\buletin.jpg');
  deletefile(ExtractFilePath(Application.ExeName)+'\chosen_image\config.txt');

  deleteFile('E:\Licenta\Script licenta\test_arr0.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr1.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr2.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr3.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr4.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr5.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr6.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr7.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr8.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr9.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr10.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr11.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr12.jpg');

  removeImages();


end;

procedure TFPrincP.FormCreate(Sender: TObject);
begin
  Panel5.Align := alNone;
  Panel7.Align := alNone;
  Panel8.Align := alNone;
  Panel6.Align := alClient;
  Panel9.Align := alNone;

  Panel5.Visible := False;
  Panel6.Visible := True;
  Panel7.Visible := False;
  Panel8.Visible := False;
  Panel9.Visible := False;
end;

procedure TFPrincP.FormShow(Sender: TObject);
begin

  TStringGrid(DBGrid3).DefaultRowHeight := 26;
  TStringGrid(DBGrid1).DefaultRowHeight := 26;
  TStringGrid(DBGrid2).DefaultRowHeight := 32;

  fdQuery1.Active := True;
  fdQuery1.Filtered := False;
  fdQuery1.Filter := 'username = '''+ username +'''';
  fdQuery1.Filtered := True;

  userId := fdQuery1.FieldByName('id').AsInteger;
  //ShowMessage(userId.ToString);

//  TakePhotoBtn := TImageButton.Create(self);
//  TakePhotoBtn.Images := ImageList1;
//  TakePhotoBtn.Index := 0;
//  TakePhotoBtn.HoverIndex := 5;
//  TakePhotoBtn.DownIndex := 0;
//  TakePhotoBtn.Width := ImageList1.Width;
//  TakePhotoBtn.Height := ImageList1.Height;
//  TakePhotoBtn.Parent := Panel4;
//  TakePhotoBtn.Top := 0;
//  TakePhotoBtn.Left := 0;
//  TakePhotoBtn.Action := TakePhoto;
//  TakePhotoBtn.Visible := False;

  LoadImageBtn := TImageButton.Create(self);
  LoadImageBtn.Images := ImageList1;
  LoadImageBtn.Index := 1;
  LoadImageBtn.HoverIndex := 6;
  LoadImageBtn.DownIndex := 1;
  LoadImageBtn.Width := ImageList1.Width;
  LoadImageBtn.Height := ImageList1.Height;
  LoadImageBtn.Parent := Panel4;
  LoadImageBtn.Top := 0;
  LoadImageBtn.Left := 0;
  LoadImageBtn.Action := LoadImage;

  ResultsImgBtn := TImageButton.Create(self);
  ResultsImgBtn.Images := ImageList1;
  ResultsImgBtn.Index := 10;
  ResultsImgBtn.HoverIndex := 11;
  ResultsImgBtn.DownIndex := 10;
  ResultsImgBtn.Width := ImageList1.Width;
  ResultsImgBtn.Height := ImageList1.Height;
  ResultsImgBtn.Parent := Panel4;
  ResultsImgBtn.Top := 47;
  ResultsImgBtn.Left := 0;
  ResultsImgBtn.Action := Results;

  LibraryBtn := TImageButton.Create(self);
  LibraryBtn.Images := ImageList1;
  LibraryBtn.Index := 2;
  LibraryBtn.HoverIndex := 7;
  LibraryBtn.DownIndex := 2;
  LibraryBtn.Width := ImageList1.Width;
  LibraryBtn.Height := ImageList1.Height;
  LibraryBtn.Parent := Panel4;
  LibraryBtn.Top := 94;
  LibraryBtn.Left := 0;
  LibraryBtn.Action := Libraryy;

  HistoryBtn := TImageButton.Create(self);
  HistoryBtn.Images := ImageList1;
  HistoryBtn.Index := 3;
  HistoryBtn.HoverIndex := 8;
  HistoryBtn.DownIndex := 3;
  HistoryBtn.Width := ImageList1.Width;
  HistoryBtn.Height := ImageList1.Height;
  HistoryBtn.Parent := Panel4;
  HistoryBtn.Top := 141;
  HistoryBtn.Left := 0;
  HistoryBtn.Action := History;

  ExitBtn := TImageButton.Create(self);
  ExitBtn.Images := ImageList1;
  ExitBtn.Index := 4;
  ExitBtn.HoverIndex := 9;
  ExitBtn.DownIndex := 4;
  ExitBtn.Width := ImageList1.Width;
  ExitBtn.Height := ImageList1.Height;
  ExitBtn.Parent := Panel4;
  ExitBtn.Top := 188;
  ExitBtn.Left := 0;
  ExitBtn.Action := Exitt;

  ChooseImgBtn := TImageButton.Create(self);
  ChooseImgBtn.Images := ImageList2;
  ChooseImgBtn.Index := 0;
  ChooseImgBtn.HoverIndex := 5;
  ChooseImgBtn.DownIndex := 0;
  ChooseImgBtn.Width := ImageList2.Width;
  ChooseImgBtn.Height := ImageList2.Height;
  ChooseImgBtn.Parent := Panel6;
  ChooseImgBtn.Top := 606;
  ChooseImgBtn.Left := 62;
  ChooseImgBtn.Action := Choose;

  SendImgBtn := TImageButton.Create(self);
  SendImgBtn.Images := ImageList2;
  SendImgBtn.Index := 1;
  SendImgBtn.HoverIndex := 6;
  SendImgBtn.DownIndex := 1;
  SendImgBtn.Width := ImageList2.Width;
  SendImgBtn.Height := ImageList2.Height;
  SendImgBtn.Parent := Panel6;
  SendImgBtn.Top := 606;
  SendImgBtn.Left := 221;
  SendImgBtn.Action := Send;

  SaveImgBtn := TImageButton.Create(self);
  SaveImgBtn.Images := ImageList2;
  SaveImgBtn.Index := 2;
  SaveImgBtn.HoverIndex := 7;
  SaveImgBtn.DownIndex := 2;
  SaveImgBtn.Width := ImageList2.Width;
  SaveImgBtn.Height := ImageList2.Height;
  SaveImgBtn.Parent := Panel6;
  SaveImgBtn.Top := 606;
  SaveImgBtn.Left := 434;
  SaveImgBtn.Action := Save;

  RemoveImgBtn := TImageButton.Create(self);
  RemoveImgBtn.Images := ImageList2;
  RemoveImgBtn.Index := 3;
  RemoveImgBtn.HoverIndex := 8;
  RemoveImgBtn.DownIndex := 3;
  RemoveImgBtn.Width := ImageList2.Width;
  RemoveImgBtn.Height := ImageList2.Height;
  RemoveImgBtn.Parent := Panel6;
  RemoveImgBtn.Top := 606;
  RemoveImgBtn.Left := 594;
  RemoveImgBtn.Action := Remove;

  OpenImgBtn := TImageButton.Create(self);
  OpenImgBtn.Images := ImageList2;
  OpenImgBtn.Index := 10;
  OpenImgBtn.HoverIndex := 11;
  OpenImgBtn.DownIndex := 10;
  OpenImgBtn.Width := ImageList2.Width;
  OpenImgBtn.Height := ImageList2.Height;
  OpenImgBtn.Parent := Panel7;
  OpenImgBtn.Top := 609;
  OpenImgBtn.Left := 554;
  OpenImgBtn.Action := Open;



end;

procedure TFPrincP.HistoryExecute(Sender: TObject);
begin
  //ShowMessage('History');
  Panel5.Align := alNone;
  Panel6.Align := alNone;
  Panel7.Align := alNone;
  Panel8.Align := alClient;
  Panel9.Align := alNone;

  Panel5.Visible := False;
  Panel6.Visible := False;
  Panel7.Visible := False;
  Panel8.Visible := True;
  Panel9.Visible := False;

  fdQuery5.Active := False;
  fdQuery5.Filtered := False;
  fdQuery5.Filter := 'users_id = '''+ userId.ToString +'''';
  fdQuery5.Filtered := True;
  fdQuery5.Active := True;



  FPrincP.FormShow(FPrincP);
end;

procedure TFPrincP.labelsFalse;
begin
  Label10.Visible := False;
  Label11.Visible := False;
  Label12.Visible := False;
  Label13.Visible := False;
  Label14.Visible := False;
  Label15.Visible := False;
  Label16.Visible := False;
  Label17.Visible := False;
  Label18.Visible := False;
  Label19.Visible := False;
  Label20.Visible := False;
  Label21.Visible := False;
  Label22.Visible := False;
end;

procedure TFPrincP.labelsTrue;
begin
  Label10.Visible := True;
  Label11.Visible := True;
  Label12.Visible := True;
  Label13.Visible := True;
  Label14.Visible := True;
  Label15.Visible := True;
  Label16.Visible := True;
  Label17.Visible := True;
  Label18.Visible := True;
  Label19.Visible := True;
  Label20.Visible := True;
  Label21.Visible := True;
  Label22.Visible := True;
end;

procedure TFPrincP.LibraryyExecute(Sender: TObject);
begin
  //ShowMessage('Library');
  Panel5.Align := alNone;
  Panel6.Align := alNone;
  Panel8.Align := alNone;
  Panel7.Align := alClient;
  Panel9.Align := alNone;

  Panel5.Visible := False;
  Panel6.Visible := False;
  Panel7.Visible := True;
  Panel8.Visible := False;
  Panel9.Visible := False;

  fdQuery3.Active := True;
  fdQuery3.Filtered := False;
  fdQuery3.Filter := 'users_id = '''+ userId.ToString +''' and type = ''original''';
  fdQuery3.Filtered := True;

  fdQuery4.Active := True;
  fdQuery4.Filtered := False;
  fdQuery4.Filter := 'users_id = '''+ userId.ToString +''' and type = ''edited''';
  fdQuery4.Filtered := True;

  if (DataSource3.DataSet.RecordCount = 0) and (DataSource4.DataSet.RecordCount = 0) then
  begin
    OpenImgBtn.Visible := False;
  end else begin
    OpenImgBtn.Visible := True;
  end;


  FPrincP.FormShow(FPrincP);
end;

procedure TFPrincP.LoadExecute(Sender: TObject);
var filename : string;
    extension : string;
    OutPutList : TStringList;
begin
  //ShowMessage('Load');

  Image6.Picture := DBImage2.Picture;
  //ShowMessage(fdQuery3.FieldByName());

  fileName := fdQuery3.FieldByName('name').AsString;

  OutPutList := TStringList.Create;
  Split('.',filename, OutPutList) ;
  fileName := OutputList[OutputList.Count - 2];
  extension := OutputList[OutputList.Count - 1];
  OutPutList.Free;
  //ShowMessage(extension);

  Edit1.Text := filename + '1.' + extension;

  fdQuery5.Active := True;
  fdQuery5.Insert;
  fdQuery5.FieldByName('event').AsString := 'Load image';
  fdQuery5.FieldByName('o_filename').AsString := Edit1.Text;
  fdQuery5.FieldByName('e_filename').AsString := '-';
  fdQuery5.FieldByName('users_id').AsInteger := userId;
  fdQuery5.FieldByName('tdate').AsDateTime := now();
  fdQuery5.Post;

  FPrincP.FormShow(FPrincP);
end;

procedure TFPrincP.LoadImageExecute(Sender: TObject);
begin
  //ShowMessage('Load image');
  Panel5.Align := alNone;
  Panel7.Align := alNone;
  Panel8.Align := alNone;
  Panel6.Align := alClient;
  Panel9.Align := alNone;

  Panel5.Visible := False;
  Panel6.Visible := True;
  Panel7.Visible := False;
  Panel8.Visible := False;
  Panel9.Visible := False;


  FPrincP.FormShow(FPrincP);
end;

procedure TFPrincP.OpenExecute(Sender: TObject);
begin
  FImageP.DBImage1.Picture.Graphic := DBImage2.Picture.Graphic;
  FImageP.ShowModal;
  FPrincP.FormShow(FPrincP);
end;

procedure TFPrincP.populateImages;
begin
  Image12.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr0.jpg');
  Image13.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr1.jpg');
  Image14.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr2.jpg');
  Image15.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr3.jpg');
  Image16.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr4.jpg');
  Image17.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr5.jpg');
  Image18.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr6.jpg');
  Image19.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr7.jpg');
  Image20.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr8.jpg');
  Image21.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr9.jpg');
  Image22.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr10.jpg');
  Image23.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr11.jpg');
  Image24.Picture.LoadFromFile('E:\Licenta\Script licenta\test_arr12.jpg');
end;

procedure TFPrincP.RemoveExecute(Sender: TObject);
begin
  //ShowMessage('Remove');

  fdQuery5.Active := True;
  fdQuery5.Insert;
  fdQuery5.FieldByName('event').AsString := 'Remove images';
  fdQuery5.FieldByName('o_filename').AsString := Edit1.Text;
  fdQuery5.FieldByName('e_filename').AsString := Edit2.Text;
  fdQuery5.FieldByName('users_id').AsInteger := userId;
  fdQuery5.FieldByName('tdate').AsDateTime := now();
  fdQuery5.Post;

  Image6.Picture.LoadFromFile(GetCurrentDir+'\images\UPrincPImage4.png');
  Image7.Picture.LoadFromFile(GetCurrentDir+'\images\UPrincPImage5.png');
  Edit1.Text := '';
  Edit2.Text := '';

  deletefile(ExtractFilePath(Application.ExeName)+'\edited_image\edited.jpg');
  deletefile(ExtractFilePath(Application.ExeName)+'\chosen_image\buletin.jpg');
  deletefile(ExtractFilePath(Application.ExeName)+'\chosen_image\config.txt');
  deleteFile('E:\Licenta\Script licenta\test_arr0.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr1.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr2.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr3.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr4.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr5.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr6.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr7.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr8.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr9.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr10.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr11.jpg');
  deleteFile('E:\Licenta\Script licenta\test_arr12.jpg');

  removeImages();


  FPrincP.FormShow(FPrincP);
end;

procedure TFPrincP.removeImages;
begin
  Image12.Picture := nil;
  Image13.Picture := nil;
  Image14.Picture := nil;
  Image15.Picture := nil;
  Image16.Picture := nil;
  Image17.Picture := nil;
  Image18.Picture := nil;
  Image19.Picture := nil;
  Image20.Picture := nil;
  Image21.Picture := nil;
  Image22.Picture := nil;
  Image23.Picture := nil;
  Image24.Picture := nil;
end;

procedure TFPrincP.ResultsExecute(Sender: TObject);
var expected_cnp : string;
    i: Integer;
    myFile : TextFile;
    resulted_cnp  : string;
begin
  Panel5.Align := alNone;
  Panel6.Align := alNone;
  Panel8.Align := alNone;
  Panel7.Align := alNone;
  Panel9.Align := alClient;

  Panel5.Visible := False;
  Panel6.Visible := False;
  Panel7.Visible := False;
  Panel8.Visible := False;
  Panel9.Visible := True;



  if fileexists('E:\Licenta\Script licenta\test_arr0.jpg') then
  begin
    ScrollBox1.Visible := True;

    expected_cnp := '';
    resulted_cnp := '';

    drawLabelShapeRed();

    populateImages();


    fdQuery2.Active := True;
    fdQuery2.Filtered := False;
    fdQuery2.Filter := 'name = '''+ Edit1.Text +'''';
    fdQuery2.Filtered := True;

    expected_cnp := fdQuery2.FieldByName('cnp').AsString;

    showExpectedCnp(expected_cnp);

    assignFile(myFile, 'E:\Licenta\Script licenta\resulted_cnp.txt');

    Reset(myFile);

    while not Eof(myFile) do
    begin
      ReadLn(myFile, resulted_cnp);
    end;

    CloseFile(myFile);

    showResultedCnp(resulted_cnp);

    drawRect(expected_cnp,resulted_cnp);

  end else begin
    ScrollBox1.Visible := False;
  end;


end;

procedure TFPrincP.SaveExecute(Sender: TObject);
var AStream:TmemoryStream;
    currentDate : Tdatetime;
    extension : String;
    OutputList : TStringList;
begin
  //ShowMessage('Save');

  if (Edit1.Text = '') or (Edit2.Text = '') then
  begin
    //ShowMessage('Invalid action!');
    MessageDlg('Invalid action!', mtInformation,[mbOk], 0, mbOk);
    FPrincP.FormShow(FPrincP);
    exit;
  end;

//  fdQuery1.Active := True;
//  fdQuery1.Filtered := False;
//  fdQuery1.Filter := 'username = '''+ username +'''';
//  fdQuery1.Filtered := True;
//
//  userId := fdQuery1.FieldByName('id').AsInteger;

  //ShowMessage(userId.ToString);

  currentDate := now();

  AStream := TMemoryStream.Create;

  OutPutList := TStringList.Create;
  Split('.',Edit1.Text, OutPutList) ;
  extension := OutputList[OutputList.Count - 1];
  OutPutList.Free;
  //ShowMessage(extension);


  //Image6.Picture.Graphic.SaveToStream(AStream);
  Image6.Picture.SaveToStream(AStream);
  //save original image
  fdQuery6.Active := True;
  fdQuery6.Insert;
  fdQuery6.FieldByName('name').AsString := Edit1.Text;
  fdQuery6.FieldByName('extension').AsString := extension;
  fdQuery6.FieldByName('type').AsString := 'original';
  fdQuery6.FieldByName('users_id').AsInteger := userId;
  //TBlobField(fdQuery2.FieldByName('picture')).LoadFromStream(AStream);
  TBlobField(fdQuery6.FieldByName('picture')).LoadFromFile('C:\Users\Marius\Documents\Embarcadero\Studio\PC2Basys3\Win32\Debug\chosen_image\buletin.jpg');
  fdQuery6.FieldByName('tdate').AsDateTime := currentDate;
  fdQuery6.Post;

  AStream.Free;


  //ShowMessage('Imaginea originala adaugata!');
  MessageDlg('Original image saved!', mtInformation,[mbOk], 0, mbOk);

  //save edited image

  AStream := TMemoryStream.Create;

  Image7.Picture.SaveToStream(AStream);
  //Image7.Picture.Graphic.SaveToStream(AStream);
  OutPutList := TStringList.Create;
  Split('.',Edit2.Text, OutPutList) ;
  extension := OutputList[OutputList.Count - 1];
  OutputList.Free;

  fdQuery6.Active := True;
  fdQuery6.Insert;
  fdQuery6.FieldByName('name').AsString := Edit2.Text;
  fdQuery6.FieldByName('extension').AsString := extension;
  fdQuery6.FieldByName('type').AsString := 'edited';
  fdQuery6.FieldByName('users_id').AsInteger := userId;
  TBlobField(fdQuery6.FieldByName('picture')).LoadFromFile('C:\Users\Marius\Documents\Embarcadero\Studio\PC2Basys3\Win32\Debug\edited_image\edited.jpg');
  //TBlobField(fdQuery2.FieldByName('picture')).LoadFromStream(AStream);
  fdQuery6.FieldByName('tdate').AsDateTime := currentDate;
  fdQuery6.Post;

  //ShowMessage('Imaginea editata adaugata!');
  MessageDlg('Edited image saved!', mtInformation,[mbOk], 0, mbOk);

  AStream.Free;

  fdQuery3.Active := False;
  fdQuery3.Active := True;

  fdQuery4.Active := False;
  fdQuery4.Active := True;

  fdQuery5.Active := True;
  fdQuery5.Insert;
  fdQuery5.FieldByName('event').AsString := 'Save images';
  fdQuery5.FieldByName('o_filename').AsString := Edit1.Text;
  fdQuery5.FieldByName('e_filename').AsString := Edit2.Text;
  fdQuery5.FieldByName('users_id').AsInteger := userId;
  fdQuery5.FieldByName('tdate').AsDateTime := currentDate;
  fdQuery5.Post;


  FPrincP.FormShow(FPrincP);
end;

procedure TFPrincP.SendExecute(Sender: TObject);
var editedFilename : String;
    inputFileName,editedFileName1 : string;
    fileName : string;
    threshold : integer;
    fx,fy : double;
    MyText: TStringlist;
begin
  if Edit1.Text = '' then
  begin
    //ShowMessage('Image to be sent not chosen!');
    MessageDlg('Image to be sent not chosen!', mtInformation,[mbOk], 0, mbOk);
    FPrincP.FormShow(FPrincP);
    exit;
  end;
  SaveDialog1 := TSaveDialog.Create(self);

  SaveDialog1.FileName := GetCurrentDir +'\chosen_image\buletin.jpg';

  //SaveDialog1.FileName := 'buletin.jpg';
  SaveDialog1.DefaultExt := 'jpg';
  Image6.Picture.SaveToFile(SaveDialog1.FileName);
//  if SaveDialog1.Execute then
//  begin
//    Image6.Picture.SaveToFile(SaveDialog1.FileName);
//  end;

  SaveDialog1.Free;

  fdQuery2.Active := True;
  fdQuery2.Filtered := False;
  fdQuery2.Filter := 'name = '''+ Edit1.Text +'''';
  fdQuery2.Filtered := True;

  fx := fdQuery2.FieldByName('fx').AsFloat;
  fy := fdQuery2.FieldByName('fy').AsFloat;
  threshold := fdQuery2.FieldByName('threshold').AsInteger;

//  ShowMessage(fx.ToString);
//  ShowMessage(fy.ToString);
//  ShowMessage(threshold.ToString);

  MyText:= TStringlist.create;
  try
    MyText.Add(fx.ToString);
    MyText.Add(fy.ToString);
    MyText.Add(threshold.ToString);
    MyText.SaveToFile('C:\Users\Marius\Documents\Embarcadero\Studio\PC2Basys3\Win32\Debug\chosen_image\config.txt');
  finally
    MyText.Free
  end;


  sleep(15000);

  editedFileName1 := ExtractFilePath(Application.ExeName)+'\edited_image\edited.jpg';

  if not fileexists(editedFileName1) then
  begin
     MessageDlg('The image was not processed!', mtInformation,[mbOk], 0, mbOk);
     FPrincP.FormShow(FPrincP);
     exit;
  end;


  Image7.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\edited_image\edited.jpg');
  editedFilename := 'e' + Edit1.Text;
  Edit2.Text := editedFilename;


  //verific daca a fost creat fisierul inputsAllVHDL.txt
  //in cazul in care a fost creat, rulez aplicatia de automatizare pentru a trimite
  //la placa fisierele de input si weights

  inputFileName := 'E:\HTerm\InputsAllVHDL.txt';

  if fileexists(inputFileName) then
  begin
     //ShowMessage('1');
     ShellExecute(Handle, 'open','C:\Users\Marius\Desktop\Winium_v4\Winium.exe', nil, nil, SW_SHOWNORMAL);
     //ShowMessage('2');
  end else begin
     //ShowMessage(inputFileName+' does not exist');
     MessageDlg(inputFileName + ' does not exist', mtInformation,[mbOk], 0, mbOk);
  end;

//  fdQuery5.Active := True;
//  fdQuery5.Insert;
//  fdQuery5.FieldByName('event').AsString := 'Send image';
//  fdQuery5.FieldByName('o_filename').AsString := Edit1.Text;
//  fdQuery5.FieldByName('e_filename').AsString := Edit2.Text;
//  fdQuery5.FieldByName('users_id').AsInteger := userId;
//  fdQuery5.FieldByName('tdate').AsDateTime := now();
//  fdQuery5.Post;

  FPrincP.FormShow(FPrincP);
end;

procedure TFPrincP.showExpectedCnp(expected_cnp: String);
begin
  Label10.Caption := expected_cnp[1];
  Label11.Caption := expected_cnp[2];
  Label12.Caption := expected_cnp[3];
  Label13.Caption := expected_cnp[4];
  Label14.Caption := expected_cnp[5];
  Label15.Caption := expected_cnp[6];
  Label16.Caption := expected_cnp[7];
  Label17.Caption := expected_cnp[8];
  Label18.Caption := expected_cnp[9];
  Label19.Caption := expected_cnp[10];
  Label20.Caption := expected_cnp[11];
  Label21.Caption := expected_cnp[12];
  Label22.Caption := expected_cnp[13];
end;

procedure TFPrincP.showResultedCnp(resulted_cnp: String);
begin
  Label26.Caption := resulted_cnp[1];
  Label27.Caption := resulted_cnp[2];
  Label28.Caption := resulted_cnp[3];
  Label29.Caption := resulted_cnp[4];
  Label30.Caption := resulted_cnp[5];
  Label31.Caption := resulted_cnp[6];
  Label32.Caption := resulted_cnp[7];
  Label33.Caption := resulted_cnp[8];
  Label39.Caption := resulted_cnp[9];
  Label35.Caption := resulted_cnp[10];
  Label36.Caption := resulted_cnp[11];
  Label37.Caption := resulted_cnp[12];
  Label38.Caption := resulted_cnp[13];
end;

procedure TFPrincP.TakePhotoExecute(Sender: TObject);
begin
  //ShowMessage('Take photo');

  Panel9.Align := alNone;
  Panel6.Align := alNone;
  Panel7.Align := alNone;
  Panel8.Align := alNone;
  Panel5.Align := alClient;

  Panel5.Visible := True;
  Panel6.Visible := False;
  Panel7.Visible := False;
  Panel8.Visible := False;
  Panel9.Visible := False;


  FPrincP.FormShow(FPrincP);
end;

end.
