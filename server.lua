local Core = exports[Config.FW]:GetCoreObject()

function IsPlayerInJob(source, jobNames)
    local user = Core.Functions.GetPlayer(source)
    if user then
        for _, jobName in ipairs(jobNames) do
            if user.PlayerData.job.name == jobName then
                return true
            end
        end
    end
    return false
end

function GetPlayerJobName(source)
    local user = Core.Functions.GetPlayer(source)
    if user then 
        return user.PlayerData.job.name
    else 
        return nil 
    end
end

-- Command with job checking
Core.Commands.Add(Config.Command, Language.UI, {}, false, function(source)
    local jobName = Config.Jobs
    if IsPlayerInJob(source, jobName) then
        TriggerClientEvent('SendAlert', source)
    else
        if Config.CustomNotify then
            TriggerClientEvent('DoLongHudText', source, Language.Nojob, "error")
        else 
            TriggerClientEvent('chatMessage', source, Language.Error)
        end
    end
end, 'user')

RegisterServerEvent('SendAlert:Server')
AddEventHandler('SendAlert:Server', function(title, text)
    local curjobname = GetPlayerJobName(source)

    if curjobname then
        for _, v in ipairs(Core.Functions.GetPlayers()) do
            local Player = Core.Functions.GetPlayer(v)
            if Player and Player.PlayerData.job.name == curjobname and Player.PlayerData.job.onduty then
                TriggerClientEvent('SendAd', v, title, text)
            end
        end
        for _, v in ipairs(Core.Functions.GetPlayers()) do
            local Player = Core.Functions.GetPlayer(v)
            if Player and not Player.PlayerData.job.name then
                TriggerClientEvent('SendAd', v, title, text)
            end
        end
    end
end)

