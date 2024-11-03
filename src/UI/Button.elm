module UI.Button exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr


type ButtonVariant
    = DefaultVariant
    | Destructive
    | Outline
    | Secondary
    | Ghost
    | Link


type ButtonSize
    = DefaultSize
    | Sm
    | Lg
    | Icon


btn_class : String
btn_class =
    "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50"


default_variant_style : String
default_variant_style =
    "bg-primary text-primary-foreground shadow hover:bg-primary/90"


default_size : String
default_size =
    "h-9 px-4 py-2"


get_button_variant_styles : ButtonVariant -> String
get_button_variant_styles v =
    case v of
        DefaultVariant ->
            default_variant_style

        Destructive ->
            "bg-destructive text-destructive-foreground shadow-sm hover:bg-destructive/90"

        Outline ->
            "border border-input bg-background shadow-sm hover:bg-accent hover:text-accent-foreground"

        Secondary ->
            "bg-secondary text-secondary-foreground shadow-sm hover:bg-secondary/80"

        Ghost ->
            "hover:bg-accent hover:text-accent-foreground"

        Link ->
            "text-primary underline-offset-4 hover:underline"


get_button_size_styles : ButtonSize -> String
get_button_size_styles sz =
    case sz of
        DefaultSize ->
            default_size

        Sm ->
            "h-8 rounded-md px-3 text-xs"

        Lg ->
            "h-10 rounded-md px-8"

        Icon ->
            "h-9 w-9"



-- TODO: figure out how to deal with disabled buttons


button : { a | variant : ButtonVariant, size : ButtonSize } -> List (Html.Attribute msg) -> List (Html msg) -> Html msg
button config attr children =
    Html.button
        (attr
            ++ [ Attr.type_ "button"
               , Attr.classList
                    [ ( get_button_variant_styles config.variant, True )
                    , ( get_button_size_styles config.size, True )
                    , ( btn_class, True )
                    ]
               ]
        )
        children
