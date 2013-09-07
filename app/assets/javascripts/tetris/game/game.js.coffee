class Tetris.Game.Game
  rate: 1000
  points: 0

  constructor: ->
    @playfield = new Tetris.Game.Playfield()
    @dropTetrominos()

  dropTetrominos: ->
    @tetromino ||= Tetris.Game.Tetromino.buildNext()
    @lastMove ||= new Date().getTime()

    @checkCollisions()
    return unless new Date().getTime()  - @lastMove > @rate

    @tetromino.fall()
    @checkCollisions()
    @lastMove = new Date().getTime()

  checkCollisions: =>
    return unless @tetromino
    for y in [0..@tetromino.shape.length - 1]
      for x in [0..@tetromino.shape[y].length - 1]
        console.log "Checking for collisions", x, y, @tetromino.shape[y]
        if @tetromino.shape[y][x] != 0 and @playfield.collides(@tetromino.x + x, @tetromino.y + y)
          @playfield.land(@tetromino)
          @points += Math.pow(100, @playfield.lastCompletedCount)
          @tetromino = null
          return

  handleInput: (move) =>
    console.log "Handle input #{move}"
    switch move
      when 'left'
        @tetromino.moveLeft()
      when 'right'
        @tetromino.moveRight()
      when 'rotate'
        @tetromino.rotate()
      when 'down'
        @tetromino.fall()
      else
        console.log "Unknown move #{move}"

  #Engine interface
  executeActions: ->
    @dropTetrominos()

  #TODO: Draw score, next piece, decoration and stuff
  draw: (context) ->
    context.clearRect(0,0,$(window).width(), $(window).height())
    @playfield.draw(context)
    @tetromino.draw(context)

