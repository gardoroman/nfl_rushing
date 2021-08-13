defmodule NflRushing.Rushings.Stat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stats" do
    field :att, :string
    field :att_g, :string
    field :avg, :string
    field :first, :string
    field :first_pct, :string
    field :forty_plus, :string
    field :fum, :string
    field :lng, :string
    field :player, :string
    field :pos, :string
    field :td, :string
    field :team, :string
    field :twenty_plus, :string
    field :yds, :string
    field :yds_g, :string

    timestamps()
  end

  @doc false
  def changeset(stat, attrs) do
    stat
    |> cast(attrs, [:player, :team, :pos, :att, :att_g, :yds, :avg, :yds_g, :td, :lng, :first, :first_pct, :twenty_plus, :forty_plus, :fum])
    |> validate_required([:player, :team, :pos, :att, :att_g, :yds, :avg, :yds_g, :td, :lng, :first, :first_pct, :twenty_plus, :forty_plus, :fum])
  end
end
