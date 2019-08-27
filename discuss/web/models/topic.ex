defmodule Discuss.Topic do

  use Discuss.Web, :model

  schema "topics" do
    field :title, :string
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom, optional(atom) => any},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title]) #validate de required field
  end

end
