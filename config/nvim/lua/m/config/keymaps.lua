vim.api.nvim_set_keymap('n', '<leader>vtn', '<cmd>ToggleSetNumber<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>vtd', Toggle_diagnostics, { noremap = true, silent = true, desc = "Toggle vim diagnostics" })
