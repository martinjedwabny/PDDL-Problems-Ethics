(define (problem hospital-01_GEN)
(:domain hospital_GEN)
(:init ( athouse))
(:goal (and ( athospital) 
    ( preference p_fast  ( tookhighway)) 
    ( preference p_ida  ( not(ida))) 
    ( preference p_idb  ( not(idb))) 
    ( preference p_lied  ( not(lied)))))
(:metric minimize (+
(* (is-violated p_fast) 3)
(* (is-violated p_ida) 1)
(* (is-violated p_idb) 1)
(* (is-violated p_lied) 1)
))
)
