defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do

    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0

    Enum.each(game.letters, fn letter -> assert letter =~ ~r/[a-z]/ end)
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [ :won, :lost ] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first occurence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used

    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognised" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    moves = [
      {"w", :good_guess, 7},
      {"i", :good_guess, 7},
      {"b", :good_guess, 7},
      {"b", :already_used, 7},
      {"l", :good_guess, 7},
      {"e", :won, 7}
    ]

    assert_moves("wibble", moves)
  end

  test "bad guess is recognised" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognised" do
    moves = [
      {"a", :bad_guess, 6},
      {"b", :bad_guess, 5},
      {"c", :bad_guess, 4},
      {"d", :bad_guess, 3},
      {"e", :bad_guess, 2},
      {"f", :bad_guess, 1},
      {"g", :lost, 0}
    ]

    assert_moves("w", moves)
  end

  def assert_moves(word, moves) do
    game = Game.new_game(word)

    Enum.reduce(moves, game, fn ({guess, state, turns_left}, game) ->
      game = Game.make_move(game, guess)

      assert %{
        game_state: ^state,
        turns_left: ^turns_left
      } = game

      game
    end)
  end
end
