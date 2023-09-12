--------------------------------- MODULE tictac ---------------------------------
EXTENDS Naturals, FiniteSets, Sequences, TLC

\*CONSTANTS test

VARIABLE hour, minute

vars == <<hour, minute>>

Init ==
    /\ hour \in 0..23
    /\ minute \in 0..59

Tick ==
    IF minute >= 59 THEN
        /\ minute' = 0
        /\
            IF hour < 23 THEN
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
    /\ hour \in 0..23
    /\ minute \in 0..59

===============================================================================