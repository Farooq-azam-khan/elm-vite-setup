module Route exposing (..)

import Url exposing (Url)
import Url.Parser as UP


type Route
    = HomeR
    | UserR String
    | ComponentsR
    | NotFoundR


parse_url : Url -> Route
parse_url url =
    case UP.parse match_route url of
        Just route ->
            route

        Nothing ->
            NotFoundR


match_route : UP.Parser (Route -> a) a
match_route =
    UP.oneOf
        [ UP.map HomeR UP.top
        , UP.map ComponentsR (UP.s "components")
        , UP.map UserR UP.string
        ]
