module Actions exposing (..)
type Msg
    = Increment
    | GetUsers
    | UserMsg (WebData (List String))
    | Decrement
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest


