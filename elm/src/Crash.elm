module Crash exposing (view)

import Html exposing (Html)
import MarkdownWrapper as MD
import Routing


-- VIEW


view : Html Routing.Msg
view =
    MD.viewMD content



-- CONTENT


content : String
content =
    """
Oops, I did some unexpected mistake.

Perhaps go to [https://hossameldeengithub.io/](https://hossameldeengithub.io/) and hope you don't face it again?
"""
