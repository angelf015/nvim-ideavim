-- Declare the path where lazy will clone plugin code
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check to see if lazy itself has been cloned, if not clone it into the lazy.nvim directory
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

-- Add the path to the lazy plugin repositories to the vim runtime path
vim.opt.rtp:prepend(lazypath)

-- Declare a few options for lazy
local opts = {
    change_detection = {
        -- Don't notify us every time a change is made to the configuration
        notify = false,
    },
    checker = {
        -- Automatically check for package updates
        enabled = true,
        -- Don't spam us with notification every time there is an update available
        notify = false,
    },
}

-- Load the options from the config/options.lua file
require("config.options")
-- Load the keymaps from the config/keymaps.lua file
require("config.keymaps")
-- Load the auto commands from the config/autocmds.lua file
require("config.autocmds")
-- Setup lazy, this should always be last
-- Tell lazy that all plugin specs are found in the plugins directory
-- Pass it the options we specified above
require("lazy").setup("plugins", opts)
-- Sonarlint
-- local lspconfig = require('lspconfig')
-- local mason = "~/.local/share/nvim/mason"
--
-- -- Autocomando para inicializar SonarLint al abrir archivos Java
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "java",
--     callback = function()
--         lspconfig.sonarlint.setup({
--             server = {
--                 cmd = {
--                     "sonarlint-language-server",
--                     -- Ensure that sonarlint-language-server uses stdio channel
--                     "-stdio",
--                     "-analyzers",
--                     -- paths to the analyzers you need, using those for python and java in this example
--                     vim.fn.expand(mason .. "/share/sonarlint-analyzers/sonarpython.jar"),
--                     vim.fn.expand(mason .. "/share/sonarlint-analyzers/sonarcfamily.jar"),
--                     vim.fn.expand(mason .. "/share/sonarlint-analyzers/sonarjava.jar"),
--                 },
--             },
--             filetypes = {
--                 -- Tested and working
--                 "python",
--                 "cpp",
--                 "java",
--             },
--         })
--     end,
-- })
