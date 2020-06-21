#NoEnv
#SingleInstance Force
;____________________________________________________________
;____________________________________________________________
;//////////////[variables]///////////////
SetWorkingDir %A_ScriptDir%
NykyinenVersio = 0.8
Sovelluskansio = AutoStartupAhk
TiedostoLatausLinkki = 
;____________________________________________________________
;____________________________________________________________
;//////////////[Gui]///////////////
start:
Menu Tray, Icon, shell32.dll, 321
Gui -MaximizeBox
Gui Add, Tab3, x0 y0 w666 h400, Startup|Asetukset
;____________________________________________________________
;____________________________________________________________
;//////////////[Gui startup check]///////////////
IfExist, %A_AppData%\%Sovelluskansio%\AutoStart\AutoStart.ini
{
    IniRead, T_valintaStartup, %A_AppData%\%Sovelluskansio%\AutoStart\AutoStart.ini,Settings,Startup
    if(T_valintaStartup == 1)
    {
        goto StartupLoop
    }
    else if(T_valintaStartup == 2)
    {
        goto StartupLoop1
    }
    else
    {
        goto StartupLoop2
    }
}
TName_List =
Loop, %A_AppData%\%Sovelluskansio%\Startup\*, 1, 0
{
	TName_List = %TName_List%%A_LoopFileName%|
}
;____________________________________________________________
;____________________________________________________________
;//////////////[Check for updates]///////////////
/*
checkForupdates:
IfExist, %A_AppData%\%Sovelluskansio%\Settings\Settings.ini
{
    IniRead, t_checkup, %A_AppData%\%Sovelluskansio%\Settings\Settings.ini, Settings, Updates
    if(t_checkup == 1)
    {
        MsgBox, tarkistetaan päivityksiä
        ; Example: Download text to a variable:
        whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        whr.Open("GET", "https://raw.githubusercontent.com/veskeli/AutoStartupAhk/master/Version.txt", False)
        whr.Send()
        ; Using 'true' above and the call below allows the script to remain responsive.
        whr.WaitForResponse()
        version := whr.ResponseText
        ;vertaa versioita
        if(version != "")
        {
            if(version != NykyinenVersio)
            {
                MsgBox, 1,Päivitys,uusi versio on %version% vanha on %NykyinenVersio%. Haluatko ladata uuden päivityksen,15
                IfMsgBox, Cancel
                {
                    ;temp stuff
                }
                else
                {

                }
            }
        }
    }
}
*/
;____________________________________________________________
;____________________________________________________________
;//////////////[Startup]///////////////
Gui Tab, 1
Gui Font, s13
Gui Add, GroupBox, x8 y30 w644 h309, Alotus sovellukset:
Gui Font
Gui Add, GroupBox, x8 y331 w644 h55
Gui Font, s15
Gui Add, Button, x194 y344 w256 h33 gLisääUusiAloitusSovellus, Lisää uusi aloitus sovellus
Gui Font
Gui Add, DropDownList, x24 y59 w618 vdorplist grefresh, %TName_List%
Gui Font, s13
Gui Add, CheckBox, x16 y210 w272 h26 vkäynnistä gKäynnistäJärjestelmäToggle, Käynnistä Järjestelmänvalvojana
Gui Font
Gui Font, s13
Gui Add, Button, x24 y101 w150 h30 gValitseTiedosto, Vaihda Tiedosto
Gui Font
Gui Add, Text, x8 y89 w644 h2 0x10
Gui Font, s13
Gui Add, GroupBox, x8 y185 w315 h154, Käynnistys asetukset
Gui Font
Gui Add, Edit, x24 y162 w210 h21 vnimi
Gui Font, s13
Gui Add, Text, x24 y135 w139 h23 +0x200, Sovelluksen nimi:
Gui Font
Gui Font, s13
Gui Add, Button, x240 y160 w80 h25 gTallennaSovelluksenNimi, Tallenna
Gui Font
Gui Font, s13
Gui Add, CheckBox, x16 y240 w271 h43 vkysy gKysyKäyttäjältäToggle, Kysy käyttäjältä Järjestelmänvalvojan salasanaa
Gui Font
Gui Font, s13
Gui Add, Text, x16 y288 w168 h43, Sovelluksen aloittamisen viive:(ms)
Gui Font
Gui Add, Edit, x192 y309 w120 h21 vviive
Gui Font, s13
Gui Add, CheckBox, x336 y303 w264 h24 vkäynnistys gKäynnistäSovellusToggle, Käynnistä Sovellus aloituksessa
Gui Font
Gui Font, s11
Gui Add, CheckBox, x456 y344 w182 h35 vAlkuSovellus gMakeStartupFile, Sovellusten käynnistäminen
Gui Font
Gui Add, Text, x176 y120 w466 h23 +0x200 vsovellus, 
Gui Font
Gui Font, s13
Gui Add, Text, x176 y96 w137 h23 +0x200, Tiedoston sijainti:
Gui Font
Gui Add, Button, x564 y93 w80 h23 gpoistasovellus, Poista sovellus
Gui Tab, 2
IfExist, %A_Startup%\Startup.ahk
{
    GuiControl,, AlkuSovellus, 1
}
;____________________________________________________________
;____________________________________________________________
;//////////////[Asetukset]///////////////
Gui Add, GroupBox, x318 y24 w339 h141, Järjestelmänvalvojan tiedot (Salasana ei turvattu)
Gui Font, s13
Gui Add, Text, x328 y56 w68 h23 +0x200, Nimi:
Gui Font
Gui Add, Edit, x408 y56 w209 h21 +ReadOnly
Gui Font, s13
Gui Add, Text, x328 y88 w79 h23 +0x200, Salasana:
Gui Font
Gui Add, Edit, x408 y88 w209 h21 +ReadOnly +Password
Gui Font, s13
Gui Add, Text, x328 y120 w68 h23 +0x200, Domain:
Gui Font
Gui Add, Edit, x407 y120 w144 h21 +ReadOnly
Gui Font, s13
Gui Add, Button, x560 y120 w80 h23, Muokkaa
Gui Font
Gui Font, s13
Gui Add, GroupBox, x318 y153 w339 h236, Tiedostot
Gui Font
Gui Font, s13
Gui Add, Text, x328 y184 w318 h69, Tiedostojen sijainti: %A_AppData%\ %Sovelluskansio%
Gui Font
Gui Font, s13
Gui Add, Button, x432 y272 w117 h23 gavaakansio, Avaa kansio
Gui Font
Gui Font, s13
Gui Add, Button, x432 y304 w117 h25 gpoistakansio, Poista kansio
Gui Font
Gui Font, s13
Gui Add, GroupBox, x7 y325 w312 h64, Versio
Gui Font
Gui Font, s13
Gui Add, Text, x16 y344 w298 h35 +0x200, Sovelluksen versio: %versio%
Gui Font, s13
Gui Add, Button, x15 y288 w192 h28 gTestaaAvausta, Testaa aloitus avausta
Gui Font, s13
Gui Add, CheckBox, x16 y248 w292 h29 gTarkistaPaivitys vcheckup +Disabled, Tarkista päivitykset käynnistyksessä
IniRead, t_checkup, %A_AppData%\%Sovelluskansio%\Settings\Settings.ini, Settings, Updates
GuiControl,,checkup,%t_checkup%
Gui Font
Gui Add, Button, x16 y208 w210 h36 gcheckForupdates, Tarkista päivitykset(väli aikainen koska version tarkistus ei toimi)

Gui Show, w661 h394, AutoStartupAhk
IfNotExist %A_AppData%\%Sovelluskansio%\Startup
    FileCreateDir, %A_AppData%\%Sovelluskansio%\Startup
IfNotExist %A_AppData%\%Sovelluskansio%\Settings
    FileCreateDir, %A_AppData%\%Sovelluskansio%\Settings
IfNotExist %A_AppData%\%Sovelluskansio%\AutoStart
    FileCreateDir %A_AppData%\%Sovelluskansio%\AutoStart
Return
;____________________________________________________________
;____________________________________________________________
;//////////////[Escape]///////////////
GuiEscape:
GuiClose:
    ExitApp
;____________________________________________________________
;____________________________________________________________
Submit:
Gui, Submit, Nohide
return
avaakansio:
IfNotExist, %A_AppData%\%Sovelluskansio%
    Return
run, %A_AppData%\%Sovelluskansio%
Return
poistakansio:
MsgBox, 1,oletko varma?,Kaikki tämän sovelluksen asetusket poistuvat!,15
IfMsgBox, Cancel
{
	return
}
FileRemoveDir, %A_AppData%\%Sovelluskansio%,1
Return
poistasovellus:
MsgBox, 1,oletko varma?,Tämä poistaa sovelluksen listalta!,15
IfMsgBox, Cancel
{
	return
}
FileDelete, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%
TName_List =
Loop, %A_AppData%\%Sovelluskansio%\Startup\*, 1, 0
{
	TName_List = %TName_List%%A_LoopFileName%|
}
GuiControl,, dorplist,|
GuiControl,, dorplist,%TName_List%
return
refresh:
Gui, Submit, Nohide
if (dorplist == "")
    return
IniRead, T_nimi, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%, Asetukset, Nimi
IniRead, T_sovellus, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%, Asetukset, Tiedoston_sijainti
IniRead, T_Käynnistä, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%, Asetukset, Käynnistä_järjestelmänvalvojana
IniRead, T_kysy, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%, Asetukset, Kysy_järjestelmänvalvojan salasanaa
IniRead, T_viive, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%, Asetukset, Sovelluksen_viive
IniRead, T_käynnistys, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%, Asetukset, Käynnistä_aloituksessa
if (T_nimi == "" || T_nimi == "ERROR")
{
    MsgBox,,Tiedosto puuttuu,Tämän nimistä tiedostoa ei löydy. Sovelluksen uudelleenkäynnistys saataa auttaa.,15
    return
}
GuiControl,, nimi,%T_nimi%
GuiControl,, sovellus,%T_sovellus%
GuiControl,, käynnistä,%T_Käynnistä%
GuiControl,, kysy,%T_kysy%
GuiControl,, viive,%T_viive%
GuiControl,, käynnistys,%T_käynnistys%
goto Submit
return
KäynnistäSovellusToggle:
Gui, Submit, Nohide
IniWrite, %käynnistys%, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%, Asetukset, Käynnistä_aloituksessa
return
KäynnistäJärjestelmäToggle:
Gui, Submit, Nohide
IniWrite, %käynnistä%, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%, Asetukset, Käynnistä_järjestelmänvalvojana
return
KysyKäyttäjältäToggle:
Gui, Submit, Nohide
IniWrite, %kysy%, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%, Asetukset, Kysy_järjestelmänvalvojan salasanaa
return
ValitseTiedosto:
FileSelectFile, SelectedFile, 3, , Select file,(*.exe; *.ahk)
if (SelectedFile = "")
{}
else
{
    GuiControl,, sovellus,%SelectedFile%
    IniWrite, %SelectedFile%, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%, Asetukset, Tiedoston_sijainti
}
return
TallennaSovelluksenNimi:
Gui, Submit, Nohide
IniWrite, %nimi%, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%, Asetukset, Nimi
FileMove, %A_AppData%\%Sovelluskansio%\Startup\%dorplist%, %A_AppData%\%Sovelluskansio%\Startup\%nimi%.ini
TName_List =
Loop, %A_AppData%\%Sovelluskansio%\Startup\*, 1, 0
{
	TName_List = %TName_List%%A_LoopFileName%|
}
GuiControl,, dorplist,|
GuiControl,, dorplist,%TName_List%
return
TarkistaPaivitys:
Gui, Submit, Nohide
IniWrite, %checkup%, %A_AppData%\%Sovelluskansio%\Settings\Settings.ini, Settings, Updates
return
;____________________________________________________________
;____________________________________________________________
;//////////////[LisääUusiAloitusSovellus]///////////////
LisääUusiAloitusSovellus:
Gui, Destroy
Gui Font, s15
Gui Add, Button, x216 y8 w246 h41 gL_valitsetiedosto, Valitse tiedosto
Gui Font
Gui Font, s13
Gui Add, Text, x8 y16 w138 h31 +0x200, Tiedoston sijainti:
Gui Font
Gui Add, Edit, x8 y56 w465 h21 vL_sovellus gSubmit
Gui Add, Text, x16 y88 w444 h2 0x10
Gui Font, s13
Gui Add, Text, x16 y96 w135 h28 +0x200, Sovelluksen nimi:
Gui Font
Gui Add, Edit, x160 y96 w280 h27 vL_nimi gSubmit
Gui Font, s13
Gui Add, GroupBox, x8 y128 w464 h152, Käynnistys asetukset
Gui Font
Gui Font, s13
Gui Add, CheckBox, x16 y160 w260 h23 vL_Käynnistä gSubmit, Käynnistä Järjestelmänvalvojana
Gui Font
Gui Font, s13
Gui Add, CheckBox, x16 y192 w298 h23 vL_kysy gSubmit, Kysy järjestelmänvalvojan salasanaa
Gui Font
Gui Font, s13
Gui Add, Text, x16 y224 w274 h24, Sovelluksen aloittamisen viive:(ms)
Gui Font
Gui Add, Edit, x296 y224 w120 h21 vL_viive gSubmit
Gui Font, s13
Gui Add, Text, x296 y248 w125 h23, (1000 ms = 1 s)
Gui Font
Gui Font, s20
Gui Add, Button, x296 y280 w174 h38 gL_tallenna, Tallenna
Gui Font
Gui Font, s20
Gui Add, Button, x16 y280 w174 h38 gL_peruuta, Peruuta
Gui Font
Gui Show, w481 h324, Uusi aloitus sovellus
return
;//////////////[LisääUusiAloitusSovellus näppäimet]///////////////
L_peruuta:
Gui, Destroy
goto start
return
L_valitsetiedosto:
FileSelectFile, SelectedFile, 3, , Select file,(*.exe; *.ahk)
if (SelectedFile = "")
{}
else
    GuiControl,, L_sovellus,%SelectedFile%
return
L_tallenna:
if (L_nimi == "" || L_sovellus == "")
{
    MsgBox,,Nimi tai tiedosto puuttuu!,Nimi tai tiedosto puuttuu!, 10
    return
}
FileCreateDir, %A_AppData%\%Sovelluskansio%\Startup
IniWrite, %L_nimi%, %A_AppData%\%Sovelluskansio%\Startup\%L_nimi%.ini, Asetukset, Nimi
IniWrite, %L_sovellus%, %A_AppData%\%Sovelluskansio%\Startup\%L_nimi%.ini, Asetukset, Tiedoston_sijainti
IniWrite, %L_Käynnistä%, %A_AppData%\%Sovelluskansio%\Startup\%L_nimi%.ini, Asetukset, Käynnistä_järjestelmänvalvojana
IniWrite, %L_kysy%, %A_AppData%\%Sovelluskansio%\Startup\%L_nimi%.ini, Asetukset, Kysy_järjestelmänvalvojan salasanaa
IniWrite, %L_viive%, %A_AppData%\%Sovelluskansio%\Startup\%L_nimi%.ini, Asetukset, Sovelluksen_viive
IniWrite, 1, %A_AppData%\%Sovelluskansio%\Startup\%L_nimi%.ini, Asetukset, Käynnistä_aloituksessa
Gui, Destroy
goto start
return
;____________________________________________________________
;____________________________________________________________
;//////////////[Startup stuff]///////////////
TestaaAvausta:
IniWrite, 1,%A_AppData%\%Sovelluskansio%\AutoStart\AutoStart.ini,Settings,Startup
sleep 200
run, %A_ScriptFullPath%
ExitApp
MakeStartupFile:
Gui, Submit, Nohide
if (AlkuSovellus == 1)
{
FileAppend, 
(
#NoEnv
#SingleInstance Force
IniWrite, 1,%A_AppData%\%Sovelluskansio%\AutoStart\AutoStart.ini,Settings,Startup
sleep 200
run, %A_ScriptFullPath%
ExitApp
), %A_Startup%\Startup.ahk
}
else
{
    FileDelete, %A_Startup%\Startup.ahk
}
return
StartupLoop:
;//////////////[Normi käynnistys]///////////////
Loop, %A_AppData%\%Sovelluskansio%\Startup\*, 1, 0
{
    IfExist, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%
    {
        IniRead, T_käynnistys, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%, Asetukset, Käynnistä_aloituksessa
        if(T_käynnistys == 1)
        {
            ;käynnistä aloituksessa
            IniRead, T_Käynnistä, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%, Asetukset, Käynnistä_järjestelmänvalvojana
            if(T_Käynnistä == 0)
            {
                ;MsgBox, normi %A_LoopFileName%
                IniRead, T_sovellus, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%, Asetukset, Tiedoston_sijainti
                run, %T_sovellus%
            }
        }
    }
}
IniWrite, 2,%A_AppData%\%Sovelluskansio%\AutoStart\AutoStart.ini,Settings,Startup
StartupLoop1:
;//////////////[Admin ilman kysy]///////////////
Loop, %A_AppData%\%Sovelluskansio%\Startup\*, 1, 0
{
    IfExist, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%
    {
        IniRead, T_käynnistys, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%, Asetukset, Käynnistä_aloituksessa
        if(T_käynnistys == 1)
        {
            ;käynnistä aloituksessa
            IniRead, T_Käynnistä, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%, Asetukset, Käynnistä_järjestelmänvalvojana
            if(T_Käynnistä == 1)
            {
                IniRead, T_kysy, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%, Asetukset, Kysy_järjestelmänvalvojan salasanaa
                if(T_kysy == 0)
                {
                    ;MsgBox, admin %A_LoopFileName%
                    IniRead, T_sovellus, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%, Asetukset, Tiedoston_sijainti
                    run, %T_sovellus%
                }
            }
        }
    }
}
IniWrite, 3,%A_AppData%\%Sovelluskansio%\AutoStart\AutoStart.ini,Settings,Startup
StartupLoop2:
;//////////////[Admin kysy]///////////////
Loop, %A_AppData%\%Sovelluskansio%\Startup\*, 1, 0
{
    IfExist, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%
    {
        IniRead, T_käynnistys, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%, Asetukset, Käynnistä_aloituksessa
        if(T_käynnistys == 1)
        {
            ;käynnistä aloituksessa
            IniRead, T_Käynnistä, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%, Asetukset, Käynnistä_järjestelmänvalvojana
            if(T_Käynnistä == 1)
            {
                
                IniRead, T_kysy, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%, Asetukset, Kysy_järjestelmänvalvojan salasanaa
                if(T_kysy == 1)
                {
                    if not A_IsAdmin
                    {
                        Run *RunAs %A_ScriptFullPath%
                        ExitApp
                    }
                    ;MsgBox, admin kysy %A_LoopFileName%
                    IniRead, T_sovellus, %A_AppData%\%Sovelluskansio%\Startup\%A_LoopFileName%, Asetukset, Tiedoston_sijainti
                    run, %T_sovellus%
                }
            }
        }
    }
}
FileDelete, %A_AppData%\%Sovelluskansio%\AutoStart\AutoStart.ini
ExitApp
;____________________________________________________________
;____________________________________________________________
;//////////////[Update stuff]///////////////
checkForupdates:
IfExist, %A_AppData%\%Sovelluskansio%\Settings\Settings.ini
{
    ; Example: Download text to a variable:
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", "https://raw.githubusercontent.com/veskeli/AutoStartupAhk/master/Version.txt", False)
    whr.Send()
    ; Using 'true' above and the call below allows the script to remain responsive.
    whr.WaitForResponse()
    version := whr.ResponseText
    ;vertaa versioita
    if(version != "")
    {
        if(version != NykyinenVersio)
        {
            MsgBox, 1,Päivitys,uusi versio on %version% vanha on %NykyinenVersio%. Haluatko ladata uuden päivityksen,15
            IfMsgBox, Cancel
            {
                ;temp stuff
            }
            else
            {
                ;lataa päivitys
                FileMove, %A_ScriptFullPath%, %A_AppData%\%Sovelluskansio%\%A_ScriptName%, 1
                sleep 1000
                UrlDownloadToFile, %TiedostoLatausLinkki%, %A_ScriptFullPath%
                Sleep 1000
			    Run, %A_ScriptFullPath%
			    ExitApp
            }
        }
    }
}
return
UpdateFiles:
;UrlDownloadToFile, *0 %url%, %A_WorkingDir%\%Filename%
Return