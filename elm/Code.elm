port module Code exposing (view)

import Html exposing (Html, pre, text, div, br, b, input)
import Html.Attributes exposing (attribute, style, id, placeholder)

-- VIEW

view : String -> Maybe (Html a)
view pageName =
  if pageName == "maplestory-lmpq-solver" then
    div [style [("text-align", "center"), ("font-size", "26px")]]
      [ script
      , br [] [], br [] []
      , input [ attribute "type" "number", id "src", placeholder "Your Room", style [("font-size", "26px")]] [addListener "src"], br [] []
      , input [ attribute "type" "number", id "dest", placeholder "Goal Room", style [("font-size", "26px")]] [addListener "dest"], br [] []
      , br [] [], b [] [div [id "sol", style [("display", "inline")]] [text "To find the shortest path between 2 rooms in Ludi maze PQ, enter their numbers above (e.g, 3 and 8)"]
      ]
      ] |> Just
  else
    Nothing

addListener id = Html.node "script" [] [text ("""
  // To add the event listeners
  (function() {
    document.getElementById("
""" ++ id ++ """
").addEventListener("input", function(e) {update(); console.log("hi")});
  })();
""")]

-- idea credit: http://stackoverflow.com/a/30543085/6690391
script = Html.node "script" [] [text """
  function solve(src, dest) {

    const steps = [ 4,   7,   -3],
          names = ['L', 'M', 'R'],
          nRooms = 16;

    --src; --dest;

    var Q = [[src, []]];

    var nIterations = 0;

    while(Q.length > 0) {

      var curRoom = Q[0][0], curPath = Q[0][1];
      Q.shift();
      console.log(curRoom);
      if (curRoom == dest) return curPath;

      for (var i = 0; i < steps.length; ++i) {
        var newRoom = (curRoom + steps[i] + nRooms - 1) % (nRooms - 1);
        if ((curRoom === 8 || curRoom === 15) && names[i] === 'M')
          newRoom = 15 + 8 - curRoom;

        Q.push([newRoom, curPath.concat(names[i])]);
      }

      ++nIterations;
      if (nIterations > 1000000) {
        return "Took too long to calculate it. A bug on my side."
      }

    }

    return "Found no path. A bug on my side.";
  }

  function update() {
    var src = parseInt(document.getElementById("src").value),
        dest = parseInt(document.getElementById("dest").value);
    var sol = document.getElementById("sol");

    sol.innerHTML = "";

    if (isNaN(src) || isNaN(dest) || src < 1 || src > 16 || dest < 1 || dest > 16) {
      sol.innerHTML = "Please, make sure both rooms are in the range [1-16]."
      return;
    }

    var minPath = solve(src, dest);

    sol.innerHTML = minPath.length == 0 ? "You're already there" : minPath;
  }
"""]