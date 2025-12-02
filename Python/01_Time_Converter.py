def convert_minutes(minutes):
    hours = minutes // 60
    remaining_minutes = minutes % 60
    return f"{hours} hr{'s' if hours != 1 else ''} {remaining_minutes} minute{'s' if remaining_minutes != 1 else ''}"

print(convert_minutes(int(input("input : "))))
