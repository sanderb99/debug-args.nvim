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


local isTableEmpty = function (tbl)
    for _,_ in pairs(tbl) do
        return false
    end
    return true
end

local printSavedArgs = function ()
    if isTableEmpty(savedArgs) then
        vim.print("There are no saved arguments")
    else
        local result = "The saved arguments are: "
        for _,value in pairs(savedArgs) do
            result = result .. tostring(value) .. " "
        end
        vim.print(result)
    end
end



-- Define a function to prompt for input arguments and run a command
function M.run_command_with_args()
    printSavedArgs()
    local l = vim.fn.input("\nDo you want to change them? ")
    if l == "y" then
        local args_str = vim.fn.input("Enter arguments: ")
        local args = getTableFromString(args_str)
        savedArgs = args
        dap.configurations.cpp[1].args = args
    end
    dap.continue()
end








return M
