AR + Perl + Linux + 64bit = Fail problem.
=========================================

A minimal test case.

To use:

1. Edit Makefile.PL and adjust $API
2. Edit t/arstest.t and adjust server/username/password in ars_Login() line
3. perl Makefile.PL
4. make
5. make test

It should fail with 

    [arstest.xs 40] XS_arstest_ars_Login : ars_Login(SERVER, USER, PASS, [null], [null], 0, 0)
    [arstest.xs 59] XS_arstest_ars_Login : ARVerifyUser failed 2
    messageType = 2
    messageNum  = 90
    messageText = Cannot open catalog; Message number = 90
    appendedText = remedy.acsu.buffalo.edu : RPC: Rpcbind failure - RPC: Can't decode result```


Then

1. cd minimal-c
2. Adjust the server/username/password in arstest.c
3. ./build

It should succeed with 

    [arstest.c 36] main : ars_Login(SERVER, USER, PASS, [null], [null], 9000, 390680)
    [arstest.c 72] main : ARVerifyUser ok 0

The code in arstest.xs and arstest.c are, ostensibly, the same. So basically when you insert the 
code that works perfectly fine as a standalone C app into a Perl XS, it fails. 

Debugging with GDB shows that BMC has RPC routines embedded that take precendece over the libc
versions (xdr_*) and my best guess is that there is some alignment issue when these routines are
combined with Perl memory management? That's as far as I got. 


