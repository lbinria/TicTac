--------------------------- MODULE TicTacWatchTrace ---------------------------
(***************************************************************************)
(* clock *)
(***************************************************************************)

EXTENDS TLC, Sequences, SequencesExt, Naturals, FiniteSets, Bags, Json, IOUtils, TicTacWatch, TraceSpec

(* Override CONSTANTS from the original spec *)

(* Replace Nil constant *)
TraceNil == "null"

(* Can be extracted from vars in original spec*)
UpdateVariablesImpl(t) ==
    /\
        IF "action" \in DOMAIN t
        THEN action' = UpdateVariable(action, "action", t)
        ELSE TRUE
    /\
        IF "nTick" \in DOMAIN t
        THEN nTick' = UpdateVariable(nTick, "nTick", t)
        ELSE TRUE
    /\
        IF "nTack" \in DOMAIN t
        THEN nTack' = UpdateVariable(nTack, "nTack", t)
        ELSE TRUE
    /\
        IF "hour" \in DOMAIN t
        THEN hour' = UpdateVariable(hour, "hour", t)
        ELSE TRUE
    /\
        IF "minute" \in DOMAIN t
        THEN minute' = UpdateVariable(minute, "minute", t)
        ELSE TRUE
    /\
        IF "tictac" \in DOMAIN t
        THEN tictac' = UpdateVariable(tictac, "tictac", t)
        ELSE TRUE

IsTick ==
    /\ IsEvent("Tick")
    /\ Tick

IsTack ==
    /\ IsEvent("Tack")
    /\ Tack

TraceNextImpl ==
    \/ IsTick
    \/ IsTack

(* if we want to compose actions *)
ComposedNext == FALSE

BaseSpec == Init /\ [][Next \/ ComposedNext]_vars
-----------------------------------------------------------------------------
=============================================================================
