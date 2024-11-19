module UI.Common exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute)



-- Common State Types


type ActiveOrDisabled
    = Active
    | Disabled


is_disabled : ActiveOrDisabled -> String
is_disabled state =
    case state of
        Active ->
            "false"

        Disabled ->
            "true"


aria_disabled : ActiveOrDisabled -> Attribute msg
aria_disabled state =
    is_disabled state |> attribute "data-disabled"


data_disabled : ActiveOrDisabled -> Attribute msg
data_disabled state =
    is_disabled state |> attribute "data-disabled"


type OpenClosedState
    = OpenState
    | ClosedState


toggle_open_closed_state : OpenClosedState -> OpenClosedState
toggle_open_closed_state pstate =
    case pstate of
        OpenState ->
            ClosedState

        ClosedState ->
            OpenState


aria_labelledby : String -> Attribute msg
aria_labelledby label =
    attribute "aria-labelledby" label


aria_state : OpenClosedState -> String
aria_state state =
    case state of
        OpenState ->
            "true"

        ClosedState ->
            "false"


data_state : OpenClosedState -> Attribute msg
data_state state =
    attribute "data-state" <|
        case state of
            OpenState ->
                "open"

            ClosedState ->
                "closed"


aria_expanded : OpenClosedState -> Attribute msg
aria_expanded state =
    state |> aria_state |> attribute "aria-expanded"



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


data_side : String -> Attribute msg
data_side side =
    attribute "data-side" side


data_align : String -> Attribute msg
data_align align =
    attribute "data-align" align
