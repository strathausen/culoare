culoare
=======

colours for node served with hot coffee

[Imgur](http://i.imgur.com/EW6Jv.gif)

current state
-------------

normal, light and bg colours working. zalgo. rainbow. this library should be
good as it is and never be outdated, because it is supposed to do only one
task - even if i won't work on it anymore, it is save to be used.

usage
-----

just use strings like this:

```coffee
require 'culoare'

console.log 'coloured string'.lightred.bold.underline
```

see the example.coffee for examples.

about and credits
-----------------

basically i cloned colors.js from Marak/cloudhead and just stripped some code
like the browser mode - who would want to use that? - and the string prototype
blacklist, since i am not the programmer's nanny :-) also the functionality
that would let you do colors.red("my colorstring") did not match my taste.

i then ported all the cool stuff to the coolest language ever and added some 
more colours. i don't know what or who zalgo is and what it is good for, so the
only logical consequence was to just leave it in place.

there's an additional feature called .light that will convert the colours to
their lighter counterpart.

usage is pretty similar to colors.js except that you can't use colors directly
via something like colors.red("...")

if there's something you miss i might add it.

so thanks to Marak for the cool stuff and to Jeremy for the cool language.

enjoy.
