require_relative 'employee.rb'

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, boss = nil, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    bonus = employees.inject(0) do |accum, el|
      case el
      when Manager
        accum = accum + el.bonus(1) + el.salary
      else
        accum = accum + el.salary
      end
    end
    bonus * multiplier
  end
  
end
