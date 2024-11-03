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
import UI.Button as Button
import UI.Card as Card
import Url exposing (Url)


view : Model -> Browser.Document Msg
view model =
    { title = "counter"
    , body =
        [ div
            [ class "mx-5 sm:mx-0 sm:mx-auto lg sm:max-w-xl lg:max-w-3xl mt-10 space-x-10" ]
            [ Card.card []
                [ Card.card_header []
                    [ Card.card_title [ class "flex space-x-5 py-3" ]
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
                    ]
                , Card.card_content
                    []
                    [ div []
                        [ Button.button { variant = Button.DefaultVariant, size = Button.Icon } [ onClick Decrement ] [ text "-" ]
                        , span [] [ model.count |> String.fromInt |> text ]
                        , Button.button { variant = Button.DefaultVariant, size = Button.Icon } [ onClick Increment ] [ text "+" ]
                        ]
                    , div [ class "mt-10" ]
                        [ Button.button { variant = Button.DefaultVariant, size = Button.DefaultSize }
                            [ onClick GetUsers ]
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
                ]
            ]
        , Toasty.view toast_config Toasty.Defaults.view ToastyMsg model.toasties
        ]
    }


type alias Flags =
    { local_version : Maybe String }


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags _ key =
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
