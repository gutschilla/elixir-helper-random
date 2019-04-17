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

Strings will only contain a-z, A-Z and 0-9 characters and will always start with
a character.

Numbers may be shorter than length. (Due to possible start with 0)

The whole thing relies on Erlang's random:uniform/1 - I don't know if this is a
secure PRNG or not, so better do not use this module for security stuff.

Motivation
============

1. Detects OTP version and uses `:random.seed` or `:rand.seed` with either
   `:erlang.now` or `:erlang.monotonic_time` as both the rand module and using
   erland.now got deprecated in OTP 17 and 18.
   
2. I use it all the time.

License
=======
MIT
