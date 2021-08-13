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
            {col_name, info} = fields[k]
            {value, touchdown} = update_value(info, v)

            if k == "Lng" and touchdown == "T" do
                acc
                |> Map.put(:lng_td, true)
                |> Map.put(col_name, value)
            else
                Map.put(acc, col_name, value)
            end
        end)
        changeset = Stat.changeset(%Stat{}, stat_record)

        Repo.insert!(changeset)
    end

    def update_value("string", value), do: {value, ""}
    def update_value("float", value) do
        value 
        |> to_string()
        |> Float.parse()
    end    

    def map_fields do
        %{
            "Player" => {:player, "string"},
            "Team" => {:team, "string"},
            "Pos" => {:pos, "string"},
            "Att" => {:att, "float"},
            "Att/G" => {:att_g, "float"},
            "Yds" => {:yds, "float"},
            "Avg" => {:avg, "float"},
            "Yds/G" => {:yds_g, "float"},
            "TD" => {:td, "float"},
            "Lng" => {:lng, "float"},
            "1st" => {:first, "float"},
            "1st%" => {:first_pct, "float"},
            "20+" => {:twenty_plus, "float"},
            "40+" => {:forty_plus, "float"},
            "FUM" => {:fum, "float"}
          }
    end
end
