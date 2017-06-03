var app = Elm.Main.embed(document.body);

// To make use of the `URL` lib since there's nothing like it in Elm
app.ports.decodeUrl.subscribe(
    url => app.ports.onUrlDecoded.send([
               urlToLocation(new URL(url, window.location.href)),
               window.location.origin
           ])
);

const urlToLocation = url => ({
    href : url.href,
    host : url.host,
    hostname : url.hostname,
    protocol : url.protocol,
    origin : url.origin,
    port_ : url.port,
    pathname : url.pathname,
    search : url.search,
    hash : url.hash,
    username : url.username,
    password : url.password
});