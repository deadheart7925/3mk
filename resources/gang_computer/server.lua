local QBCore = exports['qb-core']:GetCoreObject()

local function isGangAllowed(gangName)
    if not gangName then return false end
    return Config.AllowedGangs[gangName] or false
end

RegisterNetEvent('gang-computer:server:requestAccess', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    local gangData = Player.PlayerData.gang or {}
    local gangName = gangData.name
    if not isGangAllowed(gangName) then
        TriggerClientEvent('gang-computer:client:accessDenied', src)
        return
    end

    local intel = Config.IntelFeed[gangName] or Config.IntelFeed.default or {}

    TriggerClientEvent('gang-computer:client:open', src, {
        gang = gangData.label or gangName or 'Unknown',
        rank = gangData.grade and gangData.grade.name or 'Recruit',
        intel = intel,
        dispatch = Config.DispatchExamples
    })
end)
