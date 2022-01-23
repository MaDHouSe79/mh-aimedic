local Translations = {
    error = {
        not_enough_money  = "U kunt zich geen medische behandeling veroorloven",
        only_when_dead    = "Dit kan alleen worden gebruikt als het dood is",
        to_many_medics    = "Er zijn te veel medici online",
        job_not_found     = "Error: no job %value found in shared files qbcore",
        unknow_error      = "Onbekende fout...",
    },
    success = {
        treatment_done    = "Uw behandeling is voltooid, u werd in rekening gebracht: %{value}",
    },
    info = {
        getting_treatment = "De dokter geeft je medische hulp",
        waiting_message   = "Je moet wachten totdat de dokter klaar is.",
    },
    
    mail = {
        ["sender"]        = "%{docter}",
        ["subject"]       = "Medische hulp",
        ["message"]       = "Hey, %{username}<br /><br />Een rekening voor Medische hulp!<br />Locatie: <strong>%{streetName}</strong><br /><br/><br/>Met vriendelijke groet,<br />%{company}",
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
