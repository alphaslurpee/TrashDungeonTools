if not(GetLocale() == "zhCN") then
  return
end
local addonName, TDT = ...
local L = TDT.L
L = L or {}

--@localization(locale="zhCN", format="lua_additive_table", namespace="TDT", handle-subnamespaces="none")@