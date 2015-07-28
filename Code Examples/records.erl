%%% Author @tesp0
%%% This module is for demonstrating basic record use
-module(records).
-compile(export_all).

%% Define a record structure
-record(state, {
        field1,
        field2 = default,
        field3 = []
    }).

%% Create a record with default values for fields 2 & 3
create_record_defaults(F1) -> #state{field1 = F1}.

%% Create a record
create_record(F1, F2, F3) -> #state{field1 = F1, field2 = F2, field3 = F3}.

%% Pattern match function clause
print_state(#state{field1 = F1} = State) ->
    io:format("F1: ~p, State: ~p~n", [F1, State]).

%% Pattern match function clause, equivalent but reversed
print_state_alt(State = #state{field1 = F1}) ->
    io:format("F1: ~p, State: ~p~n", [F1, State]).

%% Print out fields from State
print_state_fields(State = #state{}) ->
    io:format("F1: ~p,
               F2: ~p,
               F3: ~p,
               State: ~p~n", [ State#state.field1,
                               State#state.field2,
                               State#state.field3,
                               State ]).

% Erlang/OTP 17 [erts-6.3] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

% Eshell V6.3  (abort with ^G)
% 1> State_defaults = records:create_record_defaults("Bob").
% {state,"Bob",default,[]}
% 2> State_all_fields = records:create_record("Bob", "Hi", "There").
% {state,"Bob","Hi","There"}
% 3> records:print_state(State_defaults).
% F1: "Bob", State: {state,"Bob",default,[]}
% ok
% 4> records:print_state(State_all_fields).
% F1: "Bob", State: {state,"Bob","Hi","There"}
% ok
% 5> records:print_state_fields(State_defaults).  
% F1: "Bob",
%                F2: default,
%                F3: [],
%                State: {state,"Bob",default,[]}
% ok
% 6> records:print_state_fields(State_all_fields).
% F1: "Bob",
%                F2: "Hi",
%                F3: "There",
%                State: {state,"Bob","Hi","There"}