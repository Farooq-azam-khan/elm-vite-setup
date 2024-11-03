module Types exposing (..)

import Browser.Navigation as Nav
import RemoteData exposing (RemoteData(..), WebData)
import Route exposing (..)
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
    , route : Route
    , user_settings : UserSettingsLocalStorage
    , toasties : Toasty.Stack Toasty.Defaults.Toast
    }


init_model : Nav.Key -> Route -> Model
init_model key route =
    { local_version = Nothing
    , route = route
    , server_version = NotAsked
    , users = NotAsked
    , user_settings = { dark_mode = True }
    , count = 0
    , key = key
    , toasties = Toasty.initialState
    }
