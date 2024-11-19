module UI.Table exposing
    ( my_table
    , table_body
    , table_caption
    , table_cell
    , table_footer
    , table_head
    , table_header
    , table_row
    )

import Html exposing (..)
import Html.Attributes as Attr exposing (class)


my_table : List (Attribute msg) -> List (Html msg) -> Html msg
my_table attrs children =
    Html.table attrs children


table_body : List (Attribute msg) -> List (Html msg) -> Html msg
table_body attrs children =
    tbody
        (attrs ++ [ class "[&_tr:last-child]:border-0" ])
        children


table_caption : List (Attribute msg) -> List (Html msg) -> Html msg
table_caption attrs children =
    caption (attrs ++ [ class "mt-4 text-sm text-muted-foreground" ]) children


table_cell : List (Attribute msg) -> List (Html msg) -> Html msg
table_cell attrs children =
    div attrs children


table_footer : List (Attribute msg) -> List (Html msg) -> Html msg
table_footer attrs children =
    tfoot (attrs ++ [ class "border-t bg-muted/50 font-medium [&>tr]:last:border-b-0" ]) children


table_head : List (Attribute msg) -> List (Html msg) -> Html msg
table_head attrs children =
    th
        (attrs
            ++ [ Attr.scope "col"
               , class "h-10 px-2 text-left align-middle font-medium text-muted-foreground [&:has([role=checkbox])]:pr-0 [&>[role=checkbox]]:translate-y-[2px] w-[100px]"
               ]
        )
        children


table_header : List (Attribute msg) -> List (Html msg) -> Html msg
table_header attrs children =
    thead (attrs ++ [ class "[&_tr]:border-b" ]) children


table_row : List (Attribute msg) -> List (Html msg) -> Html msg
table_row attrs children =
    tr
        (attrs ++ [ class "border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted" ])
        children
