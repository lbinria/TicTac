--------------------------------- MODULE TicTacWatch ---------------------------------
EXTENDS Naturals, Integers, TLC

Abs(x) == IF x > 0 THEN x ELSE -x

VARIABLE action, nTick, nTack, hour, minute, tictac

vars == <<action, nTick, nTack, hour, minute, tictac>>

Move ==
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

Init ==
    /\ action \in {"Tick", "Tack"}
    /\ nTick = 0
    /\ nTack = 0
    /\ hour \in 0..23
    /\ minute \in 0..59
    /\ tictac = [h \in 0..23 |-> [m \in 0..59 |-> ""]]

TypeInv ==
    /\ action \in {"Tick", "Tack"}
    /\ nTick \in Nat
    /\ nTack \in Nat
    /\ Abs(nTick - nTack) <= 1
    /\ hour \in 0..23
    /\ minute \in 0..59
    /\ \A h \in 0..23 : \A m \in 1..59 :
        (tictac[h][m] = "Tick" /\ tictac[h][m-1] /= "") => tictac[h][m-1] = "Tack"

Tick ==
    /\ action = "Tack"
    /\ Move 
    /\ nTick' = nTick + 1
    /\ action' = "Tick"
    /\ tictac' = [tictac EXCEPT ![hour][minute] = "Tack"]
    /\ UNCHANGED nTack

Tack ==
    /\ action = "Tick"
    /\ Move 
    /\ nTack' = nTack + 1
    /\ action' = "Tack"
    /\ tictac' = [tictac EXCEPT ![hour][minute] = "Tick"]
    /\ UNCHANGED nTick

Next ==
    \/ Tick
    \/ Tack

Spec == Init /\ [][Next]_vars

===============================================================================