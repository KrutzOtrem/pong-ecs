-- crates the ball assemblage
return function (e, x, y, dx, dy)
    e
    :give('ball')
    :give('position', x, y)
    :give('velocity', dx, dy)
    :give('size', 4, 4)
    :give('renderable', 1, 1, 1)
end