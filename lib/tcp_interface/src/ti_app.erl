-module(ti_app).

-behavior(application).

-export([start/2, stop/1]).

-define(DEFAULT_PORT, 1155).

start(_StartType, _StartArgs) ->
    Port = get_port(?DEFAULT_PORT),
    LSock = create_listening_socket(Port),
    start_supervisor(LSock),
    accept_first_connection().

stop(_State) ->
    ok.

get_port(DefaultPort) ->
    case application:get_env(tcp_interface, port) of
        {ok, P}     -> P;
        undefined   -> DefaultPort 
    end.

create_listening_socket(Port) ->
    {ok, LSock} = gen_tcp:listen(Port, [{active, true}]),
    LSock.

start_supervisor(Socket) ->
    {ok, _Pid} = ti_sup:start_link(Socket).

accept_first_connection() ->
    ti_sup:start_child().

