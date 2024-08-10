module Main exposing (main)

import Actions exposing (..)
import Api exposing (..)
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import RemoteData exposing (RemoteData(..))
import ToastMessages exposing (..)
import Toasty
import Toasty.Defaults
import Types exposing (..)
import Url exposing (Url)


view : Model -> Browser.Document Msg
view model =
    { title = "counter"
    , body =
        [ div
            [ class "mx-5 sm:mx-0 sm:mx-auto lg sm:max-w-xl lg:max-w-3xl mt-10 space-x-10" ]
            [ h3 [ class "flex space-x-5 py-3" ]
                [ span []
                    [ case model.server_version of
                        Loading ->
                            text "server version: loading version..."

                        NotAsked ->
                            text "server version: not asked"

                        Success version ->
                            text <| "server version: " ++ version

                        Failure _ ->
                            text <| "server version: failed to get version"
                    ]
                , span []
                    [ case model.local_version of
                        Nothing ->
                            text "local version: not stored yet"

                        Just version ->
                            text <| "local version: " ++ version
                    ]
                ]
            , button [ class "bg-black px-5 py-1 text-white rounded-md", onClick Decrement ] [ text "-" ]
            , span [] [ model.count |> String.fromInt |> text ]
            , button [ class "bg-black px-5 py-1 text-white rounded-md", onClick Increment ] [ text "+" ]
            , div [ class "mt-10" ]
                [ button [ class "bg-gray-300 px-5 py-4 text-gray-800 rounded-md", onClick GetUsers ]
                    [ text "Get Users" ]
                , case model.users of
                    NotAsked ->
                        div [] [ text "Not asked to get users" ]

                    Loading ->
                        div [] [ text "Loading users" ]

                    Success userlist ->
                        ol [] (List.map (\user -> li [] [ text user ]) userlist)

                    Failure _ ->
                        div [] [ text "an unknown error occured fetching users" ]
                ]
            ]
        , Toasty.view toast_config Toasty.Defaults.view ToastyMsg model.toasties
        ]
    }


type alias Flags =
    { local_version : Maybe String }


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        _ =
            Debug.log "flags in elm" flags

        _ =
            Debug.log "url in elm" url
    in
    ( init_model key |> (\m -> { m | local_version = flags.local_version, server_version = Loading }), api_get_version Version )


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }
