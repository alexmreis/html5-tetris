#require tetris/game/playfield
class Tetris.Game.Tetromino
  @TYPES: ['O', 'I', 'T', 'S', 'Z', 'J', 'L']

  @build: (type) ->
    new Tetris.Game.Tetromino(shape: @typeShape(type))

  @typeShape: (type) ->
    switch type
      when 'O'
        [['O','O'],
         ['O','O']]
      when 'I'
        [['I','I','I','I']]
      when 'T'
        [[ 0 , 'T',  0 ],
         ['T', 'T', 'T']]
      when 'S'
        [[ 0 , 'S', 'S'],
         ['S', 'S',  0 ]]
      when 'Z'
        [['Z','Z', 0 ],
         [ 0 ,'Z','Z']]
      when 'J'
        [['J', 0 , 0 ],
         ['J','J','J']]
      when 'L'
        [['L', 0 , 0 ],
         ['L','L','L']]
      else
        []

  @nextType: ->
    @TYPES[Math.min((Math.random() * (@TYPES.length)).toFixed(), @TYPES.length - 1)]

  @buildNext: ->
    @build(@nextType())

  shape: [[]]
  x: 0
  y: 0

  constructor: (options) ->
    @shape = options['shape'] or [[]]
    @x = (Tetris.Game.Playfield.WIDTH / 2).toFixed() - (@shape[0].length / 2).toFixed()
    @y = 0

  width: ->
    @shape[0].length

  height: ->
    @shape.length

  fall: ->
    @y += 1

  rotate: ->
    @shape = math.transpose(math.matrix(@shape)).toArray()
    @shape = _.map @shape, (row) ->
     row.reverse()

  moveLeft: ->
    @x = Math.max(0, @x - 1)

  moveRight: ->
    @x = Math.min(Tetris.Game.Playfield.WIDTH - 1, @x + 1)

  draw: (context) ->
    for squareY in [0..@shape.length - 1]
      for squareX in [0..@shape[squareY].length]
        Tetris.Square.draw context,
          (@x + squareX) * Tetris.Game.Playfield.GRID_SQUARE,
          (@y + squareY) * Tetris.Game.Playfield.GRID_SQUARE,
          @shape[squareY][squareX]


