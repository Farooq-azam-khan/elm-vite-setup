module Types exposing (..)

import Browser.Navigation as Nav
import RemoteData exposing (RemoteData(..), WebData)
import Toasty
import Toasty.Defaults


type alias UserSettingsLocalStorage =
    { dark_mode : Bool }


type alias User =
    { id : String, name : String, email : String }


type alias Model =
    { local_version : Maybe String
    , server_version : WebData String
    , users : WebData (List String)
    , count : Int
    , key : Nav.Key
    , user_settings : UserSettingsLocalStorage
    , toasties : Toasty.Stack Toasty.Defaults.Toast
    }


init_model : Nav.Key -> Model
init_model key =
    { local_version = Nothing, server_version = NotAsked, users = NotAsked, user_settings = { dark_mode = True }, count = 0, key = key, toasties = Toasty.initialState }
