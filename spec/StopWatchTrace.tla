--------------------------- MODULE StopWatchTrace ---------------------------
(***************************************************************************)
(* clock *)
(***************************************************************************)

EXTENDS TLC, Sequences, SequencesExt, Naturals, FiniteSets, Bags, Json, IOUtils, StopWatch, TraceSpec

(* Override CONSTANTS from the original spec *)

(* Replace Nil constant *)
TraceNil == "null"

(* Can be extracted from Init in original spec*)
DefaultImpl(varName) ==
    CASE varName = "hour" -> 0..11
    []  varName = "minute" -> 0..59

(* Can be extracted from vars in original spec*)
MapVariablesImpl(t) ==
    /\
        IF "hour" \in DOMAIN t
        THEN hour' = UpdateVariable(hour, "hour", t)
        ELSE TRUE
    /\
        IF "minute" \in DOMAIN t
        THEN minute' = UpdateVariable(minute, "minute", t)
        ELSE TRUE

IsTick ==
    /\ IsEvent("Tick")
    /\ Tick

TraceNextImpl ==
    \/ IsTick

(* if we want to compose actions *)
ComposedNext == FALSE

BaseSpec == Init /\ [][Next \/ ComposedNext]_vars
-----------------------------------------------------------------------------
=============================================================================
