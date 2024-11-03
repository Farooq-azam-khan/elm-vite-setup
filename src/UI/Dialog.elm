module UI.Dialog exposing
    ( DialogModel
    , DialogMsg(..)
    , dialog
    , dialog_content
    , dialog_description
    , dialog_footer
    , dialog_header
    , dialog_title
    , dialog_trigger
    , init_dialog_model
    , update_dialog
    )

import Html exposing (..)
import Html.Attributes as Attr exposing (class)
import Html.Events exposing (onClick)
import UI.Button as Button
import UI.Common exposing (..)
import UI.Icons as Icons



-- https://ui.shadcn.com/docs/components/dialog
-- https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/dialog_role


type alias DialogModel =
    { open_close_state : OpenClosedState, dialog_id : String }


init_dialog_model : String -> DialogModel
init_dialog_model id =
    { dialog_id = id, open_close_state = ClosedState }


type DialogMsg
    = OpenDialog
    | CloseDialog
    | ToggleDialog


update_dialog : DialogMsg -> DialogModel -> DialogModel
update_dialog d_msg d_model =
    case d_msg of
        OpenDialog ->
            { d_model | open_close_state = OpenState }

        CloseDialog ->
            { d_model | open_close_state = ClosedState }

        ToggleDialog ->
            { d_model | open_close_state = toggle_open_closed_state d_model.open_close_state }



-- views


dialog : DialogModel -> List (Attribute DialogMsg) -> List (Html DialogMsg) -> Html DialogMsg
dialog dialog_model attrs children =
    div (attrs ++ [ data_state dialog_model.open_close_state ])
        (button
            [ data_state dialog_model.open_close_state
            , Attr.class """data-[state=closed]:invisible cursor-default fixed inset-0 z-50 bg-black/80  data-[state=open]:animate-in 
            data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0"""
            , Attr.attribute "data-aria-hidden" (aria_state dialog_model.open_close_state)
            , Attr.attribute "aria-hidden" (aria_state dialog_model.open_close_state)
            , onClick CloseDialog
            ]
            []
            :: children
        )


dialog_content : DialogModel -> List (Attribute DialogMsg) -> List (Html DialogMsg) -> Html DialogMsg
dialog_content dialog_model attrs children =
    div
        (attrs
            ++ [ Attr.attribute "role" "dialog"
               , data_state dialog_model.open_close_state
               , Attr.tabindex -1
               , Attr.id <| dialog_model.dialog_id ++ "-controls"
               , Attr.attribute "aria-describeby" <| dialog_model.dialog_id ++ "-describe"
               , Attr.attribute "aria-labelby" <| dialog_model.dialog_id ++ "-label"
               , class """data-[state=closed]:invisible fixed left-[50%] top-[50%] z-50 grid w-full max-w-lg translate-x-[-50%] translate-y-[-50%] gap-4 border bg-background p-6 
                        shadow-lg duration-200 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 
                        data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[state=closed]:slide-out-to-left-1/2 
                        data-[state=closed]:slide-out-to-top-[48%] data-[state=open]:slide-in-from-left-1/2 data-[state=open]:slide-in-from-top-[48%] sm:rounded-lg sm:max-w-[425px]
                """
               ]
        )
        (children
            ++ [ Button.button { variant = Button.NoVariant, size = Button.NoSize }
                    [ class "absolute right-4 top-4 rounded-sm opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:pointer-events-none data-[state=open]:bg-accent data-[state=open]:text-muted-foreground"
                    , onClick CloseDialog
                    ]
                    [ Icons.close_icon "w-4 h-4" ]
               ]
        )


dialog_description : DialogModel -> List (Attribute msg) -> List (Html msg) -> Html msg
dialog_description dialog_model attrs children =
    div (attrs ++ [ Attr.id <| dialog_model.dialog_id ++ "-describe", class "text-sm text-muted-foreground" ]) children


dialog_footer : DialogModel -> List (Attribute msg) -> List (Html msg) -> Html msg
dialog_footer _ attrs children =
    div (attrs ++ [ class "flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2" ]) children


dialog_header : DialogModel -> List (Attribute msg) -> List (Html msg) -> Html msg
dialog_header _ attrs children =
    div (attrs ++ [ class "flex flex-col space-y-1.5 text-center sm:text-left" ]) children


dialog_title : DialogModel -> List (Attribute msg) -> List (Html msg) -> Html msg
dialog_title dialog_model attrs children =
    h2 (attrs ++ [ Attr.id <| dialog_model.dialog_id ++ "-label", class "text-lg font-semibold leading-none tracking-tight" ]) children


dialog_trigger :
    DialogModel
    -> (List (Attribute DialogMsg) -> List (Html DialogMsg) -> Html DialogMsg)
    -> List (Attribute DialogMsg)
    -> List (Html DialogMsg)
    -> Html DialogMsg
dialog_trigger dialog_model trigger_element attrs children =
    trigger_element
        (attrs
            ++ [ Attr.type_ "button"
               , aria_haspopup "dialog"
               , aria_expanded dialog_model.open_close_state
               , data_state dialog_model.open_close_state
               , Attr.attribute "aria-controls" <| dialog_model.dialog_id ++ "-controls"
               , Attr.attribute "aria-describeby" <| dialog_model.dialog_id ++ "-describe"
               , aria_labelledby <| dialog_model.dialog_id ++ "-label"
               , onClick OpenDialog
               ]
        )
        children
