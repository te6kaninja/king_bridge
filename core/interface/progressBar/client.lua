local resource <const> = GetConvar('kbridge:progressBar', 'ox')

function bridge.progressBar(data)
    if resource == 'ox' then
        return exports.ox_lib:progressBar(data)
    elseif resource == 'oxCircle' then
        return exports.ox_lib:progressBarCircle(data)
    elseif resource == 'ls' then
        return exports.ls_progressbar:progressBar(data)
    end
end

function bridge.cancelProgress()
    if resource == 'ox' or resource == 'oxCircle' then
        exports.ox_lib:cancelProgress()
    elseif resource == 'ls' then
        exports.ls_progressbar:cancel()
    end
end

---@return boolean?
function bridge.progressActive()
    if resource == 'ox' or resource == 'oxCircle' then
        return exports.ox_lib:progressActive()
    elseif resource == 'ls' then
        return exports.ls_progressbar:isProgressActive()
    end
end