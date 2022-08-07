(define (problem crash-p-01)
    (:domain crash-d)
    (:objects
        x1 x2 x3 exit - xPos
        y1 y2 y3 y4 y5 - yPos
        left straight right - direction
    )
    (:init
        (equal agent agent)
        (equal c1 c1)
        (equal c2 c2)

        (isExternalCar c1)
        (isExternalCar c2)

        (hasPos agent x2 y1)
        (hasPos c1 x1 y1)
        (hasPos c2 x3 y1)

        (hasDir c1 right)
        (hasDir c2 straight)

        (hasExit x3 exit y4)

        (nextX straight x1 x1)
        (nextX straight x2 x2)
        (nextX straight x3 x3)
        (nextX right x1 x2)
        (nextX right x2 x3)
        (nextX right x3 x3)
        (nextX left x1 x1)
        (nextX left x2 x1)
        (nextX left x3 x2)

        (nextY y1 y2)
        (nextY y2 y3)
        (nextY y3 y4)
        (nextY y4 y5)
    )

    (:goal
        (hasPos agent exit y5)
    )
)