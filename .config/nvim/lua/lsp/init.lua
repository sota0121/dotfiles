local lspconfig = require("lspconfig")

-- 各サーバーの設定を読み込む
require("lsp.servers")

-- 共通設定
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
})

