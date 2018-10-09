#Include %A_LineFile%\..\JSON.ahk

;-------Static Vars
gameVersion = OSRS
maxHostsOSRS = 1
maxHostsRS3 = 1
yanString =
rimString =

;---------url to json string
json_txt =({"OSRS Hosts": [{"World": 330, "loc": "Yanille", "Username": "yan1"}, {"World": 330, "loc": "Rimmington", "Username": "rim1"}, {"World": 330, "loc": "Rimmington", "Username": "rim2"}], "RS3 Hosts": [{"World": 31, "loc": "Yanille", "Username": "yan1"}]})

;------------ Handle string modifications
fixedOSRS := StrReplace(json_txt, "OSRS Hosts" , "OSRS")
fixedRS3 := StrReplace(fixedOSRS, "RS3 Hosts" , "RS3")
removedAstrisk := StrReplace(fixedRS3, "*" , "")

;-----------Parse the actual JSON
parsed := JSON.Load(removedAstrisk)

;-------------Loop to find max value that's not null
If (OSRS = %gameVersion%) 
{
    Loop
    {
        if !parsed.OSRS[maxHostsOSRS].Username
            break
        if parsed.OSRS[maxHostsOSRS].Username
            maxHostsOSRS++
            continue
    }
    maxHostsOSRS -= 1
} else if (RS3 = %gameVersion%) {
    Loop
    {
        if !parsed.RS3[maxHostsRS3].Username
            break
        if parsed.RS3[maxHostsRS3].Username
            maxHostsRS3++
            continue
    }
    maxHostRS3 -= 1
}
;----------------end of looping to find max hosts
    Loop, %maxHostsOSRS%
    {
        If (Rimmington = parsed.OSRS[%A_Index%].loc) 
        {
        rim2 = parsed.OSRS[%A_Index%].Username
        continue
        }
        else if (Yanille = parsed.OSRS[%A_Index%].loc)
        {
        }
        continue
    }
rimString = %rim2%
parsed_out := Format("
(Join`r`n
OSRS1:  [{}, {}] OSRS2:  [{}, {}] OSRS3:  [{}, {}] OSRS4:  [{}, {}] OSRS5:  [{}, {}] OSRS6:  [{}, {}] OSRS7:  [{}, {}] OSRS8:  [{}, {}] OSRS9:  [{}, {}] OSRS0:  [{}, {}]
1RS3:  [{}, {}] 2RS3:  [{}, {}] 3RS3:  [{}, {}] 4RS3:  [{}, {}] 5RS3:  [{}, {}] 6RS3:  [{}, {}] 7RS3:  [{}, {}] 8RS3:  [{}, {}] 9RS3:  [{}, {}] 0RS3:  [{}, {}]
)"
, parsed.OSRS[1].loc, parsed.OSRS[1].Username, parsed.OSRS[2].loc, parsed.OSRS[2].Username , parsed.OSRS[3].loc, parsed.OSRS[3].Username , parsed.OSRS[4].loc, parsed.OSRS[4].Username  , parsed.OSRS[5].loc, parsed.OSRS[5].Username , parsed.OSRS[6].loc, parsed.OSRS[6].Username , parsed.OSRS[7].loc, parsed.OSRS[7].Username , parsed.OSRS[8].loc, parsed.OSRS[8].Username , parsed.OSRS[9].loc, parsed.OSRS[9].Username , parsed.OSRS[10].loc, parsed.OSRS[10].Username , parsed.RS3[1].loc, parsed.RS3[1].Username , parsed.RS3[2].loc, parsed.RS3[2].Username , parsed.RS3[3].loc, parsed.RS3[3].Username , parsed.RS3[4].loc, parsed.RS3[4].Username , parsed.RS3[5].loc, parsed.RS3[5].Username , parsed.RS3[6].loc, parsed.RS3[6].Username , parsed.RS3[7].loc, parsed.RS3[7].Username , parsed.RS3[8].loc, parsed.RS3[8].Username , parsed.RS3[9].loc, parsed.RS3[9].Username , parsed.RS3[10].loc, parsed.RS3[10].Username)



stringified := JSON.Dump(parsed,, 4)
stringified := StrReplace(stringified, "`n", "`r`n") ; for display purposes only

ListVars
WinWaitActive ahk_class AutoHotkey
ControlSetText Edit1, [PARSED]`r`n%parsed_out%`r`n`r`n[STRINGIFIED]`r`n%stringified%`r`n`r`n[URL LOAD]`r`n%url_text%`r`n`r`n[JSON String]`r`n%json_txt%`r`n`r`n[[[MostRecent]]]`r`n[OSRS]`r`n%maxHostsOSRS%`r`n[RS3]`r`n%maxHostsRS3%`r`n[Game Version]`r`n%gameVersion%`r`n`r`n`r`n[RIM/YAN]`r`n[RIM]`r`n[Rim String] Rim-%rimString%`r`n[Yan]`r`n[Yan String] Yan-%yanString%
WinWaitclose
return
