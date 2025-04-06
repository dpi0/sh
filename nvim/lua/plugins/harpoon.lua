return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },

  keys = {
    {
      "<A-S-e>",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Add current buffer to harpoon list",
    },
    {
      "<A-1>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon file 1",
    },
    {
      "<A-2>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon file 2",
    },
    {
      "<A-3>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon file 3",
    },
    {
      "<A-4>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon file 4",
    },
    {
      "<A-0>",
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "Harpoon file 5",
    },
    {
      "<A-9>",
      function()
        require("harpoon"):list():select(6)
      end,
      desc = "Harpoon file 6",
    },
    {
      "<A-8>",
      function()
        require("harpoon"):list():select(7)
      end,
      desc = "Harpoon file 7",
    },
  },

  config = function()
    local harpoon = require("harpoon")
    local fzf = require("fzf-lua")

    harpoon:setup({})

    local function open_harpoon_fzf()
      local list = harpoon:list()
      local items = {}
      for i, item in ipairs(list.items) do
        table.insert(items, string.format("%d: %s", i, item.value))
      end

      fzf.fzf_exec(items, {
        prompt = "Harpoon> ",
        actions = {
          ["default"] = function(selected)
            local index = tonumber(selected[1]:match("^(%d+):"))
            if index then
              list:select(index)
            end
          end,
          ["ctrl-d"] = function(selected)
            local index = tonumber(selected[1]:match("^(%d+):"))
            if index then
              table.remove(list.items, index)
              open_harpoon_fzf()
            end
          end,
        },
        winopts = {
          height = 0.3,
          width = 0.3,
          row = 0.5,
          col = 0.5,
          anchor = "CENTER",
          border = "rounded",
          preview = { hidden = true },
        },
      })
    end

    vim.keymap.set("n", "<A-e>", open_harpoon_fzf, { desc = "Open Harpoon (FZF)" })
  end,
}
