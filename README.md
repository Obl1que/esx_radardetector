# esx_radardetector

esx_radardetector is an ESX mod for Fivem, which detects speed cameras located around the map.

## Setup

Open config.lua and change all the preset coordinates to the coordinates all of your speed cameras are at. You can find these in esx_speedcamera -> client -> main.lua -> Speedcamera60Zone, Speedcamera80Zone and Speedcamera120Zone. Copy all locations from these arrays into esx_radardetector -> config.lua -> Config.allRadarLocations. To add to your server, move esx_radardetector to YOURSERVER/resources and start it in your server.cfg

### Radar Detector item.
Insert an item called 'radar_detector' into your items SQL database, and add it to a shop (usually ammunation) for a price like $1,500. Make sure the item is called 'radar_detector', otherwise it will not work.

## Usage
To use the radar detector, you must have the radar_detector item in your inventory, and you can either run  the '/detector' command, or use the item in an inventory HUD.