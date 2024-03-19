unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FastXML, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Clipbrd,
  System.Generics.Collections, SysTypes, OpenGLSpecProcessor, OpenGL, DirectoryManager;

type
{
  Динамический/статический вариант функций
  список расширений и стандартов
}

{

<registry>
    <comment>
Copyright (c) 2013-2018 The Khronos Group Inc.
    </comment>

    <!-- SECTION: GL type definitions. -->
    <types>
            <!-- These are dependencies GL types require to be declared legally -->
        <type name="khrplatform">#include &lt;KHR/khrplatform.h&gt;</type>
            <!-- These are actual GL types -->
        <type>typedef unsigned int <name>GLenum</name>;</type>
        <type comment="Not an actual GL type, though used in headers in the past">typedef void <name>GLvoid</name>;</type>
        <type requires="khrplatform">typedef khronos_float_t <name>GLfloat</name>;</type>
        <type>typedef double <name>GLdouble</name>;</type>
        <type>typedef void *<name>GLeglClientBufferEXT</name>;</type>
        <type>typedef char <name>GLchar</name>;</type>
        <type name="GLhandleARB">#ifdef __APPLE__
typedef void *GLhandleARB;
#else
typedef unsigned int GLhandleARB;
#endif</type>
        <type requires="khrplatform">typedef khronos_uint16_t <name>GLhalf</name>;</type>
        <type>typedef struct __GLsync *<name>GLsync</name>;</type>
        <type comment="compatible with OpenCL cl_event"><name>struct _cl_event</name>;</type>
            <!-- Vendor extension types -->
        <type>typedef void (<apientry/> *<name>GLDEBUGPROCAMD</name>)(GLuint id,GLenum category,GLenum severity,GLsizei length,const GLchar *message,void *userParam);</type>
        <type requires="GLintptr">typedef GLintptr <name>GLvdpauSurfaceNV</name>;</type>
        <type>typedef void (<apientry/> *<name>GLVULKANPROCNV</name>)(void);</type>
    </types>
    <groups>
        <group name="InternalFormat" comment="Was PixelInternalFormat">
            <enum name="GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT"/>
            <!-- <enum name="GL_RGB2" comment="Never actually added to core"/> -->
        </group>
        <group name="ProgramPropertyARB">
            <enum name="GL_DELETE_STATUS" />
        </group>
    </groups>
    <enums namespace="GL" group="FragmentShaderColorModMaskATI" type="bitmask">
            <!-- Also used: 0x00000001 for GL_2X_BIT_ATI reused from FragmentShaderDestModMaskAT above -->
        <enum value="0x00000002" name="GL_COMP_BIT_ATI"/>
    </enums>
    <enums namespace="GL" start="0x96A0" end="0x96AF" vendor="Qualcomm" comment="contact Maurice Ribble">
        <enum value="0x96A2" name="GL_FRAMEBUFFER_FETCH_NONCOHERENT_QCOM"/>
            <unused start="0x96A4" end="0x96AF" vendor="Qualcomm"/>
    </enums>
    <enums namespace="GL" start="107000" end="107999" vendor="PGI" comment="Portland Graphics was acquired by Template Graphics, which is out of business">
            <!-- lots of <unused> areas here which won't be computed yet -->
        <enum value="0x1A1F8" name="GL_PREFER_DOUBLEBUFFER_HINT_PGI"/>
    </enums>
    <commands namespace="GL">
        <command>
            <proto>void <name>glWindowPos3svARB</name></proto>
            <param group="CoordS" len="3">const <ptype>GLshort</ptype> *<name>v</name></param>
            <alias name="glWindowPos3sv"/>
            <glx type="render" opcode="230"/>
        </command>
        <command>
            <proto>void <name>glWindowPos4sMESA</name></proto>
            <param group="CoordS"><ptype>GLshort</ptype> <name>x</name></param>
            <param group="CoordS"><ptype>GLshort</ptype> <name>y</name></param>
            <param group="CoordS"><ptype>GLshort</ptype> <name>z</name></param>
            <param group="CoordS"><ptype>GLshort</ptype> <name>w</name></param>
            <vecequiv name="glWindowPos4svMESA"/>
        </command>
        <command>
            <proto>void <name>glWindowPos4svMESA</name></proto>
            <param group="CoordS" len="4">const <ptype>GLshort</ptype> *<name>v</name></param>
        </command>
        <command>
            <proto><ptype>GLVULKANPROCNV</ptype> <name>glGetVkProcAddrNV</name></proto>
            <param len="COMPSIZE(name)">const <ptype>GLchar</ptype> *<name>name</name></param>
        </command>
        <command>
            <proto>void <name>glWaitVkSemaphoreNV</name></proto>
            <param><ptype>GLuint64</ptype> <name>vkSemaphore</name></param>
        </command>
    </commands>
    <feature api="glsc2" name="GL_SC_VERSION_2_0" number="2.0">
        <require comment="Not used by the API, but could be used by applications">
            <type name="GLbyte" comment="Used to define GL_BYTE data"/>
        </require>
        <require profile="compatibility" comment="Reuse ARB_vertex_type_2_10_10_10_rev compatibility profile">
            <enum name="GL_LOSE_CONTEXT_ON_RESET"/>
            <command name="glViewport"/>
        </require>
    </feature>
    <extensions>
        <extension name="GL_ARB_direct_state_access" supported="gl|glcore">
            <require>
                <enum name="GL_TEXTURE_TARGET"/>
            </require>
            <require comment="Transform Feedback object functions">
                <command name="glCreateTransformFeedbacks"/>
            </require>
        </extension>
    </extensions>
</registry>
}
  TfMain = class (TForm)
    bOpen: TButton;
    fod: TFileOpenDialog;
    chlbList: TCheckListBox;
    bSelAll: TButton;
    bUnselAll: TButton;
    bInverse: TButton;
    bSave: TButton;
    eFilter: TEdit;
    lFilter: TLabel;
    lAPI: TLabel;
    cbAPI: TComboBox;
    cbUseEnumeratesAndSets: TCheckBox;
    cbProfile: TComboBox;
    lProfile: TLabel;
    fsd: TFileSaveDialog;
    cbUseDelphiStyleAndTypes: TCheckBox;
    cbCreateDefaultFunctions: TCheckBox;
    cbAddGetProcAddress: TCheckBox;
    lCustomSets: TLabel;
    mCustomSets: TMemo;
    mExcludedSets: TMemo;
    lExcludedSets: TLabel;
    bGenerateCommand: TButton;
    procedure bOpenClick(Sender: TObject);
    procedure eFilterChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bSelAllClick(Sender: TObject);
    procedure bUnselAllClick(Sender: TObject);
    procedure bInverseClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure cbUseDelphiStyleAndTypesClick(Sender: TObject);
    procedure bGenerateCommandClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateList;
    procedure SaveSelection;
  end;

  PCheckBoxState = ^TCheckBoxState;

var
  fMain: TfMain;

procedure AddFile(const FileName: string);
procedure CreateDataObjects;
procedure FreeDataObjects;
function SetSelection(extension: TFileMask; state: TCommandUsing): Boolean;
procedure SavePascal(AFileName: string; opt: TGeneratorOptions);
procedure Test1(len: Integer; arr: PInteger); stdcall;
procedure Test2(const arr: array of Integer); stdcall;

implementation

var
  FFiles: TStringList;
  FData: TList<TParsedData>;
  FOptions: TList<TArray<TCommandUsing>>;

procedure SavePascal(AFileName: string; opt: TGeneratorOptions);
var f: TFileStream;
    saver: TPascalSaver;
begin
  f:= nil;
  saver:= nil;
  try
    f:= TFileStream.Create(AFileName, fmCreate);
    opt.Selection:= FOptions.List;
    opt.UnitName:= ChangeFileExt(ExtractFileName(AFileName), '');
    saver:= TPascalSaver.Create;
    saver.SaveToStream(FData.List, opt, f);
  finally
    saver.Free;
    f.Free;
  end;
end;

function SetSelection(extension: TFileMask; state: TCommandUsing): Boolean;
var i, j: Integer;
begin //Name.ToLower.Contains(txt)
  for i := 0 to FData.Count - 1 do with FData[i] do
    for j := 0 to High(Extensions) do with Extensions[j] do
      if extension.Compare(Name) then begin
        FOptions[i][j]:= state;
        Result:= True;
        if extension.IsSimpleString then
          Exit;
      end;
  Result:= False;
end;

procedure CreateDataObjects;
begin
  FFiles:= TStringList.Create;
  FData:= TList<TParsedData>.Create;
  FOptions:= TList<TArray<TCommandUsing>>.Create;
end;

procedure FreeDataObjects;
begin
  FreeAndNil(FFiles);
  FreeAndNil(FData);
  FreeAndNil(FOptions);
end;

procedure AddFile(const FileName: string);
var reader: TXMLReader;
    loader: TOGLLoader;
    opt: TXMLElementParserOptions;
    options: TArray<TCommandUsing>;
begin
  reader:= TXMLReader.Create;
  loader:= TOGLLoader.Create;
  try
    FillChar(opt, SizeOf(opt), 0);
    opt.OnNewInnerElement:= loader.NewElement;
    reader.LoadFromFile(FileName, opt);
    FFiles.Add(FileName);
    FData.Add(loader.Data);
    SetLength(options, Length(loader.Data.Extensions));
    FOptions.Add(options);
  finally
    loader.Free;
    reader.Free;
  end;
end;

procedure Test1(len: Integer; arr: PInteger);
begin

end;
procedure Test2(const arr: array of Integer);
begin

end;

{$R *.dfm}

{ TfMain }

procedure TfMain.bGenerateCommandClick(Sender: TObject);
var
  i: Integer;
  j: Integer;
  check: Boolean;
  st, din, full: string;
begin
  SaveSelection;
  full:= '/f ';
  for i := 0 to FOptions.Count - 1 do begin
    check:= False;
    for j := 0 to High(FOptions[i]) do begin
      case FOptions[i][j] of
        cuStatic: st:= st + FData[i].Extensions[j].Name + ' ';
        cuDynamic: din:= din + FData[i].Extensions[j].Name + ' ';
      else
        Continue;
      end;
      check:= True;
    end;
    if check then
      full:= full + '"' + FFiles[i] + '" ';
  end;

  if full = '/f ' then begin
    ShowMessage('Nothing selected');
    Exit;
  end;

  if st <> '' then
    full:= full + '/static "' + st + '" ';

  if din <> '' then
    full:= full + '/dinamic "' + din + '" ';

  if cbUseEnumeratesAndSets.Checked then
    full:= full + '/enums ';

  if cbProfile.Text <> '' then
    full:= full + '/profile "' + cbProfile.Text + '" ';

  if cbUseDelphiStyleAndTypes.Checked then
    full:= full + '/arrays ';

  if cbAddGetProcAddress.Checked then
    full:= full + '/getproc ';

  if not cbUseDelphiStyleAndTypes.Checked or cbCreateDefaultFunctions.Checked then
    full:= full + '/cfuncs ';

  if mCustomSets.Lines.Count > 0 then begin
    mCustomSets.Lines.Delimiter:= ' ';
    full:= full + '/important "' + mCustomSets.Lines.DelimitedText + '" ';
  end;

  if mExcludedSets.Lines.Count > 0 then begin
    mExcludedSets.Lines.Delimiter:= ' ';
    full:= full + '/excluded "' + mExcludedSets.Lines.DelimitedText + '" ';
  end;

  Clipboard.AsText:= full;
  ShowMessage('Console parameters copied'#13 + full);
end;

procedure TfMain.bInverseClick(Sender: TObject);
var i: Integer;
begin
  for i := 0 to chlbList.Items.Count - 1 do
    chlbList.State[i]:= TCheckBoxState((Integer(chlbList.State[i]) + 1) mod 3);
end;

procedure TfMain.bOpenClick(Sender: TObject);
var arr: array [0..1] of Integer;
var i, j: Integer;
    list: TStringList;
    s: string;
begin
  Test1(2, @arr[0]);
  Test2(arr);
  if fod.Execute then begin
    chlbList.Clear;
    AddFile(fod.FileName);
    list:= TStringList.Create;
    try
      list.Duplicates:= dupIgnore;
      list.Sorted:= True;
      list.Assign(cbAPI.Items);
      with FData.Last do begin
        for i := 0 to High(Extensions) do begin
          for s in Extensions[i].Supported do
            list.Add(s);
        end;
        list.Add('');
        s:= cbAPI.Text;
        cbAPI.Items.Assign(list);
        cbAPI.Text:= s;


        list.Clear;
        list.Assign(cbProfile.Items);
        for i := 0 to High(Extensions) do begin
          for j:= 0 to  High(Extensions[i].Require) do
            if Extensions[i].Require[j].Supported <> '' then
              list.Add(Extensions[i].Require[j].Supported);
          for j:= 0 to  High(Extensions[i].Remove) do
            if Extensions[i].Remove[j].Supported <> '' then
              list.Add(Extensions[i].Remove[j].Supported);
        end;
      end;
      list.Add('');
      s:= cbProfile.Text;
      cbProfile.Items.Assign(list);
      cbProfile.Text:= s;

      UpdateList;
    finally
      list.Free;
    end;
  end;
end;

procedure TfMain.bSaveClick(Sender: TObject);
var opt: TGeneratorOptions;
begin
  SaveSelection;
  if fsd.Execute then begin
    opt.UseEnumeratesAndSets:= cbUseEnumeratesAndSets.Checked;
    opt.Profile:= cbProfile.Text;
    opt.ConvertPointersToArray:= cbUseDelphiStyleAndTypes.Checked;
    opt.AddGetProcAddress:= cbAddGetProcAddress.Checked;
    opt.GenerateDefaultCFunctions:= not opt.ConvertPointersToArray or cbCreateDefaultFunctions.Checked;
    opt.CustomForcedSets:= mCustomSets.Lines.ToStringArray;
    opt.CustomExcludedSets:= mExcludedSets.Lines.ToStringArray;
    SavePascal(fsd.FileName, opt);
  end;
end;

procedure TfMain.bSelAllClick(Sender: TObject);
var i: Integer;
begin
  for i := 0 to chlbList.Items.Count - 1 do
    chlbList.State[i]:= cbChecked;
end;

procedure TfMain.bUnselAllClick(Sender: TObject);
var i: Integer;
begin
  for i := 0 to chlbList.Items.Count - 1 do
    chlbList.State[i]:= cbUnchecked;
end;

procedure TfMain.cbUseDelphiStyleAndTypesClick(Sender: TObject);
begin
  cbCreateDefaultFunctions.Enabled:= cbUseDelphiStyleAndTypes.Checked;
end;

procedure TfMain.eFilterChange(Sender: TObject);
begin
  SaveSelection;
  UpdateList;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  CreateDataObjects;
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  FreeDataObjects;
end;

procedure TfMain.SaveSelection;
var i: Integer;
begin
  for i := 0 to chlbList.Items.Count - 1 do
    PCheckBoxState(chlbList.Items.Objects[i])^:= chlbList.State[i];
end;

procedure TfMain.UpdateList;
var i, j, p: Integer;
    filter, filter2: Boolean;
    txt, api: string;
begin
  chlbList.Clear;

  txt:= string(eFilter.Text).ToLower;
  filter:= eFilter.Text = '';
  api:= cbAPI.Text;
  filter2:= api = '';
  chlbList.Items.BeginUpdate;
  try
  for i := 0 to FData.Count - 1 do with FData[i] do
    for j := 0 to High(Extensions) do with Extensions[j] do
      if (filter or Name.ToLower.Contains(txt)) and
          (filter2 or(OpenGLSpecProcessor.IndexOf(Supported, api) <> -1)) then begin
        p:= chlbList.Items.AddObject(Name, TObject(@FOptions[i][j]));
        chlbList.State[p]:= TCheckBoxState(FOptions[i][j]);
      end;
  finally
    chlbList.Items.EndUpdate;
  end;
end;

end.
