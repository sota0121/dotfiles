require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,  -- Ctrl+uを無効化
                ["<C-d>"] = false,  -- Ctrl+dを無効化
            },
        },
    },
})

