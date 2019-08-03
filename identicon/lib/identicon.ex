defmodule Identicon do

  @moduledoc """
  
  """

  @doc """
    Function for create a hash of input

    ## Parameters

      - input: string that representes the value to be hashed.

    ## Example
      iex(1)> Identicon.main("orange")
      [254, 1, 214, 122, 0, 45, 250, 15, 58, 192, 132, 41, 129, 66, 236, 205]

  """
  def main(input) do
    input
    |> hash_input
  end


  @doc """
  
  """
  def hash_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list

  # hash = :crypto.hash(:md5, input)
  # list = :binary_bin_to_list(hash)
  #

  end

end
