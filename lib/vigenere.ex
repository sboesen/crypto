defmodule Vigenere do
  @moduledoc "Provides functions for breaking Vigenere cipher."




    @doc """
    Determine key length given ciphertext.
    General plan of attack:
    There are 256 values in an ascii byte, but most are not used for english text.
    If we pick the right key length, the chance of any particular byte in that selection
    should be greater than 1/256. If it's the wrong key length, it should be close to uniform.


    Assuming the key length is n, for all n:
    for 0 .. n: (k)
      note every kth character in the ciphertext
        for every character in k, determine the probability over all characters in set of k

    """
    def determine_key_length(ciphertext) do
      list = for n <- (1..String.length ciphertext),
            into: [],
            do: determine_key_length(ciphertext, n)

      1..length(list)
      |> Stream.zip(list)
      |> Enum.sort_by(fn {len, freq} -> freq end)
      |> Enum.filter(fn {len, freq} -> freq < 0.9 end)
      |> Enum.reverse
    end

    @doc """
        Determine key length given `ciphertext` and `n` keylength to guess.

        Return a map of keylength and likelihood of key length [1: 0.2].
    """
    def determine_key_length(ciphertext, n) do
        extract_letters(ciphertext, n)
        |> highest_frequency
    end

    @doc """
    Extract letters from `ciphertext` every `n` characters.

    Returns list of characters or empty list.

    Example: extract_letters("abc", 2) returns ["b"]
    """

    def extract_letters(ciphertext, n) do
      String.graphemes(ciphertext)
      |> Stream.with_index
      |> Enum.filter(fn {_, idx} -> rem(idx + 1, n) == 0 end)
      |> Enum.map(fn {character, _} -> character end)
    end
    @doc """
    Performing a frequency analysis of a set of letters return the highest frequency of any letter.

    Example: Given `letters` equal to "aabc" it will return 0.25
    """
    def highest_frequency(letters) do
      letter_frequencies(letters)
      |> Enum.max_by(fn {_, frequency} -> frequency end)
      |> Tuple.to_list
      |> Enum.at(1)
    end
    @doc """
    Given `letters`, return a list of frequencies for each letter.

    Returns a list like this: [a: 0.1, b: 0.2]
    """
    def letter_frequencies(letters) do
      for {letter, count} <- letter_count(letters),
      into: [],
      do:  {letter, count / Enum.count(letters)}
    end

    @doc """
    Given `letters`, returns a list of occurrence for each letter
    Returns a list like this: [a: 1, b: 2]
    """
    def letter_count(letters) do
      Enum.map(letters, &String.to_atom/1)
      |> Enum.reduce([], fn(letter, list) -> Keyword.update(list, letter, 1, &(&1+1)) end)
    end

    def guess_key_values(letters, n) do
      
    end



end