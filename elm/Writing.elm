module Writing exposing (Route, route, view)

import Html exposing (Html, pre, text)
import Html.Attributes exposing (style)
import MarkdownWrapper as MD
import Routing
import UrlParser exposing (..)


route =
    oneOf
        [ map (Routing.Elm Stress) (s "stress")
        ]



-- VIEW


type alias Model =
    { route : Route }


type Route
    = Stress


view : Model -> Html msg
view model =
    case model.route of
        Stress ->
            pre [ style [ ( "word-wrap", "break-word" ), ( "white-space", "pre-wrap" ) ] ] [ text stress ]



-- CONTENT


stress : String
stress =
    """
Stress
======

Computers, TV and books are very stressful to me.

Did you ever try to study with a feast right outside your room? Or
even worse, a Ctrl+T away? And not only that, but also an ever-
changing feast only the knowing of which thristens and satisfies your
curiosity. That's what dealing with computers is like.

Computers are these great, really great simulators. Want to be in war?
... What a breeze. Want to sit with the funniest people on Earth? ...
No problem.

So are the TV and books. Only less interactive, with less control on
them, and more clumsy.

But does that render them purely evil?

The real world doesn't happen in books. It happens out there. On the
street outside your apartment. That's what you should be interacting
with, that's what you should be a master in dealing with.

But again, does this render the subjects useless?

Every culture is rich in some ideas and poor in others. I forgot the
count of acquaintances who see nothing wrong with staring. With apply-
ing an X-ray scan with their eyes on anyone walking on the streets. To
you of my acquaintances, *this is not okay!*

Same goes for a community that has never heard of sada2a, that has
never heard of feeding a traveller, "son of the road" as we call in
Arabic.

So, these people, perhaps they would never get in touch with such
ideas except through a simulation of lives outside theirs, out their
streets.

So, computers are what computers are. They are useful, they are handy.
But it's not right obe able to feast 24/7 with only a click away. This
makes me *very* stressed. Books are no different, but they're more
scarce and more clumsy.

Probably, in order for computers to be less stressful to me, I need to
find a way to make it harder to access the feast within it. I need to
separate between its feasts and its palms. Feasts can no longer be a
Ctrl+T away.

But I probably won't. If you do, please tell me.
======================================================================

"""
