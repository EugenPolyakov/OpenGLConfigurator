program OpenGLConfigurator;

uses
  Vcl.Forms,
  SysUtils,
  Classes,
  Winapi.Windows,
  uMain in 'uMain.pas' {fMain},
  FastXML in '..\FastXML.pas',
  WinAPIExtensions in '..\WinAPIExtensions.pas',
  OpenGLSpecProcessor in '..\OpenGL\OpenGLSpecProcessor.pas',
  SysTypes in '..\SysTypes.pas',
  SysUtilsExtensions in '..\SysUtilsExtensions.pas',
  StreamExtensions in '..\StreamExtensions.pas',
  RecordUtils in '..\RecordUtils.pas',
  DirectoryManager in '..\DirectoryManager.pas';

{$APPTYPE CONSOLE}
{$R *.res}

function TryParseParams: Boolean;
var p: Integer;
    arg: string;
    arr: TArray<string>;
    i: Integer;
    ex, outFile: Boolean;
    resultFile: string;
    opt: TGeneratorOptions;
    exceptions: string;
begin
  Result:= False;
  p:= 1;
  arg:= LowerCase(ParamStr(1));
  CreateDataObjects;
  opt.UseEnumeratesAndSets:= False;
  opt.ConvertPointersToArray:= False;
  opt.GenerateDefaultCFunctions:= False;
  opt.AddGetProcAddress:= False;
  try
    ex:= False;
    outFile:= False;
    exceptions:= '';
    while arg <> '' do begin
      if (arg = '/f') or (arg = '-f') then begin
        Inc(p);
        arg:= ParamStr(p);
        ex:= ex or (arg <> '');
        AddFile(arg);
      end else if (arg = '/static') or (arg = '-static') then begin
        Inc(p);
        arg:= ParamStr(p);
        arr:= arg.Split([' ']);
        for i := 0 to High(arr) do
          ex:= SetSelection(arr[i], cuStatic) or ex;
      end else if (arg = '/dynamic') or (arg = '-dynamic') then begin
        Inc(p);
        arg:= ParamStr(p);
        arr:= arg.Split([' ']);
        for i := 0 to High(arr) do
          ex:= SetSelection(arr[i], cuDynamic) or ex;
      end else if (arg = '/except') or (arg = '-except') then begin
        Inc(p);
        arg:= ParamStr(p);
        arr:= arg.Split([' ']);
        for i := 0 to High(arr) do
          ex:= SetSelection(arr[i], cuNone) or ex;
      end else if (arg = '/out') or (arg = '-out') then begin
        outFile:= True;
        Inc(p);
        resultFile:= ParamStr(p);
      end else if (arg = '/profile') or (arg = '-profile') then begin
        Inc(p);
        opt.Profile:= ParamStr(p);
      end else if (arg = '/arrays') or (arg = '-arrays') then begin
        opt.ConvertPointersToArray:= True;
      end else if (arg = '/enums') or (arg = '-enums') then begin
        opt.UseEnumeratesAndSets:= True;
      end else if (arg = '/unicode') or (arg = '-unicode') then begin
        opt.UnicodePascal:= True;
      end else if (arg = '/cfuncs') or (arg = '-cfuncs') then begin
        opt.GenerateDefaultCFunctions:= True;
      end else if (arg = '/getproc') or (arg = '-getproc') then begin
        opt.AddGetProcAddress:= True;
      end else if (arg = '/important') or (arg = '-important') then begin
        Inc(p);
        arg:= ParamStr(p);
        arr:= arg.Split([' ']);
        opt.CustomForcedSets:= Concat(opt.CustomForcedSets, arr);
      end else if (arg = '/excluded') or (arg = '-excluded') then begin
        Inc(p);
        arg:= ParamStr(p);
        arr:= arg.Split([' ']);
        opt.CustomExcludedSets:= Concat(opt.CustomExcludedSets, arr);
      end;

      Inc(p);
      arg:= LowerCase(ParamStr(p));
    end;
    Result:= outFile and ex;
    opt.GenerateDefaultCFunctions:= not opt.ConvertPointersToArray or opt.GenerateDefaultCFunctions;

    if Result then begin
      WriteLn('Exporting...');
      SavePascal(resultFile, opt);
      WriteLn('Exported finished');
    end;
  except
  on E: Exception do
    WriteLn('Error: ', E.Message);
  end;
  FreeDataObjects;
end;

begin
  if TryParseParams then
    Exit;
  FreeConsole;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
