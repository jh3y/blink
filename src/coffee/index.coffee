PROPS =
  gameStarter: '.game__start'
  gameReset  : '.game__reset'
  grid       : '.grid'

STATE =
  inplay: false

OPTIONS =
  sequenceLength: 4
  gridSize      : 4

GAME = {}

###
  Initiate UI component cacheing
###
UI   = {}
for ui of PROPS
  UI[ui] = document.querySelector PROPS[ui]

###
  Game handling functions
###
displaySequence  = (blinks) ->
  ###
    This needs to be a recursive function that calls itself upon completion
    each time reducing the size of the array.
  ###
  if blinks.length > 0
    gridNo = blinks.pop()
    cell = document.querySelector '[data-cell-number="' + gridNo + '"]'
    showNext = (e) ->
      console.log this
      this.removeEventListener 'animationend', showNext
      this.className = 'grid__cell'
      if blinks.length is 0
        console.log 'COMPLETE'
      else
        setTimeout(->
          displaySequence blinks
        , 0)
    cell.addEventListener 'animationend', showNext
    cell.className += ' is--blinking'

generateSequence = (gridSize, sequenceSize) ->
  newSequence = []
  i = 0
  while i < sequenceSize
    newInput = Math.floor (Math.random() * (gridSize - 1))
    newSequence.push newInput
    i++
  newSequence

resetGame = ->
  STATE.inplay        = false
  GAME.level          = 1
  GAME.sequenceLength = OPTIONS.sequenceLength
  GAME.gridSize       = OPTIONS.gridSize

startGame = ->
  levelSequence = generateSequence GAME.gridSize, GAME.sequenceLength
  setTimeout(->
    console.info levelSequence
    displaySequence levelSequence
  , 3000)

initGame = ->
  ###
    What happens when we start a game?

    1. Start Level... 1
    2. Init sequence length...
    3. Reset user input arr...

  ###
  console.info 'STARTING'
  resetGame()
  startGame()

handleUserInput = (e) ->
  if STATE.inplay
    console.log e.target, e.currentTarget
######



BINDS =
  click:
    gameStarter: initGame
    gameReset  : resetGame
    grid       : handleUserInput

###
  Binds UI events based on BINDS objects.
###
for evt of BINDS
  for ui of BINDS[evt]
    UI[ui].addEventListener evt, BINDS[evt][ui]
