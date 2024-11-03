module UI.Common exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute)



-- Common attributes / Types


type Orientation
    = Vertical
    | Horizontal


aria_haspopup : String -> Attribute msg
aria_haspopup str =
    attribute "aria-haspopup" str


aria_controls : String -> Attribute msg
aria_controls str =
    attribute "aria-controls" str


data_orientation : Orientation -> Attribute msg
data_orientation o =
    attribute "data-orientation" <|
        case o of
            Horizontal ->
                "horizontal"

            Vertical ->
                "vertical"


type Dir
    = LtrDir
    | RtlDir
    | AutoDir


dir : Dir -> Attribute msg
dir d =
    attribute "dir" <|
        case d of
            LtrDir ->
                "ltr"

            RtlDir ->
                "rtl"

            AutoDir ->
                "auto"


aria_orientation : Orientation -> Attribute msg
aria_orientation o =
    attribute "aria-orientation" <|
        case o of
            Horizontal ->
                "horizontal"

            Vertical ->
                "vertical"
