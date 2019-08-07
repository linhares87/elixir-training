defmodule Identicon do

    @moduledoc """

  """

  @doc """
    Function for create a hash of input

    ## Parameters

      - input: string that representes the value to be hashed.

    ## Examples

        iex(5)> Identicon.main("asdf")
        [  [145, 46, 200, 46, 145],
          [3, 178, 206, 178, 3],
          [73, 228, 165, 228, 73],
          [65, 6, 141, 6, 65],
          [73, 90, 181, 90, 73]
        ]

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid

  end


  @doc """

  """
  def pick_color(image) do

    #%Identicon.Image{hex: hex_list} = image #pattern matching
    #[r, g, b | _tail] = hex_list #patter matching get first 3 values of a list, the rest go to _tail

    #resuming:

    %Identicon.Image{hex: [r, g, b | _tail]} = image #pattern matching

    %Identicon.Image{image | color: {r, g, b} }

  end

  def build_grid(image) do

    %Identicon.Image{hex: hex} = image
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror_row/1) #passing function by reference. The /1 means use the funcion with one parmeter

  end

  @doc """

    ## Parameters

      - row: array of three itens, [145, 46, 200]

    ## Example
      iex(1)> Identicon.mirror_row([145, 46, 200])
      [145, 46, 200, 46, 145]

  """

  def mirror_row(row) do
    # [145, 46, 200]
    [first, second | _tail] = row
    # [145, 46, 200, 46, 145]
    row ++ [second, first]
  end


  @doc """

  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex} #attributing data to a struct


  end

end
