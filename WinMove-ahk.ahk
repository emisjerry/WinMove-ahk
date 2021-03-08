/*
Author: Jerry http://jdev.tw/blog
GitHub: https://github.com/emisjerry/WinMove-ahk

v1.0.0 2021/03/06 The initial sVersion.
v1.0.1 2021/03/08 Add Title to define the second condition to find window.
*/
#SingleInstance, Force
;@Ahk2Exe-SetMainIcon jdev_tw.ico

#Include %A_ScriptDir%\read-ini.ahk
/* read_ini usage:
[Section1]
Key1=Value1

will create dynamic variable Section1Key1, its value is Value1.
*/

sVersion := "v1.0.1"
FileEncoding, UTF-8
_iCurrentLanguage := A_Language
;; testing begin
;_iCurrentLanguage := "english"
;; testing end 

_sCaption := "Ini File Name"
_sPrompt := "Enter your ini file name: "
; 多語系設定
if (_iCurrentLanguage == "0404" || _iCurrentLanguage == "0c04" || _iCurrentLanguage == "1404") {  ; Chinese_Taiwan, Hong Kong, Macau
  _sCaption := "讀取設定 ini 檔案"
  _sPrompt := "請輸入你要使用的 ini 檔名："
}

sIniFilename = %1%
if (sIniFilename == "") {
  inputbox, sIniFilename, %_sCaption% (%sVersion%), %_sPrompt% , , 350, 120, , , , , WinSet1.ini
if ErrorLevel
  ExitApp
}

;; windows position/size setting for 4K Large-size monitor
;;f1::
  ReadIni(sIniFilename)

  _iCount := ProgramsCount
  ;;MsgBox count=%_iCount%
  _iVirtualDesktop2Count := 0
  _aVirtualDesktop2 := []

  Loop, %_iCount% {
    _sProgram := Programs%A_Index%
    _sFind := %_sProgram%Find
    WinGetTitle, _sTitle, %_sFind%
    if (_sTitle == "") {  ; This windows does not open yet.
      execute := %_sProgram%Exec
      if (execute != "") {
        Run, %execute%
        sleep, 1500
        WinGetTitle, _sTitle, %_sFind%
      } else {
        continue
      }
    }
    title := %_sProgram%Title
    if (title != "") { ;; additional condition
      _iPos := InStr(_sTitle, title)
      if (_iPos <= 0) {
        continue
      }
    }
    x := %_sProgram%X
    y := %_sProgram%Y
    w := %_sProgram%Width
    if (w == "0" || w == "-1") {
      w := A_ScreenWidth
    }
    h := %_sProgram%Height
    if (h == "0" || h == "-1") {
      h := A_ScreenHeight
    }
    desktop := %_sProgram%Desktop
    monitor := %_sProgram%Monitor
    ;;MsgBox Before move Program=%_sTitle%, x=%x%, y=%y%, w=%w%, h=%h%, desktop=%desktop%, monitor=%monitor%
    WinMove, %_sTitle%,, %x%, %y%, %w%, %h%
    ;WinGetPos,_iLeft, _iTop, _iWidth, _iHeight, %_sTitle%
    ;MsgBox title=%_sTitle%, Left=%_iLeft%, top=%_iTop%, width=%_iWidth%, height=%_iHeight%

    ; Saving the window's title to be moved to virtual desktop 2
    if (desktop == "2") {
      _iVirtualDesktop2Count++
      _aVirtualDesktop2.Push(_sTitle)
    }
  }  ; loop ini

  ; Moving window to virtual desktop 2
  Loop % _iVirtualDesktop2Count {
    _sTitle := _aVirtualDesktop2[A_Index]
    virtualDesktopMove(_sTitle)
  }
return  ; main

virtualDesktopMove(sTitle) {
  WinSet, ExStyle, ^0x80, %sTitle%
  Send {LWin down}{Ctrl down}{Right}{Ctrl up}{LWin up}
  sleep, 50
  WinSet, ExStyle, ^0x80, %sTitle%
  ;;WinActivate, %sTitle%
}


