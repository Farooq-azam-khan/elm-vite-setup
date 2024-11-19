module Api exposing (..)

import Http
import HttpBuilder
import Json.Decode as D
import Json.Encode as E
import RemoteData exposing (WebData)


encode_user : E.Value
encode_user =
    E.object [ ( "email", E.string "test@gmail.com" ), ( "username", E.string "test" ) ]


api_get_version : (WebData String -> msg) -> Cmd msg
api_get_version msg =
    "/api/version/latest"
        |> HttpBuilder.get
        |> HttpBuilder.withExpect
            (Http.expectJson
                (RemoteData.fromResult >> msg)
                D.string
            )
        |> HttpBuilder.request


get_users_api : (WebData (List String) -> msg) -> Cmd msg
get_users_api msg =
    "/api/user"
        |> HttpBuilder.get
        -- |> HttpBuilder.withJsonBody encode_user
        |> HttpBuilder.withTimeout 10000
        |> HttpBuilder.withExpect
            (Http.expectJson
                (RemoteData.fromResult >> msg)
                (D.list D.string)
            )
        |> HttpBuilder.request
