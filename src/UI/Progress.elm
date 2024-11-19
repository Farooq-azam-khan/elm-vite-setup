module UI.Progress exposing (progress)

import Html exposing (..)
import Html.Attributes as Attr exposing (class)


progress : String -> List (Attribute msg) -> List (Html msg) -> Html msg
progress pct attrs children =
    div
        (attrs ++ [ class "my-2 w-full bg-secondary/20 rounded-full h-2" ])
        (children
            ++ [ div
                    [ Attr.class "transition-all motion-reduce:transition-none  ease-out duration-1000 bg-secondary h-2 rounded-full"
                    , Attr.style "width" pct
                    ]
                    []
               ]
        )
