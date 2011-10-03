-module(hi_app).

-behavior(application).

-export([start/2, stop/1]).

-define(DEFAULT_PORT, 1156).

start(_StartType, _StartArgs) ->
    Port = get_port(?DEFAULT_PORT),
    start_supervisor(Port).

stop(_State) ->
    ok.

get_port(DefaultPort) ->
    case application:get_env(tcp_interface, port) of
        {ok, P}     -> P;
        undefined   -> DefaultPort 
    end.

start_supervisor(Port) ->
    {ok, _Pid} = ti_sup:start_link(Port).

