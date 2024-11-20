Translate the following pseudocode into the corresponding MIPS assembly code:

```
program is
    main:
        x := 0
        x := sumToN(5)
        print x

        fun sumToN(n) is
            if (n = 1) then
                return 1
            else
                return n + sumToN(n-1)
            end if
        end fun
end program
```
