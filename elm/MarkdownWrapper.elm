-- A nicer API around pablohirafuji/elm-markdown


module MarkdownWrapper exposing (viewMD)

import Html exposing (Html, a, div)
import Html.Attributes exposing (href, title)
import Html.Events exposing (defaultOptions, onWithOptions)
import Json.Decode
import Markdown as MD
import Markdown.Block as MDBlock
import Markdown.Inline as MDInline
import Markdown.Config as MDConfig
import Routing

-- Not worth making a new Msg type since it only emits Link msgs. And if this changes in the future, refactoring is
-- advertised as something safe in Elm.
viewMD : String -> Html (Routing.Msg)
viewMD content =
    content
    |> parseWith {softAsHardLineBreak = True, rawHtml = MDConfig.DontParse}
    |> List.map (MDBlock.defaultHtml Nothing (Just customizeLink))
    |> List.concat
    |> div []

parse : String -> List (MDBlock.Block b i)
parse = MDBlock.parse Nothing

parseWith : MDConfig.Options -> String -> List (MDBlock.Block b i)
parseWith o = MDBlock.parse (Just o)

customizeLink inline =
  case inline of
    MDInline.Link url maybeTitle inlines ->
      a [href url, title (Maybe.withDefault "" maybeTitle), onPreventDefaultClick (Routing.NewUrl url)] (List.map customizeLink inlines)
    _ -> MDInline.defaultHtml (Just customizeLink) inline

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