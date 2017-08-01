require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

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

end
