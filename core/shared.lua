local debug_getinfo <const>, context <const> = debug.getinfo, IsDuplicityVersion() and 'server' or 'client'

---@param module string The module folder 'notify', 'textUI', etc.
---@param resource string The chosen resource for the selected module 'ox', 'ls', 'okok', etc.
local function loadModule(module, resource)
    local basePath <const> = ('modules/%s/%s.lua'):format(module, context)
    local chunk, shared <const> = LoadResourceFile('king_bridge', basePath), LoadResourceFile('king_bridge', ('modules/%s/shared.lua'):format(module))
    if shared then
        chunk = chunk and string.format('%s\n%s', shared, chunk) or shared
    end

    if chunk then
        local modFunction <const>, err <const> = load(chunk, ('@@king_bridge/%s'):format(basePath))
        if not modFunction then
            return error(('\n^1Error importing module (%s): %s^0'):format(module, err or 'unknown error'), 3)
        end

        local result <const> = modFunction(resource)
        rawset(bridge, module, result or noop)

        return bridge[module]
    end
end

---@type table<string, string> The module name and its default value
local availableModules <const> = {
    notify = 'ox',
    progressBar = 'ox',
    textUI = 'ox'
}

_ENV.bridge = setmetatable({
    context = context
}, {
    __newindex = function(self, name, fn)
        rawset(self, name, fn)

        if debug_getinfo(2, 'S').short_src:find('@king_bridge/core') then
            exports(name, fn)
        end
    end,

    __index = function(self, name)
        if not self[name] then
            return loadModule(name, GetConvar(('kbridge:%s'):format(name), availableModules[name])) or noop
        end
    end
})