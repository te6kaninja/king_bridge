---@todo: think of a way to make this update on convar change

local resource <const> = GetConvar('kbridge:notifications', 'ox')

---@param data table
---@diagnostic disable-next-line: duplicate-set-field
function bridge.notify(data)
    if resource == 'ox' then
        lib.notify(data)
    end
end

return bridge.notify