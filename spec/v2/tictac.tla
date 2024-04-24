--------------------------------- MODULE tictac ---------------------------------
EXTENDS Naturals, Integers, TLC

Abs(x) == IF x > 0 THEN x ELSE -x

VARIABLE clockValue, nTick, nTack, action

vars == <<action, clockValue, nTick, nTack>>

Init ==
    /\ clockValue = 0
    /\ nTick = 0
    /\ nTack = 0
    /\ action \in {"Tick", "Tack"}

TypeInv ==
    /\ clockValue >= 0
    /\ nTick \in Nat
    /\ nTack \in Nat
    /\ action \in {"Tick", "Tack"}
    /\ Abs(nTick - nTack) <= 1

Tick ==
    /\ action = "Tack"
    /\ clockValue' = clockValue + 1
    /\ nTick' = nTick + 1
    /\ action' = "Tick"
    /\ UNCHANGED nTack

Tack ==
    /\ action = "Tick"
    /\ clockValue' = clockValue + 1
    /\ nTack' = nTack + 1
    /\ action' = "Tack"
    /\ UNCHANGED nTick

ResetClock ==
    /\ clockValue' = 0
    /\ UNCHANGED <<action, nTick, nTack>>

Next ==
    \/ Tick
    \/ Tack
    \/ ResetClock

Spec == Init /\ [][Next]_vars

===============================================================================