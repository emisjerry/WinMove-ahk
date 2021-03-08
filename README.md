# WinMove-ahk
Reading an ini file, moves required applications to specified position and resize it.

## Installation
Download the release zip file to any folder. Or clone its Git repository.

## Execution

```
WinMove-ahk.exe WinSet1.ini
```

You can create many ini files to adjust in different virtual desktops or monitors.

## Sample ini file
```ini
; Using WindowSpy.ahk to get the required ahk_exe
; Programs entry is ahk_exe.
; ini entry is Case-senstive.
[Programs]
1=EmEditor
2=Explorer
3=MSWord
Count=3

[EmEditor]
Find=ahk_exe ee256.exe
X=100
Y=200
Width=1500
Height=600
Monitor=1
Desktop=1

; Windows Explorer
[Explorer]
Find=ahk_class CabinetWClass
X=500
Y=200
Width=800
Height=500
Monitor=1
Desktop=2

[MSWord]
Find=ahk_exe WINWORD.EXE
; if the specified app cannot be found, using Exec to execute it.
Exec=C:\Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE
X=0
Y=0
; width=0, height=0 means maximize
Width=0
Height=0
Monitor=1
Desktop=1
```

## Entries in a section

Entry keys have the following settings:

Key | Description | Sample value
--- | --- | ---
Find | How to find the application, using ahk_class or ahk_exe | ahk_class CabinetWClass or ahk_exe Explorer.EXE
Title | The second condition to match the application | c:\project\SpecialOne
X | Left position | 200
Y | Top position | 150
Width | Width | 1920
Height | Height | 1000
Monitor | Display on which monitor | 1
Desktop | Display on which desktop | 1
  
