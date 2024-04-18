module Types exposing (..) 

import Browser.Navigation as Nav
import RemoteData exposing (WebData)

type alias  UserSettingsLocalStorage  = {dark_mode:Bool}
type alias User = {id: String, name: String, email: String}


type alias Model =
    { users : WebData (List String), count : Int, key : Nav.Key }


