require 'pry'
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
      recipes[recipe.name.to_sym] = results.min.to_i
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
