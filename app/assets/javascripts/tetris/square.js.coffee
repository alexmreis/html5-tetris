class Tetris.Square extends Tetris.SceneObject
  SIZE: 25
  STROKE: 2
  draw: (context) ->
    context.beginPath()
    unless @previous == null
      context.clearRect(@x - @STROKE,@previousY - @STROKE, @SIZE + (@STROKE * 2), @SIZE + (@STROKE * 2))
      @previousY = null
    context.rect(@x, @y, @SIZE, @SIZE)
    context.fillStyle = 'yellow'
    context.fill()
    context.lineWidth = @STROKE
    context.strokeStyle = 'black'
    context.stroke()

  executeActions: ->
    @lastMove ||= new Date().getTime()
    return unless new Date().getTime()  - @lastMove > 1000
    @previousY = @y
    @y += @SIZE + @STROKE
    @lastMove = new Date().getTime()
