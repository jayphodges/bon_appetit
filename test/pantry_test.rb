require './lib/pantry'
require './lib/recipe'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha'


class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new
    assert_instance_of Pantry, pantry
  end

  def test_it_can_be_stocked
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    assert_equal ({"Cheese"=>10}), pantry.stock
    pantry.restock("Cheese", 10)
    assert_equal ({"Cheese"=>20}), pantry.stock
  end

  def test_checking_stock
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    assert_equal 10, pantry.stock_check("Cheese")
    pantry.restock("Cheese", 10)
    assert_equal 20, pantry.stock_check("Cheese")
  end

  def test_converting_units
    pantry = Pantry.new
    centi = pantry.converter(500)
    milli = pantry.converter(0.05)
    uni = pantry.converter(65)
    centi_units = {:quantity=>5, :units=>"Centi-Units"}
    milli_units = {:quantity=>50, :units=>"Milli-Units"}
    uni_units = {:quantity=>65, :units=>"Universal Units"}
    assert_equal centi_units, centi
    assert_equal milli_units, milli
    assert_equal uni_units, uni
  end

  def test_adding_to_cookbook
    pantry = Pantry.new
    pantry.add_to_cookbook("recipe")
    assert_equal "recipe", pantry.cookbook
  end

  def test_what_can_i_make

  end

  def test_how_many_can_i_make

  end

  def recipe
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)
    r
  end

end
