return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
        indent = { char = "┊" },
        whitespace = {
            remove_blankline_trail = false,
        },
        scope = {
            char = "│",
            enabled = true,
            show_start = false,
        },
    },
}
