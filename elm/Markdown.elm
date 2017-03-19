import Parser exposing (..)

-- The AST is partially (or fully) taken from here:
-- https://hackage.haskell.org/package/commonmark-ast-0.1.0.0/candidate/src/src/Text/Commonmark/Syntax.hs
type Document
  = Blocks

type Blocks
  = List Block

type Block
  = ThematicBreak
  -- | Heading: level, sequnce of inlines that define content
  | Heading HeadingLevel (Inlines t)
  -- | Block of code: info string, literal content
  | CodeBlock (Maybe t) t
  -- | Raw HTML Block
  | HtmlBlock t
  -- | Paragraph (a grouped sequence of inlines)
  | Para (Inlines t)
  -- | Block Quote (a quoted sequence of blocks)
  | Quote (Blocks t)
  -- | List: Type of the list, tightness, a sequnce of blocks (list item)
  | List ListType Bool (List (Blocks t))

type HeadingLevel
  = Heading1
  | Heading2
  | Heading3
  | Heading4
  | Heading5
  | Heading6

type ListType
  = Ordered Delimiter Int
  | Bullet BulletMarker

type Delimiter
  = Period
  | Paren

type BulletMarker
  = Minus
  | Plus
  | Asterisk

type Inlines
  = List Inline

type Inline
  = Str String
  | Code String
  | Emph Inlines
  | Strong Inlines
  | Link Inlines String (Maybe String) -- TODO: special types
  | Image Inlines String (Maybe String) -- TODO: special types
  | RawHtml t
  | SoftBreak
  | HardBreak

-- http://spec.commonmark.org/0.27/#preliminaries

character
  =