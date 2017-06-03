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

  case msg of
    Routing.NewUrl s ->
      (model, Routing.decodeUrl s)

    Routing.UrlDecoded (loc, origin) ->
      let
        sameOrigin = origin == loc.origin
        elmPage = isElmPage loc
        moveToUrl = model ! [Navigation.newUrl loc.href] -- doesn't force a page load, so Elm is still in control
        loadUrl = model ! [Navigation.load loc.href] -- forces a page load. So, first checks the existing files (or goes to another website entirely)
      in
        if sameOrigin && elmPage then
          moveToUrl -- This will fire a UrlChange
        else
          loadUrl

    Routing.UrlChange loc ->
      onUrlChanged loc model

-- Assumes the origin is your website.
isElmPage loc =
  case parsePath route loc of
    Nothing -> True
    Just (Routing.Elm _) -> True
    Just (Routing.NonElm _ _) -> False

onUrlChanged loc model =
  case parsePath route loc of
    Nothing -> { model | route = NotFound } ! []
    Just res ->
      case res of
        Routing.Elm route -> { model | route = route } ! []
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
