FF_Launcher
prompts user for a password to open a firefox with a specified profile. stores specified profile in a truecrypt volume which it mounts and unmounts on program launch and when firefox closes. good for use on a shared computer when passwords and usernames are saved. 



settings you need to change:
if your install directories are not default for firefox or truecrypt you must change them in the source and re-compile
you must make a truecrypt volume and put your firefox profile in it. 
profile is located at: %appdata%\Mozilla\Firefox\Profiles
you also have to change the profiles.ini at:%appdata%\Mozilla\Firefox\profiles.ini with the following data:

IsRelative=0
Path=X:\profiles\7a9fvn23e.default (here you would put the path to your profile in the new truecrypt volume)

the program passes the password you enter directly to truecrypt. it also uses the /w arguement when dismounting. 


always check the notes in the source for up-to-date info