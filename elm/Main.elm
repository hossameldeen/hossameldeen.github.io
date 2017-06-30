module Main exposing (..)

import Code
import Html exposing (Html)
import MarkdownWrapper as MD
import Navigation
import NotFound
import Routing
import UrlParser exposing (..)
import Writing


main : Program Never Model Routing.Msg
main =
    Navigation.program Routing.UrlChange
        { init = \loc -> update (Routing.UrlChange loc) { route = Home }
        , update = update
        , subscriptions = \_ -> Routing.onUrlDecoded Routing.UrlDecoded
        , view = view
        }



-- MODEL


type alias Model =
    { route : Route
    }


type Route
    = Home
    | NotFound
    | Writing Writing.Route
    | Code Code.Route


route : Parser (Routing.Result Route -> internalTypeOfParser) internalTypeOfParser
route =
    oneOf
        [ map (Routing.Elm Home) top
        , map (Routing.compose Writing) (s "writing" </> Writing.route)
        , map (Routing.compose Code) (s "code" </> Code.route)
        ]



-- UPDATE


update :
    Routing.Msg
    -> Model
    -> ( Model, Cmd msg )
update msg model =
    case Debug.log "update" msg of
        Routing.GoToUrl s ->
            ( model, Routing.decodeUrl s )

        Routing.UrlDecoded ( loc, origin ) ->
            if origin /= loc.origin then
                model ! [ Navigation.load loc.href ]
            else
                onUrlChanged loc model True

        Routing.UrlChange loc ->
            onUrlChanged loc model False


onUrlChanged :
    Navigation.Location
    -> Model
    -> Bool
    -> ( Model, Cmd msg )
onUrlChanged loc model isFromElmCode =
    case parsePath route loc of
        Nothing ->
            { model | route = NotFound } ! []

        Just res ->
            case res of
                Routing.Elm route ->
                    if isFromElmCode then
                        model ! [ Navigation.newUrl loc.href ]
                    else
                        { model | route = route } ! []

                Routing.NonElm ->
                    model ! [ Navigation.load (Debug.log "NonElmUrl: " loc.href) ]



-- VIEW


view : Model -> Html Routing.Msg
view { route } =
    case route of
        Home ->
            MD.viewMD content

        NotFound ->
            NotFound.view

        Writing route ->
            Writing.view { route = route }

        Code route ->
            Code.view { route = route }


viewHome : a -> Html Routing.Msg
viewHome dontCare =
    MD.viewMD content



-- CONTENT


content : String
content =
    """
I'm Hossam El-Deen and this is my personal website.
I hold no responsibility whatsoever for anything on it.
I may lie. I may be wrong. I may change my mind anytime I want.

Use at your own risk.

## Writing

- [Stress](/writing/stress)

## Code

- [Maplestory Ludimaze PQ Solver](/code/maplestory-lmpq-solver.html).
Please, note that I don't endorse Maplestory in anyway whatsoever. I
haven't played it in long time.

"""
