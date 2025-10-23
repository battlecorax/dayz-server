# DayZ
## Dedicated server
This image lets you run your own DayZ server in a docker container.<br>
It is easy to set up and configure.

## Steam user
It is sadly nessesary to provide both steam user and steam password to download the DayZ server.<br>
This means that if your account is protected by by an authenticator, you will need to authenticate every time the server restarts!
I have read, but not tested yet, that wyou can create a separate steam account and use that for your server.

## Environment Variables
| Variable      | Default   | Required  | Description   |
| ---------     | --------  | --------- | ---------     |
| STEAM_USERNAME |           | Yes       | The steam user used for downloading and updating the server through SteamCmd. |
| STEAM_PASSWORD |          | Yes       | The password for the steam user provided. |
| STEAM_GUARD   |           | Optional  | The steam guard code, unless Steam Guard is disabled on your account, or you are using mobile authenticator. |
| SERVER_DIR   | /dayz-server | Optional  | Defines the installation path of the dayz server |
| SERVER_PORT | 2302        | Optional  | Sets the server port to be used for the game |
| SERVER_ARGS   |           | Optional  | Any additional server arguments that should be passed to the server start command |
| DAYZ_MODS   |           | Optional  | Adds mods to your server. Mod identifiers sparated by ";" Eg. 12345678;23456789; |
| DAYZ_SERVER_MODS   |           | Optional  | Adds mods to your server. Like DAYZ_MODS, but used with server mod parameter. Mod identifiers sparated by ";" Eg. 12345678;23456789; |

## TODO
- Add support for mods
- Add support for server restarts and messages