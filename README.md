# DayZ
## Dedicated server
This image lets you run your own DayZ server in a docker container.<br>
It is easy to set up and configure.

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