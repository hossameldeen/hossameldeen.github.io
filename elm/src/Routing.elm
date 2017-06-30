port module Routing exposing (Msg(..), Result(..), compose, decodeUrl, onUrlDecoded)

import Navigation


port decodeUrl : String -> Cmd msg



-- The string is your website's origin, NOT the decoded url's location.


port onUrlDecoded : (( Navigation.Location, String ) -> msg) -> Sub msg


type Result route
    = Elm route
    | NonElm


type Msg
    = UrlChange Navigation.Location
    | GoToUrl String
    | UrlDecoded ( Navigation.Location, String )


compose : (a -> b) -> Result a -> Result b
compose constructor result =
    case result of
        Elm route ->
            Elm (constructor route)

        NonElm ->
            NonElm
