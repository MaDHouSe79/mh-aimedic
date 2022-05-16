Config = {}
Config.Locale            = 'nl'                -- Change to en or nl for now
Config.NotifyShowTime    = 5000                -- All notivication display time on screen (5000 is 5 secs)
Config.MoneyFormat       = '€'                 -- $ or € or your ond format
Config.UseSocietyAccount = true                -- With true the Society Account gets the money.
Config.GradePayment      = 2                   -- Not active yet
Config.MinOnLineDoktors  = 2                   -- How many ambulance jobs have to be online to make this work, you can set this to 0 if you have a huge server and les time to get to players.
Config.treatCost         = 2000                -- The treat costs (change if needed)
Config.spawnRadius       = 100                 -- Not active yet


Config.Ped = {
    ['ambulance'] = {
        command          = "ambulance",        -- command.
        company          = "Eerste Hulp",      -- The Company name used for sending mails
        name             = "Doktor bibber",    -- The name of the docter using for sending mail
        model            = "s_m_m_doctor_01",  -- The model bed to spawn...
        job              = 'ambulance',        -- Not active yet...
        vehicle          = "ambulance",         -- Not active yet...    
        colour           = 111,                -- Not active yet...
        spawnRadius      = 100,                -- Default Value: 100
        drivingStyle     = 786603,             -- Default Value: 786603
    },
}
