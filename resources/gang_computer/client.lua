local QBCore = exports['qb-core']:GetCoreObject()
local computerEntity

local function loadModel(model)
    if not IsModelInCdimage(model) then return false end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
    return true
end

local function createComputer()
    if computerEntity and DoesEntityExist(computerEntity) then
        return
    end

    if not loadModel(Config.Computer.model) then
        print('[gang_computer] Unable to load computer model')
        return
    end

    local coords = Config.Computer.coords
    local heading = Config.Computer.heading or 0.0

    computerEntity = CreateObjectNoOffset(Config.Computer.model, coords.x, coords.y, coords.z, false, false, false)
    SetEntityHeading(computerEntity, heading)
    FreezeEntityPosition(computerEntity, true)
    SetEntityInvincible(computerEntity, true)

    exports['qb-target']:AddTargetEntity(computerEntity, {
        options = {
            {
                icon = 'fa-solid fa-computer',
                label = 'فتح كمبيوتر العصابة',
                action = function()
                    TriggerServerEvent('gang-computer:server:requestAccess')
                end
            }
        },
        distance = 1.5
    })
end

local function removeComputer()
    if computerEntity and DoesEntityExist(computerEntity) then
        exports['qb-target']:RemoveTargetEntity(computerEntity)
        DeleteEntity(computerEntity)
        computerEntity = nil
    end
end

CreateThread(function()
    createComputer()
end)

RegisterNetEvent('gang-computer:client:open', function(data)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        gang = data.gang,
        rank = data.rank,
        intel = data.intel or {},
        items = Config.DesktopItems,
        dispatch = data.dispatch or {}
    })
    PlaySoundFrontend(-1, 'NAV_UP_DOWN', 'HUD_FRONTEND_DEFAULT_SOUNDSET', true)
end)

RegisterNetEvent('gang-computer:client:accessDenied', function()
    QBCore.Functions.Notify('لا تملك صلاحية الوصول إلى هذا الجهاز.', 'error')
    PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', true)
end)

RegisterNetEvent('gang-computer:client:openStash', function()
    TriggerEvent('inventory:client:OpenStash', 'gang_computer_stash')
end)

RegisterNetEvent('gang-computer:client:openDispatch', function()
    TriggerEvent('chat:addMessage', {
        color = {255, 0, 125},
        multiline = true,
        args = {'Gang Dispatch', table.concat(Config.DispatchExamples, '\n')}
    })
end)

RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
    cb('ok')
end)

RegisterNUICallback('useItem', function(data, cb)
    local item = data and data.id and data.id
    if not item then
        cb('invalid')
        return
    end

    for _, desktopItem in ipairs(Config.DesktopItems) do
        if desktopItem.id == item and desktopItem.event and desktopItem.event ~= '' then
            TriggerEvent(desktopItem.event)
            break
        end
    end

    cb('ok')
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    removeComputer()
end)
