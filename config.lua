Config = {}
Config.Locale            = 'nl' -- change to en or nl for now
Config.NotifyShowTime    = 5000
Config.MoneyFormat       = '€'  -- $ or € or your ond format
Config.UseSocietyAccount = true
Config.GradePayment      = 2
Config.MinOnLineDoktors  = 2 
Config.treatCost         = 2000
Config.spawnRadius       = 100
Config.Ped = {
    ['ambulance'] = {
        company      = "Eerste Hulp",
        name         = "Doktor bibber", 
        model        = "s_m_m_doctor_01",
        job          = 'ambulance', 
        vehicle      = "ambumicu",    
        colour       = 111,
        spawnRadius  = 100,              -- Default Value: 100
        drivingStyle = 786603,           -- Default Value: 786603
    },
}
