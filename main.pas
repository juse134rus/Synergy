unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Web.DBWeb, Web.HTTPProd;

type
  TWebModule1 = class(TWebModule)
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDQuery1: TFDQuery;
    DataSetTableProducer1: TDataSetTableProducer;
    PageProducer1: TPageProducer;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  // Подключаемся к базе данных
  FDConnection1.Params.Clear;
  FDConnection1.Params.Add('DriverID=PG');
  FDConnection1.Params.Add('Server=localhost');
  FDConnection1.Params.Add('Database=library_db');
  FDConnection1.Params.Add('User_Name=postgres');
  FDConnection1.Params.Add('Password=ваш_пароль');
  
  try
    FDConnection1.Connected := True;
    
    // Получаем список книг
    FDQuery1.SQL.Text := 'SELECT * FROM books ORDER BY title';
    FDQuery1.Open;
    
    // Настраиваем DataSetTableProducer
    DataSetTableProducer1.Header.Add('<h1>Список книг в библиотеке</h1>');
    DataSetTableProducer1.Footer.Add('<p><a href="/">Обновить список</a></p>');
    
    // Генерируем HTML
    Response.Content := PageProducer1.Content + DataSetTableProducer1.Content;
    
    FDQuery1.Close;
  except
    on E: Exception do
      Response.Content := 'Ошибка: ' + E.Message;
  end;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  // Настройка PageProducer
  PageProducer1.HTMLDoc.Text := 
    '<html>' +
    '<head>' +
    '<title>Библиотека - Управление книгами</title>' +
    '<style>' +
    'body { font-family: Arial, sans-serif; margin: 20px; }' +
    'table { border-collapse: collapse; width: 100%; }' +
    'th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }' +
    'th { background-color: #f2f2f2; }' +
    'tr:nth-child(even) { background-color: #f9f9f9; }' +
    '</style>' +
    '</head>' +
    '<body>';
    
  PageProducer1.HTMLFooter.Text := 
    '</body>' +
    '</html>';
end;

end.