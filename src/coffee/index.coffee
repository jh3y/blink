DOMATTRIBUTES =
  gameStarter  : '.game__start'
  gameReset    : '.game__reset'
  gridContainer: '.grid__container'
  gridCells    : '[data-cell-number]'

UICACHE =
  gameStarter  : DOMATTRIBUTES.gameStarter
  gameReset    : DOMATTRIBUTES.gameReset
  gridContainer: DOMATTRIBUTES.gridContainer

STATE =
  inplay: false

OPTIONS =
  sequenceLength   : 4
  gridSize         : 4
  animationDuration: '.5s'

GAME = {}

###
  UI component cacheing
###
UI   = {}
for ui of UICACHE
  UI[ui] = document.querySelector UICACHE[ui]

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
      this.removeEventListener 'animationend', showNext
      this.className = 'grid__cell'
      if blinks.length is 0
        console.log 'COMPLETE'
        STATE.inplay = true
        GAME.inputSequence = []
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
  for cell in UI.cells
    cell.style.animationDuration = OPTIONS.animationDuration

renderGrid = ->
  grid = TEMPLATES.grid()
  UI.gridContainer.innerHTML = grid
  UI.cells = document.querySelectorAll DOMATTRIBUTES.gridCells

startGame = ->
  levelSequence = generateSequence GAME.gridSize, GAME.sequenceLength
  GAME.levelSequence = levelSequence.slice()
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
    input = parseInt e.target.getAttribute('data-cell-number'), 10
    GAME.inputSequence.unshift input
    if GAME.inputSequence.length is GAME.levelSequence.length
      if _.isEqual GAME.inputSequence, GAME.levelSequence
        alert 'YAY, you did it!!!'
      else
        alert 'Oh well, try again...'

######

renderGrid()

BINDS =
  click:
    gameStarter  : initGame
    gameReset    : resetGame
    gridContainer: handleUserInput

###
  Binds UI events based on BINDS objects.
###
for evt of BINDS
  for ui of BINDS[evt]
    UI[ui].addEventListener evt, BINDS[evt][ui]
