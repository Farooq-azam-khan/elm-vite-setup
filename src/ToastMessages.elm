module ToastMessages exposing (..)

import Html
import Html.Attributes as Attr
import Toasty
import Toasty.Defaults


toast_config : Toasty.Config msg
toast_config =
    Toasty.Defaults.config
        -- |> Toasty.delay 3000
        -- |> Toasty.transitionOutDuration 500
        |> Toasty.containerAttrs
            [ Attr.style "max-width" "1000px"
            , Attr.style "position" "fixed"
            , Attr.style "left" "0"
            , Attr.style "bottom" "0"
            , Attr.class "z-50"
            ]
        |> Toasty.transitionInAttrs
            [ Attr.class "animated moveUpAnimation"
            ]
        |> Toasty.transitionOutAttrs
            [ Attr.class "animated"
            , Attr.style "max-height" "0"
            , Attr.style "margin-top" "0"
            ]


addToast : (Toasty.Msg Toasty.Defaults.Toast -> msg) -> Toasty.Defaults.Toast -> ( { m | toasties : Toasty.Stack Toasty.Defaults.Toast }, Cmd msg ) -> ( { m | toasties : Toasty.Stack Toasty.Defaults.Toast }, Cmd msg )
addToast msg toast ( model, cmd ) =
    Toasty.addToast toast_config msg toast ( model, cmd )

addPersistantToast : (Toasty.Msg Toasty.Defaults.Toast -> msg) -> Toasty.Defaults.Toast -> ( { m | toasties : Toasty.Stack Toasty.Defaults.Toast }, Cmd msg ) -> ( { m | toasties : Toasty.Stack Toasty.Defaults.Toast }, Cmd msg )
addPersistantToast msg toast ( model, cmd ) =
    Toasty.addPersistentToast toast_config msg toast ( model, cmd )



