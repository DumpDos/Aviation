# Format JSON #

# Import #



# Variables #
local.url_ntp_form = {get.hourform="pool.ntp.org"}
local.time = {jsonform =[^.]local.url_ntp_form}
local.aircraft_list = {Lastdv}

# Mise en forme temps #
time = getAvailableLocales(js.hour.format:"HH:MM:SS", js.date.format:"DD/MM/YYYY")
local gmt.time = js.GetForm(hour)
local gmt.date = js.date.format

# Parse code JSON #

JSON.parse = 
