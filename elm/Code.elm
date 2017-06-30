module Code exposing (Route, route, view)

import Crash
import Html exposing (Html)
import Routing
import UrlParser exposing (..)


route : Parser (Routing.Result route -> internalTypeOfParser) internalTypeOfParser
route =
    oneOf
        [ map Routing.NonElm (s "maplestory-lmpq-solver.html")
        ]


type Route
    = SHOULDNTBEUSED


type alias Model =
    { route : Route }


view : Model -> Html Routing.Msg
view model =
    case model.route of
        SHOULDNTBEUSED ->
            Crash.view
