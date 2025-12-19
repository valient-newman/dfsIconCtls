{$I DFS.INC}

unit IcCtlReg;

interface

{$IFDEF DFS_WIN32}
  {$R IconCtls.res}
{$ELSE}
  {$R IconCtls.r16}
{$ENDIF}

procedure Register;

implementation

uses
  {$IFDEF DFS_NO_DSGNINTF}
  DesignIntf,
  DesignEditors,
  {$ELSE}
  DsgnIntf,
  {$ENDIF}
  IconCtls, DFSAbout, Classes;

{ Add the components to the Delphi Component Palette.  You will want to modify     }
{ this so that it appears on the page of your choice.                              }
procedure Register;
begin
  RegisterComponents('DFS', [TdfsIconComboBox, TdfsIconListBox]);
  RegisterPropertyEditor(TypeInfo(string), TdfsIconComboBox, 'Version',
     TDFSVersionProperty);
  RegisterPropertyEditor(TypeInfo(string), TdfsIconListBox, 'Version',
     TDFSVersionProperty);
end;

end.
