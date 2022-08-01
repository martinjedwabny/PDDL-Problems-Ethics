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
        :parameters (?D - direction ?L1 - lane ?A1 - altitude ?L2 - lane ?A2 - altitude)
        :precondition (and
            (not (hasCrashed agent c1 ?L1 ?A1))
            (not (hasCrashed agent c2 ?L1 ?A1))
            (hasPosition agent ?L1 ?A1)
            (nextLane ?D ?L1 ?L2)
            (nextAltitude ?A1 ?A2))
        :effect (and
            (not (hasPosition agent ?L1 ?A1))
            (hasPosition agent ?L2 ?A2)
            (forall
                (?CC - car ?DD - direction ?A3 - altitude ?A4 - altitude ?L3 - lane ?L4 - lane)
                (when
                    (and
                        (isExternalCar ?CC)
                        (not (hasCrashed ?CC agent ?L3 ?A3))
                        (not (hasCrashed ?CC c1 ?L3 ?A3))
                        (not (hasCrashed ?CC c2 ?L3 ?A3))
                        (hasPosition ?CC ?L3 ?A3)
                        (hasDirection ?CC ?DD)
                        (nextLane ?DD ?L3 ?L4)
                        (nextAltitude ?A3 ?A4))
                    (and
                        (not (hasPosition ?CC ?L3 ?A3))
                        (hasPosition ?CC ?L4 ?A4)))))
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
                    (hasDirection ?CC ?DD)
                    (hasPosition ?CC ?L1 ?A1)
                    (nextLane ?DD ?L1 ?L2)
                    (nextAltitude ?A1 ?A2))
                (and
                    (not (hasPosition ?CC ?L1 ?A1))
                    (hasPosition ?CC ?L2 ?A2))))
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
                (?CC - car ?DD - direction ?A3 - altitude ?A4 - altitude ?L3 - lane ?L4 - lane)
                (when
                    (and
                        (isExternalCar ?CC)
                        (not (hasCrashed ?CC agent ?L3 ?A3))
                        (not (hasCrashed ?CC c1 ?L3 ?A3))
                        (not (hasCrashed ?CC c2 ?L3 ?A3))
                        (hasPosition ?CC ?L3 ?A3)
                        (hasDirection ?CC ?DD)
                        (nextLane ?DD ?L3 ?L4)
                        (nextAltitude ?A3 ?A4))
                    (and
                        (not (hasPosition ?CC ?L3 ?A3))
                        (hasPosition ?CC ?L4 ?A4))))
        )
    )
)