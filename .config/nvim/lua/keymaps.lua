-- リーダーキー設定
vim.g.mapleader = " "

-- キーマッピング
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })  -- 保存
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })  -- 終了

-- NvimTreeトグル
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Telescope検索
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", ":Telescope live_grep<CR>", { noremap = true, silent = true })

