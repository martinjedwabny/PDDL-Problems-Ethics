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
        (isEqual ?C1 - car ?C2 - car)
        (hasPosition ?C1 - car ?L1 - lane ?A1 - altitude)
        (hasDirection ?C1 - car ?D1 - direction)
        (hasSpeed ?C1 - car ?S1 - speed)
        (nextLane ?D1 - direction ?L1 - lane ?L2 - lane)
        (nextAltitude ?S1 - speed ?A1 - altitude ?A2 - altitude)
        (hasCrashed ?C1 - car)
        (updatedCrashes)
    )

    (:action changeDirection
        :parameters (?D1 - direction)
        :precondition (updatedCrashes)
        :effect (and
            (not (hasDirection agent left))
            (not (hasDirection agent right))
            (not (hasDirection agent straight))
            (hasDirection agent ?D1))
    )

    ; (:action changeSpeed
    ;     :parameters (?S1 - speed)
    ;     :precondition (updatedCrashes)
    ;     :effect (and
    ;         (not (hasSpeed agent stop))
    ;         (not (hasSpeed agent normal))
    ;         (not (hasSpeed agent fast))
    ;         (hasSpeed agent ?S1))
    ; )

    ; (:action changeDirection
    ;     :parameters (?D1 - direction ?D2 - direction)
    ;     :precondition (and
    ;         (updatedCrashes)
    ;         (hasDirection agent ?D1))
    ;     :effect (and
    ;         (not (hasDirection agent ?D1))
    ;         (hasDirection agent ?D2))
    ; )

    ; (:action changeSpeed
    ;     :parameters (?S1 - speed ?S2 - speed)
    ;     :precondition (and
    ;         (updatedCrashes)
    ;         (hasSpeed agent ?S1))
    ;     :effect (and
    ;         (not (hasSpeed agent ?S1))
    ;         (hasSpeed agent ?S2))
    ; )

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
                (?C1 - car ?D1 - direction ?S1 - speed ?A1 - altitude ?A2 - altitude ?L1 - lane ?L2 - lane)
                (when
                    (and
                        (not (hasCrashed ?C1))
                        (hasPosition ?C1 ?L1 ?A1)
                        (hasDirection ?C1 ?D1)
                        (hasSpeed ?C1 ?S1)
                        (nextLane ?D1 ?L1 ?L2)
                        (nextAltitude ?S1 ?A1 ?A2))
                    (and
                        (not (hasPosition ?C1 ?L1 ?A1))
                        (hasPosition ?C1 ?L2 ?A2))))
        )
    )
)