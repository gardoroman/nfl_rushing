defmodule NflRushingWeb.StatLiveTest do
  use NflRushingWeb.ConnCase

  import Phoenix.LiveViewTest

  alias NflRushing.Rushings

  @create_attrs %{att: 120.5, att_g: 120.5, avg: 120.5, first: 120.5, first_pct: 120.5, forty_plus: 120.5, fum: 120.5, lng: 120.5, lng_td: false, player: "some player", pos: "some pos", td: 120.5, team: "some team", twenty_plus: 120.5, yds: 120.5, yds_g: 120.5}
  @update_attrs %{att: 456.7, att_g: 456.7, avg: 456.7, first: 456.7, first_pct: 456.7, forty_plus: 456.7, fum: 456.7, lng: 456.7, lng_td: false, player: "some updated player", pos: "some updated pos", td: 456.7, team: "some updated team", twenty_plus: 456.7, yds: 456.7, yds_g: 456.7}
  @invalid_attrs %{att: nil, att_g: nil, avg: nil, first: nil, first_pct: nil, forty_plus: nil, fum: nil, lng: nil, player: nil, pos: nil, td: nil, team: nil, twenty_plus: nil, yds: nil, yds_g: nil}

  defp fixture(:stat) do
    {:ok, stat} = Rushings.create_stat(@create_attrs)
    stat
  end

  defp create_stat(_) do
    stat = fixture(:stat)
    %{stat: stat}
  end

  describe "Index" do
    setup [:create_stat]

    test "lists all stats", %{conn: conn, stat: stat} do
      {:ok, _index_live, html} = live(conn, Routes.stat_index_path(conn, :index))

      assert html =~ "NFL Rushing Stats"
      assert html =~ stat.player
    end

    # test "saves new stat", %{conn: conn} do
    #   {:ok, index_live, _html} = live(conn, Routes.stat_index_path(conn, :index))

    #   assert index_live |> element("a", "New Stat") |> render_click() =~
    #            "New Stat"

    #   assert_patch(index_live, Routes.stat_index_path(conn, :new))

    #   assert index_live
    #          |> form("#stat-form", stat: @invalid_attrs)
    #          |> render_change() =~ "can&#39;t be blank"

    #   {:ok, _, html} =
    #     index_live
    #     |> form("#stat-form", stat: @create_attrs)
    #     |> render_submit()
    #     |> follow_redirect(conn, Routes.stat_index_path(conn, :index))

    #   assert html =~ "Stat created successfully"
    #   assert html =~ "some player"
    # end

    # test "updates stat in listing", %{conn: conn, stat: stat} do
    #   {:ok, index_live, _html} = live(conn, Routes.stat_index_path(conn, :index))

    #   assert index_live |> element("#stat-#{stat.id} a", "Edit") |> render_click() =~
    #            "Edit Stat"

    #   assert_patch(index_live, Routes.stat_index_path(conn, :edit, stat))

    #   assert index_live
    #          |> form("#stat-form", stat: @invalid_attrs)
    #          |> render_change() =~ "can&#39;t be blank"

    #   {:ok, _, html} =
    #     index_live
    #     |> form("#stat-form", stat: @update_attrs)
    #     |> render_submit()
    #     |> follow_redirect(conn, Routes.stat_index_path(conn, :index))

    #   assert html =~ "Stat updated successfully"
    #   assert html =~ "some updated player"
    # end

    # test "deletes stat in listing", %{conn: conn, stat: stat} do
    #   {:ok, index_live, _html} = live(conn, Routes.stat_index_path(conn, :index))

    #   assert index_live |> element("#stat-#{stat.id} a", "Delete") |> render_click()
    #   refute has_element?(index_live, "#stat-#{stat.id}")
    # end
  end

  # describe "Show" do
  #   setup [:create_stat]

  #   test "displays stat", %{conn: conn, stat: stat} do
  #     {:ok, _show_live, html} = live(conn, Routes.stat_show_path(conn, :show, stat))

  #     assert html =~ "Show Stat"
  #     assert html =~ stat.player
  #   end

  #   test "updates stat within modal", %{conn: conn, stat: stat} do
  #     {:ok, show_live, _html} = live(conn, Routes.stat_show_path(conn, :show, stat))

  #     assert show_live |> element("a", "Edit") |> render_click() =~
  #              "Edit Stat"

  #     assert_patch(show_live, Routes.stat_show_path(conn, :edit, stat))

  #     assert show_live
  #            |> form("#stat-form", stat: @invalid_attrs)
  #            |> render_change() =~ "can&#39;t be blank"

  #     {:ok, _, html} =
  #       show_live
  #       |> form("#stat-form", stat: @update_attrs)
  #       |> render_submit()
  #       |> follow_redirect(conn, Routes.stat_show_path(conn, :show, stat))

  #     assert html =~ "Stat updated successfully"
  #     assert html =~ "some updated player"
  #   end
  # end
end
