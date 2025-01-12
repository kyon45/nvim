return {
  ---@type LazySpec
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
  ---@type LazySpec
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      indent = {
        enabled = true,
        animate = {
          enabled = false,
        },
      },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      -- dashboard
      dashboard = {
        sections = {
          { section = 'header' },
          { section = 'keys', gap = 1, padding = 1 },
          { section = 'startup' },
        },
      },
    },
    -- stylua: ignore
    keys = {
      -- notifier
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      -- words
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },
  },
}
