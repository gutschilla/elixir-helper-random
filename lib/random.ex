defmodule Misc.Random do

    def seed_random do
        use_monotonic = :erlang.module_info 
            |> Keyword.get( :exports ) 
            |> Keyword.get( :monotonic_time )
        time_bif = case use_monotonic do
          1   -> &:erlang.monotonic_time/0
          nil -> &:erlang.now/0
        end
        :random.seed( time_bif.() )
    end

    def string( length ) do
        get_string( length )
    end

    def string() do
        get_string( 8 )
    end

    def get_string( length ) do
        seed_random
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
        seed_random
        { number, "" } = Integer.parse 1..length |> Enum.map_join fn(_) ->
            :random.uniform(10) - 1
        end
        number
    end

end
