local dap = require("dap")


M = {}

local savedArgs = {}

function M.setup()
    vim.cmd([[command! DebugWithArgs lua require('debug-args').run_command_with_args()]])
    savedArgs = {}
end

local getTableFromString = function(s)
    local word_table = {}

    for word in s:gmatch("%S+") do
        table.insert(word_table, word)
    end

    return word_table

end



local printSavedArgs = function ()
    print("The saved args are: ")
    local res = ""
    for _,value in pairs(savedArgs) do
        res = res .. tostring(value) .. " "
    end
    res = res .. "\n"
    print(res)
end

-- Define a function to prompt for input arguments and run a command
function M.run_command_with_args()
    printSavedArgs()
    local l = vim.fn.input("Press Enter...")
    local args_str = vim.fn.input("Enter arguments: ")
    local args = getTableFromString(args_str)
    dap.configurations.cpp[1].args = args
    dap.continue()
end








return M
