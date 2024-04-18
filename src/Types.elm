module Types exposing (..) 

import Toasty
import Toasty.Defaults
import RemoteData exposing (RemoteData(..))
import Browser.Navigation as Nav
import RemoteData exposing (WebData)
import Browser.Navigation as Nav 

type alias  UserSettingsLocalStorage  = {dark_mode:Bool}
type alias User = {id: String, name: String, email: String}


type alias Model =
    { users : WebData (List String)
    , count : Int
    , key : Nav.Key 
    , user_settings: UserSettingsLocalStorage
    , toasties : Toasty.Stack Toasty.Defaults.Toast
    
    }

init_model : Nav.Key -> Model 
init_model key = { users = NotAsked, user_settings = {dark_mode=True}, count = 0, key = key, toasties = Toasty.initialState } 
