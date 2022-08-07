(define (problem crash-p-01)
    (:domain crash-d)
    (:objects
        c1 c2 - car
        x1 x2 - xPos
        y1 y2 y3 y4 - yPos
        left straight right stop - direction
    )
    (:init
        (updated)

        (equal agent agent)
        (equal c1 c1)
        (equal c2 c2)

        (hasPos agent x1 y1)
        (hasPos c1 x2 y1)
        (hasPos c2 x2 y3)

        (hasDir agent straight)
        (hasDir c1 straight)
        (hasDir c2 stop)

        (nextX stop x1 x1)
        (nextX stop x2 x2)
        (nextX straight x1 x1)
        (nextX straight x2 x2)
        (nextX right x1 x2)
        (nextX right x2 x2)
        (nextX left x1 x1)
        (nextX left x2 x1)

        (nextY stop y1 y1)
        (nextY stop y2 y2)
        (nextY stop y3 y3)
        (nextY stop y4 y4)
        (nextY straight y1 y2)
        (nextY straight y2 y3)
        (nextY straight y3 y4)
        (nextY left y1 y2)
        (nextY left y2 y3)
        (nextY left y3 y4)
        (nextY right y1 y2)
        (nextY right y2 y3)
        (nextY right y3 y4)
    )

    (:goal
        (and (hasPos agent x2 y4)
            (not (hasCrashed agent)))
    )
)