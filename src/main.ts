import Elm from './elm/Main';
import './main.scss'

document.addEventListener("DOMContentLoaded", () => {
  const node = document.getElementById('ELM_ROOT')
  const app = Elm.Elm.Main.init({ 
    flags: null,
    node
  })
  app.ports.sendMsg.subscribe( data => {
    alert("alert at JS world : " + data)
    app.ports.recivedMsg.send("echo from js: " + data) 
  })
})
