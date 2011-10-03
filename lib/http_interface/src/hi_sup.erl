-module(hi_sup).

-behavior(supervisor).

-export([start_link/1, start_child/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link(Port) ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, [Port]).

start_child() ->
    supervisor:start_child(?SERVER, []).

init([Port]) ->
    Server = {hi_server, {hi_server, start_link, [Port]},
        permanent, brutal_kill, worker, [hi_server]},
    Children = [Server],
    RestartStrategy = {one_for_one, 0, 1},
    {ok, {RestartStrategy, Children}}.

