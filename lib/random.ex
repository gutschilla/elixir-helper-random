defmodule Random do

    use Application

    # See http://elixir-lang.org/docs/stable/elixir/Application.html
    # for more information on OTP Applications
    def start(_type, _args) do
        import Supervisor.Spec, warn: false

        children = [
          # Define workers and child supervisors to be supervised
          # worker(TestApp.Worker, [arg1, arg2, arg3])
        ]
        opts = [strategy: :one_for_one, name: Random.Supervisor]
        Supervisor.start_link(children, opts)
    end


    def string( length ) do
        get_string( length )
    end

    def string() do
        get_string( 8 )
    end

    def get_string( length ) do
        :random.seed(:erlang.now())
        alphabet
            =  "abcdefghijklmnopqrstuvwxyz"
            <> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            <> "0123456789"
        alphabet_length = alphabet |> String.length
        1..length
        |> Enum.map_join fn(_) ->
            alphabet |> String.at :random.uniform( alphabet_length ) - 1
        end
    end

    def number() do
        get_number(8)
    end

    def number( length ) do
        get_number( length )
    end

    def get_number( length ) do
        :random.seed(:erlang.now())
        { number, "" } = Integer.parse 1..length |> Enum.map_join fn(_) ->
            :random.uniform(10) - 1
        end
        number
    end

end

defmodule Random.Supervisor do
    use Supervisor

    def start_link do
        Supervisor.start_link(__MODULE__, :ok)
    end

    def init(:ok) do
        children = []
        supervise(children, strategy: :one_for_one)
    end
end
