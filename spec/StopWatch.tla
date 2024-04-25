--------------------------------- MODULE StopWatch ---------------------------------
EXTENDS Naturals, TLC

VARIABLE hour, minute

vars == <<hour, minute>>

Init ==
    /\ hour \in 0..11
    /\ minute \in 0..59

Tick ==
    IF minute >= 59 THEN
        /\ minute' = 0
        /\
            IF hour < 11 THEN
                hour' = hour + 1
            ELSE
                hour' = 0
    ELSE
        /\ minute' = minute + 1
        /\ UNCHANGED hour

Next == Tick

Spec == Init /\ [][Next]_vars

(* Invariant *)
TypeInv ==
    /\ hour \in 0..11
    /\ minute \in 0..59

===============================================================================