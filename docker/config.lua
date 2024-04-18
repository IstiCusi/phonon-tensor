-- -------------------- Additional plugins and packages ---------------------

lvim.plugins = {
  {"vimwiki/vimwiki"},
  {'godlygeek/tabular'},
  {'easymotion/vim-easymotion'},
  {'christoomey/vim-tmux-navigator'},
  { "blazkowolf/gruber-darker.nvim" },
  { "mg979/vim-visual-multi" },
  { "frenzyexists/aquarium-vim" },
  {"sekke276/dark_flat.nvim"},
  { "savq/melange-nvim" },
}

-- ----------------------- standard keyboard settings -----------------------

vim.keymap.set("i", "jj", "<ESC>", { silent = true })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('t', 'jj', [[<C-\><C-n>]])

-- ------------- path update to fix the #include <> gf features -------------

vim.opt.path:append("/usr/include/c++/12/**")
vim.opt.path:append("/usr/local/include/**")
vim.opt.path:append("/usr/include/**")
vim.opt.path:append("./**")

-- ----------------------------- Search Man pages  -----------------------------

vim.api.nvim_set_keymap('n', '<F2>', ':lua SearchManPageForCurrentWord()<CR>', { noremap = true })
function SearchManPageForCurrentWord()
  local word = vim.fn.expand("<cword>")
  vim.cmd('Man ' .. word)
end

-- ---------------------------- settings fuer vimwiki --------------------------

vim.g.vimwiki_list = {{path = '/home/phonon/workingdir/.wiki'}}

-- ------------------------- Setup Debugger for C++/C --------------------------

local dap = require("dap")
local executable = "OpenDebugAD7"

dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = vim.fn.stdpath "data" .. "/mason/packages/cpptools/extension/debugAdapters/bin/" .. executable,
  options = {
    detached = false,
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp


-- ---- Custom version of go to file, that allows to create it when missing ----

function CustomGoToFile()
    local filename = vim.fn.expand('<cfile>')  -- Get the filename under the cursor
    print(filename)

    local pathString = table.concat(vim.opt.path:get(), ",")

    if not string.find(pathString, "**") then
        vim.opt.path:append("**")
    end

    if vim.fn.filereadable(filename) ~= 1 then
        local pathOption = vim.opt.path:get()
        local path = vim.fn.findfile(filename, table.concat(pathOption, ","))
        if path ~= "" then
            filename = path
        end
    end

    if vim.fn.filereadable(filename) == 1 then
        vim.cmd('edit ' .. filename)
    else
        local choice = vim.fn.input("The file does not exist. Would you like to create it? (y/n): ")
        if choice == 'y' then
            vim.cmd('edit ' .. filename)
        end
    end
end

vim.api.nvim_set_keymap('n', 'gf', [[:lua CustomGoToFile()<CR>]], { noremap = true, silent = true })

