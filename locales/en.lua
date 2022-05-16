local Translations = {
    error = {
        not_enough_money  = "You can't afford medical treatment",
        only_when_dead    = "This can only be used when dead",
        to_many_medics    = "There are too many medics online",
        job_not_found     = "Error: no job %value found in job shared files of qbcore",
        unknow_error      = "Unknow error...",
    },
    success = {
        treatment_done    = "Your treatment is done, you were charged: %{value}",
    },
    info = {
        getting_treatment = "The doctor is giving you medical aid",
        waiting_message   = "You must wait until the doctor is ready",
    },
    mail = {
        sender            = "%{doctor}",
        subject           = "Medical assistance",
        message           = "Hey, %{username}<br /><br />An invoice for Medical assistance!<br />Location: <strong>Garage %{streetName}</strong><br /><br/><br/>Kind regard,<br />%{company}",
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
