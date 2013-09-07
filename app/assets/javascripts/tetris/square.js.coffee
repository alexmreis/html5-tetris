class Tetris.Square
  @SIZE: 13
  @STROKE: 1
  @draw: (context, x, y, type) ->
    return unless type
      #context.clearRect(x, y, @SIZE + @STROKE, @SIZE + @STROKE)
      #return
    context.beginPath()
    context.rect(x, y, @SIZE, @SIZE)
    context.fillStyle = @typeColor(type)
    context.fill()
    context.lineWidth = @STROKE
    context.strokeStyle = 'black'
    context.stroke()

  @typeColor: (type) ->
    switch type
      when 'O' then 'yellow'
      when 'I' then 'cyan'
      when 'T' then 'purple'
      when 'S' then 'green'
      when 'Z' then 'red'
      when 'J' then 'blue'
      when 'L' then 'orange'
      else 'white'

