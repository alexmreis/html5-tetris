class Tetris.Game.Playfield
  @WIDTH = 10
  @DEPTH = 22
  @GRID_SQUARE = 25

  rows: []

  constructor: ->
    @initializeRows()

  initializeRows: ->
    for i in [1..Tetris.Game.Playfield.DEPTH]
      row = []
      for j in [1..Tetris.Game.Playfield.WIDTH]
        row.push(0)
      @rows.push(row)

  collides: (x,y) ->
    nextRow = Math.min(@rows.length - 1, y + 1)
    return true if nextRow >= Tetris.Game.Playfield.DEPTH - 1

    return false unless @rows[nextRow]
    @rows[nextRow][x] != 0 and @rows[nextRow][x] != null

  land: (tetromino) ->
    shape = tetromino.shape
    for y in [0..shape.length - 1]
      for x in [0..shape[y].length - 1]
        @rows[tetromino.y + y][ tetromino.x + x] = shape[y][x] unless shape[y][x] == 0

    @removeCompletedLines()

  completedLines: ->
    _.select @rows, (row) ->
      _.every row, (item) ->
        item != 0

  removeCompletedLines: ->
    @completed = @completedLines()
    rows = _.difference(@rows, @completed)
    return if rows.length == @rows.length

    @lastCompletedCount = @rows.length - rows.length
    for i in [1..@rows.length - rows.length]
      row = []
      for j in [1..Tetris.Game.Playfield.WIDTH]
        row.push(0)

      #Add as many empty rows as we removed to the top
      rows.unshift(row)
    @rows = rows

  isFull: ->
    _.any @rows[0], (value) ->
      value != 0

  draw: (context) ->
    #Hide first 2 rows as per tetris specs
    for y in [2..Tetris.Game.Playfield.DEPTH - 1]
      for x in [0..Tetris.Game.Playfield.WIDTH - 1]
        Tetris.Square.draw(context, x * Tetris.Game.Playfield.GRID_SQUARE, y * Tetris.Game.Playfield.GRID_SQUARE, @rows[y][x])


