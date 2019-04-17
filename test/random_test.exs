defmodule Misc.RandomTest do
  use ExUnit.Case

    test "generate string(8)" do
        string = Misc.Random.string(99)
        assert String.valid? string
        assert String.length( string ) == 99
    end

    test "generate string() is like string(8)" do
        string = Misc.Random.string()
        assert String.valid? string
        assert String.length( string ) == 8
    end

    test "strings always start with a character" do
      string_starts_with_character = fn length ->
        length
        |> Misc.Random.string
        |> String.match?(~r/\A[a-z]/i)
      end
     1..100 |> Enum.all?(string_starts_with_character) |> assert
    end

    test "numbers have desired length (no leading zeroes)" do
      numbers_have_desired_length = fn length ->
        number    = length |> Misc.Random.number
        length_ok = number |> to_string |> String.length |> Kernel.==(length)
        start_ok  = number |> to_string |> String.match?(~r/\A[1-9]/)
        if not length_ok do
          IO.inspect([length, number])
        end
        start_ok and length_ok
      end
      1..100 |> Enum.all?(numbers_have_desired_length) |> assert
    end

    test "generate number" do
        number = Misc.Random.number()
        assert is_integer number
    end

end
