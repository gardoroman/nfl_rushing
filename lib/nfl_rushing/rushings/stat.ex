defmodule NflRushing.Rushings.Stat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stats" do
    field :att, :float
    field :att_g, :float
    field :avg, :float
    field :first, :float
    field :first_pct, :float
    field :forty_plus, :float
    field :fum, :float
    field :lng, :float
    field :lng_td, :boolean
    field :player, :string
    field :pos, :string
    field :td, :float
    field :team, :string
    field :twenty_plus, :float
    field :yds, :float
    field :yds_g, :float

    timestamps()
  end

  @doc false
  def changeset(stat, attrs) do
    stat
    |> cast(attrs, [:player, :team, :pos, :att, :att_g, :yds, :avg, :yds_g, :td, :lng, :lng_td, :first, :first_pct, :twenty_plus, :forty_plus, :fum])
    |> validate_required([:player, :team, :pos, :att, :att_g, :yds, :avg, :yds_g, :td, :lng, :first, :first_pct, :twenty_plus, :forty_plus, :fum])
  end
end
