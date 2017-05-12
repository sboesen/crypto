defmodule VigenereTest do
  use ExUnit.Case
  doctest Crypto

  test "letter_frequencies computes letter frequencies correctly" do
      assert [a: 1/3, b: 2/3] == Vigenere.letter_frequencies(["a","b","b"])
      assert [a: 5/7, b: 2/7] == Vigenere.letter_frequencies(["a","a","a","a","a","b","b"])
  end
  test "extract_letters extracts the correct letters" do
    assert ["a","b","c"] == Vigenere.extract_letters("abc", 1)
    assert ["b"] == Vigenere.extract_letters("abc", 2)
    assert ["c"] == Vigenere.extract_letters("abc", 3)
    assert ["b", "d"] == Vigenere.extract_letters("abcd", 2)
    assert ["c"] == Vigenere.extract_letters("abcd", 3)
  end

  test "letter_count counts letters correctly" do
    assert [a: 1, b: 2] == Vigenere.letter_count(["a","b","b"])
    assert [a: 5, b: 2] == Vigenere.letter_count(["a","a","a","a","a","b","b"])
  end
  test "highest_frequency returns highest frequency" do
    assert 0.5 == Vigenere.highest_frequency(["a","b","b","c"])
    assert 0.25 == Vigenere.highest_frequency(["a","b","c","d"])
  end
  test "determine_key_length works for short ciphertext" do
    output = [{12, 0.6666666666666666}, {11, 0.6666666666666666}, {21, 0.5},
                           {20, 0.5}, {19, 0.5}, {18, 0.5}, {17, 0.5}, {16, 0.5}, {15, 0.5},
                           {14, 0.3333333333333333}, {13, 0.3333333333333333},
                           {7, 0.3333333333333333}, {6, 0.2857142857142857},
                           {3, 0.2857142857142857}, {10, 0.25}, {9, 0.25}, {5, 0.25},
                           {8, 0.2}, {4, 0.2}, {1, 0.16666666666666666},
                           {2, 0.14285714285714285}]
    computed = Vigenere.determine_key_length("F96DE8C227A259C87EE1DA2AED57C93FE5DA36ED4EC87EF2C63AAE5B9A7EFFD673BE4ACF7BE8923CAB1ECE7AF2DA3DA44FCF7AE29235A24C963FF0DF3CA3599A70E5DA36BF1ECE77F8DC34BE129A6CF4D126BF5B9A7CFEDF3EB850D37CF0C63AA2509A76FF9227A55B9A6FE3D720A850D97AB1DD35ED5FCE6BF0D138A84CC931B1F121B44ECE70F6C032BD56C33FF9D320ED5CDF7AFF9226BE5BDE3FF7DD21ED56CF71F5C036A94D963FF8D473A351CE3FE5DA3CB84DDB71F5C17FED51DC3FE8D732BF4D963FF3C727ED4AC87EF5DB27A451D47EFD9230BF47CA6BFEC12ABE4ADF72E29224A84CDF3FF5D720A459D47AF59232A35A9A7AE7D33FB85FCE7AF5923AA31EDB3FF7D33ABF52C33FF0D673A551D93FFCD33DA35BC831B1F43CBF1EDF67F0DF23A15B963FE5DA36ED68D378F4DC36BF5B9A7AFFD121B44ECE76FEDC73BE5DD27AFCD773BA5FC93FE5DA3CB859D26BB1C63CED5CDF3FE2D730B84CDF3FF7DD21ED5ADF7CF0D636BE1EDB79E5D721ED57CE3FE6D320ED57D469F4DC27A85A963FF3C727ED49DF3FFFDD24ED55D470E69E73AC50DE3FE5DA3ABE1EDF67F4C030A44DDF3FF5D73EA250C96BE3D327A84D963FE5DA32B91ED36BB1D132A31ED87AB1D021A255DF71B1C436BF479A7AF0C13AA14794")
    IO.inspect(computed, limit: :infinity)
    assert output == computed
  end

#  test "guess_key_values returns highest frequency" do
#    assert 0.5 == Vigenere.guess_key_values(["a","b","b","c"])
#    assert 0.25 == Vigenere.guess_key_values(["a","b","c","d"])
#  end
end