-- local mocha = require("catppuccin.palettes").get_palette "mocha"


require("bufferline").setup {
    options = {
        numbers = "ordinal",
        indicator = {
            -- style = "underline"
        },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end
    },
    -- highlights = require("catppuccin.groups.integrations.bufferline").get {
    --     styles = { "italic", "bold" },
    --     custom = {
    --         all = {
    --             fill = { bg = "#000000" },
    --         },
    --         mocha = {
    --             background = { fg = mocha.text },
    --         },
    --         latte = {
    --             background = { fg = "#000000" },
    --         },
    --     },
    -- },

}
