(define (problem crash-p-01)
    (:domain crash-d)
    (:objects
        l1 l2 l3 exit - lane
        a1 a2 a3 a4 a5 - altitude
        left straight right - direction
    )
    (:init
        (equal agent agent)
        (equal c1 c1)
        (equal c2 c2)

        (isExternalCar c1)
        (isExternalCar c2)

        (hasPos agent l2 a1)
        (hasPos c1 l1 a1)
        (hasPos c2 l3 a1)

        (hasDir c1 right)
        (hasDir c2 straight)

        (hasExit l3 exit a4)

        (nextX straight l1 l1)
        (nextX straight l2 l2)
        (nextX straight l3 l3)
        (nextX right l1 l2)
        (nextX right l2 l3)
        (nextX right l3 l3)
        (nextX left l1 l1)
        (nextX left l2 l1)
        (nextX left l3 l2)

        (nextY a1 a2)
        (nextY a2 a3)
        (nextY a3 a4)
        (nextY a4 a5)
    )

    (:goal
        (hasPos agent exit a5)
    )
)