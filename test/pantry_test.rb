require './lib/pantry'
require './lib/recipe'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha'


class PantryTest < Minitest::Test

  def setup
    @pantry = Pantry.new
  end

  def test_it_exists
    assert_instance_of Pantry, @pantry
  end

  def test_it_can_be_stocked
    @pantry.restock("Cheese", 10)
    assert_equal ({"Cheese"=>10}), @pantry.stock
    @pantry.restock("Cheese", 10)
    assert_equal ({"Cheese"=>20}), @pantry.stock
  end

  def test_checking_stock
    @pantry.restock("Cheese", 10)
    assert_equal 10, @pantry.stock_check("Cheese")
    @pantry.restock("Cheese", 10)
    assert_equal 20, @pantry.stock_check("Cheese")
  end

  def test_convert_units
    actual = @pantry.convert_units(recipe1)
    expected = ({"Cheese"=>{:quantity=>20, :units=>"Universal Units"},
                 "Flour"=>{:quantity=>20, :units=>"Universal Units"}
                })
    assert_equal actual, expected
  end

  def test_converting_units
    centi = @pantry.converter(500)
    milli = @pantry.converter(0.05)
    uni = @pantry.converter(65)
    centi_units = {:quantity=>5, :units=>"Centi-Units"}
    milli_units = {:quantity=>50, :units=>"Milli-Units"}
    uni_units = {:quantity=>65, :units=>"Universal Units"}
    assert_equal centi_units, centi
    assert_equal milli_units, milli
    assert_equal uni_units, uni
  end

  def test_adding_to_cookbook
    @pantry.add_to_cookbook("recipe")
    assert_equal ["recipe"], @pantry.cookbook
  end

  def test_what_can_i_make
    @pantry.add_to_cookbook(recipe2)
    fill_pantry
    actual = @pantry.what_can_i_make
    expected = ["Brine Shot"]
    assert_equal expected, actual
  end

  def test_how_many_can_i_make_with_multiple_recipes
    @pantry.add_to_cookbook(recipe1)
    @pantry.add_to_cookbook(recipe2)
    @pantry.add_to_cookbook(recipe3)
    fill_pantry
    actual = @pantry.what_can_i_make
    expected = ["Brine Shot", "Peanuts"]
    assert_equal expected, actual
  end

  def test_how_many_can_i_make
    @pantry.add_to_cookbook(recipe1)
    @pantry.add_to_cookbook(recipe2)
    @pantry.add_to_cookbook(recipe3)
    fill_pantry
    actual = @pantry.how_many_can_i_make
    expected = ({:"Brine Shot"=>4, :Peanuts=>2})
    assert_equal expected, actual
  end

  def recipe1
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r1
  end

  def recipe2
    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)
    r2
  end

  def recipe3
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    r3
  end

  def fill_pantry
    @pantry.restock("Cheese", 10)
    @pantry.restock("Flour", 20)
    @pantry.restock("Brine", 40)
    @pantry.restock("Raw nuts", 20)
    @pantry.restock("Salt", 20)
  end

end
