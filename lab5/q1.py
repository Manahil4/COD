def identify_even_odd(num):
    if num % 2 == 0:
        return "Even"
    else:
        return "Odd"

# Example usage:
user_input = int(input("Enter some integer value: "))
result = identify_even_odd(user_input)
print("The number is", result)
