Matrix = famous.math.Matrix

class ExMatrix extends Matrix
  toString: ->
    M = @get()
    M[0]
    "#{M[0]}\n#{M[1]}\n#{M[2]}"

Template.hello.helpers
  matrix: ->
    m = new ExMatrix [
      [2, 0, 0]
      [0, 2, 0]
      [0, 0, 2]
    ]
    m.toString()
