-- A nicer API around pablohirafuji/elm-markdown


module MarkdownWrapper exposing (..)

import Html exposing (Html, em, strong, br, code, node, text, img, a)
import Html.Attributes exposing (src, href, attribute, alt, title)
import Markdown
import Markdown.Block exposing (Block)
import Markdown.Inline exposing (..)
import Markdown.Config exposing (Options)
--import Markdown.Helpers exposing (Attribute)

parse : String -> List (Block b i)
parse = Markdown.Block.parse Nothing

parseWith : Options -> String -> List (Block b i)
parseWith o = Markdown.Block.parse (Just o)

--testHtml : Inline i -> Maybe (Html msg)
--testHtml inline =
--  case inline of
--    Text str -> Html.text ("456" ++ str ++ "123") |> Just
--    _ -> Nothing
--
--customizeInlineHtml : (Inline i -> Maybe (Html msg)) -> Inline i -> Html msg
--customizeInlineHtml customTransformer inline =
--  case (customTransformer inline) of
--    Just html -> html
--    Nothing ->
--      let
--                transformer : Inline i -> Html msg
--                transformer =
--                    Maybe.withDefault (defaultHtml Nothing) customTransformer
--
--
--            in case inline of
--                Text str ->
--                    text str
--
--
--                HardLineBreak ->
--                    br [] []
--
--
--                CodeInline codeStr ->
--                    code [] [ text codeStr ]
--
--
--                Link url maybeTitle inlines ->
--                    case maybeTitle of
--                        Just title_ ->
--                            a [ href url, title title_ ]
--                                (List.map transformer inlines)
--
--
--                        Nothing ->
--                            a [ href url ]
--                                (List.map transformer inlines)
--
--
--                Image url maybeTitle inlines ->
--                    case maybeTitle of
--                        Just title_ ->
--                            img
--                                [ alt (extractText inlines)
--                                , src url
--                                , title title_
--                                ] []
--
--
--                        Nothing ->
--                            img
--                                [ alt (extractText inlines)
--                                , src url
--                                ] []
--
--
--                HtmlInline tag attrs inlines ->
--                    node tag
--                        (attributesToHtmlAttributes attrs)
--                        (List.map transformer inlines)
--
--
--                Emphasis length inlines ->
--                    case length of
--                        1 ->
--                            em [] (List.map transformer inlines)
--
--
--                        2 ->
--                            strong [] (List.map transformer inlines)
--
--
--                        _ ->
--                            if length - 2 > 0 then
--                                strong []
--                                    <| flip (::) []
--                                    <| transformer
--                                    <| Emphasis (length - 2) inlines
--
--
--                            else
--                                em [] (List.map transformer inlines)
--
--
--                Custom _ inlines ->
--                    text ""
--attributesToHtmlAttributes : List Attribute -> List (Html.Attribute msg)
--attributesToHtmlAttributes =
--    List.map attributeToAttribute
--
--
--attributeToAttribute : Attribute -> Html.Attribute msg
--attributeToAttribute ( name, maybeValue ) =
--    attribute name (Maybe.withDefault name maybeValue)
--customizeInlineHtml : (Inline i -> Maybe (Html msg)) -> Inline i -> Html msg
--customizeInlineHtml f inline =
--  case (f inline) of
--    Just html -> html
--    Nothing -> case blockChildren inline of
--      Just children -> defaultHtml (Just (customizeInlineHtml f)) inline
--      Nothing -> defaultHtml Nothing inline
--
--customizeBlockHtml : (Block i -> Maybe (Html msg)) -> Block i -> Html msg
--customizeBlockHtml f block =
--  case (f block) of
--    Just html -> html
--    Nothing -> case blockChildren block of
--      Just children -> defaultHtml (Just (customizeBlockHtml f)) block
--      Nothing -> defaultHtml Nothing block
--
--blockChildren : Block i -> Maybe (List (Inline i))
--blockChildren inline =
--  case inline of
--    Link _ _ children -> Just children
--    _ -> Nothing
--
--inlineChildren : Inline i -> Maybe (List (Inline i))
--inlineChildren inline =
--  case inline of
--    Link _ _ children -> Just children
--    _ -> Nothing
