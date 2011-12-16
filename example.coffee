colors = require './src/culoare'
console.log ('a green ' + 'with '.yellow + 'text in ' + 'many '.red +
  'different ' + 'colours'.rainbow + ' nested that ' + 'goes on'.zebra +
  ' in green').green
console.log 'green text'.green, 'and lightgreen text'.lightgreen
console.log 'and yellow bold underlined text'.yellow.bold.underline
console.log 'red'.red, 'lightred'.lightred, 'and grey'.grey, 'as bg'.bggrey
console.log 'and background, too'.bgmagenta, 'inverse'.inverse
console.log 'combinations of green and blue are especially nice'.bggreen.blue
console.log 'bglightred'.bglightred, 'bgred blinking'.bgred.blink
console.log 'happy rainbow colours'.rainbow
console.log 'zebra animal farm'.zebra
console.log 'the zalgo is loose'.zalgo

colors.addSequencer "america", (letter, i, exploded) ->
  if letter == " "
    letter
  else
    switch i % 3
      when 0
        letter.red
      when 1
        letter.white
      when 2
        letter.blue

colors.addSequencer "random", do ->
  available = [ 'bold', 'underline', 'blink', 'inverse', 'grey', 'yellow'
  'red', 'lightgreen', 'blue', 'white', 'bgcyan', 'magenta', 'lightmagenta']

  (letter, i, exploded) ->
    if letter == " "
      letter
    else
      letter[available[Math.round Math.random() * (available.length - 1)]]

console.log "AMERICA! FORK YEAH!".america
console.log "So apparently I've been to Mars, with all the little green men.
 But you know, I don't recall.".random

#
# Custom themes
#

# Load theme with JSON literal
colors.setTheme
  silly: 'rainbow',
  input: 'grey',
  verbose: 'cyan',
  prompt: 'grey',
  info: 'green',
  data: 'grey',
  help: 'cyan',
  warn: 'yellow',
  debug: 'blue',
  error: 'red'


# outputs red text
console.log "this is an error".error

# outputs yellow text
console.log "this is a warning".warn

# outputs grey text
console.log "this is an input".input

# Load a theme from file
#colors.setTheme './themes/winston-dark.js'
