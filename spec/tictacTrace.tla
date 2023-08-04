--------------------------- MODULE tictacTrace ---------------------------
(***************************************************************************)
(* Simplified specification of 2PC *)
(***************************************************************************)

EXTENDS TLC, Sequences, SequencesExt, Naturals, FiniteSets, Bags, Json, IOUtils, tictac, TVOperators, TraceSpec

(* Override CONSTANTS *)

(* Replace Nil constant *)
TraceNil == "null"

(* Replace Server constant *)
\*TraceServer ==
\*    ToSet(JsonTrace[1].Server)

(* Can be extracted from init *)
DefaultImpl(varName) ==
    CASE varName = "hour" -> {0..12}
    []  varName = "minute" -> {0..60}

MapVariablesImpl(t) ==
    /\
        IF "hour" \in DOMAIN t
        THEN hour' = MapVariable(hour, "hour", t)
        ELSE TRUE
    /\
        IF "minute" \in DOMAIN t
        THEN minute' = MapVariable(minute, "minute", t)
        ELSE TRUE



IsTick ==
    /\ IsEvent("Tick")
    /\ Tick


TraceNextImpl ==
    \/ IsTick

ComposedNext == TRUE

BASE == INSTANCE tictac
BaseSpec == BASE!Init /\ [][BASE!Next \/ ComposedNext]_vars
-----------------------------------------------------------------------------
=============================================================================