(define (problem crash-p-01)
    (:domain crash-d)
    (:objects
        c1 c2 - car
        x1 x2 x3 - xPos
        y1 y2 y3 y4 y5 - yPos
        left straight right stop - direction
    )
    (:init
        (updated)

        (equal agent agent)
        (equal c1 c1)
        (equal c2 c2)

        (hasPos agent x2 y1)
        (hasPos c1 x1 y1)
        (hasPos c2 x3 y1)

        (hasDir agent straight)
        (hasDir c1 right)
        (hasDir c2 straight)

        (nextX stop x1 x1)
        (nextX stop x2 x2)
        (nextX stop x3 x3)
        (nextX straight x1 x1)
        (nextX straight x2 x2)
        (nextX straight x3 x3)
        (nextX right x1 x2)
        (nextX right x2 x3)
        (nextX right x3 x3)
        (nextX left x1 x1)
        (nextX left x2 x1)
        (nextX left x3 x2)

        (nextY stop y1 y1)
        (nextY stop y2 y2)
        (nextY stop y3 y3)
        (nextY stop y4 y4)
        (nextY stop y5 y5)
        (nextY straight y1 y2)
        (nextY straight y2 y3)
        (nextY straight y3 y4)
        (nextY straight y4 y5)
        (nextY left y1 y2)
        (nextY left y2 y3)
        (nextY left y3 y4)
        (nextY left y4 y5)
        (nextY right y1 y2)
        (nextY right y2 y3)
        (nextY right y3 y4)
        (nextY right y4 y5)
    )

    (:goal
        (and (hasPos agent x3 y5)
            (not (hasCrashed agent)))
    )
)