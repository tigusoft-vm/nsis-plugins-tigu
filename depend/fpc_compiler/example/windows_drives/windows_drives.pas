program listdevices;
 
{$ifdef fpc}{$mode delphi}{$endif}
{$apptype console}
 
uses
  Windows;
 
var
  Drive: Char;
  DriveLetter: string;
  OldMode: Word; 
begin
  WriteLn('The following drives were found in this computer:');
  WriteLn('');
 
  // Empty Floppy or Zip drives can generate a Windows error.
  // We disable system errors during the listing.
  // Note that another way to skip these errors would be to use DEVICE_IO_CONTROL.
  OldMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try 
 
    // Search all drive letters
    for Drive := 'A' to 'Z' do
    begin
      DriveLetter := Drive + ':\';
 
      case GetDriveType(PChar(DriveLetter)) of
       DRIVE_REMOVABLE: WriteLn(DriveLetter + ' Floppy Drive');
       DRIVE_FIXED:     WriteLn(DriveLetter + ' Fixed Drive');
       DRIVE_REMOTE:    WriteLn(DriveLetter + ' Network Drive');
       DRIVE_CDROM:     WriteLn(DriveLetter + ' CD-ROM Drive');
       DRIVE_RAMDISK:   WriteLn(DriveLetter + ' RAM Disk');
      end;
    end;
 
  finally
    // Restores previous Windows error mode.
    SetErrorMode(OldMode); 
  end;
 
  // Also add a stop to see the result under Windows
  WriteLn('');
  WriteLn('Please press <ENTER> to exit the program.');
  ReadLn(DriveLetter);
end.
