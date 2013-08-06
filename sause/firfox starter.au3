#cs ----------------------------------------------------------------------------
written in autoit V3
requires truecrypt to be installed
truecrypt arguments must be in the correct order. see link for details:
http://www.truecrypt.org/docs/command-line-usage

you must make a truecrypt volume and put your firefox profile in it. profile is located at: %appdata%\Mozilla\Firefox\Profiles
you also have to change the profiles.ini at:%appdata%\Mozilla\Firefox\profiles.ini with the following data:

IsRelative=0
Path=X:\profiles\7a9fvn23e.default (here you would put the path to your profile in the new truecrypt volume)

#ce ----------------------------------------------------------------------------
TraySetState(2)
$count = 4
$volume_location = "C:\new.tc" ;truecrypt volume with firefox profile in it
$drive_letter = 'X'
While 1
   $pass = InputBox ("Enter password", "Please enter your password to unlock firefox","","!", 150, 150)
   if @error = 1 Then
      Exit
   EndIf
   ShellExecuteWait('C:\Program Files\TrueCrypt\truecrypt.exe', '/lx /p ' & $pass & ' /q /s /v C:\new.tc')
   if DriveStatus($drive_letter & ":\") == "READY" Then ;if you want the volume to mou
      Runwait("C:\Program Files (x86)\Mozilla Firefox\firefox.exe")
      ShellExecuteWait('"C:\Program Files\TrueCrypt\truecrypt.exe"', '/dx /q /s /w')
      Exit
   Else
      MsgBox (1, "Wrong password", "You have " & $count & " more attempts until the system is locked down")
      $count = $count - 1
   EndIf
   if $count == 0 Then
          ;shuts down the system if the password try count goes past 3
      shutdown(0)
      Exit
   EndIf
WEnd