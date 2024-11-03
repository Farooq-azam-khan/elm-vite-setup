module UI.DropdownMenu exposing
    ( DropdownMenuModel
    , DropdownMenuMsg(..)
    , dropdown_menu
    , dropdown_menu_content
    , dropdown_menu_group
    , dropdown_menu_item
    , dropdown_menu_label
    , dropdown_menu_portal
    , dropdown_menu_separator
    , dropdown_menu_shortcut
    , dropdown_menu_sub
    , dropdown_menu_sub_content
    , dropdown_menu_sub_trigger
    , dropdown_menu_trigger
    , init_dropdown_menu_model
    , update_dropdown_menu
    )

import Html exposing (..)
import Html.Attributes as Attr exposing (attribute, class, tabindex)
import Html.Events exposing (onClick)
import UI.Common exposing (..)
import UI.Icons as Icons



-- https://ui.shadcn.com/docs/components/dropdown-menu
-- https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/menu_role


type alias DropdownMenuModel =
    { open_close_state : OpenClosedState, menu_id : String }


type DropdownMenuMsg
    = OpenDropdownMenu
    | CloseDropdownMenu
    | ToggleDropdownMenu


update_dropdown_menu : DropdownMenuMsg -> DropdownMenuModel -> DropdownMenuModel
update_dropdown_menu d_msg d_model =
    case d_msg of
        OpenDropdownMenu ->
            { d_model | open_close_state = OpenState }

        CloseDropdownMenu ->
            { d_model | open_close_state = ClosedState }

        ToggleDropdownMenu ->
            { d_model | open_close_state = toggle_open_closed_state d_model.open_close_state }


init_dropdown_menu_model : String -> DropdownMenuModel
init_dropdown_menu_model id =
    { menu_id = id, open_close_state = ClosedState }


dropdown_menu :
    DropdownMenuModel
    -> List (Attribute DropdownMenuMsg)
    -> List (Html DropdownMenuMsg)
    -> Html DropdownMenuMsg
dropdown_menu dm_model attrs children =
    div
        (attrs
            ++ [ data_state dm_model.open_close_state
               , class ""
               ]
        )
        (button
            [ data_state dm_model.open_close_state
            , Attr.class """data-[state=closed]:invisible cursor-default fixed inset-0 z-50 
                bg-black/5  data-[state=open]:animate-in data-[state=closed]:animate-out 
                data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0"""
            , Attr.attribute "data-aria-hidden" (aria_state dm_model.open_close_state)
            , Attr.attribute "aria-hidden" (aria_state dm_model.open_close_state)
            , onClick CloseDropdownMenu
            ]
            []
            :: children
        )


trigger_id : DropdownMenuModel -> String
trigger_id { menu_id } =
    menu_id ++ "-trigger"


content_id : DropdownMenuModel -> String
content_id { menu_id } =
    menu_id ++ "-content"


dropdown_menu_trigger :
    DropdownMenuModel
    -> (List (Attribute DropdownMenuMsg) -> List (Html DropdownMenuMsg) -> Html DropdownMenuMsg)
    -> List (Attribute DropdownMenuMsg)
    -> List (Html DropdownMenuMsg)
    -> Html DropdownMenuMsg
dropdown_menu_trigger ({ open_close_state } as dm_model) element attrs children =
    element
        (attrs
            ++ [ aria_haspopup "menu"
               , aria_controls <| content_id dm_model
               , Attr.type_ "button"
               , onClick ToggleDropdownMenu
               , data_state open_close_state
               , aria_expanded open_close_state
               , Attr.id <| trigger_id dm_model
               ]
        )
        children


dropdown_menu_content :
    DropdownMenuModel
    -> List (Attribute DropdownMenuMsg)
    -> List (Html DropdownMenuMsg)
    -> Html DropdownMenuMsg
dropdown_menu_content ({ open_close_state } as dm_model) attrs children =
    div
        (attrs
            -- overflow-hidden
            ++ [ attribute "data-side" "top"
               , attribute "data-align" "center"
               , data_state open_close_state
               , data_orientation "vertical"
               , role "menu"
               , aria_orientation Vertical
               , aria_labelledby <| trigger_id dm_model
               , Attr.id <| content_id dm_model
               , dir LtrDir
               , tabindex -1
               , class """data-[state=closed]:invisible relative z-50 min-w-[8rem] rounded-md border 
                        bg-popover p-1 text-popover-foreground shadow-md 
                        data-[state=open]:animate-in data-[state=closed]:animate-out 
                        data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 
                        data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 
                        data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 
                        data-[side=top]:slide-in-from-bottom-2 w-56
                """
               , Attr.style "outline" "none"
               , Attr.style "pointer-events" "auto"
               ]
        )
        children


dropdown_menu_label : List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_label attrs children =
    div (attrs ++ [ class "px-2 py-1.5 text-sm font-semibold" ]) children


dropdown_menu_item : { a | active_or_disabled : ActiveOrDisabled } -> List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_item menu_item_state attrs children =
    div
        (attrs
            ++ [ role "menuitem"
               , class """relative flex cursor-default select-none items-center gap-2 
                        rounded-sm px-2 py-1.5 text-sm outline-none transition-colors 
                        hover:bg-accent hover:text-accent-foreground
                        focus:bg-accent focus:text-accent-foreground 
                        data-[disabled=true]:pointer-events-none  data-[disabled=true]:opacity-50 
                        [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0
                """
               , aria_disabled menu_item_state.active_or_disabled
               , data_disabled menu_item_state.active_or_disabled
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
               , aria_orientation Horizontal
               , class "-mx-1 my-1 h-px bg-muted"
               ]
        )
        children


dropdown_menu_group : List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_group attrs children =
    div (attrs ++ [ role "group" ]) children


dropdown_menu_shortcut : List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_shortcut attrs children =
    span (attrs ++ [ class "ml-auto text-xs tracking-widest opacity-60" ]) children


dropdown_menu_sub : DropdownMenuModel -> List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_sub dm_model attrs children =
    div
        (attrs
            ++ [ role "menuitem"
               , Attr.id <| dm_model.menu_id ++ "-sub-menu"
               , aria_haspopup "menu"
               , aria_expanded OpenState -- TODO: open close for sub menu
               , aria_controls <| dm_model.menu_id ++ "-sub-menu-controls"
               , data_state OpenState -- TODO: same open close state as dialog
               , tabindex -1
               , data_orientation "vertical"
               , class """relative flex cursor-default gap-2 select-none items-center rounded-sm px-2 py-1.5 
               text-sm outline-none focus:bg-accent 
               data-[state=open]:bg-accent [&_svg]:pointer-events-none [&_svg]:size-4 
               [&_svg]:shrink-0"""
               ]
        )
        children


dropdown_menu_sub_content : DropdownMenuModel -> List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_sub_content dm_model attrs children =
    div
        (attrs
            ++ [ Attr.id <| dm_model.menu_id ++ "-sub-menu-controls"
               , data_side "right"
               , data_align "start"
               , data_orientation "vertical"
               , data_state dm_model.open_close_state
               , dir LtrDir
               , role "menu"
               , aria_orientation Vertical
               , aria_labelledby <| sub_trigger_id dm_model
               , tabindex -1
               , class """data-[state=closed]:invisible z-50 min-w-[8rem] overflow-hidden rounded-md 
    border bg-popover p-1 text-popover-foreground shadow-lg data-[state=open]:animate-in 
    data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 
    data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 
    data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 
    data-[side=top]:slide-in-from-bottom-2
    """
               ]
        )
        children


sub_trigger_id : DropdownMenuModel -> String
sub_trigger_id dm_model =
    dm_model.menu_id ++ "-sub-trigger"



-- TODO: hover / focus to open sub menu


dropdown_menu_sub_trigger : DropdownMenuModel -> List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_sub_trigger dm_model attrs children =
    div
        (attrs
            ++ [ class """w-full flex cursor-default gap-2 select-none items-center rounded-sm px-2 py-1.5 
            text-sm outline-none focus:bg-accent data-[state=open]:bg-accent [&_svg]:pointer-events-none 
            [&_svg]:size-4 [&_svg]:shrink-0""", Attr.id <| sub_trigger_id dm_model ]
        )
        (children ++ [ Icons.chevron_right "w-5 h-5 ml-auto" ])


dropdown_menu_portal : List (Attribute msg) -> List (Html msg) -> Html msg
dropdown_menu_portal attrs children =
    div (attrs ++ [ dir LtrDir, class "absolute inset-0 ml-[14rem]" ]) children



-- TODO: DropdownMenuCheckboxItem
-- TODO: DropdownMenuRadioGroup, DropdownMenuRadioItem
