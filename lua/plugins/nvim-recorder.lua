return -- minimal config for lazy-loading with lazy.nvim
{
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify",
    keys = {
        -- these must match the keys in the mapping config below
        { "q", desc = " Start Recording" },
        { "Q", desc = " Play Recording" },
    },
    config = function()
        require("recorder").setup({
            mapping = {
                startStopRecording = "q",
                playMacro = "Q",
            },
        })

        local lualineZ = require("lualine").get_config().sections.lualine_z or {}
        local lualineY = require("lualine").get_config().sections.lualine_y or {}
        table.insert(lualineZ, { require("recorder").recordingStatus })
        table.insert(lualineY, { require("recorder").displaySlots })

        require("lualine").setup {
            tabline = {
                lualine_y = lualineY,
                lualine_z = lualineZ,
            },
        }
    end,
}
