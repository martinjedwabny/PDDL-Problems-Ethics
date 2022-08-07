(define (domain crash-d)
    (:requirements :adl)

    (:types
        car xPos yPos direction speed - object
    )

    (:constants
        agent - car
        left straight right - direction
        stop normal fast - speed
    )

    (:predicates
        (equal ?C1 - car ?C2 - car)
        (hasPos ?C1 - car ?X1 - xPos ?Y1 - yPos)
        (hasDir ?C1 - car ?D1 - direction)
        (hasSpeed ?C1 - car ?S1 - speed)
        (nextX ?D1 - direction ?X1 - xPos ?X2 - xPos)
        (nextY ?S1 - speed ?Y1 - yPos ?Y2 - yPos)
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
                (?C1 - car ?C2 - car ?Y1 - yPos ?X1 - xPos)
                (when
                    (and
                        (not (equal ?C1 ?C2))
                        (not (hasCrashed ?C1))
                        (hasPos ?C1 ?X1 ?Y1)
                        (hasPos ?C2 ?X1 ?Y1))
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
                (?C1 - car ?D1 - direction ?S1 - speed ?Y1 - yPos ?Y2 - yPos ?X1 - xPos ?X2 - xPos)
                (when
                    (and
                        (not (hasCrashed ?C1))
                        (hasPos ?C1 ?X1 ?Y1)
                        (hasDir ?C1 ?D1)
                        (hasSpeed ?C1 ?S1)
                        (nextX ?D1 ?X1 ?X2)
                        (nextY ?S1 ?Y1 ?Y2))
                    (and
                        (not (hasPos ?C1 ?X1 ?Y1))
                        (hasPos ?C1 ?X2 ?Y2))))
        )
    )
)