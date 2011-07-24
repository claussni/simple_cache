-module(sc_event_logger).

-behavior(gen_event).

-export([add_handler/0, delete_handler/0, handle_event/2]).

add_handler() ->
	sc_event:add_handler(?MODULE, []).

delete_handler() ->
	sc_event:delete_handler(?MODULE, []).

handle_event({create, {Key, Value}}, State) ->
	error_logger:info_msg("create(~w, ~w)~n", [Key, Value]),
	{ok, State};

handle_event({lookup, Key}, State) ->
	error_logger:info_msg("lookup(~w)~n", [Key]),
	{ok, State};

handle_event({delete, Key}, State) ->
	error_logger:info_msg("delete(~w)~n", [Key]),
	{ok, State};

handle_event({replace, {Key, Value}}, State) ->
	error_logger:info_msg("replace(~w, ~w)~n", [Key, Value]),
	{ok, State};

