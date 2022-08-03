(define (domain crash-d)
    (:requirements :adl)

    (:types
        car lane altitude direction - object
    )

    (:constants
        agent - car
    )

    (:predicates
        (equal ?C1 - car ?C2 - car)
        (hasPos ?C - car ?L - lane ?A - altitude)
        (hasDir ?C - car ?D - direction)
        (nextX ?D - direction ?L1 - lane ?L2 - lane)
        (nextY ?D - direction ?A1 - altitude ?A2 - altitude)
        (hasCrashed ?C1 - car)
        (updated)
    )

    (:action changeDirection
        :parameters (?D1 - direction ?D2 - direction)
        :precondition (and
            (updated)
            (hasDir agent ?D1))
        :effect (and
            (not (hasDir agent ?D1))
            (hasDir agent ?D2))
    )

    (:action update
        :parameters ()
        :precondition (not (updated))
        :effect (and
            (updated)
            (forall
                (?C1 - car ?C2 - car ?A1 - altitude ?L1 - lane)
                (when
                    (and
                        (not (equal ?C1 ?C2))
                        (not (hasCrashed ?C1))
                        (hasPos ?C1 ?L1 ?A1)
                        (hasPos ?C2 ?L1 ?A1))
                    (and
                        (hasCrashed ?C1)
                        (hasCrashed ?C2)
                    ))))
    )

    (:action go
        :parameters ()
        :precondition (updated)
        :effect (and
            (not (updated))
            (forall
                (?C1 - car ?D1 - direction ?A1 - altitude ?A2 - altitude ?L1 - lane ?L2 - lane)
                (when
                    (and
                        (not (hasCrashed ?C1))
                        (hasPos ?C1 ?L1 ?A1)
                        (hasDir ?C1 ?D1)
                        (nextX ?D1 ?L1 ?L2)
                        (nextY ?D1 ?A1 ?A2))
                    (and
                        (not (hasPos ?C1 ?L1 ?A1))
                        (hasPos ?C1 ?L2 ?A2))))
        )
    )
)