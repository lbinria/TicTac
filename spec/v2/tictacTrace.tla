--------------------------- MODULE tictacTrace ---------------------------
(***************************************************************************)
(* clock *)
(***************************************************************************)

EXTENDS TLC, Sequences, SequencesExt, Naturals, FiniteSets, Bags, Json, IOUtils, tictac, TraceSpec

(* Override CONSTANTS from the original spec *)

(* Replace Nil constant *)
TraceNil == "null"

(* Replace ResetValue constant *)
TraceResetValue ==
    JsonTrace[1].ResetValue

(* Can be extracted from Init in original spec*)
DefaultImpl(varName) ==
    CASE varName = "clockValue" -> 0
    []  varName = "nTick" -> 0
    []  varName = "nTack" -> 0

(* Can be extracted from vars in original spec*)
MapVariablesImpl(t) ==
    /\
        IF "clockValue" \in DOMAIN t
        THEN clockValue' = MapVariable(clockValue, "clockValue", t)
        ELSE TRUE
    /\
        IF "nTick" \in DOMAIN t
        THEN nTick' = MapVariable(nTick, "nTick", t)
        ELSE TRUE
    /\
        IF "nTack" \in DOMAIN t
        THEN nTack' = MapVariable(nTack, "nTack", t)
        ELSE TRUE

IsTick ==
    /\ IsEvent("Tick")
    /\ Tick

IsTack ==
    /\ IsEvent("Tack")
    /\ Tack

IsResetClock ==
    /\ IsEvent("ResetClock")
    /\ ResetClock

TraceNextImpl ==
    \/ IsTick
    \/ IsTack
    \/ IsResetClock

(* if we want to compose actions *)
ComposedNext == FALSE

BaseSpec == Init /\ [][Next \/ ComposedNext]_vars
-----------------------------------------------------------------------------
=============================================================================
