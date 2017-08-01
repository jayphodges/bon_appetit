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

  def test_converting_units
    pantry = Pantry.new
    centi = pantry.convert_units({:Cheese => 500})
    milli = pantry.convert_units({:Pepper => 0.05})
    uni = pantry.convert_units({:Meat => 65})
    centi_units = {:Cheese=>{:quantity=>5, :units=>"Centi-Units"}}
    milli_units = {:Pepper=>{:quantity=>50, :units=>"Milli-Units"}}
    uni_units = {:Meat=>{:quantity=>65, :units=>"Universal Units"}}
    assert_equal centi_units, centi
    assert_equal milli_units, milli
    assert_equal uni_units, uni

  end


end
