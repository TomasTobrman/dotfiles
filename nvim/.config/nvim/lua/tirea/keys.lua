vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Move focus left" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Move focus down" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Move focus up" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Move focus right" })

vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Escape terminal mode" })

vim.keymap.set("n", "<leader>tl", "<cmd>set background=light<cr><cmd>set cursorcolumn<cr>", { desc = "Set theme to light" })
vim.keymap.set("n", "<leader>tb", "<cmd>set background=dark<cr><cmd>set nocursorcolumn<cr>", { desc = "Set theme to dark" })

