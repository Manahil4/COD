def main():
    # Prompt the user to enter temperature
    temperature = int(input("Enter temperature of the day: "))

    # Check the temperature and print appropriate message
    if temperature < 20:
        print("Pleasant weather")
    elif temperature == 20:
        print("Pleasant weather")
    else:
        if temperature < 30:
            print("It is cold today")
        else:
            print("It is hot today")

if __name__ == "__main__":
    main()
