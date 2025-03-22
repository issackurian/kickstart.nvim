-- set commentstring for terraform files, will be used by commentary.vim
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'terraform', 'tf' },
  callback = function()
    vim.bo['commentstring'] = '# %s'
  end,
})
