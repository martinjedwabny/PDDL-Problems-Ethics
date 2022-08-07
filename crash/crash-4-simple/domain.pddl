(define (domain crash-d)
    (:requirements :adl)

    (:types
        car xPos yPos direction - object
    )

    (:constants
        agent - car
    )

    (:predicates
        (equal ?C1 - car ?C2 - car)
        (hasPos ?C - car ?X1 - xPos ?Y1 - yPos)
        (hasDir ?C - car ?D - direction)
        (nextX ?D - direction ?X1 - xPos ?X2 - xPos)
        (nextY ?D - direction ?Y1 - yPos ?Y2 - yPos)
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
                (?C1 - car ?D1 - direction ?Y1 - yPos ?Y2 - yPos ?X1 - xPos ?X2 - xPos)
                (when
                    (and
                        (not (hasCrashed ?C1))
                        (hasPos ?C1 ?X1 ?Y1)
                        (hasDir ?C1 ?D1)
                        (nextX ?D1 ?X1 ?X2)
                        (nextY ?D1 ?Y1 ?Y2))
                    (and
                        (not (hasPos ?C1 ?X1 ?Y1))
                        (hasPos ?C1 ?X2 ?Y2))))
        )
    )
)