vim.api.nvim_create_user_command('ToggleSetNumber', ToggleSetNumber, {})
vim.api.nvim_set_keymap('n', '<leader>tn', '<cmd>ToggleSetNumber<CR>', { noremap = true, silent = true })
