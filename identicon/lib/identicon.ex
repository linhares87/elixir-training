defmodule Identicon do

    @moduledoc """

  """

  @doc """
    Function for create a hash of input

    ## Parameters

      - input: string that representes the value to be hashed.

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do

    odd_squares = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end

    %Identicon.Image{image | grid: odd_squares}
  end


  @doc """

    Pick a color based on the hash.

    ##Parameters

      - Image: %Identicon.Image with a hash

    ##Examples

      iex(11)> hash = Identicon.hash_input("asdf")
      %Identicon.Image{
        color: nil,
        grid: nil,
        hash: [145, 46, 200, 3, 178, 206, 73, 228, 165, 65, 6, 141, 73, 90, 181, 112]
      }
      iex(12)> Identicon.pick_color(hash)
      %Identicon.Image{
        color: [145, 46, 200],
        grid: nil,
        hash: [145, 46, 200, 3, 178, 206, 73, 228, 165, 65, 6, 141, 73, 90, 181, 112]
      }

  """
  def pick_color(image) do

    #%Identicon.Image{hex: hex_list} = image #pattern matching
    #[r, g, b | _tail] = hex_list #patter matching get first 3 values of a list, the rest go to _tail

    #resuming:

    %Identicon.Image{hash: [r, g, b | _tail]} = image #pattern matching

    %Identicon.Image{image | color: [r, g, b] }

  end


  @spec build_grid(Identicon.Image.t()) :: Identicon.Image.t()
  def build_grid(image) do

    %Identicon.Image{hash: hex} = image
    grid = hex
          |> Enum.chunk(3)
          |> Enum.map(&mirror_row/1) #passing function by reference. The /1 means use the funcion with one parmeter
          |> List.flatten
          |> Enum.with_index

    %Identicon.Image{image | grid: grid}

  end

  @doc """

    Creates a mirror of a row, adding the oposite columns

    ## Parameters

      - row: array of three itens, [145, 46, 200]

    ## Examples
      iex(1)> Identicon.mirror_row([145, 46, 200])
      [145, 46, 200, 46, 145]

  """
  def mirror_row(row) do
    [first, second | _tail] = row # [145, 46, 200]
    row ++ [second, first] # [145, 46, 200, 46, 145]
  end


  @doc """

    Creates a Identicon.Image with a hash of the input

    ## Parameters

     - input: string to be hashed

    ## Examples

    iex(1)> Identicon.hash_input("asdf")
    %Identicon.Image{
      color: nil,
      grid: nil,
      hash: [145, 46, 200, 3, 178, 206, 73, 228, 165, 65, 6, 141, 73, 90, 181, 112]
    }
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hash: hex} #attributing data to a struct


  end

end
