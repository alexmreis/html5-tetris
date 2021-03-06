class Tetris.GameEngine
  FPS: 15
  constructor: ->
    @inputQueue = []
    @scene = []
    @canvas = $('canvas')[0]
    $(@canvas).attr('width', '250')
    $(@canvas).attr('height','525')
    $(window).on('keydown', @addToInputQueue)

  mainLoop: =>
    @processInput()
    @executeActions()
    @renderFrame()

  addToInputQueue: (evt) =>
    @inputQueue.push(@mapInput(evt.which))

  processInput: =>
    return unless  @inputQueue.length > 0
    for key in @inputQueue
      if key
        for obj in @scene
          obj.handleInput(key)
    @inputQueue = []

  mapInput: (keyCode) =>
    switch keyCode
      when 37 then "left"
      when 39 then "right"
      when 32, 49, 38 then "rotate"
      when 40 then "down"
      else null 

  enqueueInput: (move) ->
    @inputQueue.push(move)

  executeActions: ->
    for obj in @scene
      obj.executeActions()

  renderFrame: ->
    context = @canvas.getContext('2d')
    for obj in @scene
      obj.draw(context)

  startLoop: ->
    window.game = new Tetris.Game.Game()
    @scene.push window.game
    window.setInterval @mainLoop, (1000 / @FPS).toFixed()
