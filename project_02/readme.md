Write a MIPS assembly program that has the following functionality:

Allows users to input an array and then provide the following options:

```
Sort the array.
Compute the sum of the elements of the array.
Find the greatest element in the array.
```

Upon starting the program, it should print the following on the screen:

```
Welcome to Array Manipulator v1.0!
To start array input please enter array size:
```

At which point the user is prompted to enter an integer. After this, the user is prompted to enter each element:

```
Enter element 0: 7
Enter element 1: 6
...
Enter element n: 8
```

After this the following menu appears:

```
What do you want to do with the array?
1. Sort.
2. Compute sum of elements.
3. Find greatest element.
4. Quit.
Action:
```

At which point the user is prompted to enter an integer between 1-4. Upon selecting an action, the result is displayed and the menu displayed again, unless the user selected to quit:

```
Action: 2
Result: 8

What do you want to do with the array?
1. Sort.
2. Compute sum of elements.
3. Find greatest element.
4. Quit.
Action:
```

If the user selects to quit, the program exits gracefully with a 'Bye!' message:

```
Action: 4
Bye!
```

For the sorting function use either Quicksort or Merge Sort.
