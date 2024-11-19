module UI.NavigationMenu exposing
    ( navigation_menu
    , navigation_menu_content
    , navigation_menu_item
    , navigation_menu_link
    , navigation_menu_list
    , navigation_menu_trigger
    )

import Html exposing (..)
import Html.Attributes as Attr exposing (class, classList)
import UI.Common exposing (..)


navigation_menu : List (Attribute msg) -> List (Html msg) -> Html msg
navigation_menu attrs children =
    nav
        (attrs
            ++ [ class "relative z-10 flex max-w-max flex-1 items-center justify-center"
               , data_orientation Horizontal
               , dir LtrDir
               ]
        )
        children


navigation_menu_list : String -> List (Html msg) -> Html msg
navigation_menu_list class_name children =
    ul
        [ classList
            [ ( class_name, True )
            , ( "group flex flex-1 list-none items-center justify-center space-x-1", True )
            ]
        ]
        children


navigation_menu_item :
    List (Attribute msg)
    -> List (Html msg)
    -> Html msg
navigation_menu_item attrs children =
    li attrs children


navigation_menu_link : List (Attribute msg) -> List (Html msg) -> Html msg
navigation_menu_link attrs children =
    a
        (attrs
            ++ [ Attr.class
                    """group inline-flex h-9 w-max items-center justify-center rounded-md 
                    bg-background px-4 py-2 text-sm font-medium transition-colors 
                    hover:bg-accent hover:text-accent-foreground focus:bg-accent 
                    focus:text-accent-foreground focus:outline-none 
                    disabled:pointer-events-none disabled:opacity-50 
                    data-[active]:bg-accent/50 data-[state=open]:bg-accent/50"""
               ]
        )
        children


navigation_menu_content : String -> List (Html msg) -> Html msg
navigation_menu_content class_name children =
    div
        [ classList
            [ ( class_name, True )
            , ( "left-0 top-0 w-full data-[motion^=from-]:animate-in data-[motion^=to-]:animate-out data-[motion^=from-]:fade-in data-[motion^=to-]:fade-out data-[motion=from-end]:slide-in-from-right-52 data-[motion=from-start]:slide-in-from-left-52 data-[motion=to-end]:slide-out-to-right-52 data-[motion=to-start]:slide-out-to-left-52 md:absolute md:w-auto ", True )
            ]
        ]
        children


navigation_menu_trigger : List (Attribute msg) -> List (Html msg) -> Html msg
navigation_menu_trigger attrs children =
    button
        (attrs
            ++ [ class """group inline-flex h-9 w-max items-center justify-center rounded-md 
                    bg-background px-4 py-2 text-sm font-medium transition-colors 
                    hover:bg-accent hover:text-accent-foreground focus:bg-accent 
                    focus:text-accent-foreground focus:outline-none 
                    disabled:pointer-events-none disabled:opacity-50 
                    data-[active]:bg-accent/50 data-[state=open]:bg-accent/50 group"""
               ]
        )
        children



{-


   navigation_menu_indicator class_name children =
       div [ classList [ ( class_name, True ) ] ] children



      NavigationMenuViewport,
-}
