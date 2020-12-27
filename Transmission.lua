local TDT = TDT
local L = TDT.L
local Compresser = LibStub:GetLibrary("LibCompress")
local Encoder = Compresser:GetAddonEncodeTable()
local Serializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")
local configForDeflate = {
    [1]= {level = 1},
    [2]= {level = 2},
    [3]= {level = 3},
    [4]= {level = 4},
    [5]= {level = 5},
    [6]= {level = 6},
    [7]= {level = 7},
    [8]= {level = 8},
    [9]= {level = 9},
}
TDTcommsObject = LibStub("AceAddon-3.0"):NewAddon("TDTCommsObject","AceComm-3.0","AceSerializer-3.0")

-- Lua APIs
local tostring, string_char, strsplit,tremove,tinsert = tostring, string.char, strsplit,table.remove,table.insert
local pairs, type, unpack = pairs, type, unpack
local bit_band, bit_lshift, bit_rshift = bit.band, bit.lshift, bit.rshift

--Based on code from WeakAuras2, all credit goes to the authors
local bytetoB64 = {
    [0]="a","b","c","d","e","f","g","h",
    "i","j","k","l","m","n","o","p",
    "q","r","s","t","u","v","w","x",
    "y","z","A","B","C","D","E","F",
    "G","H","I","J","K","L","M","N",
    "O","P","Q","R","S","T","U","V",
    "W","X","Y","Z","0","1","2","3",
    "4","5","6","7","8","9","(",")"
}

local B64tobyte = {
    a =  0,  b =  1,  c =  2,  d =  3,  e =  4,  f =  5,  g =  6,  h =  7,
    i =  8,  j =  9,  k = 10,  l = 11,  m = 12,  n = 13,  o = 14,  p = 15,
    q = 16,  r = 17,  s = 18,  t = 19,  u = 20,  v = 21,  w = 22,  x = 23,
    y = 24,  z = 25,  A = 26,  B = 27,  C = 28,  D = 29,  E = 30,  F = 31,
    G = 32,  H = 33,  I = 34,  J = 35,  K = 36,  L = 37,  M = 38,  N = 39,
    O = 40,  P = 41,  Q = 42,  R = 43,  S = 44,  T = 45,  U = 46,  V = 47,
    W = 48,  X = 49,  Y = 50,  Z = 51,["0"]=52,["1"]=53,["2"]=54,["3"]=55,
    ["4"]=56,["5"]=57,["6"]=58,["7"]=59,["8"]=60,["9"]=61,["("]=62,[")"]=63
}

-- This code is based on the Encode7Bit algorithm from LibCompress
-- Credit goes to Galmok (galmok@gmail.com)
local decodeB64Table = {}

function decodeB64(str)
    local bit8 = decodeB64Table
    local decoded_size = 0
    local ch
    local i = 1
    local bitfield_len = 0
    local bitfield = 0
    local l = #str
    while true do
        if bitfield_len >= 8 then
            decoded_size = decoded_size + 1
            bit8[decoded_size] = string_char(bit_band(bitfield, 255))
            bitfield = bit_rshift(bitfield, 8)
            bitfield_len = bitfield_len - 8
        end
        ch = B64tobyte[str:sub(i, i)]
        bitfield = bitfield + bit_lshift(ch or 0, bitfield_len)
        bitfield_len = bitfield_len + 6
        if i > l then
            break
        end
        i = i + 1
    end
    return table.concat(bit8, "", 1, decoded_size)
end

function TDT:TableToString(inTable, forChat,level)
    local serialized = Serializer:Serialize(inTable)
    local compressed = LibDeflate:CompressDeflate(serialized, configForDeflate[level])
    -- prepend with "!" so that we know that it is not a legacy compression
    -- also this way, old versions will error out due to the "bad" encoding
    local encoded = "!"
    if(forChat) then
        encoded = encoded .. LibDeflate:EncodeForPrint(compressed)
    else
        encoded = encoded .. LibDeflate:EncodeForWoWAddonChannel(compressed)
    end
    return encoded
end

function TDT:StringToTable(inString, fromChat)
    -- if gsub strips off a ! at the beginning then we know that this is not a legacy encoding
    local encoded, usesDeflate = inString:gsub("^%!", "")
    local decoded
    if(fromChat) then
        if usesDeflate == 1 then
            decoded = LibDeflate:DecodeForPrint(encoded)
        else
            decoded = decodeB64(encoded)
        end
    else
        decoded = LibDeflate:DecodeForWoWAddonChannel(encoded)
    end

    if not decoded then
        return "Error decoding."
    end

    local decompressed, errorMsg = nil, "unknown compression method"
    if usesDeflate == 1 then
        decompressed = LibDeflate:DecompressDeflate(decoded)
    else
        decompressed, errorMsg = Compresser:Decompress(decoded)
    end
    if not(decompressed) then
        return "Error decompressing: " .. errorMsg
    end

    local success, deserialized = Serializer:Deserialize(decompressed)
    if not(success) then
        return "Error deserializing "..deserialized
    end
    return deserialized
end

local function filterFunc(_, event, msg, player, l, cs, t, flag, channelId, ...)
    if flag == "GM" or flag == "DEV" or (event == "CHAT_MSG_CHANNEL" and type(channelId) == "number" and channelId > 0) then
        return
    end
    local newMsg = ""
    local remaining = msg
    local done
    repeat
        local start, finish, characterName, displayName = remaining:find("%[TrashDungeonTools: ([^%s]+) %- ([^%]]+)%]")
        local startLive, finishLive, characterNameLive, displayNameLive = remaining:find("%[TDTLive: ([^%s]+) %- ([^%]]+)%]")
        if(characterName and displayName) then
            characterName = characterName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
            displayName = displayName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
            newMsg = newMsg..remaining:sub(1, start-1)
            newMsg = "|cfff49d38|Hgarrmission:TDT-"..characterName.."|h["..displayName.."]|h|r"
            remaining = remaining:sub(finish + 1)
        elseif (characterNameLive and displayNameLive) then
            characterNameLive = characterNameLive:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
            displayNameLive = displayNameLive:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
            newMsg = newMsg..remaining:sub(1, startLive-1)
            newMsg = newMsg.."|Hgarrmission:TDTlive-"..characterNameLive.."|h[".."|cFF00FF00Live Session: |cfff49d38"..""..displayNameLive.."]|h|r"
            remaining = remaining:sub(finishLive + 1)
        else
            done = true
        end
    until(done)
    if newMsg ~= "" then
        return false, newMsg, player, l, cs, t, flag, channelId, ...
    end
end

local presetCommPrefix = "TDTPreset"

TDT.liveSessionPrefixes = {
    ["enabled"] = "TDTLiveEnabled",
    ["request"] = "TDTLiveReq",
    ["ping"] = "TDTLivePing",
    ["obj"] = "TDTLiveObj",
    ["objOff"] = "TDTLiveObjOff",
    ["objChg"] = "TDTLiveObjChg",
    ["cmd"] = "TDTLiveCmd",
    ["note"] = "TDTLiveNote",
    ["preset"] = "TDTLivePreset",
    ["pull"] = "TDTLivePull",
    ["week"] = "TDTLiveWeek",
    ["free"] = "TDTLiveFree",
    ["bora"] = "TDTLiveBora",
    ["mdi"] = "TDTLiveMDI",
    ["reqPre"] = "TDTLiveReqPre",
    ["corrupted"] = "TDTLiveCor",
    ["difficulty"] = "TDTLiveLvl",
}

TDT.dataCollectionPrefixes = {
    ["request"] = "TDTDataReq",
    ["distribute"] = "TDTDataDist",
}

function TDTcommsObject:OnEnable()
    self:RegisterComm(presetCommPrefix)
    for _,prefix in pairs(TDT.liveSessionPrefixes) do
        self:RegisterComm(prefix)
    end
    for _,prefix in pairs(TDT.dataCollectionPrefixes) do
        self:RegisterComm(prefix)
    end
    TDT.transmissionCache = {}
    ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", filterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", filterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", filterFunc)
end

--handle preset chat link clicks
hooksecurefunc("SetItemRef", function(link, text)
    if(link and link:sub(0, 19) == "garrmission:TDTlive") then
        local sender = link:sub(21, string.len(link))
        local name,realm = string.match(sender,"(.*)+(.*)")
        sender = name.."-"..realm
        --ignore importing the live preset when sender is player, open TDT only
        local playerName,playerRealm = UnitFullName("player")
        playerName = playerName.."-"..playerRealm
        if sender==playerName then
            TDT:ShowInterface(true)
        else
            TDT:ShowInterface(true)
            TDT:LiveSession_Enable()
        end
        return
    elseif (link and link:sub(0, 15) == "garrmission:TDT") then
        local sender = link:sub(17, string.len(link))
        local name,realm = string.match(sender,"(.*)+(.*)")
        if (not name) or (not realm) then
            print(string.format(L["receiveErrorUpdate"],sender))
            return
        end
        sender = name.."-"..realm
        local preset = TDT.transmissionCache[sender]
        if preset then
            TDT:ShowInterface(true)
            TDT:OpenChatImportPresetDialog(sender,preset)
        end
        return
    end
end)

function TDTcommsObject:OnCommReceived(prefix, message, distribution, sender)
    --[[
        Sender has no realm name attached when sender is from the same realm as the player
        UnitFullName("Nnoggie") returns no realm while UnitFullName("player") does
        UnitFullName("Nnoggie-TarrenMill") returns realm even if you are not on the same realm as Nnoggie
        We append our realm if there is no realm
    ]]
    local name, realm = UnitFullName(sender)
    if not name then return end
    if not realm or string.len(realm)<3 then
        local _,r = UnitFullName("player")
        realm = r
    end
    local fullName = name.."-"..realm

    --standard preset transmission
    --we cache the preset here already
    --the user still decides if he wants to click the chat link and add the preset to his db
    if prefix == presetCommPrefix then
        local preset = TDT:StringToTable(message,false)
        TDT.transmissionCache[fullName] = preset
        --live session preset
        if TDT.liveSessionActive and TDT.liveSessionAcceptingPreset and preset.uid == TDT.livePresetUID then
            if TDT:ValidateImportPreset(preset) then
                TDT:ImportPreset(preset,true)
                TDT.liveSessionAcceptingPreset = false
                TDT.main_frame.SendingStatusBar:Hide()
                if TDT.main_frame.LoadingSpinner then
                    TDT.main_frame.LoadingSpinner:Hide()
                    TDT.main_frame.LoadingSpinner.Anim:Stop()
                end
                TDT.liveSessionRequested = false
            end
        end
    end

    if prefix == TDT.dataCollectionPrefixes.request then
        TDT.DataCollection:DistributeData()
    end

    if prefix == TDT.dataCollectionPrefixes.distribute then
        local package = TDT:StringToTable(message,false)
        TDT.DataCollection:MergeReceiveData(package)
    end

    if prefix == TDT.liveSessionPrefixes.enabled then
        if TDT.liveSessionRequested == true then
            TDT:LiveSession_SessionFound(fullName,message)
        end
    end

    --pulls
    if prefix == TDT.liveSessionPrefixes.pull then
        if TDT.liveSessionActive then
            local preset = TDT:GetCurrentLivePreset()
            local pulls = TDT:StringToTable(message,false)
            preset.value.pulls = pulls
            if not preset.value.pulls[preset.value.currentPull] then
                preset.value.currentPull = #preset.value.pulls
                preset.value.selection = {#preset.value.pulls}
            end
            if preset == TDT:GetCurrentPreset() then
                TDT:ReloadPullButtons()
                TDT:SetSelectionToPull(TDT:GetCurrentPull())
                TDT:POI_UpdateAll() --for corrupted spires
                TDT:UpdateProgressbar()
            end
        end
    end

    --corrupted
    if prefix == TDT.liveSessionPrefixes.corrupted then
        if TDT.liveSessionActive then
            local preset = TDT:GetCurrentLivePreset()
            local offsets = TDT:StringToTable(message,false)
            --only reposition if no blip is currently moving
            if not TDT.draggedBlip then
                preset.value.riftOffsets = offsets
                TDT:UpdateMap()
            end
        end
    end

    --difficulty
    if prefix == TDT.liveSessionPrefixes.difficulty then
        if TDT.liveSessionActive then
            local db = TDT:GetDB()
            local difficulty = tonumber(message)
            if difficulty and difficulty~= db.currentDifficulty then
                local updateSeasonal
                if ((difficulty>=10 and db.currentDifficulty<10) or (difficulty<10 and db.currentDifficulty>=10)) then
                    updateSeasonal = true
                end
                db.currentDifficulty = difficulty
                TDT.main_frame.sidePanel.DifficultySlider:SetValue(difficulty)
                TDT:UpdateProgressbar()
                if TDT.EnemyInfoFrame and TDT.EnemyInfoFrame.frame:IsShown() then TDT:UpdateEnemyInfoData() end
                TDT:ReloadPullButtons()
                if updateSeasonal then
                    TDT:DungeonEnemies_UpdateSeasonalAffix()
                    TDT.main_frame.sidePanel.difficultyWarning:Toggle(difficulty)
                    TDT:POI_UpdateAll()
                    TDT:KillAllAnimatedLines()
                    TDT:DrawAllAnimatedLines()
                end
            end
        end
    end

    --week
    if prefix == TDT.liveSessionPrefixes.week then
        if TDT.liveSessionActive then
            local preset = TDT:GetCurrentLivePreset()
            local week = tonumber(message)
            if preset.week ~= week then
                preset.week = week
                local teeming = TDT:IsPresetTeeming(preset)
                preset.value.teeming = teeming
                if preset == TDT:GetCurrentPreset() then
                    local affixDropdown = TDT.main_frame.sidePanel.affixDropdown
                    affixDropdown:SetValue(week)
                    if not TDT:GetCurrentAffixWeek() then
                        TDT.main_frame.sidePanel.affixWeekWarning.image:Hide()
                        TDT.main_frame.sidePanel.affixWeekWarning:SetDisabled(true)
                    elseif TDT:GetCurrentAffixWeek() == week then
                        TDT.main_frame.sidePanel.affixWeekWarning.image:Hide()
                        TDT.main_frame.sidePanel.affixWeekWarning:SetDisabled(true)
                    else
                        TDT.main_frame.sidePanel.affixWeekWarning.image:Show()
                        TDT.main_frame.sidePanel.affixWeekWarning:SetDisabled(false)
                    end
                    TDT:DungeonEnemies_UpdateTeeming()
                    TDT:DungeonEnemies_UpdateInspiring()
                    TDT:UpdateFreeholdSelector(week)
                    TDT:DungeonEnemies_UpdateBlacktoothEvent(week)
                    TDT:DungeonEnemies_UpdateSeasonalAffix()
                    TDT:DungeonEnemies_UpdateBoralusFaction(preset.faction)
                    TDT:POI_UpdateAll()
                    TDT:UpdateProgressbar()
                    TDT:ReloadPullButtons()
                    TDT:KillAllAnimatedLines()
                    TDT:DrawAllAnimatedLines()
                end
            end
        end
    end

    --live session messages that ignore concurrency from here on, we ignore our own messages
    if sender == UnitFullName("player") then return end


    if prefix == TDT.liveSessionPrefixes.request then
        if TDT.liveSessionActive then
            TDT:LiveSession_NotifyEnabled()
        end
    end

    --request preset
    if prefix == TDT.liveSessionPrefixes.reqPre then
        local playerName,playerRealm = UnitFullName("player")
        playerName = playerName.."-"..playerRealm
        if playerName == message then
            TDT:SendToGroup(TDT:IsPlayerInGroup(),true,TDT:GetCurrentLivePreset())
        end
    end


    --ping
    if prefix == TDT.liveSessionPrefixes.ping then
        local currentUID = TDT:GetCurrentPreset().uid
        if TDT.liveSessionActive and (currentUID and currentUID==TDT.livePresetUID) then
            local x,y,sublevel = string.match(message,"(.*):(.*):(.*)")
            x = tonumber(x)
            y = tonumber(y)
            sublevel = tonumber(sublevel)
            local scale = TDT:GetScale()
            if sublevel == TDT:GetCurrentSubLevel() then
                TDT:PingMap(x*scale,y*scale)
            end
        end
    end

    --preset objects
    if prefix == TDT.liveSessionPrefixes.obj then
        if TDT.liveSessionActive then
            local preset = TDT:GetCurrentLivePreset()
            local obj = TDT:StringToTable(message,false)
            TDT:StorePresetObject(obj,true,preset)
            if preset == TDT:GetCurrentPreset() then
                local scale = TDT:GetScale()
                local currentPreset = TDT:GetCurrentPreset()
                local currentSublevel = TDT:GetCurrentSubLevel()
                TDT:DrawPresetObject(obj,nil,scale,currentPreset,currentSublevel)
            end
        end
    end

    --preset object offsets
    if prefix == TDT.liveSessionPrefixes.objOff then
        if TDT.liveSessionActive then
            local preset = TDT:GetCurrentLivePreset()
            local objIdx,x,y = string.match(message,"(.*):(.*):(.*)")
            objIdx = tonumber(objIdx)
            x = tonumber(x)
            y = tonumber(y)
            TDT:UpdatePresetObjectOffsets(objIdx,x,y,preset,true)
            if preset == TDT:GetCurrentPreset() then TDT:DrawAllPresetObjects() end
        end
    end

    --preset object changed (deletions, partial deletions)
    if prefix == TDT.liveSessionPrefixes.objChg then
        if TDT.liveSessionActive then
            local preset = TDT:GetCurrentLivePreset()
            local changedObjects = TDT:StringToTable(message,false)
            for objIdx,obj in pairs(changedObjects) do
                preset.objects[objIdx] = obj
            end
            if preset == TDT:GetCurrentPreset() then TDT:DrawAllPresetObjects() end
        end
    end

    --various commands
    if prefix == TDT.liveSessionPrefixes.cmd then
        if TDT.liveSessionActive then
            local preset = TDT:GetCurrentLivePreset()
            if message == "deletePresetObjects" then TDT:DeletePresetObjects(preset, true) end
            if message == "undo" then TDT:PresetObjectStepBack(preset, true) end
            if message == "redo" then TDT:PresetObjectStepForward(preset, true) end
            if message == "clear" then TDT:ClearPreset(preset,true) end
        end
    end

    --note text update, delete, move
    if prefix == TDT.liveSessionPrefixes.note then
        if TDT.liveSessionActive then
            local preset = TDT:GetCurrentLivePreset()
            local action,noteIdx,text,y = string.match(message,"(.*):(.*):(.*):(.*)")
            noteIdx = tonumber(noteIdx)
            if action == "text" then
                preset.objects[noteIdx].d[5]=text
            elseif action == "delete" then
                tremove(preset.objects,noteIdx)
            elseif action == "move" then
                local x = tonumber(text)
                y = tonumber(y)
                preset.objects[noteIdx].d[1]=x
                preset.objects[noteIdx].d[2]=y
            end
            if preset == TDT:GetCurrentPreset() then TDT:DrawAllPresetObjects() end
        end
    end

    --preset
    if prefix == TDT.liveSessionPrefixes.preset then
        if TDT.liveSessionActive then
            local preset = TDT:StringToTable(message,false)
            TDT.transmissionCache[fullName] = preset
            if TDT:ValidateImportPreset(preset) then
                TDT.livePresetUID = preset.uid
                TDT:ImportPreset(preset,true)
            end
        end
    end

    --freehold
    if prefix == TDT.liveSessionPrefixes.free then
        if TDT.liveSessionActive then
            local preset = TDT:GetCurrentLivePreset()
            local value,week = string.match(message,"(.*):(.*)")
            value = value == "T" and true or false
            week = tonumber(week)
            preset.freeholdCrew = (value and week) or nil
            if preset == TDT:GetCurrentPreset() then
                TDT:DungeonEnemies_UpdateFreeholdCrew(preset.freeholdCrew)
                TDT:UpdateFreeholdSelector(week)
                TDT:ReloadPullButtons()
                TDT:UpdateProgressbar()
            end
        end
    end

    --Siege of Boralus
    if prefix == TDT.liveSessionPrefixes.bora then
        if TDT.liveSessionActive then
            local preset = TDT:GetCurrentLivePreset()
            local faction = tonumber(message)
            preset.faction = faction
            if preset == TDT:GetCurrentPreset() then
                TDT:UpdateBoralusSelector()
                TDT:ReloadPullButtons()
                TDT:UpdateProgressbar()
            end
        end
    end

    --MDI
    if prefix == TDT.liveSessionPrefixes.mdi then
        if TDT.liveSessionActive then
            local preset = TDT:GetCurrentLivePreset()
            local updateUI = preset == TDT:GetCurrentPreset()
            local action,data = string.match(message,"(.*):(.*)")
            data = tonumber(data)
            if action == "toggle" then
                TDT:GetDB().MDI.enabled = data == 1 or false
                TDT:DisplayMDISelector()
            elseif action == "beguiling" then
                preset.mdi.beguiling = data
                if updateUI then
                    TDT.MDISelector.BeguilingDropDown:SetValue(preset.mdi.beguiling)
                    TDT:DungeonEnemies_UpdateSeasonalAffix()
                    TDT:DungeonEnemies_UpdateBoralusFaction(preset.faction)
                    TDT:UpdateProgressbar()
                    TDT:ReloadPullButtons()
                    TDT:POI_UpdateAll()
                    TDT:KillAllAnimatedLines()
                    TDT:DrawAllAnimatedLines()
                end
            elseif action == "freehold" then
                preset.mdi.freehold = data
                if updateUI then
                    TDT.MDISelector.FreeholdDropDown:SetValue(preset.mdi.freehold)
                    if preset.mdi.freeholdJoined then
                        TDT:DungeonEnemies_UpdateFreeholdCrew(preset.mdi.freehold)
                    end
                    TDT:DungeonEnemies_UpdateBlacktoothEvent()
                    TDT:UpdateProgressbar()
                    TDT:ReloadPullButtons()
                end
            elseif action == "join" then
                preset.mdi.freeholdJoined = data == 1 or false
                if updateUI then
                    TDT:DungeonEnemies_UpdateFreeholdCrew()
                    TDT:ReloadPullButtons()
                    TDT:UpdateProgressbar()
                end
            end

        end
    end

end


---MakeSendingStatusBar
---Creates a bar that indicates sending progress when sharing presets with your group
---Called once from initFrames()
function TDT:MakeSendingStatusBar(f)
    f.SendingStatusBar = CreateFrame("StatusBar", nil, f)
    local statusbar = f.SendingStatusBar
    statusbar:SetMinMaxValues(0, 1)
    statusbar:SetPoint("LEFT", f.bottomPanel, "LEFT", 5, 0)
    statusbar:SetWidth(200)
    statusbar:SetHeight(20)
    statusbar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    statusbar:GetStatusBarTexture():SetHorizTile(false)
    statusbar:GetStatusBarTexture():SetVertTile(false)
    statusbar:SetStatusBarColor(0.26,0.42,1)

    statusbar.bg = statusbar:CreateTexture(nil, "BACKGROUND")
    statusbar.bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    statusbar.bg:SetAllPoints(true)
    statusbar.bg:SetVertexColor(0.26,0.42,1)

    statusbar.value = statusbar:CreateFontString(nil, "OVERLAY")
    statusbar.value:SetPoint("CENTER", statusbar, "CENTER", 0, 0)
    statusbar.value:SetFontObject("GameFontNormalSmall")
    statusbar.value:SetJustifyH("CENTER")
    statusbar.value:SetJustifyV("CENTER")
    statusbar.value:SetShadowOffset(1, -1)
    statusbar.value:SetTextColor(1, 1, 1)
    statusbar:Hide()

    if IsAddOnLoaded("ElvUI") then
        local E, L, V, P, G = unpack(ElvUI)
        statusbar:SetStatusBarTexture(E.media.normTex)
    end
end

--callback for SendCommMessage
local function displaySendingProgress(userArgs,bytesSent,bytesToSend)
    TDT.main_frame.SendingStatusBar:Show()
    TDT.main_frame.SendingStatusBar:SetValue(bytesSent/bytesToSend)
    TDT.main_frame.SendingStatusBar.value:SetText(string.format(L["Sending: %.1f"],bytesSent/bytesToSend*100).."%")
    --done sending
    if bytesSent == bytesToSend then
        local distribution = userArgs[1]
        local preset = userArgs[2]
        local silent = userArgs[3]
        --restore "Send" and "Live" button
        if TDT.liveSessionActive then
            TDT.main_frame.LiveSessionButton:SetText(L["*Live*"])
        else
            TDT.main_frame.LiveSessionButton:SetText(L["Live"])
            TDT.main_frame.LiveSessionButton.text:SetTextColor(1,0.8196,0)
            TDT.main_frame.LinkToChatButton:SetDisabled(false)
            TDT.main_frame.LinkToChatButton.text:SetTextColor(1,0.8196,0)
        end
        TDT.main_frame.LinkToChatButton:SetText(L["Share"])
        TDT.main_frame.LiveSessionButton:SetDisabled(false)
        TDT.main_frame.SendingStatusBar:Hide()
        --output chat link
        if not silent then
            local prefix = "[TrashDungeonTools: "
            local dungeon = TDT:GetDungeonName(preset.value.currentDungeonIdx)
            local presetName = preset.text
            local name, realm = UnitFullName("player")
            local fullName = name.."+"..realm
            SendChatMessage(prefix..fullName.." - "..dungeon..": "..presetName.."]",distribution)
            TDT:SetThrottleValues(true)
        end
    end
end

---generates a unique random 11 digit number in base64 and assigns it to a preset if it does not have one yet
---credit to WeakAuras2
function TDT:SetUniqueID(preset)
    if not preset.uid then
        local s = {}
        for i=1,11 do
            tinsert(s, bytetoB64[math.random(0, 63)])
        end
        preset.uid = table.concat(s)
    end
end

---SendToGroup
---Send current preset to group/raid
function TDT:SendToGroup(distribution,silent,preset)
    TDT:SetThrottleValues()
    preset = preset or TDT:GetCurrentPreset()
    --set unique id
    TDT:SetUniqueID(preset)
    --gotta encode mdi mode / difficulty into preset
    local db = TDT:GetDB()
    preset.mdiEnabled = db.MDI.enabled
    preset.difficulty = db.currentDifficulty
    local export = TDT:TableToString(preset,false,5)
    TDTcommsObject:SendCommMessage("TDTPreset", export, distribution, nil, "BULK",displaySendingProgress,{distribution,preset,silent})
end

---GetPresetSize
---Returns the number of characters the string version of the preset contains
function TDT:GetPresetSize(forChat,level)
    local preset = TDT:GetCurrentPreset()
    local export = TDT:TableToString(preset,forChat,level)
    return string.len(export)
end

local defaultCPS = tonumber(_G.ChatThrottleLib.MAX_CPS)
local defaultBURST = tonumber(_G.ChatThrottleLib.BURST)
function TDT:SetThrottleValues(default)
    if not _G.ChatThrottleLib then return end
    if default then
        _G.ChatThrottleLib.MAX_CPS = defaultCPS
        _G.ChatThrottleLib.BURST = defaultBURST
    else --4000/16000 is fine but we go safe with 2000/10000
        _G.ChatThrottleLib.MAX_CPS= 2000
        _G.ChatThrottleLib.BURST = 10000
    end
end
