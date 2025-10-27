# DayZ
## Dedicated server
This image lets you run your own DayZ server in a docker container.<br>
It is easy to set up and configure; Actually you can run this image without providing a single configuration (other than volumes and ports), and it would run the default map Chernarus out of the box.<br>
You can change the map if you want, using ENV options, and can even use custom maps and mods if you would like to fo that.<br>

### Notice
This is the first time I am creating a docker image, so it may not be as optimized as it probably should be, but I will dig deeper into that, and try to perfect it over time.<br>
Also feel free to send me your suggestions, if you feel something should be different, but cannot promise I will implement them, depending on the proposal.<br>
It is an early version, and I am still working on testing and is going to run my own server on this image so that i can find bugs or something that needs changed myself, but feel free to use it at your own risk.

## Environment Variables
| Variable      | Default   | Required  | Description   |
| ---------     | --------  | --------- | ---------     |
| SERVER_PORT   | 2302      | Optional  | Sets the server port to be used for the game |
| DAYZ_HOSTNAME | My DayZ Server | Optional | |
| DAYZ_PASSWORD |  | Optional | |
| DAYZ_ADMIN_PASSWORD | admin123 | Optional | |
| DAYZ_DESCRIPTION | Welcome to my DayZ server! | Optional | |
| DAYZ_ENABLE_WHITELIST | 0 | Optional | |
| DAYZ_MAX_PLAYERS | 60 | Optional | |
| DAYZ_FORCE_SAME_BUILD | 1 | Optional | |
| DAYZ_DISABLE_VON | 0 | Optional | |
| DAYZ_VON_CODEC_QUALITY | 20 | Optional | |
| DAYZ_SHARD_ID | 123abc | Optional | |
| DAYZ_DISABLE_3RD_PERSON | 0 | Optional | |
| DAYZ_DISABLE_CROSSHAIR | 0 | Optional | |
| DAYZ_DISABLE_PERSONAL_LIGHT | 1 | Optional | |
| DAYZ_LIGHTING_CONFIG | 1 | Optional | |
| DAYZ_SERVER_TIME | SystemTime | Optional | |
| DAYZ_SERVER_TIME_ACCELERATION | 12 | Optional | |
| DAYZ_SERVER_NIGHT_TIME_ACCELERATION | 1 | Optional | |
| DAYZ_SERVER_TIME_PERSISTENT | 1 | Optional | |
| DAYZ_LOGIN_QUEUE_CONCURRENT_PLAYERS | 5 | Optional | |
| DAYZ_LOGIN_QUEUE_MAX_PLAYERS | 500 | Optional | |
| DAYZ_STORAGE_AUTO_FIX | 1 | Optional | |
| DAYZ_MISSION  | dayzOffline.chernarusplus | Optional | Defines the map played on the server. If the selected mission is not one of the available missions (see "Server missions" section), the missions folder will stay empty. |
| DAYZ_MODS |  | Optional | Names of the mods you want to add to the server as -mod, separated by ";", eg. DAYZ_MODS=@CF;@DF - The mods you enter here have to exist in the user-mods folder with the same folder name. |
| DAYZ_SERVER_MODS |  | Optional | Names of the mods you want to add to the server as -servermod, separated by ";", eg. DAYZ_MODS=@CF;@DF - The mods you enter here have to exist in the user-mods folder with the same folder name. |

## Server missions
Official regular server images are downloaded to the image and available for use.
Notice, that if you change any files in the mission folder, they will not be copied over again, unless you delete the entire folder and restart the container.

### Included maps
| Mission name | Map |
| ----------- | ----- |
| dayzOffline.chernarusplus | Chernarus |
| dayzOffline.sakhal | Frostline |
| dayzOffline.enoch | Livonia |

If you enter another name than any of these, the mpmissions folder will stay empty, and the server will fail to start unless you provide your own corresponding mission files. This is useful if you want to play a modded map.

## Mods
Mods support is added to the server, but you need to maintain the mods yourself, meaning you will need to download and keep the files updated yourself.<br>
<span style="color: orange; font-style: italic">Sorry, but this is due to the fact that Steam requires account login to download the files from Steam Workshop, and therefore would require you to provide your Steam login to the server, which would massivly overcomplicate things, not to mention the security aspects.</span>

Map the volume /server/user-mods:
```bash
-v /mods:/server/user-mods
```
Place your mod direcories in this folder.<br>
The folders you place in this folder will automatically be linked to the server folder, and if there is a keys folder inside, all keys will be copied to the servers keys folder.<br>
This is not enough though. You also need to register the mod to the server startup with the environmental variables "DAYZ_MODS" or "DAYZ_SERVER_MODS" depending if they should be registered using the -mod or -servermod parameter.
```bash
-e DAYZ_MODS=@mod1;@mod2
```
The mods you registere here needs to exist in the mods folder from before.