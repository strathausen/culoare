###
culoare - colours for the node console

extending the String class

to install, type

  npm install culoare

then require it and from then on do "my coloured string".yellow.bold

@author Johann Philipp Strathausen <strathausen@gmail.com>

@license MIT

ideas and code stolen from colors.js
  https://github.com/Marak/colors.js
  (npm install colors)
###

# string colour escape sequencer
module.exports.escape = e = (x) ->
  '\x1b[' + x + 'm'

# wrapper that returns an array with two escape sequences for wrapping
module.exports.wrap = w = (a, o) ->
  [ (e a), (e o) ]

# magic String class enhancer
module.exports.addProperty = addProperty = (color, func) ->
  String::__defineGetter__ color, func

# now to the colour styling
module.exports.styles = styles =
  bold:         w 1, 22
  italic:       w 3, 23
  underline:    w 4, 24
  blink:        w 5, 25
  inverse:      w 7, 27
  grey:         w 90, 39
  bggrey:       w 100, 49

# common list of common names
colors =
  [ 'black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white' ]

# light and normal colours along with their start- and reset-values
modes = [
  [ '', [ 30, 39 ] ]
  [ 'bg', [ 40, 49 ] ]
  [ 'light', [ 90, 39 ] ]
  [ 'bglight', [ 100, 49 ] ]
]

# more generic colour styles
for c, i in colors
  for [ mode, [ set, reset ] ] in modes
    # do light colours, but don't do "lightblack" or "lightwhite"
    unless mode == 'light' and set in [0, 7]
      styles["#{mode + c}"] = w "#{set + i}", reset

# wrap up a string with a nice coloured coat
stylize = (str, style) ->
  # awesome! yeah, baby!!
  [a, o] = styles[style]
  # get the reset colour code (if there is one)
  code = o.replace /\u001b\[(\d+)m/g, '$1'
  # make it a regexp and replace all occurences with the start colour code
  [a, o].join str.replace (new RegExp '\\u001b\\[' + code + 'm', 'g'), a

# iterate through the styles and apply them initially
for style of styles
  addProperty style, ((style) ->
    -> stylize this, style) style

module.exports.applyTheme = applyTheme = (theme) ->
  # iterate through theme properties
  for k, v of theme
    addProperty k, ((v) ->
      -> stylize this, v) v

sequencer = (map) ->
  -> @split('').map(map).join ''

module.exports.addSequencer = addSequencer = (name, map) ->
  addProperty name, sequencer map

# the rainbow
rainbow = [ 'red', 'yellow', 'green', 'cyan', 'blue', 'magenta' ]
rainbowMap = do ->
  (letter, i, exploded) ->
    if letter == ' '
      letter
    else
      stylize letter, rainbow[i++ % rainbow.length]

addSequencer 'rainbow', rainbowMap

# the zebra
addSequencer 'zebra', (letter, i, exploded) ->
  if i % 2 == 0 then letter else letter.inverse

module.exports.themes = themes = {}

module.exports.setTheme = (theme) ->
  if typeof theme == 'string'
    try
      themes[theme] = require theme
      applyTheme themes[theme]
      themes[theme]
    catch err
      console.log err
      err
  else
    applyTheme theme

addProperty 'stripColors', ->
  "#{this}".replace /\u001b\[\d+m/g, ''

# please no
zalgo = (text, options) ->
  soul =
    up: [
      '̍', '̎', '̄', '̅'
      '̿', '̑', '̆', '̐'
      '͒', '͗', '͑', '̇'
      '̈', '̊', '͂', '̓'
      '̈', '͊', '͋', '͌'
      '̃', '̂', '̌', '͐'
      '̀', '́', '̋', '̏'
      '̒', '̓', '̔', '̽'
      '̉', 'ͣ', 'ͤ', 'ͥ'
      'ͦ', 'ͧ', 'ͨ', 'ͩ'
      'ͪ', 'ͫ', 'ͬ', 'ͭ'
      'ͮ', 'ͯ', '̾', '͛'
      '͆', '̚'
    ]
    down: [
      '̖', '̗', '̘', '̙'
      '̜', '̝', '̞', '̟'
      '̠', '̤', '̥', '̦'
      '̩', '̪', '̫', '̬'
      '̭', '̮', '̯', '̰'
      '̱', '̲', '̳', '̹'
      '̺', '̻', '̼', 'ͅ'
      '͇', '͈', '͉', '͍'
      '͎', '͓', '͔', '͕'
      '͖', '͙', '͚', '̣'
    ]
    mid: [
      '̕', '̛', '̀', '́'
      '͘', '̡', '̢', '̧'
      '̨', '̴', '̵', '̶'
      '͜', '͝', '͞'
      '͟', '͠', '͢', '̸'
      '̷', '͡', ' ҉'
    ]
  
  all = [].concat soul.up, soul.down, soul.mid
  zalgo = {}

  randomNumber = (range) ->
    Math.floor Math.random() * range

  # tests if... yeah, what does it test actually?
  is_char = (character) ->
    bool = false
    all.filter (i) ->
      bool = (i == character)
    bool

  heComes = (text, options={}) ->
    result = ''
    options["up"] = options["up"] or true
    options["mid"] = options["mid"] or true
    options["down"] = options["down"] or true
    options["size"] = options["size"] or "maxi"
    text = text.split ''
    for l in text
      if is_char l
        continue
      
      result = result + l
      counts = up: 0, down: 0, mid: 0
      switch options.size
        when 'mini'
          counts.up = randomNumber 8
          counts.min = randomNumber 2
          counts.down = randomNumber 8
        when 'maxi'
          counts.up = (randomNumber 16) + 3
          counts.min = (randomNumber 4) + 1
          counts.down = (randomNumber 64) + 3
        else
          counts.up = (randomNumber 8) + 1
          counts.mid = (randomNumber 6) / 2
          counts.down = (randomNumber 8) + 1

      for index in ["up", "mid", "down"]
        for i in [0..counts[index]]
          if options[index]
            result = result + soul[index][randomNumber soul[index].length]
    result
  
  heComes text

# don't summon zalgo
addProperty 'zalgo', ->
  zalgo this
