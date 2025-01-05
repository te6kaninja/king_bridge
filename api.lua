-- Based on the https://github.com/overextended/ox_lib/blob/master/init.lua

local resource <const>, context <const> = 'king_bridge', lib.context
local function loadModule(self, name)
    local directory <const> = ('modules/%s'):format(name)
    local basePath <const> = ('%s/%s.lua'):format(directory, context)

    local chunk, shared <const> = LoadResourceFile(resource, basePath), LoadResourceFile(resource, ('%s/shared.lua'):format(directory))
    if shared then
        chunk = chunk and string.format('%s\n%s', shared, chunk) or shared
    end

    if chunk then
        local modFunction <const>, err <const> = load(chunk, ('@@%s/%s'):format(resource, basePath))
        if not modFunction then
            return error(('\n^1Error importing module (%s): %s^0'):format(directory, err or 'unknown error'), 3)
        end

        local result <const> = modFunction()
        self[name] = result or noop

        return self[name]
    end
end

local export <const> = exports.king_bridge
local function fetch(self, name, ...)
    local module = rawget(self, name)

    if not module then
        self[name] = noop
        module = loadModule(self, name)

        if not module then
            local function method(...)
                return export[name](nil, ...)
            end

            if not ... then
                self[name] = method
            end

            return method
        end
    end

    return module
end

local bridge = setmetatable({}, {
    __index = fetch,
    __newindex = function(self, key, fn)
        rawset(self, key, fn)

        if debug.getinfo(2, 'S').short_src:find('@king_bridge/core') then
            exports(key, fn)
        end
    end
})

_ENV.bridge = bridge