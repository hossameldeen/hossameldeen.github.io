module Routing exposing (Result(..), Msg(..), compose)

import Html exposing (Html)
import Navigation

--
type Result route =
    Elm route
  | NonElm String Bool -- Bool : True for relative, in respect to Elm logic. False for absolute (whether same domain or no).

type Msg =
    UrlChange Navigation.Location
  | NewUrl String

compose : String -> (a -> b) -> Result a -> Result b
compose parent constructor result =
  case result of
    Elm route -> Elm (constructor route)
    NonElm url isRelative -> NonElm (if isRelative then parent ++ "/" ++ url else url) isRelative
