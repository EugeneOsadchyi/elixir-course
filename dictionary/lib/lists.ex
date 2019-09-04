defmodule Lists do

  def len([]),    do: 0
  def len([_head|tail]), do: 1 + len(tail)

  def sum([]),    do: 0
  def sum([head|tail]), do: head + sum(tail)

  def double([]),    do: []
  def double([head|tail]), do: [ 2*head | double(tail) ]

  def square([]),    do: []
  def square([head|tail]), do: [ head*head | square(tail) ]

  def map([], _func), do: []
  def map([head|tail], func) do
    [ func.(head) | map(tail, func) ]
  end

  def sum_pairs([]), do: []
  def sum_pairs([ h1, h2 | t]), do: [ h1 + h2 | sum_pairs(t) ]

  def even_length?([]), do: true
  def even_length?([a]), do: false
end
