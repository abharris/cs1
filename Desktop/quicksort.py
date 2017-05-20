# Alexis Harris
# CS 1
# 10/30/16
# quicksort.py
# This program has three functions, partition, quicksort and sort which all work to sort a list

# organizes the list to be divided in such a way that to left of last element in the original list it is less than it and to the right it is greater
# uses a list, a start and end point to be partioned and a comparison function
def partition(the_list, p, r, compare_func):

    pivot = the_list[r] # gets last element

    i = p-1
    j = p

    while j<r:
        if not compare_func(the_list[j], pivot): #if it is greater than the pivot, just increment j
            j = j+1

        elif compare_func(the_list[j], pivot): #if it is less than the pivot, increment i, switch i+1 and j, increment j
            i = i+1

            # swap the_list[i] and the_list[j]
            temp = the_list[i]
            the_list[i] = the_list[j]
            the_list[j] = temp

            j = j+1


    index = i+1 #new index of the after the list is organized

    #switches the pivot (the last element) with the spot in which to the left of it it is less than the pivot and to the right it is greater
    temp = the_list[index]
    the_list[index] = pivot
    the_list[r] = temp

    return index #returns new index of the pivot

#sorts the list using the partition function, a list, a starting and ending point to sort and a compare function
#does this recursively until it has been sorted
def quicksort(the_list, p, r, compare_func):

    #keeps going recursively until the lists are sorted
    if r > p: #it has more than one element
        q = partition(the_list, p, r, compare_func) #finds the pivot
        quicksort(the_list, p, q-1, compare_func) #calls quicksort on the left half of the list before the pivot
        quicksort(the_list, q+1, r, compare_func) #calls quicksort on the right half of the list after the pivot

# calls the quicksort function with a list and a compare function
def sort(the_list, compare_func):
    quicksort(the_list, 0, len(the_list) - 1, compare_func)
