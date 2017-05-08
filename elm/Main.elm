import NotFound
import Writing
import Code

import Html exposing (Html)
import Navigation
import UrlParser exposing (..)
import MarkdownWrapper as MD
import Routing
import Crash


main : Program Never Model Routing.Msg
main =
  Navigation.program Routing.UrlChange
    { init =  (\loc -> ({route = route loc}, Cmd.none))
    , update = update
    , subscriptions = (\_ -> Sub.none)
    , view = view
    }

-- MODEL

type alias Model =
  { route : Routing.Result Route
  }

type Route = Home | NotFound | Writing Writing.Route | Code Code.Route

route : Navigation.Location -> Routing.Result Route
route loc =
  ((oneOf
    [ map (Routing.Elm Home) top
    , map (Routing.compose "writing" Writing) (s "writing" </> Writing.route)
    , map (Routing.compose "code" Code) (s "code" </> Code.route)
    ]
  |> parsePath) <| loc) |> Maybe.withDefault (Routing.Elm NotFound)



-- UPDATE

update msg model =
  case msg of
    Routing.UrlChange loc -> case route loc of
      Routing.Elm route -> { model | route = Routing.Elm route } ! []
      Routing.NonElm url _ -> (model, Navigation.load url)
    Routing.NewUrl s ->
      (model, Navigation.newUrl s)


-- VIEW

view : Model -> Html Routing.Msg
view {route} =
  case route of
    Routing.Elm Home -> MD.viewMD content
    Routing.Elm NotFound -> NotFound.view
    Routing.Elm (Writing route) -> Writing.view {route = route}
    Routing.Elm (Code route) -> Code.view {route = route}
    Routing.NonElm _ _ ->  Crash.view

viewHome dontCare =
  MD.viewMD content

-- CONTENT

content = """
I'm Hossam El-Deen and this is my personal website.
I hold no responsibility whatsoever for anything on it.
I may lie. I may be wrong. I may change my mind anytime I want.

Use at your own risk.

## Writing

- [Stress](/writing/stress)

## Code

- [Maplestory Ludimaze PQ Solver](/code/maplestory-lmpq-solver).
Please, note that I don't endorse Maplestory in anyway whatsoever. I
haven't played it in long time.

"""
