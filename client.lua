local ui = false
local display = false

-- funcs

function UI()

    if not ui then 
        SetDisplay(true)       
    else 
        SetDisplay(not ui)
    end

end

RegisterCommand('alert', function()

    UI()
end)

function SetDisplay(bool)

    display = bool
    SendNUIMessage({
        type = "open",
        status = bool
        
    }) 
end

-- events

RegisterNUICallback("exit", function(data)

    SendNUIMessage({
        type = "close",
        status = bool,
        
    })
    SetDisplay(false)
end)




-- MAGIC HAPPENS HERE

RegisterNetEvent('SendAlert', function()

    local input = lib.inputDialog(Language.UI, {
        {type = 'input', label = Language.Title, description = Language.EnterTitle, required = true},
        {type = 'input', label = Language.Description, description = Language.EnterDescription, icon = 'hashtag', required = true},

    
    })
    TriggerEvent('SendAd', input[1], input[2])
end)

RegisterNetEvent('SendAd', function(title, text)

    SendNUIMessage({
        type = "sendAlert",
        title = title,
        text = text,

        
    })
    UI()
end)


