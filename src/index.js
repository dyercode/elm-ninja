import { Elm } from "./Main.elm";

const basePath = new URL(document.baseURI).pathname;

Elm.Main.init({
  node: document.querySelector("main"),
  flags: { basePath: basePath === "/" ? "" : basePath },
  ports: {
    consoleLog: { subscribe: console.log },
  },
});
