(define (problem crash-p-01)
    (:domain crash-d)
    (:objects
        c1 c2 - car
        l1 l2 - lane
        a1 a2 a3 a4 - altitude
        left straight right stop - direction
    )
    (:init
        (updated)

        (equal agent agent)
        (equal c1 c1)
        (equal c2 c2)

        (hasPos agent l1 a1)
        (hasPos c1 l2 a1)
        (hasPos c2 l2 a3)

        (hasDir agent straight)
        (hasDir c1 straight)
        (hasDir c2 stop)

        (nextX stop l1 l1)
        (nextX stop l2 l2)
        (nextX straight l1 l1)
        (nextX straight l2 l2)
        (nextX right l1 l2)
        (nextX right l2 l2)
        (nextX left l1 l1)
        (nextX left l2 l1)

        (nextY stop a1 a1)
        (nextY stop a2 a2)
        (nextY stop a3 a3)
        (nextY stop a4 a4)
        (nextY straight a1 a2)
        (nextY straight a2 a3)
        (nextY straight a3 a4)
        (nextY left a1 a2)
        (nextY left a2 a3)
        (nextY left a3 a4)
        (nextY right a1 a2)
        (nextY right a2 a3)
        (nextY right a3 a4)
    )

    (:goal
        (and (hasPos agent l2 a4)
            (not (hasCrashed agent)))
    )
)