module UI.Tooltip exposing
    ( tooltip
    , tooltip_content
    , tooltip_provider
    , tooltip_trigger
    )

import Html exposing (..)
import Html.Attributes as Attr exposing (class)



-- https://www.radix-ui.com/primitives/docs/components/tooltip


type alias TooltipId =
    String


tooltip : TooltipId -> List (Html msg) -> Html msg
tooltip tooltip_id children =
    div
        [ Attr.id tooltip_id
        , Attr.attribute "data-tooltip-target" tooltip_id
        ]
        children



-- TODO: figure out how to show element when fcused
-- The component that pops out when the tooltip is open.


tooltip_content : List (Html.Attribute msg) -> List (Html msg) -> Html msg
tooltip_content attrs children =
    div
        (attrs
            ++ [ class (String.trim """max-w-[10rem] invisible opacity-0
                    group-hover:visible group-hover:opacity-100 
                    group-focus:visible group-focus:opacity-100
                    transition-opacity delay-150 duration-300 
                    absolute z-10 left-0 bottom-0 mb-10 mr-3 
                    inline-block shadow-sm rounded-lg text-xs 
                    font-medium text-white bg-gray-900 px-2 py-1""")
               ]
        )
        children


tooltip_provider : List (Attribute msg) -> List (Html msg) -> Html msg
tooltip_provider attrs children =
    div (attrs ++ [ class "group relative", Attr.attribute "role" "tooltip" ])
        children


tooltip_trigger : TooltipId -> (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
tooltip_trigger tooltip_id trigger_element trigger_attrs trigger_children =
    trigger_element (trigger_attrs ++ [ Attr.attribute "aria-describedby" tooltip_id ]) trigger_children
