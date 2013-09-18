;WOW Installer Script MiniDice WOW Addon Package v1.0.0
;script by �ǹ�
;last fix 2013.09.17

!define PRODUCT_NAME "MiniDice WOW Addon Package"
!define PRODUCT_VERSION "Build v1.0.0"
!define PRODUCT_PUBLISHER "�ǹ�"
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


; ������ ���� ------------------------------
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "License.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
#!define MUI_FINISHPAGE_NOAUTOCLOSE ;�ν����� �������������� �ٷ� �Ѿ

;  finish ������
!define MUI_FINISHPAGE_RUN "$INSTDIR\Launcher.exe"
!define MUI_FINISHPAGE_RUN_TEXT "��������ũ����Ʈ �����ϱ�"
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
InstallDirRegKey HKLM "SOFTWARE\Wow5432Node\Microsoft\Windows\Currentversion\Unistall\���� ���� ��ũ����Ʈ" "InstallLocation"

InstallDir $INSTDIR
ShowInstDetails show
ShowUnInstDetails show



; �ν��� �Լ� ------------------------------



Function .onInit
  
     ;�ν��緯 ùȭ���Դϴ�.
	InitPluginsDir
	File /oname=$PLUGINSDIR\splash.bmp "setup_start.bmp" ;������ �׸�
	advsplash::show 300 1800 2400 0xDE3E48 $PLUGINSDIR\splash ;�ð������� ���ּ���. 300 1800 2400
	Pop $0


FunctionEnd


;��������ġ-----------------------------------------

!ifndef NOINSTTYPES ; only if not defined
  InstType "�⺻ ��ġ" ;1���Դϴ�.
  InstType "��ü ��ġ" ;2���Դϴ�.
  InstType "�ּ� ��ġ" ;3���Դϴ�.
!endif

ShowInstDetails show ;�ν�������� �����ݴϴ�.
ShowUnInstDetails show ;���ν�������� �����ݴϴ�.
;������ �������� ���� ����ȭ�� �������� ������ݴϴ�. �ٸ� ���� �򰥸����� ������ �� �����ϰ� ����Ͻñ� �ٶ��ϴ�.
; �Ʒ� ������ �����Ҷ� �̷��� �־��ݴϴ�.
; SectionIn 1 2 ;1���� �⺻, 2���� ��ü��ġ�Դϴ�. �ʼ��ֵ���� ��� �̷����̰���.
; SectionIn 1 <- �⺻��ġ�� �Ҷ��� ������ �Ǿ��ֽ��ϴ�. 
; SectionIn 2 <- ��ü��ġ�� ���������� üũ�Ǿ��ֽ��ϴ�.���ü�ġ�� �ϸ� ������ ��������.




; ���� ------------------------------
Section "!�⺻ �ֵ��" Basic_SEC
SectionIn 1 2 3 ;
  SectionIn RO
  SetOutPath "$INSTDIR"
  SetOverwrite on
  CreateDirectory "$SMPROGRAMS\MiniDiceWOWUI"

; ����� ���� �ִ��� �˻�
  StrCpy $R1 0
  ${DirState} "$INSTDIR\Interface" $R1
	StrCmp $R1 1 backup
  ${DirState} "$INSTDIR\WTF" $R1
	StrCmp $R1 1 backup



; ���
  backup:
  RMDir /r "$INSTDIR\Old"
  CreateDirectory "$INSTDIR\Old"

  Rename "$INSTDIR\Interface" "$INSTDIR\Old\Interface"
  Rename "$INSTDIR\WTF" "$INSTDIR\Old\WTF"




;  nextC:
; ���� ����
  File /a /r "d:\Wow_UI\wowui\"

SectionEnd




;�ڡڡ�----------------------------------------------------------------------------
;Installer Sections - ȭ�鱸�� �ֵ��
SectionGroup /e "��Ʈ" _base2



 Section "��Ʈ" Font
 SectionIn 1 2 ;
  SetOutPath "$INSTDIR"
  File /a /r "d:\Wow_UI\font\fonts"
 SectionEnd 

SectionGroupEnd ; 



;�ڡڡ�----------------------------------------------------------------------------
;Installer Sections - 
SectionGroup /e "����" achieve

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

SectionGroup /e "���̵�" raid

 Section "VuhDo ���ݴ�������" VuhDo
 SectionIn 1 2 ;
  SetOutPath "$INSTDIR\Interface"
  File /a /r "d:\Wow_UI\wowui2\VuhDo\AddOns"
 SectionEnd 

 Section "DBM ���̵�溸��" DBM
 SectionIn 1 2;
  SetOutPath "$INSTDIR\Interface"
  File /a /r "d:\Wow_UI\wowui2\DBM\AddOns"
 SectionEnd 
 
SectionGroupEnd ; 

SectionGroup /e "��Ÿ" etc

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




; ���ǿ� ���� ���� ------------------------------
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${Basic_SEC} "�⺻ �ֵ��."




!insertmacro MUI_DESCRIPTION_TEXT ${_base2} "�⺻�����"
  !insertmacro MUI_DESCRIPTION_TEXT ${Font} "font"

!insertmacro MUI_DESCRIPTION_TEXT ${achieve} "����"
  !insertmacro MUI_DESCRIPTION_TEXT ${Overachiever} "Overachiever"
  !insertmacro MUI_DESCRIPTION_TEXT ${_NPCScan} "_NPCScan"
  !insertmacro MUI_DESCRIPTION_TEXT ${TabardAddict} "Tabard Addict" 
  !insertmacro MUI_DESCRIPTION_TEXT ${RaidAchievementFilter} "RaidAchievementFilter"

!insertmacro MUI_DESCRIPTION_TEXT ${raid} "���̵�"
  !insertmacro MUI_DESCRIPTION_TEXT ${VuhDo} "VuhDo ���ݴ�������"
  !insertmacro MUI_DESCRIPTION_TEXT ${DBM} "DBM"   
  
  
!insertmacro MUI_DESCRIPTION_TEXT ${etc} "��Ÿ"
  !insertmacro MUI_DESCRIPTION_TEXT ${StatusBars2} "StatusBars2"
  !insertmacro MUI_DESCRIPTION_TEXT ${MarkingBar} "Marking Bar" 
  !insertmacro MUI_DESCRIPTION_TEXT ${BlueItemInfo} "��������"
  
!insertmacro MUI_FUNCTION_DESCRIPTION_END


















; �߰� ���� ------------------------------
Section -AdditionalIcons
  CreateShortCut "$SMPROGRAMS\Ÿ��õ��UI\Ÿ��õ��UI����.lnk" "$INSTDIR\DarkAngelUI_uninst.exe"
  CreateShortCut "$DESKTOP\Ÿ��õ��UI����.lnk" "$INSTDIR\DarkAngelUI_uninst.exe"
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



; ���ν��� ���� ------------------------------
Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "$(^Name)��(��) �����Ͻðڽ��ϱ�?" IDYES +2
  Abort
  ${un.DirState} "$INSTDIR\Old" $R4
	StrCmp $R4 1 ynoldback
  StrCpy $R4 0
  Goto end

  ynoldback:
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON1 "UI�� ���� �������� �����ðڽ��ϱ�?$\n(PC�������� ���!)" IDYES +2
  StrCpy $R4 0

  end:
  Push $R4
FunctionEnd


Section Uninstall
; ���� ����
  RMDir /r "$INSTDIR\Interface"
  RMDir /r "$INSTDIR\WTF"
  RMDir /r "$INSTDIR\Data\Fonts"



	StrCmp $R4 1 0 nextU

; ���� ��������
  Rename "$INSTDIR\Old\Interface" "$INSTDIR\Interface"
  Rename "$INSTDIR\Old\WTF" "$INSTDIR\WTF"
;  Rename "$INSTDIR\Old\Data\Fonts" "$INSTDIR\Data\Fonts"


  RMDir /r "$INSTDIR\Old"

  nextU:
; �ٷΰ���, ������Ʈ�� ����
  Delete "$DESKTOP\Ÿ��õ��UI����.lnk"
  RMDir /r "$SMPROGRAMS\Ÿ��õ��UI"

  Delete "$INSTDIR\DarkAngelUI_uninst.exe"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey ${PRODUCT_DIR_ROOT_REGKEY} "${PRODUCT_DIR_REGKEY}"

  SetAutoClose true
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name)��(��) ������ ���ŵǾ����ϴ�."
FunctionEnd


