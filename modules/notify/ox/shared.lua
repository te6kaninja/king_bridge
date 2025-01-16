if bridge.context == 'client' then
    ---@param data table
    ---@diagnostic disable-next-line: duplicate-set-field
    function bridge.notify(data)
        if resource == 'ox' then
            exports.ox_lib:notify(data)
        end
    end

    RegisterNetEvent('king_bridge:notify', bridge.notify)
else
    ---@param src integer
    ---@param data table
    ---@diagnostic disable-next-line: duplicate-set-field
    function bridge.notify(src, data)
        if src and type(src) == 'number' and data then
            TriggerClientEvent('king_bridge:notify', src, data)
        end
    end
end

return bridge.notify