#cs ----------------------------------------------------------------------------
written in autoit V3
requires truecrypt to be installed
truecrypt arguments must be in the correct order. see link for details:
http://www.truecrypt.org/docs/command-line-usage

IF YOU CHANCGE THINGS BE MINDFULL OF THE QUOTES YOU'RE CHANGING. autoit getts pissy when you mix single and double quotes. 

NOT ON PASSWORD: for some reason truecrypt CLI doesnt approve of passwords with spaces. i think i will have to eliminate the AutoIt
password box all together and just let the truecrypt PW box run. 

you must make a truecrypt volume and put your firefox profile in it. profile is located at: %appdata%\Mozilla\Firefox\Profiles
you also have to change the profiles.ini at:%appdata%\Mozilla\Firefox\profiles.ini with the following data:

IsRelative=0
Path=X:\profiles\7a9fvn23e.default (here you would put the path to your profile in the new truecrypt volume)
"C:\Program Files\TrueCrypt\TrueCrypt.exe" /lx /p i have a launcher /q /s /v C:\volume\fflaunch.tc
"C:\Program Files\TrueCrypt\truecrypt.exe" /dx /q /s /w
#ce ----------------------------------------------------------------------------
TraySetState(2)
$count = 4
$volume_location = 'C:\volume\fflaunch.tc' ;truecrypt volume with firefox profile in it
$drive_letter = 'X' ;specify the drive letter
$profile_loc = '-profile ' & $drive_letter & '":\prntdrv\Data\profile"';if you have multiple profiles you can select to run yours and bypass the profile manager by setting the directory of it here. if not than leave it blank
While 1
   $pass = InputBox ("Enter password", "Please enter your password to unlock firefox","","*", 150, 150)
   ;msgbox(1, "", "-"&$pass&"-")
   if @error = 1 Then
	  ;make log file here
      Exit
   EndIf
   ShellExecuteWait('"C:\Program Files\TrueCrypt\TrueCrypt.exe"', '/lx /p ' & $pass & ' /q /s /v ' & $volume_location)
   if DriveStatus($drive_letter & ":\") == "READY" Then 
      ShellExecuteWait("C:\Program Files (x86)\Mozilla Firefox\firefox.exe", $profile_loc)
      ShellExecuteWait('"C:\Program Files\TrueCrypt\truecrypt.exe"', '/dx /q /s /w')
      Exit
   Else
	  $count = $count - 1
      MsgBox (16, "Wrong password", "You have " & $count & " more attempts until the account is logged off. This is brians firefox profile with his saved passwords. Please do not open unless you are him. ")
   EndIf

   if $count == 0 Then
          ;shuts down the system if the password try count goes past 3
      shutdown(0)
      Exit
   EndIf
WEnd