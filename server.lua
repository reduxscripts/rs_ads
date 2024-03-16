local Core = exports[Config.FW]:GetCoreObject()

function IsPlayerInJob(source, jobNames)
    local user = Core.Functions.GetPlayer(source)
    if user ~= nil then
        for _, jobName in ipairs(jobNames) do
            if user.PlayerData.job.name == jobName then
                return true
            end
        end
    end
    return false
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
