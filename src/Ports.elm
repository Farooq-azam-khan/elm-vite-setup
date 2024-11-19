port module Ports exposing (..)

import Types exposing (..)


port save_user_settings_to_local_storage : UserSettingsLocalStorage -> Cmd msg


port save_version_to_local_storage : String -> Cmd msg


port hard_refresh : () -> Cmd msg
