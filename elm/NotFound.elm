module NotFound exposing (view)

import Html exposing (Html)
import MarkdownWrapper as MD

-- VIEW

view : Html MD.Msg
view =
  MD.viewMD content


-- CONTENT

content : String
content = """
The link you wrote doesn't exist.

Go to [https://hossameldeengithub.io/](https://hossameldeengithub.io/)? perhaps you find it there.
"""