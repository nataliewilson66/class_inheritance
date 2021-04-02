require_relative 'employee'

class Manager < Employee

  attr_accessor :salary, :employees

  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    reporting_queue = [self]
    salary_sum = 0
    until reporting_queue.empty?
      current_emp = reporting_queue.shift
      salary_sum += current_emp.salary
      reporting_queue += current_emp.employees if current_emp.is_a?(Manager)
    end
    salary_sum -= self.salary
    salary_sum * multiplier
  end

end

david = Employee.new("David", "TA", 10000, nil)
shawna = Employee.new("Shawna",  "TA", 12000, nil)
darren = Manager.new("Darren", "TA Manager", 78000, nil, [david, shawna])
david.boss = darren
shawna.boss = darren
ned = Manager.new("Ned", "Founder", 1000000, nil, [darren])
darren.boss = ned

puts ned.bonus(5)
puts darren.bonus(4)
puts david.bonus(3)