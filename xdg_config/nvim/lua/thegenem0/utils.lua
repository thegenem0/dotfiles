local function merge_plugins(...)
    local merged = {}
    for _, config in ipairs({ ... }) do
        for _, plugin in ipairs(config) do
            table.insert(merged, plugin)
        end
    end
    return merged
end

return {
    merge_plugins = merge_plugins
}
