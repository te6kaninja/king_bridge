---@param src integer
---@param data table
---@diagnostic disable-next-line: duplicate-set-field
function bridge.notify(src, data)
    if src and type(src) == 'number' and data then
        TriggerClientEvent('king_bridge:notify', src, data)
    end
end

return bridge.notify