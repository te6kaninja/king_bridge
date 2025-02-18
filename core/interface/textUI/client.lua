local resource <const> = GetConvar('kbridge:textUI', 'ox')

---@param text string
---@param data table?
function bridge.showTextUI(text, data)
    if text then
        if resource == 'ox' then
            if data and data?.key then
                text = ('[%s] %s'):format(data.key or 'E', text)
            end
            exports.ox_lib:showTextUI(text, data)
        elseif resource == 'ls' and data then
            exports.ls_textui:showTextUI(data.id, data.key, text)
        end
    end
end

---@param id any
function bridge.hideTextUI(id)
    if resource == 'ox' then
        exports.ox_lib:hideTextUI()
    elseif resource == 'ls' and id then
        exports.ls_textui:hideTextUI(id)
    end
end

-- Works only with text UIs that support it themselves
---@return any[] | table?
function bridge.getTextUIs()
    if resource == 'ls' then
        return exports.ls_textui:getTextUIs()
    end
end