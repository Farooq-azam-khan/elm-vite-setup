module UI.Card exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)



-- https://ui.shadcn.com/docs/components/card


card_header : List (Attribute msg) -> List (Html msg) -> Html msg
card_header attrs children =
    div
        (attrs ++ [ class "flex flex-col space-y-1.5 p-6" ])
        children


card_title : List (Attribute msg) -> List (Html msg) -> Html msg
card_title attrs children =
    h2 (attrs ++ [ class "font-semibold leading-none tracking-tight" ]) children


card_description : List (Attribute msg) -> List (Html msg) -> Html msg
card_description attrs children =
    div (attrs ++ [ class "text-sm text-muted-foreground" ]) children


card_content : List (Attribute msg) -> List (Html msg) -> Html msg
card_content attrs children =
    div (attrs ++ [ class "p-6 pt-0" ]) children


card_footer : List (Attribute msg) -> List (Html msg) -> Html msg
card_footer attrs children =
    div (attrs ++ [ class "flex items-center justify-between p-6 pt-0" ]) children


card : List (Attribute msg) -> List (Html msg) -> Html msg
card attrs children =
    div
        (attrs
            ++ [ class
                    "rounded-xl border bg-card text-card-foreground shadow"
               ]
        )
        children
