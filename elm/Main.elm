import NotFound
import Writing
import Code

import MarkdownWrapper as MD
import Routing
import Crash

import Html exposing (Html)
import Navigation
import UrlParser exposing (..)
import List.Nonempty as NE exposing (Nonempty, (:::))
import Ports


main : Program Never Model Routing.Msg
main =
  Navigation.program Routing.UrlChange
    { init =  (\loc -> update (Routing.UrlChange loc) {route = Home})
    , update = update
    , subscriptions = (\_ -> Routing.onUrlDecoded Routing.UrlDecoded)
    , view = view
    }

-- MODEL

type alias Model =
  { route : Route
  }

type Route = Home | NotFound | Writing Writing.Route | Code Code.Route

route =
  oneOf
    [ map (Routing.Elm Home) top
    , map (Routing.compose "writing" Writing) (s "writing" </> Writing.route)
    , map (Routing.compose "code" Code) (s "code" </> Code.route)
    ]


-- UPDATE

update msg model =
  case Debug.log "update of main:" msg of
    Routing.NewUrl s -> (model, Routing.decodeUrl s)
    Routing.UrlDecoded (loc, origin) ->
      if Debug.log "comp res" ((Debug.log "left" origin) /= (Debug.log "right" loc.origin)) then model ! [Navigation.load loc.href] else urlChange2 loc model
    Routing.UrlChange loc -> urlChange loc model

urlChange loc model =
  case Debug.log "hamada" (parsePath route loc) of
    Nothing -> { model | route = NotFound } ! []
    Just res ->
      case res of
        Routing.Elm route -> { model | route = route } ! []
        Routing.NonElm url _ -> model ! [Navigation.load url]

urlChange2 loc model =
  case Debug.log "hamada2" (parsePath route loc) of
    Nothing -> { model | route = NotFound } ! []
    Just res ->
      case res of
        Routing.Elm route -> { model | route = route } ! [Navigation.newUrl loc.href]
        Routing.NonElm url _ -> model ! [Navigation.load url]


-- VIEW

view : Model -> Html Routing.Msg
view {route} =
  case route of
    Home -> MD.viewMD content
    NotFound -> NotFound.view
    (Writing route) -> Writing.view {route = route}
    (Code route) -> Code.view {route = route}

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
