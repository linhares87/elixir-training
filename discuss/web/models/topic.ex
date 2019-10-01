defmodule Discuss.Topic do

  use Discuss.Web, :model

  schema "topics" do
    field :title, :string
  end

  def changeset(struct, params \\ %{}) do #params with default value empty
    struct
    |> cast(params, [:title])
    |> validate_required([:title]) #validate de required field
  end

end
