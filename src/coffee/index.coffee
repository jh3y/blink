PROPS =
  gameStarter: '.game__start'
  grid       : '.grid'

STATE =
  inplay: false

UI    =
  gameStarter: document.querySelector PROPS.gameStarter
  grid       : document.querySelector PROPS.grid

startGame = ->
  console.info 'STARTING'
  STATE.inplay = !STATE.inplay

handleUserInput = (e) ->
  if STATE.inplay
    console.log e.target, e.currentTarget

ui.gameStarter.addEventListener 'click', startGame
ui.grid.addEventListener 'click', handleUserInput
