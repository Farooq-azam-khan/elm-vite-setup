module Types exposing (..)

import Browser.Navigation as Nav
import RemoteData exposing (RemoteData(..), WebData)
import Route exposing (..)
import Toasty
import Toasty.Defaults
import UI.Dialog exposing (DialogModel, init_dialog_model)
import UI.DropdownMenu exposing (DropdownMenuModel, init_dropdown_menu_model)


type alias UserSettingsLocalStorage =
    { dark_mode : Bool }


type alias User =
    { id : String, name : String, email : String }


type alias Model =
    { local_version : Maybe String
    , server_version : WebData String
    , users : WebData (List String)
    , user_profile_dialog : DialogModel
    , user_dropdown_menu : DropdownMenuModel
    , count : Int
    , route : Route
    , user_settings : UserSettingsLocalStorage
    , toasties : Toasty.Stack Toasty.Defaults.Toast
    }

init_model2 : Route -> Model
init_model2 route =
    { local_version = Nothing
    , route = route
    , server_version = NotAsked
    , users = NotAsked
    , user_profile_dialog = init_dialog_model "user-profile-dialog"
    , user_dropdown_menu = init_dropdown_menu_model "user-dropdown-menu"
    , user_settings = { dark_mode = True }
    , count = 0
    , toasties = Toasty.initialState
    }

{-
init_model : Nav.Key -> Route -> Model
init_model key route =
    { local_version = Nothing
    , route = route
    , server_version = NotAsked
    , users = NotAsked
    , user_profile_dialog = init_dialog_model "user-profile-dialog"
    , user_dropdown_menu = init_dropdown_menu_model "user-dropdown-menu"
    , user_settings = { dark_mode = True }
    , count = 0
    , key = key
    , toasties = Toasty.initialState
    }
-}
