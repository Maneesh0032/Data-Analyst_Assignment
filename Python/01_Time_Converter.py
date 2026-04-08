def convert_minutes(m):
    # calculate hours
    h = m // 60  
    
    # remaining minutes
    rm = m % 60  

    # format hours
    h_part = f"{h} hr" if h == 1 else f"{h} hrs"

    # format minutes
    m_part = f"{rm} minute" if rm == 1 else f"{rm} minutes"

    # final result
    return f"{h_part} {m_part}"


m = int(input("Enter minutes: "))
print(convert_minutes(m))
