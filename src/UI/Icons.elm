module UI.Icons exposing (..)

import Html exposing (..)
import Html.Attributes as Attr
import Svg exposing (path, svg)
import Svg.Attributes as SvgAttr


close_icon : String -> Html msg
close_icon class_name =
    svg
        [ Attr.attribute "data-slot" "icon"
        , SvgAttr.class class_name
        , SvgAttr.fill "none"
        , SvgAttr.strokeWidth "1.5"
        , SvgAttr.stroke "currentColor"
        , SvgAttr.viewBox "0 0 24 24"
        , Attr.attribute "aria-hidden" "true"
        ]
        [ path
            [ SvgAttr.strokeLinecap "round"
            , SvgAttr.strokeLinejoin "round"
            , SvgAttr.d "M6 18 18 6M6 6l12 12"
            ]
            []
        ]
