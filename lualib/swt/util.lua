local json      = require "cjson"

local M = {}

function M.log_info(...)
    print(string.format(...))
end

function M.log_error(...)
    print(string.format(...))
end

function M.pack(cmd, data)
    return json.encode({cmd = cmd, data = data})
end

function M.unpack(msg)
    local pack = json.decode(msg)
    return pack.cmd, pack.data
end

function M.bind(func, ...)
    local rest = {...}
    return function(...)
        local args = {}
        for i = 1, #rest do
            table.insert(args, rest[i])
        end
        for i = 1, select("#", ...) do
            table.insert(args, select(i, ...))
        end
        return func(table.unpack(args))
    end
end

return M
