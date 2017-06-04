module Code exposing (route, Route, view)

import Html exposing (Html, pre, text, div, br, b, input)
import Html.Attributes exposing (attribute, style, id, placeholder)
import UrlParser exposing (..)
import Routing
import Crash

route =
  oneOf
    [ map (Routing.NonElm) (s "maplestory-lmpq-solver.html")
    ]

type Route = SHOULDNTBEUSED

type alias Model = { route : Route }

view model =
  case model.route of
    SHOULDNTBEUSED -> Crash.view