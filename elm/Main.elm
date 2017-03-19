import Html exposing (Html, a, div)
import Html.Attributes exposing (href, title)
import Html.Events exposing (defaultOptions, onWithOptions)
import Json.Decode
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
    Markdown.Inline.Link url maybeTitle inlines ->
      a [href url, title (Maybe.withDefault "" maybeTitle), onPreventDefaultClick (NewUrl url)] (List.map link inlines)
    _ -> Markdown.Inline.defaultHtml (Just link) inline

onPreventDefaultClick message =
    onWithOptions "click"
        { defaultOptions | preventDefault = True }
        (preventDefault2
            |> Json.Decode.andThen (maybePreventDefault message)
        )
preventDefault2 =
    Json.Decode.map2
        (invertedOr)
        (Json.Decode.field "ctrlKey" Json.Decode.bool)
        (Json.Decode.field "metaKey" Json.Decode.bool)
maybePreventDefault msg preventDefault =
    case preventDefault of
        True ->
            Json.Decode.succeed msg

        False ->
            Json.Decode.fail "Normal link"
invertedOr : Bool -> Bool -> Bool
invertedOr x y =
    not (x || y)

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
