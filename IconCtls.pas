{$I DFS.INC}  { Standard defines for all Delphi Free Stuff components }

{------------------------------------------------------------------------------}
{ TdfsIconComboBox and TdfsIconListBox v1.17                                   }
{------------------------------------------------------------------------------}
{ A Caching Icon ComboBox and ListBox component for Delphi.                    }
{                                                                              }
{ Copyright 1996-2001, Brad Stowers.  All Rights Reserved.                     }
{ Remade by Valient Newman to comply with Delphi 2009 requirements             }
{                                                                              }
{ Copyright:                                                                   }
{ All Delphi Free Stuff (hereafter "DFS") source code is copyrighted by        }
{ Bradley D. Stowers (hereafter "author"), and shall remain the exclusive      }
{ property of the author.                                                      }
{                                                                              }
{ Distribution Rights:                                                         }
{ You are granted a non-exlusive, royalty-free right to produce and distribute }
{ compiled binary files (executables, DLLs, etc.) that are built with any of   }
{ the DFS source code unless specifically stated otherwise.                    }
{ You are further granted permission to redistribute any of the DFS source     }
{ code in source code form, provided that the original archive as found on the }
{ DFS web site (http://www.delphifreestuff.com) is distributed unmodified. For }
{ example, if you create a descendant of TDFSColorButton, you must include in  }
{ the distribution package the colorbtn.zip file in the exact form that you    }
{ downloaded it from http://www.delphifreestuff.com/mine/files/colorbtn.zip.   }
{                                                                              }
{ Restrictions:                                                                }
{ Without the express written consent of the author, you may not:              }
{   * Distribute modified versions of any DFS source code by itself. You must  }
{     include the original archive as you found it at the DFS site.            }
{   * Sell or lease any portion of DFS source code. You are, of course, free   }
{     to sell any of your own original code that works with, enhances, etc.    }
{     DFS source code.                                                         }
{   * Distribute DFS source code for profit.                                   }
{                                                                              }
{ Warranty:                                                                    }
{ There is absolutely no warranty of any kind whatsoever with any of the DFS   }
{ source code (hereafter "software"). The software is provided to you "AS-IS", }
{ and all risks and losses associated with it's use are assumed by you. In no  }
{ event shall the author of the softare, Bradley D. Stowers, be held           }
{ accountable for any damages or losses that may occur from use or misuse of   }
{ the software.                                                                }
{                                                                              }
{ Support:                                                                     }
{ Support is provided via the DFS Support Forum, which is a web-based message  }
{ system.  You can find it at http://www.delphifreestuff.com/discus/           }
{ All DFS source code is provided free of charge. As such, I can not guarantee }
{ any support whatsoever. While I do try to answer all questions that I        }
{ receive, and address all problems that are reported to me, you must          }
{ understand that I simply can not guarantee that this will always be so.      }
{                                                                              }
{ Clarifications:                                                              }
{ If you need any further information, please feel free to contact me directly.}
{ This agreement can be found online at my site in the "Miscellaneous" section.}
{------------------------------------------------------------------------------}
{ The latest version of my components are always available on the web at:      }
{   http://www.delphifreestuff.com/                                            }
{ See IconCtls.txt for notes, known issues, and revision history.              }
{------------------------------------------------------------------------------}
{ Date last modified:  June 28, 2001                                           }
{------------------------------------------------------------------------------}
{ Date last modified by Newman:  December 18, 2025                             }
{ Github Repository <https://github.com/valient-newman>                        }
{------------------------------------------------------------------------------}

unit IconCtls;

interface

uses
  {$IFDEF DFS_COMPILER_2_UP}
  Windows,
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Menus;

const
  DFS_COMBO_VERSION = 'TdfsIconComboBox v1.17';
  DFS_LIST_VERSION  = 'TdfsIconListBox v1.17';

type
  TdfsIconComboBox = class(TCustomComboBox)
  private
    { Variables for properties }
    FFileName: String;
    FAutoDisable: boolean;
    FEnableCaching: boolean;
    FNumberOfIcons: integer;
    FRecreating: boolean;
    FOnFileChange: TNotifyEvent;

    { Routines that should only be used internally by component }
    procedure LoadIcons;
    procedure FreeIcons;
    procedure UpdateEnabledState;

    {$IFDEF DFS_COMPILER_3_UP}
    procedure CMRecreateWnd(var Message: TMessage); message CM_RECREATEWND;
    {$ENDIF}
    procedure WMDeleteItem(var Msg: TWMDeleteItem); message WM_DELETEITEM;
  protected
    { Routines for setting property values and updating affected items }
    procedure SetFileName(Value: String);
    procedure SetAutoDisable(Value: boolean);
    procedure SetEnableCaching(Value: boolean);
    function GetVersion: string;
    procedure SetVersion(const Val: string);

    { Icon service routines }
    function  ReadIcon(const Index: integer): TIcon;
    function  GeTdfsIcon(Index: integer): TIcon;

    { Owner drawing routines }
    procedure MeasureItem(Index: Integer; var Height: Integer);              override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
  public
    constructor Create(AOwner: TComponent); override;

    { Returns a specific TIcon in the list.  The TIcon is owned by the
      component, so you should NEVER free it. }
    property Icon[Index: integer]: TIcon
       read GeTdfsIcon;
  published
    property Version: string
       read GetVersion
       write SetVersion
       stored FALSE;
    { Name of icon file to display }
    property FileName: string
       read FFileName
       write SetFileName;
    { If true, the combobox will be disabled when FileName does not exist }
    property AutoDisable: boolean
       read FAutoDisable
       write SetAutoDisable
       default TRUE;
    { If true, icons will be loaded as needed, instead of all at once }
    property EnableCaching: boolean
       read FEnableCaching
       write SetEnableCaching
       default TRUE;
    { The number of icons in the file.  -1 if FileName is not valid.  }
    property NumberOfIcons: integer
       read FNumberOfIcons
       default -1;

    { Useful if you have statics the reflect the number of icons, etc. }
    property OnFileChange: TNotifyEvent
       read FOnFileChange
       write FOnFileChange;

    { Protected properties in parent that we will make available to everyone }
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property DropDownCount default 5;
    property Enabled;
    property ItemIndex;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TOrientation = (lbHorizontal, lbVertical);

  TdfsIconListBox = class(TCustomListBox)
  private
    { Private declarations }
    FFileName: String;
    FAutoDisable: boolean;
    FEnableCaching: boolean;
    FNumberOfIcons: integer;
    FMargin: integer;
    FRecreating: boolean;
    FOnFileChange: TNotifyEvent;

    { Routines that should only be used internally by component }
    procedure LoadIcons;
    procedure FreeIcons;
    procedure UpdateEnabledState;

    procedure CNDeleteItem(var Msg: TWMDeleteItem); message CN_DELETEITEM;
    {$IFDEF DFS_COMPILER_3_UP}
    procedure CMRecreateWnd(var Message: TMessage); message CM_RECREATEWND;
    {$ENDIF}
  protected
    procedure CreateParams(var Params: TCreateParams);                       override;
    procedure CreateWnd; override;
    { Routines for setting property values and updating affected items }
    procedure SetFileName(Value: String);
    procedure SetAutoDisable(Value: boolean);
    procedure SetMargin(const Value: integer);
    procedure SetEnableCaching(Value: boolean);
    function GetVersion: string;
    procedure SetVersion(const Val: string);

    { Icon service routines }
    function  ReadIcon(const Index: integer): TIcon;
    function  GeTdfsIcon(Index: integer): TIcon;

    { Owner drawing routines }
{    procedure MeasureItem(Index: Integer; var Height: Integer);              override;}
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
  public
    constructor Create(AOwner: TComponent); override;

    { Returns a specific TIcon in the list.  The TIcon is owned by the
      component, so you should NEVER free it. }
    property Icon[Index: integer]: TIcon
       read GeTdfsIcon;
  published
    property Version: string
       read GetVersion
       write SetVersion
       stored FALSE;
    { Name of icon file to display }
    property FileName: string
       read FFileName
       write SetFileName;
    { If true, the combobox will be disabled when FileName does not exist }
    property AutoDisable: boolean
       read FAutoDisable
       write SetAutoDisable
       default TRUE;
    { If true, icons will be loaded as needed, instead of all at once }
    property EnableCaching: boolean
       read FEnableCaching
       write SetEnableCaching
       default TRUE;
    { Number of pixels of white space to add around the icons for padding }
    property Margin: integer
       read FMargin
       write SetMargin
       default 5;
    { The number of icons in the file.  -1 if FileName is not valid.  }
    property NumberOfIcons: integer
       read FNumberOfIcons
       default -1;

    { Useful if you have statics the reflect the number of icons, etc. }
    property OnFileChange: TNotifyEvent
       read FOnFileChange
       write FOnFileChange;

    { Protected properties in parent that we will make available to everyone }
    property Align;
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property Enabled;
    property ItemIndex;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

implementation

uses
  ShellAPI;


{ TdfsIconComboBox Component }
constructor TdfsIconComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRecreating := FALSE;
  { Set default values }
  FileName := '';
  AutoDisable := TRUE;
  EnableCaching := TRUE;
  FNumberOfIcons := -1;
  DropDownCount := 5;
  Style := csOwnerDrawFixed;
  ItemHeight := GetSystemMetrics(SM_CYICON) + 6;
  Height := ItemHeight;
  Font.Name := 'Arial';
  Font.Height := ItemHeight;
  Width := GetSystemMetrics(SM_CXICON) + GetSystemMetrics(SM_CXVSCROLL) + 10;
end;

{$IFDEF DFS_COMPILER_3_UP}
procedure TdfsIconComboBox.CMRecreateWnd(var Message: TMessage);
begin
  FRecreating := TRUE;
  try
    inherited;
  finally
    FRecreating := FALSE;
  end;
end;
{$ENDIF}

procedure TdfsIconComboBox.WMDeleteItem(var Msg: TWMDeleteItem);
var
  Icon: TIcon;
begin
  if FRecreating then exit;

  { Don't use GeTdfsIcon here! }
  Icon := TIcon(Items.Objects[Msg.DeleteItemStruct^.itemID]);
  { Free it.  If it is NIL, Free ignores it, so it is safe }
  Icon.Free;
  { Zero out the TIcon we just freed }
  Items.Objects[Msg.DeleteItemStruct^.itemID] := NIL;
end;

{ Initialize the icon handles, which are stored in the Objects property }
procedure TdfsIconComboBox.LoadIcons;
var
  x: integer;
  Icon: TIcon;
  Buff: array[0..255] of char;
  OldCursor: TCursor;
begin
  { Clear any old icon handles }
  FreeIcons;
  { Reset the contents of the combobox }
  Clear;
  { Update the enabled state of the control }
  UpdateEnabledState;
  { If we have a valid file then setup the combobox. }
  if FileExists(FileName) then begin
    { If we are not loading on demand, set the cursor to an hourglass }
    OldCursor := Screen.Cursor;
    if not EnableCaching then
      Screen.Cursor := crHourGlass;
    { Find out how many icons are in the file }
      FNumberOfIcons := ExtractIcon(hInstance, StrPCopy(Buff, FileName),
         {$IFDEF DFS_WIN32} UINT(-1)); {$ELSE} word(-1)); {$ENDIF}
    { Loop for every icon in the file }
    for x := 0 to NumberOfIcons - 1 do begin
      { If we are not loading on demand... }
      if not EnableCaching then begin
        { Create a TIcon object... }
        Icon := TIcon.Create;
        { and assign the icon to it. }
        Icon.Handle := ExtractIcon(hInstance, Buff, x);
        { Add the icon and a dummy string to the combobox }
        Items.AddObject(Format('%d',[x]), Icon);
      end else
        { We're loading on demand, so just add a dummy string }
        Items.AddObject(Format('%d',[x]), NIL);
    end;
    { Reset the index to the first item. }
    ItemIndex := 0;
    { if not loading on demand, restore the cursor }
    if not EnableCaching then
      Screen.Cursor := OldCursor;
  end;
end;

{ Free the icon resources we created. }
procedure TdfsIconComboBox.FreeIcons;
var
  x: integer;
  Icon: TIcon;
begin
  { Loop for every icon }
  for x := 0 to Items.Count-1 do begin
    { Get the icon object }
    Icon := TIcon(Items.Objects[x]);  { Don't use GeTdfsIcon here! }
    { Free it.  If it is NIL, Free ignores it, so it is safe }
    Icon.Free;
    { Zero out the TIcon we just freed }
    Items.Objects[x] := NIL;
  end;
  { Reset the number of Icons to reflect that we have no file. }
  FNumberOfIcons := -1;
end;

{ Disable the control if we don't have a valid filename, and option is enabled }
procedure TdfsIconComboBox.UpdateEnabledState;
begin
  if AutoDisable then
    Enabled := FileExists(FileName)
  else
    Enabled := TRUE;
  { This could be compressed into one statement, but I don't think it }
  { is nearly as readable/understandable this way.  Looks like C.     }
{ Enabled := (AutoDisable and FileExists(FileName)) or (not AutoDisable); }
end;

{ Update the filename of the icon file. }
procedure TdfsIconComboBox.SetFileName(Value: String);
begin
  { If new value is same as old, don't reload icons.  That's silly. }
  if FFileName = Value then exit;
  FFileName := Value;
  { Initialize icon handles from new icon file. }
  LoadIcons;
  { Call user event handler, if one exists }
  if assigned(FOnFileChange) then
    FOnFileChange(Self);
end;

{ Update the AutoDisable property }
procedure TdfsIconComboBox.SetAutoDisable(Value: boolean);
begin
  { If it's the same, we don't need to do anything }
  if Value = FAutoDisable then exit;
  FAutoDisable := Value;
  { Update the enabled state of control based on new AutoDisable setting }
  UpdateEnabledState;
end;

{ Update the EnableCaching property }
procedure TdfsIconComboBox.SetEnableCaching(Value: boolean);
begin
  { If it's the same, we don't need to do anything }
  if Value = FEnableCaching then exit;
  FEnableCaching := Value;
  { If load on demand is not enabled, we need to load all the icons. }
  if not FEnableCaching then
    LoadIcons;
end;

{ Used to extract icons from files and assign them to a TIcon object }
function TdfsIconComboBox.ReadIcon(const Index: integer): TIcon;
var
  Buff: array[0..255] of char;
begin
  { Create the new icon }
  Result := TIcon.Create;
  { Assign it the icon handle }
  Result.Handle := ExtractIcon(hInstance, StrPCopy(Buff, FileName), Index);
end;

{ Returns the icon for a given combobox index }
function TdfsIconComboBox.GeTdfsIcon(Index: integer): TIcon;
begin
  { If load on demand is enabled... }
  if EnableCaching then
    { Has the icon been loaded yet? }
    if Items.Objects[Index] = NIL then
      { No, we must get the icon and add it to Objects }
      Items.Objects[Index] := ReadIcon(Index);
  { Return the requested icon }
  Result := TIcon(Items.Objects[Index]);
end;

{ Return the size of the item we are drawing }
procedure TdfsIconComboBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  { Ask Windows how tall icons are }
  Height := GetSystemMetrics(SM_CYICON);
end;

{ Draw the item requested in the given rectangle.  Because of the parent's default }
{ behavior, we needn't worry about the State.  That's very nice.                   }
procedure TdfsIconComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Icon: TIcon;
begin
  { Use the controls canvas for drawing... }
  with Canvas do begin
    try
      { Fill in the rectangle.  The proper brush has already been set up for us,   }
      { so we needn't use State to set it ourselves.                               }
      FillRect(Rect);
      { Get the icon to be drawn }
      Icon := GeTdfsIcon(Index);
      { If nothing has gone wrong, draw the icon.  Theoretically, it should never  }
      { be NIL, but why take the chance?                                           }
      if Icon <> nil then
        { Using the given rectangle, draw the icon on the control's canvas,        }
        { centering it within the rectangle.                                       }
        with Rect do Draw(Left + (Right - Left - Icon.Width) div 2,
                          Top + (Bottom - Top - Icon.Width) div 2, Icon);
    except
      { If anything went wrong, we fall down to here.  You may want to add some    }
      { sort of user notification.  No clean up is necessary since we did not      }
      { create anything.  We'll just ignore the problem and hope it goes away. :)  }
      {!};
    end;
  end;
end;

function TdfsIconComboBox.GetVersion: string;
begin
  Result := DFS_COMBO_VERSION;
end;

procedure TdfsIconComboBox.SetVersion(const Val: string);
begin
  { empty write method, just needed to get it to show up in Object Inspector }
end;



{ TdfsIconListBox Component }

constructor TdfsIconListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRecreating := FALSE;
  { Set default values }
  FMargin := 5;
  ItemHeight := GetSystemMetrics(SM_CYICON) + FMargin;{ + 6;}
  Style := lbOwnerDrawFixed;
  Font.Name := 'Arial';
  Font.Height := ItemHeight;
  FileName := '';
  FAutoDisable := TRUE;
  FEnableCaching := TRUE;
  FNumberOfIcons := -1;
end;

procedure TdfsIconListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or LBS_MULTICOLUMN;
{  if Orientation = lbVertical then
    Params.Style := Params.Style or LBS_DISABLENOSCROLL or WS_VSCROLL and (not WS_HSCROLL)
  else
    Params.Style := Params.Style or LBS_DISABLENOSCROLL or WS_HSCROLL and (not WS_VSCROLL);}
end;

procedure TdfsIconListBox.CNDeleteItem(var Msg: TWMDeleteItem);
var
  Icon: TIcon;
begin
  if FRecreating then exit;

  { Don't use GeTdfsIcon here! }
  Icon := TIcon(Items.Objects[Msg.DeleteItemStruct^.itemID]);
  { Free it.  If it is NIL, Free ignores it, so it is safe }
  Icon.Free;
  { Zero out the TIcon we just freed }
  Items.Objects[Msg.DeleteItemStruct^.itemID] := NIL;
end;


{ Initialize the icon handles, which are stored in the Objects property }
procedure TdfsIconListBox.LoadIcons;
  function CounTdfsIcons(Inst: THandle; Filename: PChar): integer;
  var
    TmpIcon: HICON;
  begin
    Result := 0;
    TmpIcon := ExtractIcon(Inst, Filename, Result);
    while (TmpIcon <> 0) do begin
      inc(Result);
      DestroyIcon(TmpIcon);
      TmpIcon := ExtractIcon(Inst, Filename, Result);
    end;
  end;
var
  x: integer;
  Icon: TIcon;
  Buff: array[0..255] of char;
  OldCursor: TCursor;
begin
  { Clear any old icon handles }
  FreeIcons;
  { Reset the contents of the listbox }
  Clear;
  { Update the enabled state of the control }
  UpdateEnabledState;
  { If we have a valid file then setup the combobox. }
  if FileExists(FileName) then begin
    { If we are not loading on demand, set the cursor to an hourglass }
    OldCursor := Screen.Cursor;
    if not EnableCaching then
      Screen.Cursor := crHourGlass;
    { Find out how many icons are in the file }
      FNumberOfIcons := ExtractIcon(hInstance, StrPCopy(Buff, FileName),
         {$IFDEF DFS_WIN32} UINT(-1)); {$ELSE} word(-1)); {$ENDIF}
    { Loop for every icon in the file }
    for x := 0 to NumberOfIcons - 1 do begin
      { If we are not loading on demand... }
      if not EnableCaching then begin
        { Create a TIcon object... }
        Icon := TIcon.Create;
        { and assign the icon to it. }
        Icon.Handle := ExtractIcon(hInstance, Buff, x);
        { Add the icon and a dummy string to the combobox }
        Items.AddObject(Format('%d',[x]), Icon);
      end else
        { We're loading on demand, so just add a dummy string }
        Items.AddObject(Format('%d',[x]), NIL);
    end;
    { Reset the index to the first item. }
    ItemIndex := 0;
    { if not loading on demand, restore the cursor }
    if not EnableCaching then
      Screen.Cursor := OldCursor;
  end;
end;

{ Free the icon resources we created. }
procedure TdfsIconListBox.FreeIcons;
var
  x: integer;
  Icon: TIcon;
begin
  { Loop for every icon }
  for x := 0 to Items.Count-1 do begin
    { Get the icon object }
    Icon := TIcon(Items.Objects[x]);  { Don't use GeTdfsIcon here! }
    { Free it.  If it is NIL, Free ignores it, so it is safe }
    Icon.Free;
    { Zero out the TIcon we just freed }
    Items.Objects[x] := NIL;
  end;
  { Reset the number of Icons to reflect that we have no file. }
  FNumberOfIcons := -1;
end;

{ Disable the control if we don't have a valid filename, and option is enabled }
procedure TdfsIconListBox.UpdateEnabledState;
begin
  if AutoDisable then
    Enabled := FileExists(FileName)
  else
    Enabled := TRUE;
end;

(*
{ Reset the size of the listbox to reflect changes in orientation and IconsDisplayed }
procedure TdfsIconListBox.ResetSize;
var
  NewWidth, NewHeight: integer;
  Multiplier: integer;
begin
  NewWidth := FItemWidth * XIcons + 2;
  NewHeight := ItemHeight * YIcons + GetSystemMetrics(SM_CYHSCROLL) + 4;
  SetBounds(Left, Top, NewWidth+3, NewHeight);
  // Stupid scrollbar
  Multiplier := NumberOfIcons div YIcons;
  if NumberOfIcons mod YIcons > 0 then
    inc(Multiplier);
  if NewWidth >= FItemWidth * Multiplier + 2 then
    SetBounds(Left, Top, NewWidth+3, NewHeight - GetSystemMetrics(SM_CYHSCROLL));
  { I've had nothing but trouble with Delphi's Columns property.  I'll just do
    it myself, thank you very much. }
  {  Columns := XIcons;}
  { Delphi 4 (maybe other versions, too) screws up in SetColumnWidth.  Things
    get out of whack as the width grows larger. Fix it up after Columns set. }
  if HandleAllocated then
//    SendMessage(Handle, LB_SETCOLUMNWIDTH, FItemWidth, 0);
    SendMessage(Handle, LB_SETCOLUMNWIDTH, NewWidth div XIcons, 0);

{
  if Width < FItemWidth * XIcons + 2 then
    Height := ItemHeight * YIcons + GetSystemMetrics(SM_CYHSCROLL) + 1
  else
    Height := ItemHeight * YIcons + 3;
  Width := FItemWidth * XIcons + 2;
  Columns := XIcons;
}
*)
(*  if Orientation = lbVertical then begin
    { Set height to hold the desired number of icons }
    Height := ItemHeight * IconsDisplayed + 2;
    { Set width to an icon plus a scrollbar }
    Width := FItemWidth + GetSystemMetrics(SM_CXVSCROLL) + 10;
    { Make sure we don't have any columns. }
    Columns := 0;
  end else begin
    { Set height to an icon plus a scrollbar }
    Height := ItemHeight + GetSystemMetrics(SM_CYHSCROLL) + 1;
    { Set width to hold the desired number of icons }
    Width := FItemWidth * IconsDisplayed + 2;
    { Set number of columns in the listbox to the desired number of icons }
    Columns := IconsDisplayed;
  end;
end;  *)

{ Update the filename of the icon file. }
procedure TdfsIconListBox.SetFileName(Value: String);
begin
  { If new value is same as old, don't reload icons.  That's silly. }
  if FFileName = Value then exit;
  FFileName := Value;
  { Initialize icon handles from new icon file. }
  LoadIcons;
  { Call user event handler, if one exists }
  if assigned(FOnFileChange) then
    FOnFileChange(Self);
end;

{ Update the AutoDisable property }
procedure TdfsIconListBox.SetAutoDisable(Value: boolean);
begin
  { If it's the same, we don't need to do anything }
  if Value = FAutoDisable then exit;
  FAutoDisable := Value;
  { Update the enabled state of control based on new AutoDisable setting }
  UpdateEnabledState;
end;

{ Update the EnableCaching property }
procedure TdfsIconListBox.SetEnableCaching(Value: boolean);
begin
  { If it's the same, we don't need to do anything }
  if Value = FEnableCaching then exit;
  FEnableCaching := Value;
  { If load on demand is not enabled, we need to load all the icons. }
  if not FEnableCaching then
    LoadIcons;
end;

{ Used to extract icons from files and assign them to a TIcon object }
function TdfsIconListBox.ReadIcon(const Index: integer): TIcon;
var
  Buff: array[0..255] of char;
begin
  { Create the new icon }
  Result := TIcon.Create;
  { Assign it the icon handle }
  Result.Handle := ExtractIcon(hInstance, StrPCopy(Buff, FileName), Index);
end;

{ Returns the icon for a given combobox index }
function TdfsIconListBox.GeTdfsIcon(Index: integer): TIcon;
begin
  { If load on demand is enabled... }
  if EnableCaching then
    { Has the icon been loaded yet? }
    if Items.Objects[Index] = NIL then
      { No, we must get the icon and add it to Objects }
      Items.Objects[Index] := ReadIcon(Index);
  { Return the requested icon }
  Result := TIcon(Items.Objects[Index]);
end;


{ Draw the item requested in the given rectangle.  Because of the parent's default }
{ behavior, we needn't worry about the State.  That's very nice.                   }
procedure TdfsIconListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Icon: TIcon;
begin
  { Use the controls canvas for drawing... }
  with Canvas do begin
    try
      { Fill in the rectangle.  The proper brush has already been set up for us,   }
      { so we needn't use State to set it ourselves.                               }
      FillRect(Rect);
      { Get the icon to be drawn }
      Icon := GeTdfsIcon(Index);
      { If nothing has gone wrong, draw the icon.  Theoretically, it should never  }
      { be NIL, but why take the chance?                                           }
      if Icon <> nil then
        { Using the given rectangle, draw the icon on the control's canvas,        }
        { centering it within the rectangle.                                       }
        with Rect do Draw(Left + (Right - Left - Icon.Width) div 2,
                          Top + (Bottom - Top - Icon.Width) div 2, Icon);
    except
      { If anything went wrong, we fall down to here.  You may want to add some    }
      { sort of user notification.  No clean up is necessary since we did not      }
      { create anything.  We'll just ignore the problem and hope it goes away. :)  }
      {!};
    end;
  end;
end;

procedure TdfsIconListBox.SetMargin(const Value: integer);
begin
  if Value <> FMargin then
  begin
    FMargin := Value;
    if HandleAllocated then
      SendMessage(Handle, LB_SETCOLUMNWIDTH, GetSystemMetrics(SM_CXICON) +
         FMargin, 0);
    ItemHeight := GetSystemMetrics(SM_CYICON) + FMargin;

{    Invalidate;}
  end;
end;

function TdfsIconListBox.GetVersion: string;
begin
  Result := DFS_LIST_VERSION;
end;

procedure TdfsIconListBox.SetVersion(const Val: string);
begin
  { empty write method, just needed to get it to show up in Object Inspector }
end;

procedure TdfsIconListBox.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, LB_SETCOLUMNWIDTH, GetSystemMetrics(SM_CXICON) + FMargin,
     0);
end;

{$IFDEF DFS_COMPILER_3_UP}
procedure TdfsIconListBox.CMRecreateWnd(var Message: TMessage);
begin
  FRecreating := TRUE;
  try
    inherited;
  finally
    FRecreating := FALSE;
  end;
end;
{$ENDIF}

end.

