;WOW Installer Script MiniDice WOW Addon Package v1.0.0
;script by 의문
;last fix 2013.09.17

!define PRODUCT_NAME "MiniDice WOW Addon Package"
!define PRODUCT_VERSION "Build v1.0.0"
!define PRODUCT_PUBLISHER "의문"
!define PRODUCT_DIR_REGKEY "Software\MiniDiceWOWUI"
!define PRODUCT_DIR_ROOT_REGKEY "HKLM"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\MiniDiceWOWUI"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"



; MUI 1.67 compatible ------------------------------
!include "MUI.nsh"
!include "WordFunc.nsh"
!insertmacro StrFilter
!include "FileFunc.nsh"
  ;!insertmacro Locate
  ;!insertmacro un.Locate
!insertmacro DirState
!insertmacro un.DirState

; MUI Settings ------------------------------ ------------------------------

!include "x64.nsh"




#!define MUI_ABORTWARNING
!define MUI_ICON "unknown.ico"
!define MUI_UNICON "unknown.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "wow_welcome.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP_NOSTRETCH


; 페이지 삽입 ------------------------------
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "License.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
#!define MUI_FINISHPAGE_NOAUTOCLOSE ;인스톨후 마지막페이지로 바로 넘어감

;  finish 페이지
!define MUI_FINISHPAGE_RUN "$INSTDIR\Launcher.exe"
!define MUI_FINISHPAGE_RUN_TEXT "월드오브워크래프트 실행하기"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES
; Language files
;!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Korean"



; Reserve Files ------------------------------

  ;These files should be inserted before other files in the data block
  ;Keep these lines before any File command
  ;Only for solid compression (by default, solid compression is enabled for BZIP2 and LZMA)

; MUI end ------------------------------ ------------------------------


Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
BrandingText /TRIMRIGHT "${PRODUCT_NAME}"
OutFile "MiniDiceWOWUI.exe"

;InstallDirRegKey HKLM "SOFTWARE\Blizzard Entertainment\World of Warcraft" "InstallPath"
InstallDirRegKey HKLM "SOFTWARE\Wow5432Node\Microsoft\Windows\Currentversion\Unistall\월드 오브 워크래프트" "InstallLocation"

InstallDir $INSTDIR
ShowInstDetails show
ShowUnInstDetails show



; 인스톨 함수 ------------------------------



Function .onInit
  
     ;인스톨러 첫화면입니다.
	InitPluginsDir
	File /oname=$PLUGINSDIR\splash.bmp "setup_start.bmp" ;보여줄 그림
	advsplash::show 300 1800 2400 0xDE3E48 $PLUGINSDIR\splash ;시간조절을 해주세요. 300 1800 2400
	Pop $0


FunctionEnd


;선택적설치-----------------------------------------

!ifndef NOINSTTYPES ; only if not defined
  InstType "기본 설치" ;1번입니다.
  InstType "전체 설치" ;2번입니다.
  InstType "최소 설치" ;3번입니다.
!endif

ShowInstDetails show ;인스톨과정을 보여줍니다.
ShowUnInstDetails show ;언인스톨과정을 보여줍니다.
;기존의 모음집과 조금 차별화된 구성으로 만들어줍니다. 다만 조금 헷갈릴수가 있으니 잘 이해하고 사용하시길 바랍니다.
; 아래 섹션을 구성할때 이렇게 넣어줍니다.
; SectionIn 1 2 ;1번은 기본, 2번은 전체설치입니다. 필수애드온의 경우 이런식이겠죠.
; SectionIn 1 <- 기본설치를 할때만 선택이 되어있습니다. 
; SectionIn 2 <- 전체설치를 선택했을때 체크되어있습니다.선택설치를 하면 선택이 해제되죠.




; 섹션 ------------------------------
Section "!기본 애드온" Basic_SEC
SectionIn 1 2 3 ;
  SectionIn RO
  SetOutPath "$INSTDIR"
  SetOverwrite on
  CreateDirectory "$SMPROGRAMS\MiniDiceWOWUI"

; 백업할 파일 있는지 검사
  StrCpy $R1 0
  ${DirState} "$INSTDIR\Interface" $R1
	StrCmp $R1 1 backup
  ${DirState} "$INSTDIR\WTF" $R1
	StrCmp $R1 1 backup



; 백업
  backup:
  RMDir /r "$INSTDIR\Old"
  CreateDirectory "$INSTDIR\Old"

  Rename "$INSTDIR\Interface" "$INSTDIR\Old\Interface"
  Rename "$INSTDIR\WTF" "$INSTDIR\Old\WTF"




;  nextC:
; 파일 복사
  File /a /r "d:\Wow_UI\wowui\"

SectionEnd




;★★★----------------------------------------------------------------------------
;Installer Sections - 화면구성 애드온
SectionGroup /e "폰트" _base2



 Section "폰트" Font
 SectionIn 1 2 ;
  SetOutPath "$INSTDIR"
  File /a /r "d:\Wow_UI\font\fonts"
 SectionEnd 

SectionGroupEnd ; 



;★★★----------------------------------------------------------------------------
;Installer Sections - 
SectionGroup /e "업적" achieve

 Section "Overachiever" Overachiever
 SectionIn 1 2 ;
  SetOutPath "$INSTDIR\Interface"
  File /a /r "d:\Wow_UI\wowui2\Overachiever\AddOns"
 SectionEnd 

 Section "_NPCScan" _NPCScan
 SectionIn 1 2;
  SetOutPath "$INSTDIR\Interface"
  File /a /r "d:\Wow_UI\wowui2\_NPCScan\AddOns"
 SectionEnd 


 Section "Tabard Addict" TabardAddict
 SectionIn 1 2;
  SetOutPath "$INSTDIR\Interface"
  File /a /r "d:\Wow_UI\wowui2\TabardAddict\AddOns"
 SectionEnd 


 Section "RaidAchievementFilter" RaidAchievementFilter
 SectionIn 1 2;
  SetOutPath "$INSTDIR\Interface"
  File /a /r "d:\Wow_UI\wowui2\RaidAchievementFilter\AddOns"
 SectionEnd 

 
SectionGroupEnd ; 

SectionGroup /e "레이드" raid

 Section "VuhDo 공격대프레임" VuhDo
 SectionIn 1 2 ;
  SetOutPath "$INSTDIR\Interface"
  File /a /r "d:\Wow_UI\wowui2\VuhDo\AddOns"
 SectionEnd 

 Section "DBM 레이드경보기" DBM
 SectionIn 1 2;
  SetOutPath "$INSTDIR\Interface"
  File /a /r "d:\Wow_UI\wowui2\DBM\AddOns"
 SectionEnd 
 
SectionGroupEnd ; 

SectionGroup /e "기타" etc

 Section "StatusBars2" StatusBars2
 SectionIn 1 2 ;
  SetOutPath "$INSTDIR\Interface"
  File /a /r "d:\Wow_UI\wowui2\StatusBars2\AddOns"
 SectionEnd 

 Section "Marking Bar" MarkingBar
 SectionIn 1 2;
  SetOutPath "$INSTDIR\Interface"
  File /a /r "d:\Wow_UI\wowui2\MarkingBar\AddOns"
 SectionEnd 


 Section "BlueItemInfo" BlueItemInfo
 SectionIn 1 2;
  SetOutPath "$INSTDIR\Interface"
  File /a /r "d:\Wow_UI\wowui2\BlueItemInfo\AddOns"
 SectionEnd 
 
 
SectionGroupEnd ; 




; 섹션에 대한 설명 ------------------------------
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${Basic_SEC} "기본 애드온."




!insertmacro MUI_DESCRIPTION_TEXT ${_base2} "기본에드온"
  !insertmacro MUI_DESCRIPTION_TEXT ${Font} "font"

!insertmacro MUI_DESCRIPTION_TEXT ${achieve} "업적"
  !insertmacro MUI_DESCRIPTION_TEXT ${Overachiever} "Overachiever"
  !insertmacro MUI_DESCRIPTION_TEXT ${_NPCScan} "_NPCScan"
  !insertmacro MUI_DESCRIPTION_TEXT ${TabardAddict} "Tabard Addict" 
  !insertmacro MUI_DESCRIPTION_TEXT ${RaidAchievementFilter} "RaidAchievementFilter"

!insertmacro MUI_DESCRIPTION_TEXT ${raid} "레이드"
  !insertmacro MUI_DESCRIPTION_TEXT ${VuhDo} "VuhDo 공격대프레임"
  !insertmacro MUI_DESCRIPTION_TEXT ${DBM} "DBM"   
  
  
!insertmacro MUI_DESCRIPTION_TEXT ${etc} "기타"
  !insertmacro MUI_DESCRIPTION_TEXT ${StatusBars2} "StatusBars2"
  !insertmacro MUI_DESCRIPTION_TEXT ${MarkingBar} "Marking Bar" 
  !insertmacro MUI_DESCRIPTION_TEXT ${BlueItemInfo} "블루아이템"
  
!insertmacro MUI_FUNCTION_DESCRIPTION_END


















; 추가 섹션 ------------------------------
Section -AdditionalIcons
  CreateShortCut "$SMPROGRAMS\타락천사UI\타락천사UI제거.lnk" "$INSTDIR\DarkAngelUI_uninst.exe"
  CreateShortCut "$DESKTOP\타락천사UI제거.lnk" "$INSTDIR\DarkAngelUI_uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\DarkAngelUI_uninst.exe"
  WriteRegStr ${PRODUCT_DIR_ROOT_REGKEY} "${PRODUCT_DIR_REGKEY}" "Install_Dir" "$INSTDIR"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\DarkAngelUI_uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\DarkAngelUI_uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
	WriteRegDWORD ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "NoModify" 1
	WriteRegDWORD ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "NoRepair" 1
SectionEnd



; 언인스톨 섹션 ------------------------------
Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "$(^Name)을(를) 제거하시겠습니까?" IDYES +2
  Abort
  ${un.DirState} "$INSTDIR\Old" $R4
	StrCmp $R4 1 ynoldback
  StrCpy $R4 0
  Goto end

  ynoldback:
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON1 "UI를 원래 설정으로 돌리시겠습니까?$\n(PC방을위한 배려!)" IDYES +2
  StrCpy $R4 0

  end:
  Push $R4
FunctionEnd


Section Uninstall
; 파일 삭제
  RMDir /r "$INSTDIR\Interface"
  RMDir /r "$INSTDIR\WTF"
  RMDir /r "$INSTDIR\Data\Fonts"



	StrCmp $R4 1 0 nextU

; 원래 설정으로
  Rename "$INSTDIR\Old\Interface" "$INSTDIR\Interface"
  Rename "$INSTDIR\Old\WTF" "$INSTDIR\WTF"
;  Rename "$INSTDIR\Old\Data\Fonts" "$INSTDIR\Data\Fonts"


  RMDir /r "$INSTDIR\Old"

  nextU:
; 바로가기, 레지스트리 삭제
  Delete "$DESKTOP\타락천사UI제거.lnk"
  RMDir /r "$SMPROGRAMS\타락천사UI"

  Delete "$INSTDIR\DarkAngelUI_uninst.exe"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey ${PRODUCT_DIR_ROOT_REGKEY} "${PRODUCT_DIR_REGKEY}"

  SetAutoClose true
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name)는(은) 완전히 제거되었습니다."
FunctionEnd


