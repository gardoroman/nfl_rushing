defmodule NflRushing.Seeds do

    alias NflRushing.Repo
    alias NflRushing.Rushings.Stat


    #---------------------------------------------------------
    # run/0
    # Read the "rushing.json" file and decode into an
    # Elixir map and then call load_record/1
    #---------------------------------------------------------
    def run do
        {:ok, file} = File.read("rushing.json")
        Jason.decode!(file)
        |> Enum.each(&load_record/1)
    end

    #----------------------------------------------------------
    # load_record/1
    # Format the record for loading into the stats
    # table.
    # For the purposes of this coding challenge,
    # all values will be converted to string.
    #----------------------------------------------------------
    def load_record(rec) do
        fields = map_fields()
        stat_record = Enum.reduce(rec, %{}, fn {k, v}, acc -> 
            col_name = fields[k]
            Map.put(acc, col_name, to_string(v))
        end)
        changeset = Stat.changeset(%Stat{}, stat_record)

        Repo.insert!(changeset)
    end
    
    

    def map_fields do
        %{
            "Player" => :player,
            "Team" => :team,
            "Pos" => :pos,
            "Att" => :att,
            "Att/G" => :att_g,
            "Yds" => :yds,
            "Avg" => :avg,
            "Yds/G" => :yds_g,
            "TD" => :td,
            "Lng" => :lng,
            "1st" => :first,
            "1st%" => :first_pct,
            "20+" => :twenty_plus,
            "40+" => :forty_plus,
            "FUM" => :fum
          }
    end
end
