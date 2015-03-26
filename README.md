Misc.Random
===========

Provides
    -   Misc.Random.string() alias to Random.string(8)
    -   Misc.Random.string( length ): returns random string with <length> characters
    -   Misc.Random.number() alias to Random.number(8)
    -   Misc.Random.number( length ): returns random number with <length> digits.

This is intended to provide shorthands to generate random temporary file names,
unimportant validation codes and stuff like that.

Notes
=====

Strings will only contain a-z, A-Z and 0-9 characters.

Numbers may be shorter than length. (Due to possible start with 0)

The whole thing relies on Erlang's random:uniform/1 - I don't know if this is a
secure PRNG or not, so better do not use this module for security stuff.

Todo
====

Add documentation, generate String of numbers.

LICENSE
=======
MIT
