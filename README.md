Actually, this README is directed at me. This is a personal project and not meant to be used by anyone else.

Use `./sss-elm-live.sh` while developing/writing locally. When you commit `pre-commit` will run, which compiles your `Elm` code and generates the js files in `assets/gen/`.

Github pages will load `index.html` when someone accesses `hossameldeen.github.io`, and `404.html` when someone accesses a non-existing url. Also, not that any file is accessible, so beware.

You wanted to deal with everything in Elm (including urls), so you've decided to only provide `404.html`. Then, in the Elm code for the `404.html` page, you check if the url written (perhaps even just `hossameldeen.github.io`) is a valid url in the app or no. If it's not a valid url then, in Elm, you show the page that'd have been shown in a real `404.html`.  
While testing locally, you'll need to provide an `index.html` identical to `404.html` because `elm-live` opens `index.html`. Also, note that elm-live opens `index.html` on 404 errors if `--pushstate` is provided (which you've done).

Yes, this has the bad side of (probably) not being indexed in search engines and (probably) not being blind-friendly, but let's hope this problem is solved when Elm does server-side rendering.

Current status:
- Implementing `Code` in Elm, you're trying to rewrite as little as possible to try the heroic act of embedding HTML/CSS/JS in Elm.
- Run `elm-live` and see the problem. You have a problem with `addListener`.
- The place of `addListener` in the code is a hack. Seems like you have no guarantee on the order of creating/appending the DOM nodes. So, when you put it elsewhere it got a `null` error.
- An idea to see if there's a way in Elm to know when an Html got rendered and make a port for that event.
