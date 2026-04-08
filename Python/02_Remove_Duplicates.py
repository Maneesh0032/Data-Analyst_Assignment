def remove_duplicates(s):
    # this will store the final result without duplicates
    res = ""

    # go through each character in the string
    for ch in s:
        # add character only if not already present
        if ch not in res:
            res += ch

    # return the cleaned string
    return res


s = input("Enter string: ")
print(remove_duplicates(s))
