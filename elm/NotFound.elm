module NotFound exposing (view)

import Html exposing (Html)
import MarkdownWrapper as MD
import Routing

-- VIEW

view : Html Routing.Msg
view =
  MD.viewMD content


-- CONTENT

content : String
content = """
The link you wrote doesn't exist.

Go to [https://hossameldeen.github.io/](https://hossameldeen.github.io/)? perhaps you find it there.
"""