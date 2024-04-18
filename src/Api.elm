module Api exposing (..)

import Http
import HttpBuilder
import Json.Decode as D
import Json.Encode as E
import RemoteData exposing (WebData)


encode_user : E.Value
encode_user =
    E.object [ ( "email", E.string "test@gmail.com" ), ( "username", E.string "test" ) ]


get_users_api : (WebData (List String) -> msg) -> Cmd msg
get_users_api msg =
    HttpBuilder.post "/api/user"
        |> HttpBuilder.withJsonBody encode_user
        |> HttpBuilder.withTimeout 10000
        |> HttpBuilder.withExpect
            (Http.expectJson
                (RemoteData.fromResult >> msg)
                (D.list D.string)
            )
        |> HttpBuilder.request
