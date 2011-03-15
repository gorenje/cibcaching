Instance Variable Shadowing
---------------------------

The point here is not to demostrate bad code but the fact that there are no warnings
to advise of the fact that the behaviour differs in "development" mode and "compiled"
mode.

See the code for the shadowing, but basically an instance variable is shadowed and
and used as a local variable, but when set, it behaviours as a instance variable
in development mode and as a local variable once compiled.

Reproducing
-----------

To see the resul in "development" mode:

# open index.html

To see the result in "compiled" mode:

# jake flatten
# open Build/{Press,Release,Flatten}/CibCaching/index.html

All have the correct behaviour.

Versions
--------

# capp --version
cappuccino 0.9.0 (2011-02-23 8c1a3a)

# Safari --version
Version 5.0.3 (5533.19.4)
