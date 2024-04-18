module Route exposing (..)

import Url exposing (Url)
import Url.Parser as UP


type Route
    = HomeRoute
    | UserRoute String
    | NotFound


parse_url : Url -> Route
parse_url url =
    case UP.parse match_route url of
        Just route ->
            route

        Nothing ->
            NotFound


match_route : UP.Parser (Route -> a) a
match_route =
    UP.oneOf
        [ UP.map HomeRoute UP.top
        , UP.map UserRoute UP.string
        ]

