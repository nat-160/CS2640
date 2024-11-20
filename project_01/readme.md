Consider the following pseudo code:

```
program:
   main:
       n := facto_rec(5)
       print n

       fun facto_rec(n) is
           if (n <= 1) then
               return 1
           else
               return n * facto_rec(n-1)
           end if
       end fun
end program
```

Translate the program into MIPS assembly code.
