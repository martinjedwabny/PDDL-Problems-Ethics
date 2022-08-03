(define (domain crash-d)
    (:requirements :strips :typing :conditional-effects :negative-preconditions :derived-predicates)

    (:types
        car lane altitude direction - object
    )

    (:constants
        agent c1 c2 - car
    )

    (:predicates
        (equal ?C1 - car ?C2 - car)
        (isExternalCar ?C - car)
        (hasPos ?C - car ?L - lane ?A - altitude)
        (hasDir ?C - car ?D - direction)
        (nextX ?D - direction ?L1 - lane ?L2 - lane)
        (nextY ?A1 - altitude ?A2 - altitude)
        (hasExit ?L1 - lane ?L2 - lane ?A - altitude)
        (hasCrashed ?C1 - car ?C2 - car ?L - lane ?A - altitude)
    )

    (:derived
        (hasCrashed ?C1 - car ?C2 - car ?L - lane ?A - altitude)
        (and
            (not (equal ?C1 ?C2))
            (hasPos ?C1 ?L ?A)
            (hasPos ?C2 ?L ?A))
    )

    (:action go
        :parameters (?D - direction ?L1 - lane ?A1 - altitude ?L2 - lane ?A2 - altitude)
        :precondition (and
            (not (hasCrashed agent c1 ?L1 ?A1))
            (not (hasCrashed agent c2 ?L1 ?A1))
            (hasPos agent ?L1 ?A1)
            (nextX ?D ?L1 ?L2)
            (nextY ?A1 ?A2))
        :effect (and
            (not (hasPos agent ?L1 ?A1))
            (hasPos agent ?L2 ?A2)
            (forall
                (?CC - car ?DD - direction ?A3 - altitude ?A4 - altitude ?L3 - lane ?L4 - lane)
                (when
                    (and
                        (isExternalCar ?CC)
                        (not (hasCrashed ?CC agent ?L3 ?A3))
                        (not (hasCrashed ?CC c1 ?L3 ?A3))
                        (not (hasCrashed ?CC c2 ?L3 ?A3))
                        (hasPos ?CC ?L3 ?A3)
                        (hasDir ?CC ?DD)
                        (nextX ?DD ?L3 ?L4)
                        (nextY ?A3 ?A4))
                    (and
                        (not (hasPos ?CC ?L3 ?A3))
                        (hasPos ?CC ?L4 ?A4)))))
    )

    (:action stop
        :parameters ()
        :precondition ()
        :effect (forall
            (?CC - car ?DD - direction ?A1 - altitude ?A2 - altitude ?L1 - lane ?L2 - lane)
            (when
                (and
                    (isExternalCar ?CC)
                    (not (hasCrashed ?CC agent ?L1 ?A1))
                    (not (hasCrashed ?CC c1 ?L1 ?A1))
                    (not (hasCrashed ?CC c2 ?L1 ?A1))
                    (hasDir ?CC ?DD)
                    (hasPos ?CC ?L1 ?A1)
                    (nextX ?DD ?L1 ?L2)
                    (nextY ?A1 ?A2))
                (and
                    (not (hasPos ?CC ?L1 ?A1))
                    (hasPos ?CC ?L2 ?A2))))
    )

    (:action takeExit
        :parameters (?L1 - lane ?A1 - altitude ?L2 - lane ?A2 - altitude)
        :precondition (and
            (not (hasCrashed agent c1 ?L1 ?A1))
            (not (hasCrashed agent c2 ?L1 ?A1))
            (hasPos agent ?L1 ?A1)
            (hasExit ?L1 ?L2 ?A1)
            (nextY ?A1 ?A2))
        :effect (and
            (not (hasPos agent ?L1 ?A1))
            (hasPos agent ?L2 ?A2)
            (forall
                (?CC - car ?DD - direction ?A3 - altitude ?A4 - altitude ?L3 - lane ?L4 - lane)
                (when
                    (and
                        (isExternalCar ?CC)
                        (not (hasCrashed ?CC agent ?L3 ?A3))
                        (not (hasCrashed ?CC c1 ?L3 ?A3))
                        (not (hasCrashed ?CC c2 ?L3 ?A3))
                        (hasPos ?CC ?L3 ?A3)
                        (hasDir ?CC ?DD)
                        (nextX ?DD ?L3 ?L4)
                        (nextY ?A3 ?A4))
                    (and
                        (not (hasPos ?CC ?L3 ?A3))
                        (hasPos ?CC ?L4 ?A4))))
        )
    )
)