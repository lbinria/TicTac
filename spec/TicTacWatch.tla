--------------------------------- MODULE TicTacWatch ---------------------------------
EXTENDS Naturals, Integers, TLC

Abs(x) == IF x > 0 THEN x ELSE -x

VARIABLE nTick, nTack, hour, minute, tictac

vars == <<nTick, nTack, hour, minute, tictac>>

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
    /\ nTick = 0
    /\ nTack = 0
    /\ hour \in 0..23
    /\ minute \in 0..59
    /\ tictac = [h \in 0..23 |-> [m \in 0..59 |-> ""]]

TypeInv ==
    /\ nTick \in Nat
    /\ nTack \in Nat
    /\ Abs(nTick - nTack) <= 1
    /\ hour \in 0..23
    /\ minute \in 0..59
    /\ \A h \in 0..23 : \A m \in 1..59 :
        tictac[h][m] \in {"","Tick","Tack"}
    /\ \A h \in 0..23 : \A m \in 1..59 :
        (tictac[h][m] = "Tick" /\ tictac[h][m-1] /= "") => tictac[h][m-1] = "Tack"

Tick ==
    /\ \/ tictac[hour][minute] = "Tack"
       \/ tictac[hour][minute] = ""
    /\ Move 
    /\ nTick' = nTick + 1
    /\ tictac' = [tictac EXCEPT ![hour'][minute'] = "Tick"]
    /\ UNCHANGED nTack

Tack ==
    /\ \/ tictac[hour][minute] = "Tick"
       \/ tictac[hour][minute] = ""
    /\ Move 
    /\ nTack' = nTack + 1
    /\ tictac' = [tictac EXCEPT ![hour'][minute'] = "Tack"]
    /\ UNCHANGED nTick

Next ==
    \/ Tick
    \/ Tack

Spec == Init /\ [][Next]_vars

===============================================================================