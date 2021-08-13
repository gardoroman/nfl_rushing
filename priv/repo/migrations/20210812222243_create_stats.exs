defmodule NflRushing.Repo.Migrations.CreateStats do
  use Ecto.Migration

  def change do
    create table(:stats) do
      add :player, :string, null: false
      add :team, :string, null: false
      add :pos, :string, null: false
      add :att, :string, default: "0"
      add :att_g, :string, default: "0"
      add :yds, :string, default: "0"
      add :avg, :string, default: "0"
      add :yds_g, :string, default: "0"
      add :td, :string, default: "0"
      add :lng, :string, default: "0"
      add :first, :string, default: "0"
      add :first_pct, :string, default: "0"
      add :twenty_plus, :string, default: "0"
      add :forty_plus, :string, default: "0"
      add :fum, :string, default: "0"

      timestamps()
    end

  end
end
