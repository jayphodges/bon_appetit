require 'pry'

class Pantry

  attr_reader :stock

  def initialize
    @stock = Hash.new(0)
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

  private

  def converter(unit)
    if unit < 1
      {quantity: (unit * 1000).to_i,
         units: "Milli-Units"}
    elsif unit > 100
      {quantity: (unit / 100).round(0),
         units: "Centi-Units"}
    else
      {quantity: unit, units: "Universal Units"}
    end
  end

end
