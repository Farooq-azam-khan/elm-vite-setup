module UI.DropdownMenu exposing
    ( DropdownMenuState(..)
    , dropdown_menu
    , dropdown_menu_content
    , dropdown_menu_group
    , dropdown_menu_item
    , dropdown_menu_label
    , dropdown_menu_separator
      --    , dropdown_menu_shortcut
      --    , dropdown_menu_sub
    , dropdown_menu_state_to_string
      --    , dropdown_menu_portal
    , dropdown_menu_subContent
      --    , dropdown_menu_subTrigger
    , dropdown_menu_trigger
    , is_dropdown_menu_open
    )

import Html exposing (..)
import Html.Attributes as Attr exposing (attribute, class, tabindex)
import UI.Common exposing (..)



-- https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/menu_role


type DropdownMenuState
    = DMOpen
    | DMClosed



-- TODO: add acctions / update msg
{- type alias Model = {orientation : Orientation } -}
{- type DropdownMenuAction
   = ToggleDrodownMenuState DropdownMenuState
   | KeyPressed Int
-}


is_dropdown_menu_open : DropdownMenuState -> Bool
is_dropdown_menu_open dm_state =
    case dm_state of
        DMClosed ->
            False

        DMOpen ->
            True


dropdown_menu_state_to_string : DropdownMenuState -> String
dropdown_menu_state_to_string dm_state =
    case dm_state of
        DMClosed ->
            "closed"

        DMOpen ->
            "open"


data_state : DropdownMenuState -> Attribute msg
data_state state =
    state |> dropdown_menu_state_to_string |> attribute "data-state"


aria_expanded : DropdownMenuState -> Attribute msg
aria_expanded state =
    case state of
        DMOpen ->
            attribute "aria-expanded" "true"

        DMClosed ->
            attribute "aria-expanded" "false"


dropdown_menu : DropdownMenuState -> List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu state attrs children =
    div
        (attrs
            ++ [ data_state state
               , aria_expanded state
               ]
        )
        children


dropdown_menu_trigger : List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_trigger attrs children =
    button
        (attrs
            ++ [ aria_haspopup "menu"
               , aria_controls "menu"
               ]
        )
        children


dropdown_menu_content : List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_content attrs children =
    div (attrs ++ [ class """z-50 min-w-[10rem] overflow-hidden rounded-md border 
        bg-popover p-1 text-popover-foreground shadow-md data-[state=open]:animate-in 
        data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 
        data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 
        data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 
        data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 w-64""" ])
        children


dropdown_menu_subContent : List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_subContent attrs children =
    div attrs children


dropdown_menu_label : List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_label attrs children =
    div (attrs ++ [ class "px-2 py-1.5 text-sm font-semibold" ]) children


dropdown_menu_item : List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_item attrs children =
    div
        (attrs
            ++ [ role "menuitem"
               , class """relative flex cursor-default select-none items-center 
               rounded-sm px-2 py-1.5 text-sm outline-none transition-colors 
               focus:bg-accent focus:text-accent-foreground 
               data-[disabled]:pointer-events-none data-[disabled]:opacity-50"""
               , tabindex -1
               , data_orientation "vertical"
               ]
        )
        children


data_orientation : String -> Attribute msg
data_orientation str =
    attribute "data-orientation" str


role : String -> Attribute msg
role rl =
    Attr.attribute "role" rl


dropdown_menu_separator : List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_separator attrs children =
    div
        (attrs
            ++ [ role "separator"
               , aria_orientation Vertical
               , class "-mx-1 my-1 h-px bg-muted"
               ]
        )
        children


dropdown_menu_group : List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_group attrs children =
    div (attrs ++ [ role "group" ]) children



{-
   dropdown_menu_portal=div [] []
   dropdown_menu_shortcut=div [] []
   dropdown_menu_sub=div [] []
   dropdown_menu_subTrigger=div [] []
-}
