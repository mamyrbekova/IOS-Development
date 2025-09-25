import Foundation

// PROBLEM 1
func runFizzBuzz() {
    for number in 1...100 {
        if number % 3 == 0 && number % 5 == 0 {
            print("FizzBuzz")
        }
        else if number % 3 == 0 {
            print("Fizz")
        }
        else if number % 5 == 0 {
            print("Buzz")
        }
        else {
            print(number)
        }
    }
}


// PROBLEM 2
func isPrime(_ number: Int) -> Bool {
    if number < 2 { return false }
    if number == 2 { return true }
    if number % 2 == 0 { return false }
    
    var divisor = 3
    while divisor * divisor <= number {
        if number % divisor == 0 { return false }
        divisor += 2
    }
    return true
}

func findPrimesInRange() {
    print("Prime numbers between 1 and 100:")
    for number in 1...100 {
        if isPrime(number) {
            print(number, terminator: " ")
        }
    }
    print("\n")
}

// PROBLEM 3

func celsiusToFahrenheit(_ celsius: Double) -> Double {
    return (celsius * 9/5) + 32
}

func celsiusToKelvin(_ celsius: Double) -> Double {
    return celsius + 273.15
}

func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
    return (fahrenheit - 32) * 5/9
}

func fahrenheitToKelvin(_ fahrenheit: Double) -> Double {
    return celsiusToKelvin(fahrenheitToCelsius(fahrenheit))
}

func kelvinToCelsius(_ kelvin: Double) -> Double {
    return kelvin - 273.15
}

func kelvinToFahrenheit(_ kelvin: Double) -> Double {
    return celsiusToFahrenheit(kelvinToCelsius(kelvin))
}

func runTemperatureConverter() {
    print("Problem 3: Temperature Converter")
    
    print("Enter temperature value: ", terminator: "")
    guard let tempInput = readLine(), let temperature = Double(tempInput) else {
        print("Invalid temperature value.\n")
        return
    }
    
    print("Enter temperature unit (C, F, or K): ", terminator: "")
    guard let unitInput = readLine()?.uppercased(), !unitInput.isEmpty else {
        print("Invalid unit input.\n")
        return
    }
    
    let unit = unitInput.prefix(1)
    
    switch unit {
    case "C":
        print("\(temperature)°C = \(String(format: "%.2f", celsiusToFahrenheit(temperature)))°F")
        print("\(temperature)°C = \(String(format: "%.2f", celsiusToKelvin(temperature)))K")
    case "F":
        print("\(temperature)°F = \(String(format: "%.2f", fahrenheitToCelsius(temperature)))°C")
        print("\(temperature)°F = \(String(format: "%.2f", fahrenheitToKelvin(temperature)))K")
    case "K":
        print("\(temperature)K = \(String(format: "%.2f", kelvinToCelsius(temperature)))°C")
        print("\(temperature)K = \(String(format: "%.2f", kelvinToFahrenheit(temperature)))°F")
    default:
        print("Invalid unit.")
    }
    print()
}


// PROBLEM 4
func shoppingListManager() {
    var shoppingList: [String] = []
    var isRunning = true

    
    while isRunning {
        displayMenu()
        
        print("Enter your choice (1-4): ", terminator: "")
        guard let input = readLine(), let choice = Int(input) else {
            print("Invalid input. Please enter a number between 1 and 4.\n")
            continue
        }
        
        switch choice {
        case 1:
            addItem(to: &shoppingList)
        case 2:
            removeItem(from: &shoppingList)
        case 3:
            displayShoppingList(shoppingList)
        case 4:
            isRunning = false
            print("Thank you for using Shopping List Manager. Goodbye!")
        default:
            print("Invalid choice. Please enter a number between 1 and 4.\n")
        }
    }
}

func displayMenu() {
    print("SHOPPING LIST MENU")
    print("1. Add item to shopping list")
    print("2. Remove item from shopping list")
    print("3. View current shopping list")
    print("4. Exit")
}

func addItem(to list: inout [String]) {
    print("Enter the item to add: ", terminator: "")
    guard let item = readLine(), !item.trimmingCharacters(in: .whitespaces).isEmpty else {
        print("Invalid item name. Item cannot be empty.\n")
        return
    }
    
    let trimmedItem = item.trimmingCharacters(in: .whitespaces)
    
    if list.contains(where: { $0.lowercased() == trimmedItem.lowercased() }) {
        print("'\(trimmedItem)' is already in your shopping list.\n")
        return
    }
    
    list.append(trimmedItem)
    print("'\(trimmedItem)' has been added to your shopping list.\n")
}

func removeItem(from list: inout [String]) {
    if list.isEmpty {
        print("Your shopping list is empty. Nothing to remove.\n")
        return
    }
    
    displayShoppingList(list)
    print("Enter the item number to remove: ", terminator: "")
    
    guard let input = readLine(), let itemNumber = Int(input) else {
        print("Invalid input. Please enter a valid item number.\n")
        return
    }
    
    if itemNumber >= 1 && itemNumber <= list.count {
        let removedItem = list.remove(at: itemNumber - 1)
        print("'\(removedItem)' has been removed from your shopping list.\n")
    } else {
        print("Invalid item number. Please enter a number between 1 and \(list.count).\n")
    }
}

func displayShoppingList(_ list: [String]) {
    if list.isEmpty {
        print("Your shopping list is currently empty.\n")
    } else {
        print("CURRENT SHOPPING LIST")
        
        for (index, item) in list.enumerated() {
            print("\(index + 1). \(item)")
        }
        
        print("Total items: \(list.count)")
    }
}

extension String {
    static func * (left: String, right: Int) -> String {
        return String(repeating: left, count: right)
    }
}



// PROBLEM 5
func wordFrequencyCounter() {
    print("Enter a sentence: ", terminator: "")
    guard let input = readLine(), !input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
        print("No sentence!\n")
        return
    }
    let lowercased = input.lowercased()
    
    let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet.whitespaces)
    let filteredScalars = lowercased.unicodeScalars.filter { allowedCharacterSet.contains($0) }
    let cleaned = String(String.UnicodeScalarView(filteredScalars))
    
    let words = cleaned.split { $0.isWhitespace }.map { String($0) }
    
    var Dict: [String: Int] = [:]
    
    for word in words {
           if word.isEmpty { continue }
           Dict[word, default: 0] += 1
       }
       
       print("\nWord frequencies:")
       for (word, count) in Dict {
           print("\(word): \(count)")
       }
       print()
}

// PROBLEM 6
func fibonacci(_ n: Int) -> [Int] {
    if n <= 0 {
        return []
    } else if n == 1 {
        return [0]
    } else if n == 2 {
        return [0, 1]
    }
    
    var sequence = [0, 1]
    
    for _ in 3...n {
        let next = sequence[sequence.count - 1] + sequence[sequence.count - 2]
        sequence.append(next)
    }
    
    return sequence
}

func runFibonacci() {
    print("Enter how many Fibonacci numbers to generate: ", terminator: "")
    
    guard let input = readLine(), let n = Int(input) else {
        print("Invalid input.\n")
        return
    }
    
    let result = fibonacci(n)
    if result.isEmpty {
        print("No Fibonacci numbers generated. Please enter a positive integer.\n")
    } else {
        print("First \(n) Fibonacci numbers: \(result)\n")
    }
}

// PROBLEM 7
func gradeCalculator() {
    print("Enter the number of sttudents: ", terminator: "")
    guard let input = readLine(), let numStudents = Int(input), numStudents > 0 else {
        print("Invalid input!\n")
        return
    }
    
    var students: [String: Int] = [:]
    
    for i in 1...numStudents {
        print("Enter the student's name: ", terminator: "")
        guard let name = readLine(), !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("Invalid name!")
            return
        }
        
        print("Enter \(name)'s score: ", terminator: "")
        guard let scoreInput = readLine(),  let score = Int(scoreInput) else {
            print("Invalid input!")
            return
        }
        students[name] = score
    }
    
    let scores = Array(students.values)
       
       guard !scores.isEmpty else {
           print("No scores entered.\n")
           return
       }
    
    let total = scores.reduce(0, +)
        let average = Double(total) / Double(scores.count)
        let highest = scores.max() ?? 0
        let lowest = scores.min() ?? 0
        
        print("\nGrade Report: ")
        print("\nAverage score: \(String(format: "%.2f", average))")
        print("\nHighest score: \(highest)")
        print("\nLowest score: \(lowest)\n")
        
        for (name, score) in students {
            if Double(score) >= average {
                print("\(name): \(score) → Above/Equal to Average")
            } else {
                print("\(name): \(score) → Below Average")
            }
        }
        
        print()
    
}

// PROBLEM 8
func isPalindrome(_ text: String) -> Bool  {
    let cleaned = text.lowercased().filter { $0.isLetter || $0.isNumber }
    return cleaned == String(cleaned.reversed())
}

func palindromeChecker() {
    print("Enter an word: ", terminator: "")
    guard let input = readLine(), !input.isEmpty else {
        print("Invalid input!")
        return
    }
    if isPalindrome(input) {
        print("\(input) is palindrome\n")
    }else {
        print("\(input) is not palindrome\n")
    }
    
}

// PROBLEM 9

func add(_ a: Double, _ b: Double) -> Double {
    return a + b
}

func subtract(_ a: Double, _ b: Double) -> Double {
    return a - b
}

func multiply(_ a: Double, _ b: Double) -> Double {
    return a * b
}

func divide(_ a: Double, _ b: Double) -> Double? {
    if b == 0 {
        return nil
    }
    return a / b
}

func simpleCalculator() {
    var operation = true
    
    while operation {
        print("\nEnter the first number: ", terminator: "")
        guard let input1 = readLine(), let num1 = Double(input1) else {
            print("Invalid input!")
            continue
        }
        
        print("Enter the second number: ", terminator: "")
        guard let input2 = readLine(), let num2 = Double(input2) else {
            print("Invalid input.")
            continue
        }
        
        print("Choose operation (+, -, *, /): ", terminator: "")
        guard let op = readLine(), !op.isEmpty else {
            print("Invalid operation.")
            continue
        }
        
        var result: Double?
        switch op {
        case "+":
            result = add(num1, num2)
        case "-":
            result = subtract(num1, num2)
        case "*":
            result = multiply(num1, num2)
        case "/":
            if let res = divide(num1, num2) {
                result = res
            } else {
                print("Error: Division by zero is not allowed.")
            }
        default:
            print("Invalid operation. Please choose +, -, *, /")
        }
        
        if let res = result {
            print("Result: \(res)")
        }
        
        print("\nDo you want to perform another calculation? (y/n): ", terminator: "")
        if let choice = readLine(), choice.lowercased() != "y" {
            operation = false
        }
    }
    
    print("Calculator exited.\n")
}

// PROBLEM 10

func hasUniqueCharacters(_ text: String) -> Bool {
    var seen: Set<Character> = []
    
    for char in text {
        if seen.contains(char) {
            return false
        }
        seen.insert(char)
    }
    return true
}

func runUniqueCharactersChecker() {
    print("Enter a string: ", terminator: "")
    
    guard let input = readLine(), !input.isEmpty else {
        print("Invalid input. Please enter some text.\n")
        return
    }
    
    if hasUniqueCharacters(input) {
        print("\(input) has all unique characters.\n")
    } else {
        print("\(input) does not have all unique characters.\n")
    }
}




// problem 1 - runFizzBuzz()
// problem 2 - findPrimesInRange()
// problem 3 - runTemperatureConverter()
// problem 4 - shoppingListManager()
// problem 5 - wordFrequencyCounter()
// problem 6 - runFibonacci()
// problem 7 - gradeCalculator()
// problem 8 - palindromeChecker()
// problem 9 - simpleCalculator()
// problem 10 - runUniqueCharactersChecker()


func main() {
//    runFizzBuzz()
//    findPrimesInRange()
//    runTemperatureConverter()
//    shoppingListManager()
//    wordFrequencyCounter()
//    runFibonacci()
//    gradeCalculator()
//    palindromeChecker()
//    simpleCalculator()
//    runUniqueCharactersChecker()
}


main()



