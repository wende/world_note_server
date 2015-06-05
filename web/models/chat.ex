defmodule WorldNote.Chat do
  use WorldNote.Web, :model

  schema "chats" do
    field :fbid, :integer
    field :latitude, :float
    field :longitude, :float
    field :content, :string

    timestamps
  end

  @required_fields ~w(fbid latitude longitude content)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
