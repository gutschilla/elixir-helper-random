defmodule Misc.Random do

  def seed_random do
    try do
      get_otp_version() |> seed()
    catch
      _, _ -> seed()
    end
  end

  def get_otp_version do
    :otp_release
    |> :erlang.system_info()
    |> to_string()
    |> Integer.parse()
    |> elem(0)
  end

  # this work on OTP 17 w/o warnings
  def seed do
    :erlang.now() |> :random.seed()
  end

  def seed(otp_version) when otp_version <= 17 do
    seed()
  end

  # use of erlang.now is deprecated in OTP 18
  def seed(otp_version) when otp_version == 18 do
    :erlang.monotonic_time() |> :random.seed()
  end

  # random is deperecated for rand in OTP 19
  def seed(otp_version) when otp_version >= 19 do
    now = {
      :erlang.phash2([node()]),
      :erlang.monotonic_time(),
      :erlang.unique_integer()
    }
    :rand.seed(:exsplus, now)
  end

  @doc """
  Generates a random string that will always start with a character.
  """
  def string(length \\ 8) do
    seed_random()
    get_string(length)
  end

  defp get_string(1) do
    default_alphabet(:alpha) |> get_random_char
  end

  defp get_string(length) when length > 1 do
    first = get_string(1)
    rest  = Enum.map_join(2..length, fn _ -> default_alphabet() |> get_random_char() end)
    first <> rest
  end

  def get_random_char(alphabet) do
    alphabet_length = alphabet |> String.length
    get_random_char(alphabet, alphabet_length)
  end

  def get_random_char(alphabet, alphabet_length) do
    alphabet |> String.at(uniform(alphabet_length) - 1)
  end

  @doc """
  Generates a random number as string that will not start with leading zeroes.
  """
  def number(length \\ 8) do
   seed_random()
   length
   |> get_number()
   |> Integer.parse()
   |> elem(0)
  end

  defp get_number(1) do
    default_alphabet(:numeric_wo_zeroes) |> get_random_char()
  end

  defp get_number(length) when is_integer(length) do
    first = get_number(1)
    rest  = Enum.map_join(2..length, fn _ -> default_alphabet(:numeric) |> get_random_char end)
    first <> rest
  end

  def default_alphabet do
    default_alphabet(:alpha) <> default_alphabet(:numeric)
  end

  def default_alphabet(:alpha) do
    "abcdefghijklmnopqrstuvwxyz" <> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  end

  def default_alphabet(:numeric) do
    default_alphabet(:numeric_wo_zeroes) <> "0"
  end

  def default_alphabet(:numeric_wo_zeroes) do
    "123456789"
  end

  def uniform(x) do
    try do
      get_otp_version() |> get_uniform(x)
    catch
      _, _ -> get_uniform(x)
    end
  end

  def get_uniform(x), do: x |> :random.uniform
  def get_uniform(otp_version, x) when otp_version <= 18,       do: x |> get_uniform(x)
  def get_uniform(otp_version, x) when is_integer(otp_version), do: x |> :rand.uniform

end
