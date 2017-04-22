import NotFound
import Writing
import Code

import Html exposing (Html)
import Navigation exposing (Location)
import UrlParser exposing (..)
import MarkdownWrapper as MD


main : Program Never Model Msg
main =
  Navigation.program UrlChange
    { init =  (\loc -> ({route = route loc}, Cmd.none))
    , update = update
    , subscriptions = (\_ -> Sub.none)
    , view = view
    }

-- MODEL

type alias Model =
    { route : Route
    }

type Route = Home | NotFound | Writing String | Code String

route loc =
  ((oneOf
    [ map Home top
    , map Writing (s "writing" </> string)
    , map Code (s "code" </> string)
    ]
  |> parsePath) <| loc) |> Maybe.withDefault NotFound



-- UPDATE

type Msg = UrlChange Navigation.Location
         | NewUrl String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UrlChange loc ->
      {model | route = route loc} ! []
    NewUrl s ->
      (model, Navigation.newUrl s)


-- VIEW

view : Model -> Html Msg
view {route} =
  case route of
    Home -> MD.viewMD content |> Html.map (\msg -> case msg of MD.NewUrl s -> NewUrl s)
    NotFound -> NotFound.view |> Html.map (\msg -> case msg of MD.NewUrl s -> NewUrl s)
    Writing pageName -> Writing.view pageName |> Maybe.withDefault NotFound.view |> Html.map (\msg -> case msg of MD.NewUrl s -> NewUrl s)
    Code pageName -> Code.view pageName |> Maybe.withDefault NotFound.view |> Html.map (\msg -> case msg of MD.NewUrl s -> NewUrl s)


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
