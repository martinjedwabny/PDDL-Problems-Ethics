(define (domain crash-d)
    (:requirements :adl :typing)

    (:types
        car lane altitude direction - object
    )

    (:constants
        agent - car
    )

    (:predicates
        (isEqual ?C1 - car ?C2 - car)
        (hasPosition ?C - car ?L - lane ?A - altitude)
        (hasDirection ?C - car ?D - direction)
        (nextLane ?D - direction ?L1 - lane ?L2 - lane)
        (nextAltitude ?D - direction ?A1 - altitude ?A2 - altitude)
        (hasCrashed ?C1 - car)
        (updatedCrashes)
    )

    (:action changeDirection
        :parameters (?D1 - direction ?D2 - direction)
        :precondition (and
            (updatedCrashes)
            (hasDirection agent ?D1))
        :effect (and
            (not (hasDirection agent ?D1))
            (hasDirection agent ?D2))
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
                        (nextAltitude ?D1 ?A1 ?A2))
                    (and
                        (not (hasPosition ?C1 ?L1 ?A1))
                        (hasPosition ?C1 ?L2 ?A2))))
        )
    )
)