Actually, this README is directed at me. This is a personal project and not meant to be used by anyone else.

Use `./sss-elm-live.sh` while developing/writing locally. When you commit `pre-commit` will run, which compiles your `Elm` code and generates the js files in `assets/gen/`.

For the code structure, you're obliged to provide an `index.html` which is the page loaded when someone accesses `hossameldeen.github.io`, and `404.html` which is the page loaded when someone writes a non-existing url. Also, note that any file is accessible, so beware.

Currently, you have two Elm entries, one for the `index.html` and another for `404.html`. You probably change that and should make it only one that handles all urls (except files).


Mar-19, 2017: Currently, you're thinking about understanding regular expressions https://developer.mozilla.org/en/docs/Web/JavaScript/Guide/Regular_Expressions
Your bigger problem: clicking on links & wanting to have an Elm representation of Markdown.

Now, you're thinking about using elm-tools/parser and write a simple parser for what you need & increment on it only when you need.
