def check_sorting(numbers)
  number_check = []
  sort_check = numbers.each_with_index do |number, index|
    if index + 1 < numbers.length()
      numbers[index] <= numbers[index + 1] ? number_check.push(true) : number_check.push(false)
    end
  end
  return number_check.all?(true)
end

numbers = [20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

def bubble_sort(numbers)

  while !check_sorting(numbers)
    numbers.each_with_index do |number, i|

      if numbers[i + 1] == nil
        break
      end

      if numbers[i] > numbers[i+1]
        numbers[i], numbers[i+1] = numbers[i+1], numbers[i]
      end
      
    end
  end


  return numbers
end

puts "#{bubble_sort(numbers)}"