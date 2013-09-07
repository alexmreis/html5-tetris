class Tetris.Game.Game
  rate: 1000
  score: 0
  over: false

  constructor: ->
    @playfield = new Tetris.Game.Playfield()
    @dropTetrominos()

  dropTetrominos: ->
    @tetromino ||= Tetris.Game.Tetromino.buildNext()
    @lastMove ||= new Date().getTime()

    return unless new Date().getTime()  - @lastMove > @rate

    @checkCollisions()
    @tetromino.fall() if @tetromino
    @lastMove = new Date().getTime()

  checkCollisions: =>
    return unless @tetromino
    for y in [0..@tetromino.shape.length - 1]
      for x in [0..@tetromino.shape[y].length - 1]
        if @tetromino.shape[y][x] != 0 and @playfield.collides(@tetromino.x + x, @tetromino.y + y)
          @playfield.land(@tetromino)
          if @playfield.lastCompletedCount
            @score += Math.pow(2, @playfield.lastCompletedCount) * 100
          @tetromino = null
          return

  handleInput: (move) =>
    console.log "Handle input #{move}"
    return unless @tetromino
    previousPos = [@tetromino.x, @tetromino.y]
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
    if @illegalTetrominoPosition()
      @tetromino.x = previousPos[0]
      @tetromino.y = previousPos[1]

  illegalTetrominoPosition: ->
    return false unless @tetromino
    for y in [0..@tetromino.shape.length - 1]
      for x in [0..@tetromino.shape[y].length - 1]
        if @tetromino.shape[y][x] != 0 and @playfield.rows[@tetromino.y + y][@tetromino.x + x] != 0
          return true
    false

  #Engine interface
  executeActions: ->
    return if @over
    @dropTetrominos()
    @over = @playfield.isFull()
    if @over
      alert("Game over! Score: #{@score}")

  #TODO: Draw score, next piece, decoration and stuff
  draw: (context) ->
    context.clearRect(0,0,$(window).width(), $(window).height())
    @playfield.draw(context)
    @tetromino.draw(context) if @tetromino

