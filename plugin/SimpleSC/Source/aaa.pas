{
License Agreement

This content is subject to the Mozilla Public License Version 1.1 (the "License");
You may not use this plugin except in compliance with the License. You may 
obtain a copy of the License at http://www.mozilla.org/MPL. 

Alternatively, you may redistribute this library, use and/or modify it 
under the terms of the GNU Lesser General Public License as published 
by the Free Software Foundation; either version 2.1 of the License, 
or (at your option) any later version. You may obtain a copy 
of the LGPL at www.gnu.org/copyleft. 

Software distributed under the License is distributed on an "AS IS" basis, 
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License 
for the specific language governing rights and limitations under the License. 

The original code is LSASecurityControl.pas, released April 16, 2007. 

The initial developer of the original code is Rainer Budde (http://www.speed-soft.de).

SimpleSC - NSIS Service Control Plugin is written, published and maintaned by
Rainer Budde (rainer@speed-soft.de).
}
unit aaa;

interface

uses
  Windows, SysUtils,
  jwawinsvc; { needed for GetLastError ? }

  function GrantPrivilege(AccountName: String; PrivilegeName: String): Integer;
  function RemovePrivilege(AccountName: String; PrivilegeName: String): Integer;
  function EnablePrivilege(PrivilegeName: String): Integer;
  function DisablePrivilege(PrivilegeName: String): Integer;

implementation

type
  LSA_HANDLE = Pointer;
  TLSAHandle = LSA_HANDLE;

  LSA_UNICODE_STRING = record
    Length: Word;
    MaximumLength: Word;
    Buffer: PWideChar;
  end;
  TLSAUnicodeString = LSA_UNICODE_STRING;
  PLSAUnicodeString = ^TLSAUnicodeString;

  LSA_OBJECT_ATTRIBUTES = record
    Length: ULONG;
    RootDirectory: THandle;
    ObjectName: PLSAUnicodeString;
    Attributes: ULONG;
    SecurityDescriptor: Pointer;
    SecurityQualityOfService: Pointer; 
  end;
  TLsaObjectAttributes = LSA_OBJECT_ATTRIBUTES;
  PLsaObjectAttributes = ^TLsaObjectAttributes;


function Test(): Integer;
begin
	Result := 0;
	Result := GetLastError;
end;



function GrantPrivilege(AccountName: String; PrivilegeName: String): Integer;
begin
end;
function RemovePrivilege(AccountName: String; PrivilegeName: String): Integer;
begin
end;
function EnablePrivilege(PrivilegeName: String): Integer;
begin
end;
function DisablePrivilege(PrivilegeName: String): Integer;
begin
end;

function GetAccountSid(const AccountName: String; var Sid: PSID): Integer;
var
  DomainSize: LongWord;
  SidSize: LongWord;
  Domain: String;
  Use: SID_NAME_USE;
begin
  Result := 0;

  SidSize := 0;
  DomainSize := 0;

  if not LookupAccountName(nil, PChar(AccountName), nil, SidSize, nil, DomainSize, Use) and (GetLastError = ERROR_INSUFFICIENT_BUFFER) then
  begin
    SetLength(Domain, DomainSize);
    Sid := AllocMem(SidSize);

    if not LookupAccountName(nil, PChar(AccountName), Sid, SidSize, PChar(Domain), DomainSize, Use) then
    begin
      Result := GetLastError;
      FreeMem(Sid);
      Sid := nil;
    end;
  end
  else
    Result := GetLastError;
end;

end.
