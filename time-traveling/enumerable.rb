module Enumerable
	def my_each
		return self unless block_given?

		for i in self do
			yield(i)
		end
	end

	def my_each_with_index
		return self unless block_given?

		for i in 0...length do
			yield(self[i], i)
		end
	end

	def my_select
		return self unless block_given?

		arr = []
		my_each do |i|
			arr << i if yield(i)
		end
		arr
	end

	def my_all?
		if block_given?
			my_each { |i| return false unless yield(i) }
		else
			my_each { |i| return false unless i }
		end
		true
	end

	def my_any?
		if block_given?
			my_each { |i| return true if yield(i) }
		else
			my_each { |i| return true if i }
		end
		false
	end

	def my_none?
		if block_given?
			my_each { |i| return false if yield(i) }
		else
			my_each { |i| return false if i }
		end
		true
	end

	def my_count(n = nil)
		counter = 0
		if block_given?
			my_each { |i| counter += 1 if yield(i) }
		elsif n.nil?
			counter = length
		else
			my_each { |i| counter += 1 if i == n }
		end
		counter
	end

	def my_map
		return self unless block_given?

		arr = []
		my_each { |i| arr << yield(i) }
		arr
	end

	def my_inject(ini = nil)
    output = ini if ini
    self.my_each do |x|
      if output
        output = yield(output, x)
      else
        output = x
      end
    end
    output
  end
end

def multiply_els(list)
	list.my_inject { |product, i| product * i}
end

puts multiply_els([2,4,5])