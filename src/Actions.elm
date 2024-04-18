module Actions exposing (..)
import Api exposing (..)
import Browser
import Browser.Navigation as Nav
import Http
import Ports
import RemoteData exposing (RemoteData(..), WebData)
import Route exposing (..)
import Time exposing (Month(..))
import ToastMessages exposing (..)
import Toasty
import Toasty.Defaults
import Types exposing (..)
import Url exposing (Url)
import Utils exposing (..)

type Msg
    = Increment
    | GetUsers
    | UserMsg (WebData (List String))
    | Decrement
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetUsers ->
            ( { model | users = Loading }, get_users_api UserMsg )

        UserMsg users ->
            ( { model | users = users }, Cmd.none )

        Increment ->
            ( { model | count = model.count |> update_by 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count  |> update_by (-1) }, Cmd.none )

        ChangedUrl url ->
            ( model, Cmd.none )

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.External href ->
                    ( model, Nav.load href )

                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



