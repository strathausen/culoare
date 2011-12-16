culoare
=======

colours for node served with hot coffee

<img src="http://i.imgur.com/EW6Jv.gif" />

what it does
------------

gives your console output light and bg colours, zebra, zalgo. and rainbow. 

current state
-------------

this library should be good as it is and not outdate due, to its limited
purpose. even if i won't work on it anymore, it should save to be used and
rare updates should be considered as a sign of quality.

usage
-----

easy. just use strings like this:

### basic

```coffee
require 'culoare'

console.log 'coloured string'.lightred.bold.underline
```

### nesting

culoare also supports great nesting of colours. this code

```coffee
console.log "green text #{'with'.yellow} text in #{'many'.red} different
 #{'colours'.rainbow} nested that #{'goes on'.zebra} in green".green
```

would result in something like

<img src="http://i.imgur.com/WrDB7.png" />

### themes

you can define themes and pass strings or arrays of strings

```coffee
colors = require 'culoare'

colors.setTheme
  silly: 'rainbow'
  input: [ 'grey', 'bold' ]
  warn: [ 'yellow', 'bold', 'underline' ]
```

whereas `console.log 'this is a warning'.warning` would provide you with a 
yellow, underlined and bold warning text.

### and much more

see the example.coffee for more examples.

about and credits
-----------------

basically i cloned colors.js from Marak/cloudhead and just stripped some code
like the browser mode - who would want to use that? - and the string prototype
blacklist, since i am not the programmer's nanny :-) also the functionality
that would let you do colors.red("my colorstring") did not match my taste.

i then ported all the cool stuff to the coolest language ever and added some 
more colours. i don't know what or who zalgo is and what it is good for, so the
only logical consequence was to just leave it in place (and i'm not actually 
sure if i did the porting of zalgo right).

there's an additional feature called .light that will convert the colours to
their lighter counterpart.

usage is pretty similar to colors.js except that you can't use colors directly
via something like colors.red("...")

if there's something you miss i might add it.

so thanks to Marak for the cool stuff and to Jeremy for the cool language and
thanks to all the other guys that worked on colors.js

enjoy.
