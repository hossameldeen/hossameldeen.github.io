import Html exposing (Html, div)
import Markdown
import Markdown.Block
import Markdown.Inline
import Markdown.Config
import Navigation exposing (Location)
import UrlParser exposing (..)


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
view model =
    content
    |> Markdown.Block.parse (Just {softAsHardLineBreak = True, rawHtml = Markdown.Config.DontParse})
    |> List.map (Markdown.Block.defaultHtml Nothing (Just link))
    |> List.concat
    |> div []

link inline =
  case inline of
    Markdown.Inline.Link url maybeTitle inlines -> Html.text "hamada"
    _ -> Markdown.Inline.defaultHtml (Just link) inline

-- CONTENT

content = """
I'm Hossam El-Deen and this is my personal website.
I hold no responsibility whatsoever for anything on it.
I may lie. I may be wrong. I may change my mind anytime I want.

Use at your own risk.

## Writing

- [Stress](/writing/stress.txt)

## Code

- [Maplestory Ludimaze PQ Solver](/maplestory-lmpq-solver.html).
Please, note that I don't endorse Maplestory in anyway whatsoever. I
haven't played it in long time.

"""
