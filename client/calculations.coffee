Matrix = famous.math.Matrix

class ExMatrix extends Matrix
  toString: ->
    M = @get()
    M[0]
    "#{M[0]}\n#{M[1]}\n#{M[2]}"
  det: ->
    M = @get()
    MR1 = M[0][0] * (M[1][1]*M[2][2] - M[1][2]*M[2][1])
    MR2 = M[0][1] * (M[1][0]*M[2][2] - M[1][2]*M[2][0])
    MR3 = M[0][2] * (M[1][0]*M[2][1] - M[1][1]*M[2][0])
    MR1 - MR2 + MR3
  inverse: ->
    det2 = (a, b, c, d) ->
      a*d - b*c
    detM = @det()
    M = @get()
    [
      [
        (det2 M[1][1], M[1][2], M[2][1], M[2][2]) / detM
        (det2 M[0][2], M[0][1], M[2][2], M[2][1]) / detM
        (det2 M[0][1], M[0][2], M[1][1], M[1][2]) / detM
      ]
      [
        (det2 M[1][2], M[1][0], M[2][2], M[2][0]) / detM
        (det2 M[0][0], M[0][2], M[2][0], M[2][2]) / detM
        (det2 M[0][2], M[0][0], M[1][2], M[1][0]) / detM
      ]
      [
        (det2 M[1][0], M[1][1], M[2][0], M[2][1]) / detM
        (det2 M[0][1], M[0][0], M[2][1], M[2][0]) / detM
        (det2 M[0][0], M[0][1], M[1][0], M[1][1]) / detM
      ]
    ]
  multiplyNoRegister: (M2) ->
    M1 = @get()
    result = Array (Array 3), (Array 3), (Array 3)
    for i in [0...3]
      result[i] = []
      for j in [0...3]
        sum = 0
        for k in [0...3]
          sum += M1[i][k] * M2[k][j]
        result[i][j] = sum;
    result

Transform = famous.core.Transform

Template.hello.helpers
  matrix: ->
    m = new ExMatrix [
      [2, 0, 0]
      [0, 2, 0]
      [0, 0, 2]
    ]
    txt = 'Initial matrix:\n' + m.toString() + '\n'
    txt += 'Determinant: ' + m.det() + '\n'
    inv = new ExMatrix m.inverse()
    txt += 'Inverse matrix:\n' + inv.toString() + '\n'
    prod = new ExMatrix (m.multiplyNoRegister inv.get())
    txt += 'Product of initial matrix and its inverse should lead to identity:'
    txt += '\n' + prod.toString() + '\n'
    txt += Transform.translate 0, 0, 0
