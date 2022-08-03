(define (domain crash-d)
    (:requirements :adl)

    (:types
        car lane altitude direction speed - object
    )

    (:constants
        agent - car
        left straight right - direction
        stop normal fast - speed
    )

    (:predicates
        (equal ?C1 - car ?C2 - car)
        (hasPos ?C1 - car ?L1 - lane ?A1 - altitude)
        (hasDir ?C1 - car ?D1 - direction)
        (hasSpeed ?C1 - car ?S1 - speed)
        (nextX ?D1 - direction ?L1 - lane ?L2 - lane)
        (nextY ?S1 - speed ?A1 - altitude ?A2 - altitude)
        (hasCrashed ?C1 - car)
        (updated)
    )

    (:action changeDirection
        :parameters (?D1 - direction)
        :precondition (updated)
        :effect (and
            (not (hasDir agent left))
            (not (hasDir agent right))
            (not (hasDir agent straight))
            (hasDir agent ?D1))
    )

    ; (:action changeSpeed
    ;     :parameters (?S1 - speed)
    ;     :precondition (updated)
    ;     :effect (and
    ;         (not (hasSpeed agent stop))
    ;         (not (hasSpeed agent normal))
    ;         (not (hasSpeed agent fast))
    ;         (hasSpeed agent ?S1))
    ; )

    ; (:action changeDirection
    ;     :parameters (?D1 - direction ?D2 - direction)
    ;     :precondition (and
    ;         (updated)
    ;         (hasDir agent ?D1))
    ;     :effect (and
    ;         (not (hasDir agent ?D1))
    ;         (hasDir agent ?D2))
    ; )

    ; (:action changeSpeed
    ;     :parameters (?S1 - speed ?S2 - speed)
    ;     :precondition (and
    ;         (updated)
    ;         (hasSpeed agent ?S1))
    ;     :effect (and
    ;         (not (hasSpeed agent ?S1))
    ;         (hasSpeed agent ?S2))
    ; )

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
                (?C1 - car ?D1 - direction ?S1 - speed ?A1 - altitude ?A2 - altitude ?L1 - lane ?L2 - lane)
                (when
                    (and
                        (not (hasCrashed ?C1))
                        (hasPos ?C1 ?L1 ?A1)
                        (hasDir ?C1 ?D1)
                        (hasSpeed ?C1 ?S1)
                        (nextX ?D1 ?L1 ?L2)
                        (nextY ?S1 ?A1 ?A2))
                    (and
                        (not (hasPos ?C1 ?L1 ?A1))
                        (hasPos ?C1 ?L2 ?A2))))
        )
    )
)