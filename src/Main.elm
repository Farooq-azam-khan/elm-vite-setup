module Main exposing (main)

import Actions exposing (..)
import Api exposing (..)
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes as Attr exposing (class)
import Html.Events exposing (onClick)
import RemoteData exposing (RemoteData(..))
import Route exposing (Route(..), parse_url)
import ToastMessages exposing (..)
import Toasty
import Toasty.Defaults
import Types exposing (..)
import UI.Button as Button
import UI.Card as Card
import UI.Common as Common
import UI.Dialog as Dialog
import UI.DropdownMenu as DropdownMenu
import UI.Icons as Icons
import Url exposing (Url)
import Url.Builder exposing (absolute)



-- Pages


components_page : Model -> Html Msg
components_page { user_profile_dialog, user_dropdown_menu } =
    div
        [ class "space-y-10 font-poppins-sans mx-5 sm:mx-0 sm:mx-auto sm:max-w-xl lg:max-w-3xl mt-10 " ]
        [ -- Card / Button
          Card.card []
            [ Card.card_header [] [ Card.card_title [] [ text "Test Card Title" ], Card.card_description [] [ text "Test card description" ] ]
            , Card.card_content [] [ text "Test card content" ]
            , Card.card_footer []
                [ Button.button { variant = Button.Outline, size = Button.DefaultSize } [] [ text "Close" ]
                , Button.button { variant = Button.DefaultVariant, size = Button.DefaultSize } [] [ text "Do Action" ]
                ]
            ]

        -- Dialog
        , Html.map UserProfileDialogMsg <|
            Dialog.dialog user_profile_dialog
                []
                [ Dialog.dialog_trigger user_profile_dialog
                    (Button.button { variant = Button.Outline, size = Button.DefaultSize })
                    []
                    [ text "Edit Profile" ]
                , Dialog.dialog_content user_profile_dialog
                    [ class "sm:max-w-[425px]"
                    ]
                    [ Dialog.dialog_header user_profile_dialog
                        []
                        [ Dialog.dialog_title user_profile_dialog [] [ text "Edit profile" ]
                        , Dialog.dialog_description user_profile_dialog [] [ text "Make changes to your profile." ]
                        ]
                    , div [ class "grid gap-4 py-4" ]
                        [ div [ class "grid grid-cols-4 items-center gap-4" ]
                            [ label [ Attr.for "name", class "text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70 text-right" ] [ text "Name" ]
                            , input [ Attr.id "name", class "flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium file:text-foreground placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 col-span-3" ] []
                            ]
                        ]
                    , div [ class "grid grid-cols-4 items-center gap-4" ]
                        [ label [ Attr.for "username", class "text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70 text-right" ] [ text "Username" ]
                        , input [ Attr.id "username", class "flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium file:text-foreground placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 col-span-3" ] []
                        ]
                    , Dialog.dialog_footer user_profile_dialog
                        []
                        [ Button.button { variant = Button.DefaultVariant, size = Button.DefaultSize }
                            []
                            [ text "Save changes"
                            ]
                        ]
                    ]
                ]

        -- Dropdown Menu
        , Html.map UserDropdownMenu <|
            DropdownMenu.dropdown_menu
                user_dropdown_menu
                []
                [ DropdownMenu.dropdown_menu_trigger
                    user_dropdown_menu
                    (Button.button { variant = Button.Outline, size = Button.DefaultSize })
                    []
                    [ text "Open Dropdown Menu" ]
                , DropdownMenu.dropdown_menu_content user_dropdown_menu
                    [ class "w-56"
                    ]
                    [ DropdownMenu.dropdown_menu_label [] [ text "My Account" ]
                    , DropdownMenu.dropdown_menu_separator [] []
                    , DropdownMenu.dropdown_menu_group []
                        [ DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Active }
                            []
                            [ Icons.user_icon "w-5 h-5"
                            , span [] [ text "Profile" ]
                            , DropdownMenu.dropdown_menu_shortcut [] [ text "⇧⌘P" ]
                            ]
                        , DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Active }
                            []
                            [ Icons.credit_card_icon "w-5 h-5"
                            , span [] [ text "Billing" ]
                            , DropdownMenu.dropdown_menu_shortcut [] [ text "⌘B" ]
                            ]
                        , DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Active }
                            []
                            [ Icons.settings_icon "w-5 h-5"
                            , span [] [ text "Profile" ]
                            , DropdownMenu.dropdown_menu_shortcut [] [ text "⌘S" ]
                            ]
                        , DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Active }
                            []
                            [ Icons.command_line_icon "w-5 h-5"
                            , span [] [ text "Keyboard shortcuts" ]
                            , DropdownMenu.dropdown_menu_shortcut [] [ text "⌘K" ]
                            ]
                        ]
                    , DropdownMenu.dropdown_menu_separator [] []
                    , DropdownMenu.dropdown_menu_group []
                        [ DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Active }
                            []
                            [ Icons.command_line_icon "w-5 h-5"
                            , span [] [ text "Team" ]
                            ]
                        , DropdownMenu.dropdown_menu_sub user_dropdown_menu
                            []
                            [ DropdownMenu.dropdown_menu_sub_trigger user_dropdown_menu
                                []
                                [ Icons.user_plus_icon "w-5 h-5"
                                , span [] [ text "Invite users" ]
                                ]
                            , DropdownMenu.dropdown_menu_portal []
                                [ DropdownMenu.dropdown_menu_sub_content user_dropdown_menu
                                    []
                                    [ DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Active }
                                        []
                                        [ Icons.mail_icon "w-5 h-5"
                                        , span [] [ text "Email" ]
                                        ]
                                    , DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Active }
                                        []
                                        [ Icons.chat_bubble_left_icon "w-5 h-5"
                                        , span [] [ text "Message" ]
                                        ]
                                    , DropdownMenu.dropdown_menu_separator [] []
                                    , DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Active }
                                        []
                                        [ Icons.plus_circle_icon "w-5 h-5"
                                        , span [] [ text "More..." ]
                                        ]
                                    ]
                                ]
                            ]
                        , DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Active }
                            []
                            [ Icons.plus_icon "w-5 h-5"
                            , span [] [ text "New Team" ]
                            , DropdownMenu.dropdown_menu_shortcut [] [ text "⌘+T" ]
                            ]
                        ]
                    , DropdownMenu.dropdown_menu_separator [] []
                    , DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Active }
                        []
                        [ Icons.plus_icon "w-5 h-5"
                        , span [] [ text "Github" ]
                        ]
                    , DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Active }
                        []
                        [ Icons.lifebuoy "w-5 h-5"
                        , span [] [ text "Support" ]
                        ]
                    , DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Disabled }
                        []
                        [ Icons.cloud_icon "w-5 h-5"
                        , span [] [ text "API" ]
                        ]
                    , DropdownMenu.dropdown_menu_separator [] []
                    , DropdownMenu.dropdown_menu_item { active_or_disabled = Common.Active }
                        []
                        [ Icons.arrow_right_end "w-5 h-5"
                        , span [] [ text "Log out" ]
                        , DropdownMenu.dropdown_menu_shortcut [] [ text "⇧⌘Q" ]
                        ]
                    ]
                ]
        ]


home_page : Model -> Html Msg
home_page model =
    div
        [ class "font-poppins-sans mx-5 sm:mx-0 sm:mx-auto lg sm:max-w-xl lg:max-w-3xl mt-10 space-x-10" ]
        [ Card.card []
            [ Card.card_header []
                [ Card.card_title [ class "flex space-x-5 py-3" ]
                    [ span []
                        [ case model.server_version of
                            Loading ->
                                text "server version: loading version..."

                            NotAsked ->
                                text "server version: not asked"

                            Success version ->
                                text <| "server version: " ++ version

                            Failure _ ->
                                text <| "server version: failed to get version"
                        ]
                    , span []
                        [ case model.local_version of
                            Nothing ->
                                text "local version: not stored yet"

                            Just version ->
                                text <| "local version: " ++ version
                        ]
                    ]
                ]
            , Card.card_content
                []
                [ div []
                    [ Button.button { variant = Button.DefaultVariant, size = Button.Icon } [ onClick Decrement ] [ text "-" ]
                    , span [] [ model.count |> String.fromInt |> text ]
                    , Button.button { variant = Button.DefaultVariant, size = Button.Icon } [ onClick Increment ] [ text "+" ]
                    ]
                , div [ class "mt-10" ]
                    [ Button.button { variant = Button.DefaultVariant, size = Button.DefaultSize }
                        [ onClick GetUsers ]
                        [ text "Get Users" ]
                    , case model.users of
                        NotAsked ->
                            div [] [ text "Not asked to get users" ]

                        Loading ->
                            div [] [ text "Loading users" ]

                        Success userlist ->
                            ol [] (List.map (\user -> li [] [ text user ]) userlist)

                        Failure _ ->
                            div [] [ text "an unknown error occured fetching users" ]
                    ]
                ]
            ]
        ]

view2 : Model -> Html  Msg
view2 model =
        div [] [ case model.route of
            HomeR ->
                home_page model

            ComponentsR ->
                components_page model

            UserR _ ->
                div [] [ text "Comming Soon..." ]

            NotFoundR ->
                div [] [ text "Route Not Found" ]
        , Toasty.view toast_config Toasty.Defaults.view ToastyMsg model.toasties
        ]


view : Model -> Browser.Document Msg
view model =
    { title = "counter"
    , body =
        [ case model.route of
            HomeR ->
                home_page model

            ComponentsR ->
                components_page model

            UserR _ ->
                div [] [ text "Comming Soon..." ]

            NotFoundR ->
                div [] [ text "Route Not Found" ]
        , Toasty.view toast_config Toasty.Defaults.view ToastyMsg model.toasties
        ]
    }


type alias Flags =
    { local_version : Maybe String , location: String }


init2 : Flags ->  ( Model, Cmd Msg )
init2 flags =
    let 
        mb_url = (Url.fromString flags.location) 
        route = case mb_url of
                Just url -> parse_url url
                Nothing -> HomeR
    in 
    ( init_model2 route
        |> (\m ->
                { m
                    | local_version = flags.local_version
                    , server_version = Loading
                }
           )
    , api_get_version Version
    
    )
{-
init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( init_model key (parse_url url)
        |> (\m ->
                { m
                    | local_version = flags.local_version
                    , server_version = Loading
                }
           )
    , api_get_version Version
    )
-}
main : Program Flags Model Msg 
main = Browser.element {init=init2, view=view2,update=update,subscriptions=subscriptions} 
{-
main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }
-}
