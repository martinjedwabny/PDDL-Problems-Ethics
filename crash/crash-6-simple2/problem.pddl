(define (problem crash-p-01)
    (:domain crash-d)
    (:objects
        c1 c2 - car
        l1 l2 - lane
        a1 a2 a3 a4 - altitude
    )
    (:init
        (updatedCrashes)

        (isEqual agent agent)
        (isEqual c1 c1)
        (isEqual c2 c2)

        (hasPosition agent l1 a1)
        (hasPosition c1 l2 a1)
        (hasPosition c2 l2 a3)

        (hasDirection agent straight)
        (hasDirection c1 straight)
        ; (hasDirection c2 straight)

        (nextLane straight l1 l1)
        (nextLane straight l2 l2)
        (nextLane right l1 l2)
        (nextLane right l2 l2)
        (nextLane left l1 l1)
        (nextLane left l2 l1)

        (nextAltitude a1 a2)
        (nextAltitude a2 a3)
        (nextAltitude a3 a4)
        (nextAltitude a4 a4)
    )

    (:goal
        (and (hasPosition agent l2 a4)
            (not (hasCrashed agent)))
    )
)