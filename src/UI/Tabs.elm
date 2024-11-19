module UI.Tabs exposing (tabs, tabs_content, tabs_list, tabs_trigger)

import Html exposing (..)
import Html.Attributes as Attr
import UI.Common exposing (..)



-- https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/tab_role


tabs : List (Attribute msg) -> List (Html msg) -> Html msg
tabs attrs children =
    div
        (attrs
            ++ [ Attr.class ""
               , data_orientation Horizontal
               , dir LtrDir
               ]
        )
        children


type alias TabId =
    String


tabs_list : TabId -> List (Attribute msg) -> List (Html msg) -> Html msg
tabs_list tab_id attrs children =
    ul
        (attrs
            ++ [ Attr.id tab_id
               , Attr.class "rounded-xl text-sm"
               , Attr.class "bg-gray-50 p-1 text-gray-400"
               , Attr.attribute "role" "tablist"
               , aria_orientation Horizontal
               ]
        )
        children


tabs_trigger : List (Attribute msg) -> List (Html msg) -> Html msg
tabs_trigger attrs children =
    li
        (attrs
            ++ [ Attr.attribute "role" "presentation"
               ]
        )
        children


type alias TabContentId =
    String


tabs_content : TabContentId -> List (Attribute msg) -> List (Html msg) -> Html msg
tabs_content tab_content_id attrs children =
    div
        (attrs
            ++ [ Attr.id tab_content_id
               , Attr.attribute "role" "tabpanel"
               , Attr.class "mt-2 ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
               , Attr.attribute "tabindex" "0"
               ]
        )
        children
