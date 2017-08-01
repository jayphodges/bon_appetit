require 'pry'
require './lib/recipe'
class Pantry

  attr_reader :stock,
              :cookbook

  def initialize
    @stock = Hash.new(0)
    @cookbook = []
  end

  def restock(item, quantity)
    @stock[item.to_s] += quantity
  end

  def stock_check(item)
    @stock[item.to_s]
  end

  def convert_units(recipe)
    result = Hash.new
    recipe.ingredients.each_pair do |key, value|
      result[key] = converter(value)
    end
    result
  end

  def converter(unit)
    if unit < 1
      {quantity: (unit * 1000).to_i,
         units: "Milli-Units"}
    elsif unit > 100
      {quantity: (unit / 100).to_i,
         units: "Centi-Units"}
    else
      {quantity: unit, units: "Universal Units"}
    end
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    check_cookbook.map do |recipe|
      recipe.name
    end
  end

  def how_many_can_i_make
    recipes = Hash.new
    check_cookbook.each do |recipe|
      results = []
      recipe.ingredients.each_pair do |key, value|
        results << (stock_check(key) / value)
      end
      recipes[recipe.name.to_sym] = results.min.round
    end
    return recipes
  end

  private

  def check_cookbook
    @cookbook.find_all do |recipe|
      recipe.ingredients.each_pair do |key, value|
        if stock_check(key) < value
          break
        end
      end
    end
  end

end

# r = Recipe.new("Spicy Cheese Pizza")
# r.add_ingredient("Cayenne Pepper", 0.025)
# r.add_ingredient("Cheese", 75)
# r.add_ingredient("Flour", 500)
# pantry = Pantry.new
# binding.pry
#=====================================
# r1 = Recipe.new("Cheese Pizza")
# r1.add_ingredient("Cheese", 20)
# r1.add_ingredient("Flour", 20)
#
# r2 = Recipe.new("Brine Shot")
# r2.add_ingredient("Brine", 10)
#
# r3 = Recipe.new("Peanuts")
# r3.add_ingredient("Raw nuts", 10)
# r3.add_ingredient("Salt", 10)
# pantry = Pantry.new
# pantry.add_to_cookbook(r1)
# pantry.add_to_cookbook(r2)
# pantry.add_to_cookbook(r3)
# #
# pantry.restock("Cheese", 10)
# pantry.restock("Flour", 20)
# pantry.restock("Brine", 40)
# pantry.restock("Raw nuts", 20)
# pantry.restock("Salt", 20)
# # pantry.how_many_can_i_make
# binding.pry
