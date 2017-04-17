-- A nicer API around pablohirafuji/elm-markdown


module MarkdownWrapper exposing (..)

import Html exposing (Html)
import Markdown
import Markdown.Block exposing (Block)
import Markdown.Inline exposing (..)
import Markdown.Config exposing (Options)

parse : String -> List (Block b i)
parse = Markdown.Block.parse Nothing

parseWith : Options -> String -> List (Block b i)
parseWith o = Markdown.Block.parse (Just o)
