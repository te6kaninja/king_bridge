if cache.context == 'client' then
    local resource <const> = GetConvar('kbridge:notifications', 'ox')

    ---@param data table
    ---@diagnostic disable-next-line: duplicate-set-field
    function bridge.notify(data)
        if resource == 'ox' then
            lib.notify(data)
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