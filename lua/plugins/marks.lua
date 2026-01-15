return {
  "chentoast/marks.nvim",
  event = "VimEnter",
  keys = {
    { "<leader>ml", "<cmd>MarksListAll<cr>", desc = "List all marks" },
  },
  opts = {
    -- whether to map keybinds or not. default true
    -- Default Kyemaps
    -- mx              Set mark x
    -- m,              Set the next available alphabetical (lowercase) mark
    -- m;              Toggle the next available mark at the current line
    -- dmx             Delete mark x
    -- dm-             Delete all marks on the current line
    -- dm<space>       Delete all marks in the current buffer
    -- m]              Move to next mark
    -- m[              Move to previous mark
    -- m:              Preview mark. This will prompt you for a specific mark to
    --                 preview; press <cr> to preview the next mark.
    --
    -- m[0-9]          Add a bookmark from bookmark group[0-9].
    -- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
    -- m}              Move to the next bookmark having the same type as the bookmark under
    --                 the cursor. Works across buffers.
    -- m{              Move to the previous bookmark having the same type as the bookmark under
    --                 the cursor. Works across buffers.
    -- dm=             Delete the bookmark under the cursor.
    default_mappings = true,
    -- which builtin marks to show. default {}
    builtin_marks = {},
    -- builtin_marks = { '.', '<', '>', '^' },
    -- whether movements cycle back to the beginning/end of buffer. default true
    cyclic = true,
    -- whether the shada file is updated after modifying uppercase marks. default false
    force_write_shada = false,
    -- how often (in ms) to redraw signs/recompute mark positions.
    -- higher values will have better performance but may cause visual lag,
    -- while lower values may cause performance penalties. default 150.
    refresh_interval = 250,
    -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    -- marks, and bookmarks.
    -- can be either a table with all/none of the keys, or a single number, in which case
    -- the priority applies to all marks.
    -- default 10.
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
    -- disables mark tracking for specific filetypes. default {}
    excluded_filetypes = {
      "notify",
      "cmp_menu",
      "noice",
      "flash_prompt",
      "neo-tree",
      "aerial",
      "trouble",
      "floaterm",
      function(win)
        return not vim.api.nvim_win_get_config(win).focusable
      end,
    },
    mappings = {
      set_next = "m.",
      prev = "mk",
      prev_bookmark = "mK",
      next = "mj",
      next_bookmark = "mJ",
      preview = "m:",
      toggle = "mm",
      set_bookmark0 = "mg0",
      set_bookmark1 = "mg1",
      set_bookmark2 = "mg2",
      set_bookmark3 = "mg3",
      set_bookmark4 = "mg4",
      set_bookmark5 = "mg5",
      set_bookmark6 = "mg6",
      set_bookmark7 = "mg7",
      set_bookmark8 = "mg8",
      set_bookmark9 = "mg9",
      delete_bookmark0 = "dmg0",
      delete_bookmark1 = "dmg1",
      delete_bookmark2 = "dmg2",
      delete_bookmark3 = "dmg3",
      delete_bookmark4 = "dmg4",
      delete_bookmark5 = "dmg5",
      delete_bookmark6 = "dmg6",
      delete_bookmark7 = "dmg7",
      delete_bookmark8 = "dmg8",
      delete_bookmark9 = "dmg9",
    },
  },
}
