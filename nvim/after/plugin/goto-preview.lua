local status, gotopreview = pcall(require, 'goto-preview')
if not status then
    return
end

gotopreview.setup{}
