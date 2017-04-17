Actually, this README is directed at me. This is a personal project and not meant to be used by anyone else.

Use `./sss-elm-live.sh` while developing/writing locally. When you commit `pre-commit` will run, which compiles your `Elm` code and generates the js files in `assets/gen/`.

Github pages will load `index.html` when someone accesses `hossameldeen.github.io`, and `404.html` when someone accesses a non-existing url. Also, not that any file is accessible, so beware.

You wanted to deal with everything in Elm (including urls), so you've decided to only provide `404.html`. Then, in the Elm code for the `404.html` page, you check if the url written (perhaps even just `hossameldeen.github.io`) is a valid url in the app or no. If it's not a valid url then, in Elm, you show the page that'd have been shown in a real `404.html`.  
While testing locally, you'll need to open `404.html` instead of `/`. Github pages will handle this redirect on its servers.

Yes, this has the bad side of (probably) not being indexed in search engines and (probably) not being blind-friendly, but let's hope this problem is solved when Elm does server-side rendering.

Current status: Seems like good progress. TODOs:
- Run elm-live and see the problem.
- `Writing` returns `Html a`, I was think it should return `Html Never`. In general, you probably need to think again of the structure of this part `|> Html.map (\msg -> case msg of MD.NewUrl s -> NewUrl s)`.
- Ummm.., regarding Point-1, perhaps adding an `index.html` for the local testing would solve it?
- You didn't implement `Code` page yet. Probably, you'll need to either port the current `lmpq-solver` page to Elm or you'll need to do something to get you of Elm and back in again.
