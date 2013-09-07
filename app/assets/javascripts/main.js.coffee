#= require_tree ./lib
#= require ./namespace
#= require_tree ./tetris
#
$ ->
  window.Tetris.engine = new Tetris.GameEngine()
  Tetris.engine.startLoop()

