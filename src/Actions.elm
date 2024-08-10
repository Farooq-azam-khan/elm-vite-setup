module Actions exposing (..)

import Api exposing (..)
import Browser
import Browser.Navigation as Nav
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
    = Version (WebData String)
    | Increment
    | GetUsers
    | ToastyMsg (Toasty.Msg Toasty.Defaults.Toast)
    | UserMsg (WebData (List String))
    | Decrement
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Version (Success server_version) ->
            let
                is_local_version_out_of_date =
                    Maybe.withDefault "" model.local_version /= server_version
            in
            if is_local_version_out_of_date then
                ( { model | server_version = Success server_version }, Cmd.batch [ Ports.save_version_to_local_storage server_version, Ports.hard_refresh () ] )

            else
                ( { model | server_version = Success server_version }, Cmd.none )

        Version version_wd ->
            ( { model | server_version = version_wd }, Cmd.none )

        ToastyMsg subMsg ->
            Toasty.update toast_config ToastyMsg subMsg model

        GetUsers ->
            ( { model | users = Loading }, get_users_api UserMsg )

        UserMsg users ->
            ( { model | users = users }, Cmd.none )
                |> addPersistantToast ToastyMsg (Toasty.Defaults.Success "Update!" "got users")

        Increment ->
            ( { model | count = model.count |> update_by 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count |> update_by -1 }, Cmd.none )

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
