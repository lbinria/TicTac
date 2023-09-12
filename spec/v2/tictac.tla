--------------------------------- MODULE tictac ---------------------------------
EXTENDS Naturals, FiniteSets, Sequences, TLC

CONSTANTS ResetValue
VARIABLE clockValue, nTick, nTack, n, actionName

vars == <<actionName, clockValue, nTick, nTack, n>>

Init ==
    /\ n = 0
    /\ clockValue = 0
    /\ nTick = 0
    /\ nTack = 0
    /\ actionName = "Init"

TypeInv ==
    /\ n \in 0..1
    /\ clockValue >= ResetValue
    /\ nTick \in Nat
    /\ nTack \in Nat

Tick ==
    /\ n = 0
    /\ clockValue' = clockValue + 1
    /\ nTick' = nTick + 1
    /\ n' = 1
    /\ actionName' = "Tick"
    /\ UNCHANGED nTack

Tack ==
    /\ n = 1
    /\ clockValue' = clockValue + 1
    /\ nTack' = nTack + 1
    /\ n' = 0
    /\ actionName' = "Tack"
    /\ UNCHANGED nTick

(* May reset on odd number *)
ResetClock ==
    /\ clockValue' = ResetValue
    /\ actionName' = "ResetClock"
    /\ UNCHANGED <<nTick, nTack, n>>

\*ChangeRate(r) ==
\*    /\ clockRate' = r
\*    /\ UNCHANGED <<clockValue, nTick, nTack, n>>

Next ==
    \/ Tick
    \/ Tack
    \/ ResetClock
\*    \/ \E r \in Nat : ChangeRate(r)

Spec == Init /\ [][Next]_vars

===============================================================================