module Main exposing (main)

import ToastMessages exposing (..)
import Toasty.Defaults
import Toasty 
import Types exposing (..)
import Api exposing (..)
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (alt, class, href, src, target)
import Html.Events exposing (onClick)
import RemoteData exposing (RemoteData(..), WebData)
import Url exposing (Url)
import Actions exposing (..)

view : Model -> Browser.Document Msg
view model =
    { title = "counter"
    , body =
        [ div
            [ class "mx-5 sm:mx-0 sm:mx-auto lg sm:max-w-xl lg:max-w-3xl mt-10 space-x-10" ]
            [ button [ class "bg-black px-5 py-1 text-white rounded-md", onClick Decrement ] [ text "-" ]
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


init : flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( init_model key, Cmd.none )


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }
