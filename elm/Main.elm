import Html exposing (Html, program)
import Markdown


main : Program Never Model Msg
main =
  program
    { init =  (model, initialSizeCmd)
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

-- MODEL

type alias Model =
    {
    }


-- UPDATE

type Msg = NoMsgTypeYet

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  model ! []


-- VIEW

view : Model -> Html Msg
view model =
  Markdown.toHtmlWith
    { githubFlavored = Just { tables = False, breaks = True }
    , defaultHighlighting = Nothing
    , sanitize = True
    , smartypants = False
    }
    [] content


-- SUBSCRIPTIONS

--
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
--}


-- INIT

--
initialSizeCmd : Cmd Msg
initialSizeCmd =
  Cmd.none
--}

model : Model
model =
  {
  }


-- CONTENT

content : String
content = """
I'm Hossam El-Deen and this is my personal website.
I hold no responsibility whatsoever for anything on it.
I may lie. I may be wrong. I may change my mind anytime I want.
Use at your own risk.

## Writing

- [Stress](/stress.txt)

## Code

- [Maplestory Ludimaze PQ Solver](/maplestory-lmpq-solver.html).
Please, note that I don't endorse Maplestory in anyway whatsoever. I
haven't played it in long time.

"""