module Code exposing (Route, route, view)

import Crash
import Html exposing (Html, b, br, div, input, pre, text)
import Html.Attributes exposing (attribute, id, placeholder, style)
import Routing
import UrlParser exposing (..)


route =
    oneOf
        [ map Routing.NonElm (s "maplestory-lmpq-solver.html")
        ]


type Route
    = SHOULDNTBEUSED


type alias Model =
    { route : Route }


view model =
    case model.route of
        SHOULDNTBEUSED ->
            Crash.view
