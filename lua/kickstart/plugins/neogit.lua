return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
    'nvim-telescope/telescope.nvim', -- optional
  },
  config = function()
    require('neogit').setup { integrations = { diffview = true, telescope = true } }
    require('diffview').setup {}
  end,
  keys = {
    {
      '<leader>g',
      function()
        require('neogit'):open()
      end,
      desc = 'Open neo[G]it',
    },
  },
}
