module UI.Dialog exposing (dialog, dialog_content, dialog_description, dialog_footer, dialog_header, dialog_title, dialog_trigger)

import Html exposing (..)
import Html.Attributes as Attr exposing (class)



-- https://ui.shadcn.com/docs/components/dialog
-- https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/dialog_role


dialog : List (Attribute msg) -> List (Html msg) -> Html msg
dialog attrs children =
    div attrs children


dialog_content : List (Attribute msg) -> List (Html msg) -> Html msg
dialog_content attrs children =
    div (attrs ++ [ Attr.attribute "role" "dialog", class "fixed inset-0 grid gap-4 border p-6 sm:rounded-lg" ]) children


dialog_description : List (Attribute msg) -> List (Html msg) -> Html msg
dialog_description attrs children =
    div (attrs ++ [ class "text-sm text-muted-foreground" ]) children


dialog_footer : List (Attribute msg) -> List (Html msg) -> Html msg
dialog_footer attrs children =
    div (attrs ++ [ class "flex flex-col-reverse sm:flex-row sm:space-x-2 sm:justify-start" ]) children


dialog_header : List (Attribute msg) -> List (Html msg) -> Html msg
dialog_header attrs children =
    div (attrs ++ [ class "flex flex-col space-y-1.5 text-center sm:text-left" ]) children


dialog_title : List (Attribute msg) -> List (Html msg) -> Html msg
dialog_title attrs children =
    h2 (attrs ++ [ class "text-lg font-semibold leading-none tracking-tight" ]) children


dialog_trigger : List (Attribute msg) -> List (Html msg) -> Html msg
dialog_trigger attrs children =
    div attrs children
