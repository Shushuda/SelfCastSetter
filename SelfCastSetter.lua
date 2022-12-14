--------------------------------------------------------------------------------
-- global local vars
--------------------------------------------------------------------------------

local addonName, addonVars = ...

--------------------------------------------------------------------------------
-- event handler frame
--------------------------------------------------------------------------------

SelfCastSetter = CreateFrame("Frame")

--------------------------------------------------------------------------------
-- slash commands
--------------------------------------------------------------------------------

function SelfCastSetter:ExecuteCommand(pCommand)
    local startIndex, endIndex, command, parameter = string.find(pCommand, "(%w+) ?(.*)")

    if not command then
        self:help(self, parameter)
        return
    end

    command = command:lower()

    if self[command] then
        self[command](self, parameter)
    end
end

function SelfCastSetter:help()
    addonVars:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/scs help"..NORMAL_FONT_COLOR_CODE..": Shows this list")
    addonVars:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/scs enable"..NORMAL_FONT_COLOR_CODE..": Enables self casting on the current spec")
    addonVars:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/scs disable"..NORMAL_FONT_COLOR_CODE..": Disables self casting on the current spec")
    addonVars:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/scs show"..NORMAL_FONT_COLOR_CODE..": Shows the saved setting for the current spec")
end

function SelfCastSetter:enable(parameter)
    self:setSelfCasting(true)
end

function SelfCastSetter:disable(parameter)
    self:setSelfCasting(false)
end

function SelfCastSetter:show(parameter)
    self:showSelfCasting()
end

--------------------------------------------------------------------------------
-- local vars
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- local functions
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- class methods
--------------------------------------------------------------------------------

-- generate defaults for db
function SelfCastSetter:generateDefaults()

    self.defaults = {
    }
end

function SelfCastSetter:setSelfCasting(enable)
    local specID, specName, _, _, _ = GetSpecializationInfo(GetSpecialization())

    self.db[specID] = enable

    self:handleSpecChange(specID, specName)
end

function SelfCastSetter:showSelfCasting()
    local specID, specName, _, _, _ = GetSpecializationInfo(GetSpecialization())

    selfCast = self.db[specID]

    if selfCast ~= nil then
        addonVars:NoteMessage(NORMAL_FONT_COLOR_CODE..": Self casting on "..specName.." set to "..tostring(selfCast))
    else
        addonVars:NoteMessage(NORMAL_FONT_COLOR_CODE..": No saved setting for "..specName)
    end
end

--------------------------------------------------------------------------------
-- event handler methods
--------------------------------------------------------------------------------

function SelfCastSetter:handleSpecChange(specID, specName)
    local enable = self.db[specID]

    if enable ~= nil then
        local selfCast
        if enable then
            selfCast = 1
        else
            selfCast = 0
        end

        SetCVar("autoSelfCast", selfCast)

        addonVars:NoteMessage(NORMAL_FONT_COLOR_CODE..": Self casting set to "..tostring(enable).."!")
    else
        addonVars:NoteMessage(NORMAL_FONT_COLOR_CODE..": No self casting settings for "..specName.."!")
    end
end

--------------------------------------------------------------------------------
-- event handler event methods
--------------------------------------------------------------------------------

function SelfCastSetter:OnEvent(event, ...)
	self[event](self, event, ...)
end

function SelfCastSetter:ADDON_LOADED(event, addOnName)
	if addOnName == addonName then
        print(addOnName, "loaded. Type /scs for help.")

        -- initialize saved variables
        SelfCastSetterDB = SelfCastSetterDB or {}
        self.db = SelfCastSetterDB

        self:generateDefaults()

        for key, value in pairs(self.defaults) do
            if self.db[key] == nil then
                self.db[key] = value
            end
        end

        -- slash commands
        SlashCmdList.SELFCASTSETTER = function (...) SelfCastSetter:ExecuteCommand(...) end
        SLASH_SELFCASTSETTER1, SLASH_SELFCASTSETTER2 = "/scs", "/selfcastsetter"

        self:UnregisterEvent(event)
    end
end

function SelfCastSetter:ACTIVE_PLAYER_SPECIALIZATION_CHANGED(event, ...)
    local specID, specName, _, _, _ = GetSpecializationInfo(GetSpecialization())

    self:handleSpecChange(specID, specName)
end

--------------------------------------------------------------------------------
-- register events and listen
--------------------------------------------------------------------------------

SelfCastSetter:RegisterEvent("ADDON_LOADED")
SelfCastSetter:RegisterEvent("ACTIVE_PLAYER_SPECIALIZATION_CHANGED")


SelfCastSetter:SetScript("OnEvent", SelfCastSetter.OnEvent)
