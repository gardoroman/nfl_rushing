defmodule NflRushing.RushingsTest do
  use NflRushing.DataCase

  alias NflRushing.Rushings

  describe "stats" do
    alias NflRushing.Rushings.Stat

    @valid_attrs %{att: 120.5, att_g: 120.5, avg: 120.5, first: 120.5, first_pct: 120.5, forty_plus: 120.5, fum: 120.5, lng: 120.5, player: "some player", pos: "some pos", td: 120.5, team: "some team", twenty_plus: 120.5, yds: 120.5, yds_g: 120.5}
    @update_attrs %{att: 456.7, att_g: 456.7, avg: 456.7, first: 456.7, first_pct: 456.7, forty_plus: 456.7, fum: 456.7, lng: 456.7, player: "some updated player", pos: "some updated pos", td: 456.7, team: "some updated team", twenty_plus: 456.7, yds: 456.7, yds_g: 456.7}
    @invalid_attrs %{att: nil, att_g: nil, avg: nil, first: nil, first_pct: nil, forty_plus: nil, fum: nil, lng: nil, player: nil, pos: nil, td: nil, team: nil, twenty_plus: nil, yds: nil, yds_g: nil}

    def stat_fixture(attrs \\ %{}) do
      {:ok, stat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rushings.create_stat()

      stat
    end

    test "list_stats/0 returns all stats" do
      stat = stat_fixture()
      assert Rushings.list_stats() == [stat]
    end

    test "get_stat!/1 returns the stat with given id" do
      stat = stat_fixture()
      assert Rushings.get_stat!(stat.id) == stat
    end

    test "create_stat/1 with valid data creates a stat" do
      assert {:ok, %Stat{} = stat} = Rushings.create_stat(@valid_attrs)
      assert stat.att == 120.5
      assert stat.att_g == 120.5
      assert stat.avg == 120.5
      assert stat.first == 120.5
      assert stat.first_pct == 120.5
      assert stat.forty_plus == 120.5
      assert stat.fum == 120.5
      assert stat.lng == 120.5
      assert stat.player == "some player"
      assert stat.pos == "some pos"
      assert stat.td == 120.5
      assert stat.team == "some team"
      assert stat.twenty_plus == 120.5
      assert stat.yds == 120.5
      assert stat.yds_g == 120.5
    end

    test "create_stat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rushings.create_stat(@invalid_attrs)
    end

    test "update_stat/2 with valid data updates the stat" do
      stat = stat_fixture()
      assert {:ok, %Stat{} = stat} = Rushings.update_stat(stat, @update_attrs)
      assert stat.att == 456.7
      assert stat.att_g == 456.7
      assert stat.avg == 456.7
      assert stat.first == 456.7
      assert stat.first_pct == 456.7
      assert stat.forty_plus == 456.7
      assert stat.fum == 456.7
      assert stat.lng == 456.7
      assert stat.player == "some updated player"
      assert stat.pos == "some updated pos"
      assert stat.td == 456.7
      assert stat.team == "some updated team"
      assert stat.twenty_plus == 456.7
      assert stat.yds == 456.7
      assert stat.yds_g == 456.7
    end

    test "update_stat/2 with invalid data returns error changeset" do
      stat = stat_fixture()
      assert {:error, %Ecto.Changeset{}} = Rushings.update_stat(stat, @invalid_attrs)
      assert stat == Rushings.get_stat!(stat.id)
    end

    test "delete_stat/1 deletes the stat" do
      stat = stat_fixture()
      assert {:ok, %Stat{}} = Rushings.delete_stat(stat)
      assert_raise Ecto.NoResultsError, fn -> Rushings.get_stat!(stat.id) end
    end

    test "change_stat/1 returns a stat changeset" do
      stat = stat_fixture()
      assert %Ecto.Changeset{} = Rushings.change_stat(stat)
    end
  end
end
