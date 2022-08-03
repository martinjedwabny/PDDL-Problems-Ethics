(define (problem crash-p-01)
    (:domain crash-d)
    (:objects
        c1 c2 - car
        l1 l2 l3 - lane
        a1 a2 a3 a4 a5 - altitude
        left straight right stop - direction
    )
    (:init
        (updated)

        (equal agent agent)
        (equal c1 c1)
        (equal c2 c2)

        (hasPos agent l2 a1)
        (hasPos c1 l1 a1)
        (hasPos c2 l3 a1)

        (hasDir agent straight)
        (hasDir c1 right)
        (hasDir c2 straight)

        (nextX stop l1 l1)
        (nextX stop l2 l2)
        (nextX stop l3 l3)
        (nextX straight l1 l1)
        (nextX straight l2 l2)
        (nextX straight l3 l3)
        (nextX right l1 l2)
        (nextX right l2 l3)
        (nextX right l3 l3)
        (nextX left l1 l1)
        (nextX left l2 l1)
        (nextX left l3 l2)

        (nextY stop a1 a1)
        (nextY stop a2 a2)
        (nextY stop a3 a3)
        (nextY stop a4 a4)
        (nextY stop a5 a5)
        (nextY straight a1 a2)
        (nextY straight a2 a3)
        (nextY straight a3 a4)
        (nextY straight a4 a5)
        (nextY left a1 a2)
        (nextY left a2 a3)
        (nextY left a3 a4)
        (nextY left a4 a5)
        (nextY right a1 a2)
        (nextY right a2 a3)
        (nextY right a3 a4)
        (nextY right a4 a5)
    )

    (:goal
        (and (hasPos agent l3 a5)
            (not (hasCrashed agent)))
    )
)