if not(GetLocale() == "zhTW") then
  return
end
local addonName, TDT = ...
local L = TDT.L
L = L or {}

--@localization(locale="zhTW", format="lua_additive_table", namespace="TDT", handle-subnamespaces="none")@