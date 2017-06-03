port module Routing exposing (decodeUrl, onUrlDecoded, Result(..), Msg(..), compose)

import Html exposing (Html)
import Navigation


port decodeUrl : String -> Cmd msg

-- The string is your website's origin, NOT the decoded url's location.
port onUrlDecoded : ((Navigation.Location, String) -> msg) -> Sub msg

type Result route =
    Elm route
  | NonElm String Bool -- Bool : True for relative, in respect to Elm logic. False for absolute (whether same domain or no).

type Msg =
    UrlChange Navigation.Location
  | NewUrl String
  | UrlDecoded (Navigation.Location, String)

compose : String -> (a -> b) -> Result a -> Result b
compose parent constructor result =
  case result of
    Elm route -> Elm (constructor route)
    NonElm url isRelative -> NonElm (if isRelative then parent ++ "/" ++ url else url) isRelative
