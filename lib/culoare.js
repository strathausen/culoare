
/*
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
*/

var addProperty, addSequencer, applyTheme, c, colors, e, i, mode, modes, rainbow, rainbowMap, reset, sequencer, set, style, styles, stylize, themes, w, zalgo, _i, _len, _len2, _ref, _ref2;

module.exports.escape = e = function(x) {
  return '\x1b[' + x + 'm';
};

module.exports.wrap = w = function(a, o) {
  return [e(a), e(o)];
};

module.exports.addProperty = addProperty = function(color, func) {
  return String.prototype.__defineGetter__(color, func);
};

module.exports.styles = styles = {
  bold: w(1, 22),
  italic: w(3, 23),
  underline: w(4, 24),
  blink: w(5, 25),
  inverse: w(7, 27),
  grey: w(90, 39),
  bggrey: w(100, 49)
};

colors = ['black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white'];

modes = [['', [30, 39]], ['bg', [40, 49]], ['light', [90, 39]], ['bglight', [100, 49]]];

for (i = 0, _len = colors.length; i < _len; i++) {
  c = colors[i];
  for (_i = 0, _len2 = modes.length; _i < _len2; _i++) {
    _ref = modes[_i], mode = _ref[0], (_ref2 = _ref[1], set = _ref2[0], reset = _ref2[1]);
    if (!(mode === 'light' && (set === 0 || set === 7))) {
      styles["" + (mode + c)] = w("" + (set + i), reset);
    }
  }
}

stylize = function(str, style) {
  var a, code, o, _ref3;
  _ref3 = styles[style], a = _ref3[0], o = _ref3[1];
  code = o.replace(/\u001b\[(\d+)m/g, '$1');
  return [a, o].join(str.replace(new RegExp('\\u001b\\[' + code + 'm', 'g'), a));
};

for (style in styles) {
  addProperty(style, (function(style) {
    return function() {
      return stylize(this, style);
    };
  })(style));
}

module.exports.applyTheme = applyTheme = function(theme) {
  var k, v, _results;
  _results = [];
  for (k in theme) {
    v = theme[k];
    _results.push(addProperty(k, (function(v) {
      return function() {
        return stylize(this, v);
      };
    })(v)));
  }
  return _results;
};

sequencer = function(map) {
  return function() {
    return this.split('').map(map).join('');
  };
};

module.exports.addSequencer = addSequencer = function(name, map) {
  return addProperty(name, sequencer(map));
};

rainbow = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta'];

rainbowMap = (function() {
  return function(letter, i, exploded) {
    if (letter === ' ') {
      return letter;
    } else {
      return stylize(letter, rainbow[i++ % rainbow.length]);
    }
  };
})();

addSequencer('rainbow', rainbowMap);

addSequencer('zebra', function(letter, i, exploded) {
  if (i % 2 === 0) {
    return letter;
  } else {
    return letter.inverse;
  }
});

module.exports.themes = themes = {};

module.exports.setTheme = function(theme) {
  if (typeof theme === 'string') {
    try {
      themes[theme] = require(theme);
      applyTheme(themes[theme]);
      return themes[theme];
    } catch (err) {
      console.log(err);
      return err;
    }
  } else {
    return applyTheme(theme);
  }
};

addProperty('stripColors', function() {
  return ("" + this).replace(/\u001b\[\d+m/g, '');
});

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
    var counts, i, index, l, result, _j, _k, _len3, _len4, _ref3, _ref4;
    if (options == null) options = {};
    result = '';
    options["up"] = options["up"] || true;
    options["mid"] = options["mid"] || true;
    options["down"] = options["down"] || true;
    options["size"] = options["size"] || "maxi";
    text = text.split('');
    for (_j = 0, _len3 = text.length; _j < _len3; _j++) {
      l = text[_j];
      if (is_char(l)) continue;
      result = result + l;
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
      _ref3 = ["up", "mid", "down"];
      for (_k = 0, _len4 = _ref3.length; _k < _len4; _k++) {
        index = _ref3[_k];
        for (i = 0, _ref4 = counts[index]; 0 <= _ref4 ? i <= _ref4 : i >= _ref4; 0 <= _ref4 ? i++ : i--) {
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
