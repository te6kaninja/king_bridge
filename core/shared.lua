local debug_getinfo <const> = debug.getinfo

_ENV.bridge = setmetatable({}, {
    __newindex = function(self, name, fn)
        rawset(self, name, fn)

        if debug_getinfo(2, 'S').short_src:find('@king_bridge/core') then
            exports(name, fn)
        end
    end,

    __index = function(self, name)
        local directory <const> = ('modules/%s'):format(name)
        local basePath <const> = ('%s/%s.lua'):format(directory, lib.context)

        local chunk, shared <const> = LoadResourceFile('king_bridge', basePath), LoadResourceFile('king_bridge', ('%s/shared.lua'):format(directory))
        if shared then
            chunk = chunk and string.format('%s\n%s', shared, chunk) or shared
        end

        if chunk then
            local modFunction <const>, err <const> = load(chunk, ('@@king_bridge/%s'):format(basePath))
            if not modFunction then
                return error(('\n^1Error importing module (%s): %s^0'):format(directory, err or 'unknown error'), 3)
            end

            local result <const> = modFunction()
            self[name] = result or noop

            return self[name]
        end
    end
})