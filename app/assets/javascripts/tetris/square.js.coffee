class Tetris.Square extends Tetris.SceneObject
  SIZE: 25
  draw: (context) ->
    context.beginPath()
    context.rect(@x, @y, @SIZE, @SIZE)
    context.fillStyle = 'yellow'
    context.fill()
    context.lineWidth = 2
    context.strokeStyle = 'black'
    context.stroke()

  executeActions: ->
    @lastMove ||= new Date().getTime()
    return unless new Date().getTime()  - @lastMove > 1000
    @y += @SIZE
    @lastMove = new Date().getTime()
