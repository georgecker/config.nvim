require('blink.cmp').setup {
  keymap = { preset = 'enter' },
}

local telescope_themes = require 'telescope.themes'
require('telescope').setup {
  defaults = telescope_themes.get_ivy(),
  extensions = {
    ['ui-select'] = {
      telescope_themes.get_ivy(),
    },
  },
}

return {}
