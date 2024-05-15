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
        {type = 'textarea', label = Language.Description, description = Language.EnterDescription, icon = 'hashtag', required = true, autosize = true},

    
    })

    

    if input then
        local title = input[1]

        local text = input[2]
        TriggerServerEvent('SendAlert:Server', title, text)
    else 
        return end 
    
end)



-- For server side trigger
RegisterNetEvent('SendAd', function(title, text)

    SendNUIMessage({
        type = "sendAlert",
        title = title,
        text = text,

        
    })
    UI()
end)


