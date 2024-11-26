return {
  -- ColorScheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local dracula = require("dracula")
      dracula.setup({
        -- customize dracula color palette
        colors = {
          bg = "#282A36",
          fg = "#F8F8F2",
          selection = "#44475A",
          comment = "#6272A4",
          red = "#FF5555",
          orange = "#FFB86C",
          yellow = "#F1FA8C",
          green = "#50fa7b",
          purple = "#BD93F9",
          cyan = "#8BE9FD",
          pink = "#FF79C6",
          bright_red = "#FF6E6E",
          bright_green = "#69FF94",
          bright_yellow = "#FFFFA5",
          bright_blue = "#D6ACFF",
          bright_magenta = "#FF92DF",
          bright_cyan = "#A4FFFF",
          bright_white = "#FFFFFF",
          menu = "#21222C",
          visual = "#3E4452",
          gutter_fg = "#4B5263",
          nontext = "#3B4048",
          white = "#ABB2BF",
          black = "#191A21",
        },
        -- show the '~' characters after the end of buffers
        show_end_of_buffer = true, -- default false
        -- use transparent background
        transparent_bg = true,    -- default false
        -- set custom lualine background color
        lualine_bg_color = "#44475a", -- default nil
        -- set italic comment
        italic_comment = true,    -- default false
        -- overrides the default highlights with table see `:h synIDattr`
      })
      -- Make sure to set the color scheme when neovim loads and configures the dracula plugin
      vim.cmd.colorscheme("dracula")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- call the setup function with properties to define how our lualine will look
      require("lualine").setup({
        options = {
          -- Use web devicons if you have a nerdfont installed
          icons_enabled = true,
          -- Set the theme to dracula, lualine documentation has other themes available as well
          theme = "palenight",
          -- Separate components of lua line with chevrons
          component_separators = { left = "", right = "" },
          -- Separate sections with solid triangles
          section_separators = { left = "", right = "" },
          -- disable the status line and winbar
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          -- Don't focus lualine on NvimTree
          ignore_focus = { "NvimTree" },
          -- Always divide lualine in the middle
          always_divide_middle = true,
          -- Disable global status
          globalstatus = false,
          -- Refresh every 1000 miliseconds
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        -- Setup what each lualine section will contain
        -- sections start at a on the left and go to z on the right
        sections = {
          -- display the current mode in section a
          lualine_a = { "mode" },
          -- display the current git branch, git differences, and any code diagnostics in section b
          lualine_b = { "branch", "diff", "diagnostics" },
          -- display the filename in section c
          lualine_c = { "filename" },
          -- display the file encoding type, os, and filetype in section x
          lualine_x = { "encoding", "fileformat", "filetype" },
          -- display where you are at in the file in section y
          lualine_y = { "progress" },
          -- display exact location of the cursor in section z
          lualine_z = { "location" },
        },
        -- Setup what each section will contain in inactive buffers
        inactive_sections = {
          -- display nothing in sections a and b
          lualine_a = {},
          lualine_b = {},
          -- display the file name in section c
          lualine_c = { "filename" },
          -- display the exact location of the cursor in section x
          lualine_x = { "location" },
          -- display nothing in sections y and z
          lualine_y = {},
          lualine_z = {},
        },
        -- Use default values for tabline, winbar, inactive winbar and extensions
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { "quickfix", "man", "fugitive" },
      })
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
  },
  {
    "echasnovski/mini.indentscope",
    event = "BufRead",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "Trouble",
          "alpha",
          "dashboard",
          "fzf",
          "help",
          "lazy",
          "mason",
          "neo-tree",
          "notify",
          "snacks_notif",
          "snacks_terminal",
          "snacks_win",
          "toggleterm",
          "trouble",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>sn",  "",                                                                            desc = "+noice" },
      { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                              desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
      { "<leader>snt", function() require("noice").cmd("pick") end,                                   desc = "Noice Picker (Telescope/FzfLua)" },
      { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,                           expr = true,              desc = "Scroll Forward",  mode = { "i", "n", "s" } },
      { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,                           expr = true,              desc = "Scroll Backward", mode = { "i", "n", "s" } },
    },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
      end
      require("noice").setup(opts)
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
        ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
        ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
        ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
        ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
        ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
        ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
 ]],
          -- stylua: ignore
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
