
/*
culoare - colours for the node console

extending the String class

to install, type

  npm install culoare

then require it and from then on do "my coloured string".yellow.bold

@author Johann Philipp Strathausen <strathausen@gmail.com>

ideas and code stolen from colors.js
  https://github.com/Marak/colors.js
  (npm install colors)
*/

var addProperty, applyTheme, c, colors, e, i, style, styles, stylize, w, zalgo, _len;

e = function(x) {
  return '\x1b[' + x + 'm';
};

w = function(a, o) {
  return [e(a), e(o)];
};

addProperty = function(color, func) {
  return String.prototype.__defineGetter__(color, func);
};

styles = {
  bold: w(1, 22),
  italic: w(3, 23),
  underline: w(4, 24),
  inverse: w(7, 24),
  grey: w(90, 39)
};

colors = ['black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white'];

for (c = 0, _len = colors.length; c < _len; c++) {
  i = colors[c];
  styles[i] = w(30 + i, 39);
  if (i !== 1) styles["light" + i] = w(36 + i, 39);
}

stylize = function(str, style) {
  return styles[style].join(str);
};

for (style in styles) {
  addProperty(style, function() {
    return stylize(this, style);
  });
}

applyTheme = function(theme) {
  var k, v, _results;
  _results = [];
  for (k in theme) {
    v = theme[k];
    _results.push(addProperty(k, function() {
      return stylize(this, v);
    }));
  }
  return _results;
};

zalgo = function(text, options) {
  var all, heComes, is_char, randomNumber, soul;
  soul = {
    up: ['̍', '̎', '̄', '̅', '̿', '̑', '̆', '̐', '͒', '͗', '͑', '̇', '̈', '̊', '͂', '̓', '̈', '͊', '͋', '͌', '̃', '̂', '̌', '͐', '̀', '́', '̋', '̏', '̒', '̓', '̔', '̽', '̉', 'ͣ', 'ͤ', 'ͥ', 'ͦ', 'ͧ', 'ͨ', 'ͩ', 'ͪ', 'ͫ', 'ͬ', 'ͭ', 'ͮ', 'ͯ', '̾', '͛', '͆', '̚'],
    down: ['̖', '̗', '̘', '̙', '̜', '̝', '̞', '̟', '̠', '̤', '̥', '̦', '̩', '̪', '̫', '̬', '̭', '̮', '̯', '̰', '̱', '̲', '̳', '̹', '̺', '̻', '̼', 'ͅ', '͇', '͈', '͉', '͍', '͎', '͓', '͔', '͕', '͖', '͙', '͚', '̣'],
    mid: ['̕', '̛', '̀', '́', '͘', '̡', '̢', '̧', '̨', '̴', '̵', '̶', '͜', '͝', '͞', '͟', '͠', '͢', '̸', '̷', '͡', ' ҉']
  };
  all = [].concat(soul.up, soul.down, soul.mid);
  zalgo = {};
  randomNumber = function(range) {
    return Math.floor(Math.random() * range);
  };
  is_char = function(character) {
    var bool;
    bool = false;
    all.filter(function(i) {
      return bool = i === character;
    });
    return bool;
  };
  heComes = function(text, options) {
    var counts, i, index, l, result, _i, _j, _len2, _len3, _ref;
    if (options == null) options = {};
    result = '';
    options["up"] = options["up"] || true;
    options["mid"] = options["mid"] || true;
    options["down"] = options["down"] || true;
    options["size"] = options["size"] || "maxi";
    text = text.split('');
    for (_i = 0, _len2 = text.length; _i < _len2; _i++) {
      l = text[_i];
      if (is_char(l)) continue;
      result = result + text[l];
      counts = {
        up: 0,
        down: 0,
        mid: 0
      };
      switch (options.size) {
        case 'mini':
          counts.up = randomNumber(8);
          counts.min = randomNumber(2);
          counts.down = randomNumber(8);
          break;
        case 'maxi':
          counts.up = (randomNumber(16)) + 3;
          counts.min = (randomNumber(4)) + 1;
          counts.down = (randomNumber(64)) + 3;
          break;
        default:
          counts.up = (randomNumber(8)) + 1;
          counts.mid = (randomNumber(6)) / 2;
          counts.down = (randomNumber(8)) + 1;
      }
      _ref = ["up", "mid", "down"];
      for (_j = 0, _len3 = _ref.length; _j < _len3; _j++) {
        index = _ref[_j];
        for (i = 0; 0 <= i ? i <= i : i >= i; 0 <= i ? i++ : i--) {
          if (options[index]) {
            result = result + soul[index][randomNumber(soul[index].length)];
          }
        }
      }
    }
    return result;
  };
  return heComes(text);
};

addProperty('zalgo', function() {
  return zalgo(this);
});
