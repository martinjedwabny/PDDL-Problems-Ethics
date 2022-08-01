(define (domain crash-d)
    (:requirements :strips :typing :conditional-effects :negative-preconditions :derived-predicates)

    (:types
        car lane altitude direction - object
    )

    (:constants
        agent c1 c2 - car
    )

    (:predicates
        (isEqual ?C1 - car ?C2 - car)
        (isExternalCar ?C - car)
        (hasPosition ?C - car ?L - lane ?A - altitude)
        (hasDirection ?C - car ?D - direction)
        (nextLane ?D - direction ?L1 - lane ?L2 - lane)
        (nextAltitude ?A1 - altitude ?A2 - altitude)
        (hasExit ?L1 - lane ?L2 - lane ?A - altitude)
        (hasCrashed ?C1 - car ?C2 - car ?L - lane ?A - altitude)
    )

    (:derived
        (hasCrashed ?C1 - car ?C2 - car ?L - lane ?A - altitude)
        (and
            (not (isEqual ?C1 ?C2))
            (hasPosition ?C1 ?L ?A)
            (hasPosition ?C2 ?L ?A))
    )

    (:action go
        :parameters (?D1 - direction ?L1 - lane ?A1 - altitude ?L2 - lane ?A2 - altitude)
        :precondition (and
            (forall
                (?C1 - car)
                (not (hasCrashed agent ?C1 ?L1 ?A1)))
            (hasPosition agent ?L1 ?A1)
            (nextLane ?D1 ?L1 ?L2)
            (nextAltitude ?A1 ?A2))
        :effect (and
            (not (hasPosition agent ?L1 ?A1))
            (hasPosition agent ?L2 ?A2)
            (forall
                (?C1 - car ?D2 - direction ?A3 - altitude ?A4 - altitude ?L3 - lane ?L4 - lane)
                (when
                    (and
                        (isExternalCar ?C1)
                        (forall
                            (?C2 - car)
                            (not (hasCrashed ?C1 ?C2 ?L3 ?A3)))
                        (hasPosition ?C1 ?L3 ?A3)
                        (hasDirection ?C1 ?D2)
                        (nextLane ?D2 ?L3 ?L4)
                        (nextAltitude ?A3 ?A4))
                    (and
                        (not (hasPosition ?C1 ?L3 ?A3))
                        (hasPosition ?C1 ?L4 ?A4)))))
    )

    (:action stop
        :parameters ()
        :precondition ()
        :effect (forall
            (?C1 - car ?D1 - direction ?A1 - altitude ?A2 - altitude ?L1 - lane ?L2 - lane)
            (when
                (and
                    (isExternalCar ?C1)
                    (forall
                        (?C2 - car)
                        (not (hasCrashed ?C1 ?C2 ?L1 ?A1)))
                    (hasDirection ?C1 ?D1)
                    (hasPosition ?C1 ?L1 ?A1)
                    (nextLane ?D1 ?L1 ?L2)
                    (nextAltitude ?A1 ?A2))
                (and
                    (not (hasPosition ?C1 ?L1 ?A1))
                    (hasPosition ?C1 ?L2 ?A2))))
    )

    (:action takeExit
        :parameters (?L1 - lane ?A1 - altitude ?L2 - lane ?A2 - altitude)
        :precondition (and
            (not (hasCrashed agent c1 ?L1 ?A1))
            (not (hasCrashed agent c2 ?L1 ?A1))
            (hasPosition agent ?L1 ?A1)
            (hasExit ?L1 ?L2 ?A1)
            (nextAltitude ?A1 ?A2))
        :effect (and
            (not (hasPosition agent ?L1 ?A1))
            (hasPosition agent ?L2 ?A2)
            (forall
                (?C1 - car ?D1 - direction ?A3 - altitude ?A4 - altitude ?L3 - lane ?L4 - lane)
                (when
                    (and
                        (isExternalCar ?C1)
                        (forall
                            (?C2 - car)
                            (not (hasCrashed ?C1 ?C2 ?L3 ?A3)))
                        (hasPosition ?C1 ?L3 ?A3)
                        (hasDirection ?C1 ?D1)
                        (nextLane ?D1 ?L3 ?L4)
                        (nextAltitude ?A3 ?A4))
                    (and
                        (not (hasPosition ?C1 ?L3 ?A3))
                        (hasPosition ?C1 ?L4 ?A4))))
        )
    )
)