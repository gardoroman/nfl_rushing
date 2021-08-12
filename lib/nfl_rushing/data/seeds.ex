defmodule NflRushing.Seeds do

    def convert_for_loading(rec) do
        
    end

    def run do
        {:ok, file} = File.read("rushing.json")
        records = Jason.decode!(file)
        Enum
        # {:ok, cwd} = File.cwd()
        # path = 
        # IO.puts(path)
        
    end
end
