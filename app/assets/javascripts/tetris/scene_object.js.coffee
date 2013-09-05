class Tetris.SceneObject
  x: 0
  y: 0

  constructor: (params) ->
    @x = params['x'] || 0
    @y = params['y'] || 0

  width: ->
    0

  height: ->
    0

  draw: (context)  ->
    true

  executeActions: ->
    true
