(define (problem crash-p-01)
    (:domain crash-d)
    (:objects
        c1 c2 - car
        l1 l2 l3 - lane
        a1 a2 a3 a4 a5 - altitude
    )
    (:init
        (updatedCrashes)

        (isEqual agent agent)
        (isEqual c1 c1)
        (isEqual c2 c2)

        (hasPosition agent l2 a1)
        (hasPosition c1 l1 a1)
        (hasPosition c2 l3 a1)

        (hasDirection agent straight)
        (hasDirection c1 right)
        (hasDirection c2 straight)

        (nextLane stop l1 l1)
        (nextLane stop l2 l2)
        (nextLane stop l3 l3)
        (nextLane straight l1 l1)
        (nextLane straight l2 l2)
        (nextLane straight l3 l3)
        (nextLane right l1 l2)
        (nextLane right l2 l3)
        (nextLane right l3 l3)
        (nextLane left l1 l1)
        (nextLane left l2 l1)
        (nextLane left l3 l2)

        (nextAltitude stop a1 a1)
        (nextAltitude stop a2 a2)
        (nextAltitude stop a3 a3)
        (nextAltitude stop a4 a4)
        (nextAltitude stop a5 a5)
        (nextAltitude straight a1 a2)
        (nextAltitude straight a2 a3)
        (nextAltitude straight a3 a4)
        (nextAltitude straight a4 a5)
        (nextAltitude left a1 a2)
        (nextAltitude left a2 a3)
        (nextAltitude left a3 a4)
        (nextAltitude left a4 a5)
        (nextAltitude right a1 a2)
        (nextAltitude right a2 a3)
        (nextAltitude right a3 a4)
        (nextAltitude right a4 a5)
    )

    (:goal
        (and (hasPosition agent l3 a5)
            (not (hasCrashed agent)))
    )
)