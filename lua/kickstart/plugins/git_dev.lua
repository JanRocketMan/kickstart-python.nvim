return {
  'moyiz/git-dev.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    {
      '<leader>cg',
      function()
        local repo = vim.fn.input 'Repository name / URI: '
        if repo ~= '' then
          require('git-dev').open(repo)
        end
      end,
      desc = '[O]pen a remote git repository',
    },
  },
}
