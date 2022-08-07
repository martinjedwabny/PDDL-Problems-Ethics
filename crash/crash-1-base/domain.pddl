(define (domain crash-d)
    (:requirements :strips :typing :conditional-effects :negative-preconditions :derived-predicates)

    (:types
        car xPos yPos direction - object
    )

    (:constants
        agent c1 c2 - car
    )

    (:predicates
        (equal ?C1 - car ?C2 - car)
        (isExternalCar ?C - car)
        (hasPos ?C - car ?X1 - xPos ?Y1 - yPos)
        (hasDir ?C - car ?D - direction)
        (nextX ?D - direction ?X1 - xPos ?X2 - xPos)
        (nextY ?Y1 - yPos ?Y2 - yPos)
        (hasExit ?X1 - xPos ?X2 - xPos ?Y1 - yPos)
        (hasCrashed ?C1 - car ?C2 - car ?X1 - xPos ?Y1 - yPos)
    )

    (:derived
        (hasCrashed ?C1 - car ?C2 - car ?X1 - xPos ?Y1 - yPos)
        (and
            (not (equal ?C1 ?C2))
            (hasPos ?C1 ?X1 ?Y1)
            (hasPos ?C2 ?X1 ?Y1))
    )

    (:action go
        :parameters (?D - direction ?X1 - xPos ?Y1 - yPos ?X2 - xPos ?Y2 - yPos)
        :precondition (and
            (not (hasCrashed agent c1 ?X1 ?Y1))
            (not (hasCrashed agent c2 ?X1 ?Y1))
            (hasPos agent ?X1 ?Y1)
            (nextX ?D ?X1 ?X2)
            (nextY ?Y1 ?Y2))
        :effect (and
            (not (hasPos agent ?X1 ?Y1))
            (hasPos agent ?X2 ?Y2)
            (forall
                (?CC - car ?DD - direction ?Y3 - yPos ?Y4 - yPos ?X3 - xPos ?X4 - xPos)
                (when
                    (and
                        (isExternalCar ?CC)
                        (not (hasCrashed ?CC agent ?X3 ?Y3))
                        (not (hasCrashed ?CC c1 ?X3 ?Y3))
                        (not (hasCrashed ?CC c2 ?X3 ?Y3))
                        (hasPos ?CC ?X3 ?Y3)
                        (hasDir ?CC ?DD)
                        (nextX ?DD ?X3 ?X4)
                        (nextY ?Y3 ?Y4))
                    (and
                        (not (hasPos ?CC ?X3 ?Y3))
                        (hasPos ?CC ?X4 ?Y4)))))
    )

    (:action stop
        :parameters ()
        :precondition ()
        :effect (forall
            (?CC - car ?DD - direction ?Y1 - yPos ?Y2 - yPos ?X1 - xPos ?X2 - xPos)
            (when
                (and
                    (isExternalCar ?CC)
                    (not (hasCrashed ?CC agent ?X1 ?Y1))
                    (not (hasCrashed ?CC c1 ?X1 ?Y1))
                    (not (hasCrashed ?CC c2 ?X1 ?Y1))
                    (hasDir ?CC ?DD)
                    (hasPos ?CC ?X1 ?Y1)
                    (nextX ?DD ?X1 ?X2)
                    (nextY ?Y1 ?Y2))
                (and
                    (not (hasPos ?CC ?X1 ?Y1))
                    (hasPos ?CC ?X2 ?Y2))))
    )

    (:action takeExit
        :parameters (?X1 - xPos ?Y1 - yPos ?X2 - xPos ?Y2 - yPos)
        :precondition (and
            (not (hasCrashed agent c1 ?X1 ?Y1))
            (not (hasCrashed agent c2 ?X1 ?Y1))
            (hasPos agent ?X1 ?Y1)
            (hasExit ?X1 ?X2 ?Y1)
            (nextY ?Y1 ?Y2))
        :effect (and
            (not (hasPos agent ?X1 ?Y1))
            (hasPos agent ?X2 ?Y2)
            (forall
                (?CC - car ?DD - direction ?Y3 - yPos ?Y4 - yPos ?X3 - xPos ?X4 - xPos)
                (when
                    (and
                        (isExternalCar ?CC)
                        (not (hasCrashed ?CC agent ?X3 ?Y3))
                        (not (hasCrashed ?CC c1 ?X3 ?Y3))
                        (not (hasCrashed ?CC c2 ?X3 ?Y3))
                        (hasPos ?CC ?X3 ?Y3)
                        (hasDir ?CC ?DD)
                        (nextX ?DD ?X3 ?X4)
                        (nextY ?Y3 ?Y4))
                    (and
                        (not (hasPos ?CC ?X3 ?Y3))
                        (hasPos ?CC ?X4 ?Y4))))
        )
    )
)