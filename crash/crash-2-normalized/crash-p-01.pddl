(define (problem crash-p-01)
    (:domain crash-d)
    (:objects
        l1 l2 l3 exit - lane
        a1 a2 a3 a4 a5 - altitude
        left straight right - direction
    )
    (:init
        (isEqual agent agent)
        (isEqual c1 c1)
        (isEqual c2 c2)

        (isExternalCar c1)
        (isExternalCar c2)

        (hasPosition agent l2 a1)
        (hasPosition c1 l1 a1)
        (hasPosition c2 l3 a1)

        (hasDirection c1 right)
        (hasDirection c2 straight)

        (hasExit l3 exit a4)

        (nextLane straight l1 l1)
        (nextLane straight l2 l2)
        (nextLane straight l3 l3)
        (nextLane right l1 l2)
        (nextLane right l2 l3)
        (nextLane right l3 l3)
        (nextLane left l1 l1)
        (nextLane left l2 l1)
        (nextLane left l3 l2)

        (nextAltitude a1 a2)
        (nextAltitude a2 a3)
        (nextAltitude a3 a4)
        (nextAltitude a4 a5)
    )

    (:goal
        (hasPosition agent exit a5)
    )
)