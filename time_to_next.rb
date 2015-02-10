require 'openssl'
require 'geokit'
require 'timezone'
require 'nearest_time_zone'


def get_time(city)
    res = Geokit::Geocoders::GoogleGeocoder.geocode(city)
    timezone = Timezone::Zone.new :zone => NearestTimeZone.to(res.lat, res.lng)  
    
    next_date = timezone.time_with_offset(Time.new(2015, 02, 11, 22))
    
    rest = next_date - timezone.time_with_offset(Time.now)
    mm, ss = rest.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    
    return "Our next meetup will take place at #{next_date.strftime("%F %H:%M")} (your timezone) - only %d day, %d hours and %d minutes left :thumbsup:" % [dd, hh, mm]
end