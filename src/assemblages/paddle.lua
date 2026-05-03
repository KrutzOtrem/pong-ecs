-- crates the paddle assemblage
return function(e, x, y, width, height, kind)
    e
    :give('paddle')
    :give('position', x, y)
    :give('velocity')
    :give('size', width, height)
    :give('renderable', 1, 1, 1)

    e:give(kind)
end