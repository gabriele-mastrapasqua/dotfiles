vim.opt.mouse = 'v'
vim.opt.number = true

vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true

vim.opt.backspace = 'indent,eol,start'
vim.opt.hidden = true
vim.opt.laststatus = 2
vim.opt.display = 'lastline'

vim.opt.showmode = true
vim.opt.showcmd = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.ttyfast = true
vim.opt.lazyredraw = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrapscan = true
vim.opt.report = 0
vim.opt.synmaxcol = 200

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.wrap = true
  end,
})
