# Dinesafe Toronto API - fork for Chrome extension

## Overview

This is a fork of [nomatteus/dinesafe](https://github.com/nomatteus/dinesafe). 

The original project served as a backend for an iOS app. This fork is intended to serve as a backend for a Chrome extension.

Please see `README.upstream.md` for more information from the original author.

## First run

```
createuser --superuser dinesafe_dev
rake db:drop
rake db:create

# n.b. running migrate will cause error (SP is defined twice?)
#   schema:load is for .rb files;
#   structure:load is for .sql files
# -> has to be stored in SQL because of stored-procs
rake db:structure:load

# downloads XML from city opendata site
rake dinesafe:update_xml

# populate database from XML
# this takes about ~20 minutes on my laptop
rake dinesafe:xml_import

# n.b. since Geocode table is empty, this is currently a no-op
rake dinesafe:geocode

# parses latlng out from Geocode.json into Establishment.latlng
#  (but there is 0 Geocode records, on first run)
# also creates Geocode records where they don't already exist
rake dinesafe:update_latlngs

# hits Google Maps for all Geocode records, populates json
# Rate-throttled. takes forever, needs to be run multiple times 
# (over several 24h periods, or from multiple IPs)
rake dinesafe:geocode

# now this copy job (Geocode -> Establishment) will in fact work
rake dinesafe:update_latlngs

```

