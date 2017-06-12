require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:make) }
    it { should validate_presence_of(:model) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:mileage) }
    it { should validate_presence_of(:interior_color) }
    it { should validate_presence_of(:exterior_color) }
  end

  describe 'serializations' do
    it { should serialize(:upgrades) }
  end

  # # - instance method
  # . - class method
  describe '#info' do
    it 'displays info about the car' do
      car = Car.create(make: 'Toyota', model: 'Tacoma',
                       price: 30000, year: 2013, mileage: 70000,
                       interior_color: 'Grey', exterior_color: 'White')
      expect(car.info).to eq("Toyota Tacoma has a exterior color of: White")
    end
  end

  describe '#old?' do
    it 'returns true if mileage > 150000' do
      car = Car.create(make: 'Toyota', model: 'Tacoma',
                       price: 30000, year: 2013, mileage: 200000,
                       interior_color: 'Grey', exterior_color: 'White')
      expect(car.old?).to eq(true)
    end

    it 'returns true if mileage = 150000' do
      car = Car.create(make: 'Toyota', model: 'Tacoma',
                       price: 30000, year: 2013, mileage: 150000,
                       interior_color: 'Grey', exterior_color: 'White')
      expect(car.old?).to eq(true)
    end

    it 'returns false if mileage < 150000' do
      car = Car.create(make: 'Toyota', model: 'Tacoma',
                       price: 30000, year: 2013, mileage: 3000,
                       interior_color: 'Grey', exterior_color: 'White')
      expect(car.old?).to eq(false)
    end
  end

  describe '#expensive?' do
    it 'returns true if price is over 30000' do
      car = Car.create(make: 'Toyota', model: 'Tacoma',
                       price: 40000, year: 2013, mileage: 3000,
                       interior_color: 'Grey', exterior_color: 'White')
      expect(car.expensive?).to eq(true)
    end

    it 'returns false if price is under 30000' do
      car = Car.create(make: 'Toyota', model: 'Tacoma',
                       price: 20000, year: 2013, mileage: 3000,
                       interior_color: 'Grey', exterior_color: 'White')
      expect(car.expensive?).to eq(false)
    end

    it 'returns false if price is equal to 30000' do
      car = Car.create(make: 'Toyota', model: 'Tacoma',
                       price: 30000, year: 2013, mileage: 3000,
                       interior_color: 'Grey', exterior_color: 'White')
      expect(car.expensive?).to eq(false)
    end
  end

  describe '.by_highest_price' do
    it 'returns array of cars ordered by highest price' do
      car1 = Car.create(make: 'Toyota', model: 'Tacoma',
                        price: 1500, year: 2013, mileage: 3000,
                        interior_color: 'Grey', exterior_color: 'White')
      car2 = Car.create(make: 'Toyota', model: 'Tacoma',
                        price: 4500, year: 2013, mileage: 3000,
                        interior_color: 'Grey', exterior_color: 'White')
      ordered_cars = Car.all.by_highest_price
      expect(ordered_cars.first).to eq(car2)
      expect(ordered_cars.last).to eq(car1)
    end
  end

  describe '.by_mileage' do
    it 'orders cars by mileage asc' do
      car1 = Car.create(make: 'Toyota', model: 'Tacoma',
                        price: 1500, year: 2013, mileage: 500000,
                        interior_color: 'Grey', exterior_color: 'White')
      car2 = Car.create(make: 'Toyota', model: 'Tacoma',
                        price: 4500, year: 2013, mileage: 3000,
                        interior_color: 'Grey', exterior_color: 'White')
      ordered_cars = Car.all.by_mileage
      expect(ordered_cars.first).to eq(car2)
      expect(ordered_cars.last).to eq(car1)
    end

    it 'orders cars by mileage desc' do
      car1 = Car.create(make: 'Toyota', model: 'Tacoma',
                        price: 1500, year: 2013, mileage: 500000,
                        interior_color: 'Grey', exterior_color: 'White')
      car2 = Car.create(make: 'Toyota', model: 'Tacoma',
                        price: 4500, year: 2013, mileage: 3000,
                        interior_color: 'Grey', exterior_color: 'White')
      ordered_cars = Car.all.by_mileage(false)
      expect(ordered_cars.first).to eq(car1)
      expect(ordered_cars.last).to eq(car2)
    end
  end

  describe '.by_year' do
    it 'orders cars by year asc' do
      car1 = Car.create(make: 'Toyota', model: 'Tacoma',
                        price: 1500, year: 2017, mileage: 500000,
                        interior_color: 'Grey', exterior_color: 'White')
      car2 = Car.create(make: 'Toyota', model: 'Tacoma',
                        price: 4500, year: 1999, mileage: 3000,
                        interior_color: 'Grey', exterior_color: 'White')
      ordered_cars = Car.all.by_year
      expect(ordered_cars.first).to eq(car2)
      expect(ordered_cars.last).to eq(car1)
    end
  end
end