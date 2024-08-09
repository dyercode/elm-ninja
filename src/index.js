import { Elm } from './Main.elm'

Elm.Main.init({
  node: document.querySelector('main'),
  flags: { seeds: Array.from(crypto.getRandomValues(new Uint32Array(4))) },
})
