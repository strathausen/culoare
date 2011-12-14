###
culoare - colours for the node console

extending the String class

to install, type

  npm install culoare

then require it and from then on do "my coloured string".yellow.bold

@author Johann Philipp Strathausen <strathausen@gmail.com>

ideas and code stolen from colors.js
  https://github.com/Marak/colors.js
  (npm install colors)
###

# string colour escape sequencer
e = (x) ->
  '\x1b[' + x + 'm'

# wrapper that returns an array with two escape sequences for wrapping
w = (a, o) ->
  [ (e a), (e o) ]

# magic String class enhancer
addProperty = (color, func) ->
  String::__defineGetter__ color, func

styles =
  bold:         w 1, 22
  italic:       w 3, 23
  underline:    w 4, 24
  inverse:      w 7, 24
  grey:         w 90, 39

colors =
  [ 'black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white' ]

# more generic color styles
for i, c in colors
  styles[i] = w 30 + i, 39
  # do light colours, but don't do "lightblack"
  unless i == 1
    styles["light#{i}"] = w 36 + i, 39

# wrap up a string with a nice coloured coat
stylize = (str, style) ->
  styles[style].join str

# iterate through the styles and apply them initially
for style of styles
  addProperty style, ->
    stylize this, style

applyTheme = (theme) ->
  # iterate through theme properties
  for k, v of theme
    addProperty k, ->
      stylize this, v

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

  is_char = (character) ->
    bool = false
    all.filter (i) ->
      bool = (i === character)

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
      
      result = result + text[l]
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
        for i = 0 ; i <= counts[index]; i++
          if options[index]
            result = result + soul[index][randomNumber soul[index].length]
    result
  
  heComes text


# don't summon zalgo
addProperty 'zalgo', ->
  zalgo this
