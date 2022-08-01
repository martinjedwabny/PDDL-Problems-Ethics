(define (domain crash-d)
    (:requirements :adl)

    (:types
        car lane altitude direction - object
    )

    (:constants
        agent - car
        left straight right - direction
    )

    (:predicates
        (isEqual ?C1 - car ?C2 - car)
        (hasPosition ?C - car ?L - lane ?A - altitude)
        (hasDirection ?C - car ?D - direction)
        (nextLane ?D - direction ?L1 - lane ?L2 - lane)
        (nextAltitude ?A1 - altitude ?A2 - altitude)
        (hasCrashed ?C1 - car)
        (updatedCrashes)
    )

    (:action setDirection
        :parameters (?D1 - direction)
        :precondition (updatedCrashes)
        :effect (and
            (not (hasDirection agent left))
            (not (hasDirection agent straight))
            (not (hasDirection agent right))
            (hasDirection agent ?D1))
    )

    (:action setStop
        :parameters ()
        :precondition (updatedCrashes)
        :effect (and
            (not (hasDirection agent left))
            (not (hasDirection agent straight))
            (not (hasDirection agent right)))
    )

    (:action updateCrashes
        :parameters ()
        :precondition (not (updatedCrashes))
        :effect (and
            (updatedCrashes)
            (forall
                (?C1 - car ?C2 - car ?A1 - altitude ?L1 - lane)
                (when
                    (and
                        (not (isEqual ?C1 ?C2))
                        (not (hasCrashed ?C1))
                        (hasPosition ?C1 ?L1 ?A1)
                        (hasPosition ?C2 ?L1 ?A1))
                    (and
                        (hasCrashed ?C1)
                        (hasCrashed ?C2)
                    ))))
    )

    (:action go
        :parameters ()
        :precondition (updatedCrashes)
        :effect (and
            (not (updatedCrashes))
            (forall
                (?C1 - car ?D1 - direction ?A1 - altitude ?A2 - altitude ?L1 - lane ?L2 - lane)
                (when
                    (and
                        (not (hasCrashed ?C1))
                        (hasPosition ?C1 ?L1 ?A1)
                        (hasDirection ?C1 ?D1)
                        (nextLane ?D1 ?L1 ?L2)
                        (nextAltitude ?A1 ?A2))
                    (and
                        (not (hasPosition ?C1 ?L1 ?A1))
                        (hasPosition ?C1 ?L2 ?A2))))
        )
    )
)