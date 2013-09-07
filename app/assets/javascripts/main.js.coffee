#= require test
#= require_tree ./lib
#= require ./namespace
#= require_tree ./tetris
#
$ ->
  new Tetris.GameEngine().startLoop()

