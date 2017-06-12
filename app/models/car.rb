class Car < ApplicationRecord
    validates_presence_of :make, :model, :year, :mileage, :price,
    :interior_color, :exterior_color

    #callbacks
    #instance methods
    def info
        "#{make} #{model} has an exterior color of: #{exterior_color}"
    end

    def old?
        mileage >= 150000 ? true : false 
    end

    def expensive
        price > 30000
    end

    #class methods - scopes
    def self.by_highest_price
        order(price :desc)
    end

    def self.by_mileage(lowest = true)
        lowest ? order(:mileage) : order(mileage :desc)
    end

    def self.by_year
        order(:year)
    end
    #associations
    #serialize - allows us to save a hash or array to a column
    serialize :upgrades, Array
end
