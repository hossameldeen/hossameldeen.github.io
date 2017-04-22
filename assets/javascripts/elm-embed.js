var app = Elm.Main.fullscreen();
app.ports.title.subscribe(function(title) {
    document.title = title;
});