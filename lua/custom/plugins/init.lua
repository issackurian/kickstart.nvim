-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'vimwiki/vimwiki' },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', ':Git<CR>')
      vim.keymap.set('n', '<leader>gs', function()
        -- always open the git window at the top
        if vim.opt.splitbelow then
          vim.opt.splitbelow = false
          vim.cmd 'Git'
          vim.opt.splitbelow = true
        else
          vim.cmd 'Git'
        end
      end)
      vim.keymap.set('n', '<leader>gc', ':Git commit<CR>')
      vim.keymap.set('n', '<leader>gp', ':Git push<CR>')
      vim.keymap.set('n', '<leader>gl', ':Git pull<CR>')
      vim.keymap.set('n', '<leader>gf', ':Git fetch<CR>')
    end,
  },
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_assume_mapped = true
      vim.keymap.set('n', '<leader>cp', ':Copilot<CR>')
      vim.keymap.set('i', '<C-e>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
  { 'Yggdroot/indentLine' },
  {
    'romgrk/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        show_all_context = false,
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
          },
          -- Example for a specific filetype.
          -- If a pattern is missing, *open a PR* so everyone can benefit.
          rust = {
            'loop_expression',
            'impl_item',
          },

          typescript = {
            'class_declaration',
            'abstract_class_declaration',
            'else_clause',
          },
        },
        exact_patterns = {
          -- Example for a specific filetype with Lua patterns
          -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
          -- exactly match "impl_item" only)
          -- rust = true,
        },
        -- [!] The options below are exposed but shouldn't require your attention,
        --     you can safely ignore them.

        -- TODO - is the below required?
        -- zindex = 20, -- The Z-index of the context window
        -- mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
      }
    end,
  },
}
