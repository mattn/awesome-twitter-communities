lines =
  File.read!("README.md")
  |> String.split("\n")

fixed_contents_cnt =
  lines
  |> Enum.find_index(& &1 == "|-|-|-|-|")
  |> Kernel.+(1)

table_contents =
  lines
  |> Enum.drop(fixed_contents_cnt)
  |> Enum.reject(& &1 == "")

mapper = fn name, category, language, url ->
  language = if language == "Japanese", do: "\u0000", else: language

  if category == "Etc" do
    {category, name, language, url, :etc}
  else
    {category, name, language, url}
  end
end

sorted_table_contents =
  table_contents
  |> Enum.map(& {&1, String.split(&1, "|")})
  |> Enum.sort_by(fn {_, ["", name, category, language, url, ""]} ->
    mapper.(name, category, language, url)
  end)
  |> Enum.map(& elem(&1, 0))

Enum.take(lines, fixed_contents_cnt)
|> Kernel.++(sorted_table_contents)
|> Kernel.++([""])
|> Enum.join("\n")
|> then(&File.write!("README.md", &1))
