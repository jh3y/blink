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

BINDS =
  click:
    gameStarter: startGame
    grid       : handleUserInput

for evt of BINDS
  for ui of BINDS[evt]
    # console.log ui, UI[ui], BINDS[evt][ui]
    UI[ui].addEventListener evt, BINDS[evt][ui]
