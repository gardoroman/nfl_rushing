defmodule NflRushing.Repo.Migrations.CreateStats do
  use Ecto.Migration

  def change do
    create table(:stats) do
      add :player, :string, null: false
      add :team, :string, null: false
      add :pos, :string, null: false
      add :att, :float, default: 0.0
      add :att_g, :float, default: 0.0
      add :yds, :float, default: 0.0
      add :avg, :float, default: 0.0
      add :yds_g, :float, default: 0.0
      add :td, :float, default: 0.0
      add :lng, :float, default: 0.0
      add :lng_td, :boolean, default: false
      add :first, :float, default: 0.0
      add :first_pct, :float, default: 0.0
      add :twenty_plus, :float, default: 0.0
      add :forty_plus, :float, default: 0.0
      add :fum, :float, default: 0.0

      timestamps()
    end

  end
end
