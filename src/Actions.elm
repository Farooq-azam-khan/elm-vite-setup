module Actions exposing (..)
import RemoteData exposing (WebData) 
import Url exposing (Url) 
import Ports 

type Msg
    = Increment
    | GetUsers
    | UserMsg (WebData (List String))
    | Decrement
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetUsers ->
            ( { model | users = Loading }, get_users_api UserMsg )

        UserMsg users ->
            ( { model | users = users }, Cmd.none )

        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

        ChangedUrl url ->
            ( model, Cmd.none )

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.External href ->
                    ( model, Nav.load href )

                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



