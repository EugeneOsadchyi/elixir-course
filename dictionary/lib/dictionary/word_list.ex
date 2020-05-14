defmodule Dictionary.WordList do

  def random_word(word_list) do
    word_list
    |> Enum.random()
  end

  def word_list() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

  def swap({ a, b }), do: { b, a }

  def eq(a, a), do: true

  def eq(_, _), do: false
end
