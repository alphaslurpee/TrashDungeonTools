local TDT = TDT
local L = TDT.L
local TDTcommsObject = TDTcommsObject
local twipe,tinsert = table.wipe,table.insert

local timer
local requestTimer
---LiveSession_Enable
function TDT:LiveSession_Enable()
    if self.liveSessionActive then return end
    self.main_frame.LiveSessionButton:SetText(L["*Live*"])
    self.main_frame.LiveSessionButton.text:SetTextColor(0,1,0)
    self.main_frame.LinkToChatButton:SetDisabled(true)
    self.main_frame.LinkToChatButton.text:SetTextColor(0.5,0.5,0.5)
    self.main_frame.sidePanelDeleteButton:SetDisabled(true)
    self.main_frame.sidePanelDeleteButton.text:SetTextColor(0.5,0.5,0.5)
    self.liveSessionActive = true
    --check if there is other clients having live mode active
    self:LiveSession_RequestSession()
    --set id here incase there is no other sessions
    self:SetUniqueID(self:GetCurrentPreset())
    self.livePresetUID = self:GetCurrentPreset().uid
    self:UpdatePresetDropdownTextColor()
    self:SetThrottleValues()
    timer = C_Timer.NewTimer(2, function()
        self.liveSessionRequested = false
        local distribution = self:IsPlayerInGroup()
        local preset = self:GetCurrentPreset()
        local prefix = "[TDTLive: "
        local dungeon = self:GetDungeonName(preset.value.currentDungeonIdx)
        local presetName = preset.text
        local name, realm = UnitFullName("player")
        local fullName = name.."+"..realm
        SendChatMessage(prefix..fullName.." - "..dungeon..": "..presetName.."]",distribution)
    end)
end

---LiveSession_Disable
function TDT:LiveSession_Disable()
    local widget = TDT.main_frame.LiveSessionButton
    widget.text:SetTextColor(widget.normalTextColor.r,widget.normalTextColor.g,widget.normalTextColor.b)
    widget.text:SetText(L["Live"])
    TDT.main_frame.LinkToChatButton:SetDisabled(false)
    self.main_frame.LinkToChatButton.text:SetTextColor(1,0.8196,0)
    local db = TDT:GetDB()
    if db.presets[db.currentDungeonIdx][1] == TDT:GetCurrentPreset() then
        TDT.main_frame.sidePanelDeleteButton:SetDisabled(true)
        TDT.main_frame.sidePanelDeleteButton.text:SetTextColor(0.5,0.5,0.5)
    else
        self.main_frame.sidePanelDeleteButton:SetDisabled(false)
        self.main_frame.sidePanelDeleteButton.text:SetTextColor(1,0.8196,0)
    end
    self.liveSessionActive = false
    self.liveSessionAcceptingPreset = false
    self:UpdatePresetDropdownTextColor()
    self.main_frame.liveReturnButton:Hide()
    self.main_frame.setLivePresetButton:Hide()
    if timer then timer:Cancel() end
    self.liveSessionRequested = false
    self.main_frame.SendingStatusBar:Hide()
    self:SetThrottleValues(true)
    if self.main_frame.LoadingSpinner then
        self.main_frame.LoadingSpinner:Hide()
        self.main_frame.LoadingSpinner.Anim:Stop()
    end
end

---Notify specific group member that my live session is active
local lastNotify
function TDT:LiveSession_NotifyEnabled()
    local now = GetTime()
    if not lastNotify or lastNotify < now - 0.2 then
        lastNotify = now
        local distribution = self:IsPlayerInGroup()
        if (not distribution) or (not self.liveSessionActive) then return end
        local uid = self.livePresetUID
        TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.enabled, uid, distribution, nil, "ALERT")
    end
    --self:SendToGroup(self:IsPlayerInGroup(),true,self:GetCurrentLivePreset())
end

---Send a request to the group to send notify messages for active sessions
function TDT:LiveSession_RequestSession()
    local distribution = self:IsPlayerInGroup()
    if (not distribution) or (not self.liveSessionActive) then return end
    self.liveSessionRequested = true
    self.liveSessionActiveSessions = self.liveSessionActiveSessions or {}
    twipe(self.liveSessionActiveSessions)
    TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.request, "0", distribution, nil, "ALERT")
end


function TDT:LiveSession_SessionFound(fullName, uid)
    local fullNamePlayer,realm = UnitFullName("player")
    fullNamePlayer = fullNamePlayer.."-"..realm

    if (not self.liveSessionAcceptingPreset) and fullNamePlayer ~= fullName then
        if timer then timer:Cancel() end
        self.liveSessionAcceptingPreset = true
        --request the preset from one client only after a short delay
        --we have to delay a bit to catch all active clients
        requestTimer = C_Timer.NewTimer(0.5, function()
            if self.liveSessionActiveSessions[1][1] ~= fullNamePlayer then
                self.main_frame.SendingStatusBar:Show()
                self.main_frame.SendingStatusBar:SetValue(0/1)
                self.main_frame.SendingStatusBar.value:SetText(L["Receiving: ..."])
                if not self.main_frame.LoadingSpinner then
                    self.main_frame.LoadingSpinner = CreateFrame("Button", "TDTLoadingSpinner", self.main_frame, "LoadingSpinnerTemplate")
                    self.main_frame.LoadingSpinner:SetPoint("CENTER",self.main_frame,"CENTER")
                    self.main_frame.LoadingSpinner:SetSize(60,60)
                end
                self.main_frame.LoadingSpinner:Show()
                self.main_frame.LoadingSpinner.Anim:Play()
                self:UpdatePresetDropdownTextColor(true)

                self.liveSessionRequested = false
                self:LiveSession_RequestPreset(self.liveSessionActiveSessions[1][1])
                self.livePresetUID = self.liveSessionActiveSessions[1][2]
            else
                self.liveSessionAcceptingPreset = false
                self.liveSessionRequested = false
            end
        end)
    end
    --catch clients
    tinsert(self.liveSessionActiveSessions,{fullName,uid})
end

function TDT:LiveSession_RequestPreset(fullName)
    local distribution = self:IsPlayerInGroup()
    if (not distribution) or (not self.liveSessionActive) then return end
    TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.reqPre, fullName, distribution,nil, "ALERT")
end

---Sends a map ping
function TDT:LiveSession_SendPing(x, y, sublevel)
    --only send ping if we are in the livesession preset
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            local scale = self:GetScale()
            TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.ping, x*(1/scale)..":"..y*(1/scale)..":"..sublevel, distribution, nil, "ALERT")
        end
    end
end

---Sends a preset object
function TDT:LiveSession_SendObject(obj)
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            local export = TDT:TableToString(obj,false,5)
            TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.obj, export, distribution, nil, "ALERT")
        end
    end
end

---Sends updated object offsets (move object)
function TDT:LiveSession_SendObjectOffsets(objIdx, x, y)
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.objOff, objIdx..":"..x..":"..y, distribution, nil, "ALERT")
        end
    end
end

---Sends updated objects - instead of sending an update every time we erase a part of an object we send one message after mouse up
function TDT:LiveSession_SendUpdatedObjects(changedObjects)
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            local export = TDT:TableToString(changedObjects,false,5)
            TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.objChg, export, distribution, nil, "ALERT")
        end
    end
end

---Sends various commands: delete all drawings, clear preset, undo, redo
function TDT:LiveSession_SendCommand(cmd)
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.cmd, cmd, distribution, nil, "ALERT")
        end
    end
end

---Sends a note text update
function TDT:LiveSession_SendNoteCommand(cmd, noteIdx, text, y)
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            text = text..":"..(y or "0")
            TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.note, cmd..":"..noteIdx..":"..text, distribution, nil, "ALERT")
        end
    end
end

---Sends a new preset to be used as the new live session preset
function TDT:LiveSession_SendPreset(preset)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        local db = self:GetDB()
        preset.mdiEnabled = db.MDI.enabled
        preset.difficulty = db.currentDifficulty
        local export = TDT:TableToString(preset,false,5)
        TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.preset, export, distribution, nil, "ALERT")
    end
end

---Sends all pulls
function TDT:LiveSession_SendPulls(pulls)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        local msg = TDT:TableToString(pulls,false,5)
        TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.pull, msg, distribution, nil, "ALERT")
    end
end

---Sends Affix Week Change
function TDT:LiveSession_SendAffixWeek(week)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.week, week.."", distribution, nil, "ALERT")
    end
end

---Sends freehold selector updates
function TDT:LiveSession_SendFreeholdSelector(value, week)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        value = value and "T:" or "F:"
        local msg = value..week
        TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.free, msg, distribution, nil, "ALERT")
    end
end

---sends boralus selector updates
function TDT:LiveSession_SendBoralusSelector(faction)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        local msg = faction..""
        TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.bora, msg, distribution, nil, "ALERT")
    end
end

---Sends MDI selector updates
function TDT:LiveSession_SendMDI(action, data)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        local msg = action..":"..data
        TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.mdi, msg, distribution, nil, "ALERT")
    end
end

do
    local timer
    ---LiveSession_QueueColorUpdate
    ---Disgusting workaround for shitty colorpicker
    ---Only send an update once a color of a pull has not changed for 0.2 seconds
    function TDT:LiveSession_QueueColorUpdate()
        if timer then timer:Cancel() end
        timer = C_Timer.NewTimer(0.2, function()
            self:LiveSession_SendPulls(self:GetPulls())
        end)
    end
end

---Sends Corrupted NPC Offset Positions
function TDT:LiveSession_SendCorruptedPositions(offsets)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        local export = TDT:TableToString(offsets,false,5)
        TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.corrupted, export, distribution, nil, "ALERT")
    end
end

---Sends current difficulty
function TDT:LiveSession_SendDifficulty()
    local distribution = self:IsPlayerInGroup()
    if distribution then
        local export = self:GetDB().currentDifficulty
        TDTcommsObject:SendCommMessage(self.liveSessionPrefixes.difficulty, export.."", distribution, nil, "ALERT")
    end
end