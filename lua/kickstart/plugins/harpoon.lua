return {
  'theprimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('harpoon'):setup { settings = { ui_nav_wrap = true } }
  end,
  keys = {
    {
      '<leader>a',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'harpoon [A]dd',
    },
    {
      '<leader>m',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'harpoon [M]enu',
    },
    {
      '<leader>n',
      function()
        require('harpoon'):list():next { ui_nav_wrap = true }
      end,
      desc = 'harpoon to [N]ext mark',
    },
    {
      '<leader>p',
      function()
        require('harpoon'):list():prev { ui_nav_wrap = true }
      end,
      desc = 'harpoon to [P]rev mark',
    },
    {
      '<leader>4',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'harpoon to mark 1',
    },
    {
      '<leader>5',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'harpoon to mark 2',
    },
    {
      '<leader>6',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'harpoon to mark 3',
    },
    {
      '<leader>=',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'harpoon to mark 4',
    },
  },
}
