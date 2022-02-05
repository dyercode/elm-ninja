import { Elm } from "./Main.elm";

const basePath = new URL(document.baseURI).pathname;

let app = Elm.Main.init({
  node: document.querySelector("main"),
  flags: { basePath: basePath === "/" ? "" : basePath },
});

app.ports.consoleLog.subscribe(console.log);
