Config = {}
Config.Locale            = 'nl'    -- change to en or nl for now
Config.NotifyShowTime    = 5000
Config.MoneyFormat       = '€'  -- $ or € or your ond format
Config.UseSocietyAccount = true
Config.GradePayment      = 2
Config.MinOnLineDoktors  = 2 
Config.treatCost         = 2000
Config.spawnRadius       = 100

Config.Ped = {
    ['ambulance'] = {
        company      = "Eerste Hulp",      -- company name used for sending mails
        name         = "Doktor bibber",    -- The name of the docter using for sending mail
        model        = "s_m_m_doctor_01",  -- The model bed to spawn...
        job          = 'ambulance',        -- Not active tet...
        vehicle      = "ambumicu",         -- Not active tet...    
        colour       = 111,                -- Not active tet...
        spawnRadius  = 100,                -- Default Value: 100
        drivingStyle = 786603,             -- Default Value: 786603
    },
}
