defmodule Procs do

  def greeting(count) do
    receive do
      { :boom, reason } ->
        exit(reason)
      { :add, n } ->
        greeting(count+n)
      { :reset } ->
        greeting(0)
      msg ->
        IO.puts("#{count}: Hello #{msg}")
        greeting(count)
    end
  end

end
