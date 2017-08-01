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
  
end
