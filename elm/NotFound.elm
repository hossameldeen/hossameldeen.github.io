import Html exposing (Html, div, program)
import Markdown
import Markdown.Config


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
  Markdown.toHtml (Just {softAsHardLineBreak = True, rawHtml = Markdown.Config.DontParse}) content |> div []


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
The link you wrote doesn't exist.

Go to [https://hossameldeengithub.io/](https://hossameldeengithub.io/)? perhaps you find it there.
"""