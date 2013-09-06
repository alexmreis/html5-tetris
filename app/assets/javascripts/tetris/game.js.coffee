window.Tetris ||= {}
class Tetris.Game

  constructor: ->
    @inputQueue = []
    @scene = []
    @canvas = $('canvas')[0]
    $(@canvas).attr('width', $(window).width())
    $(@canvas).attr('height', $(window).height())

  mainLoop: =>
    @processInput()
    @executeActions()
    @renderFrame()

  processInput: ->
    console.log "Pending input: ", @inputQueue.length

  executeActions: ->
    for obj in @scene
      obj.executeActions()

  renderFrame: ->
    context = @canvas.getContext('2d')
    for obj in @scene
      obj.draw(context)

  startLoop: ->
    @scene.push(new Tetris.Square(x: @canvas.width / 2, y:0))
    window.setInterval @mainLoop, 17
