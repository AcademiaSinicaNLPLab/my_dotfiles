let set = (pref, valueOrFunction) => {
  let value = typeof valueOrFunction === 'function'
    ? valueOrFunction(vimfx.getDefault(pref))
    : valueOrFunction
  vimfx.set(pref, value)
}
let map = (shortcuts, command, custom=false) => {
  vimfx.set(`${custom ? 'custom.' : ''}mode.normal.${command}`, shortcuts)
}
function unmap(cmd)	{
    map("", cmd);
}

set('hint_chars', 'ehstirnoamupcwlfgdy')
set('prevent_autofocus', true)

unmap('focus_search_bar')
unmap('go_to_root')
unmap('go_home')
unmap("reload_all")
unmap("reload_all_force") 
unmap("stop") 
unmap("stop_all") 
unmap('scroll_left')
unmap('scroll_right')
unmap('scroll_to_left')
unmap('scroll_to_right')
unmap('tab_select_most_recent')
unmap('tab_select_oldest_unvisited')
unmap('tab_move_to_window')
unmap('tab_select_first_non_pinned')
unmap('tab_select_last')
unmap('tab_close_to_end')
unmap('tab_close_other')
unmap('follow_in_focused_tab')
unmap('follow_in_window')
unmap('follow_copy')
unmap('follow_focus')
unmap('find')
unmap('find_links_only')
unmap('window_new')


map('<c-h>', 'tab_select_previous')
map('<c-l>', 'tab_select_next')
map('<c-H>', 'tab_move_backward')
map('<c-L>', 'tab_move_forward')
map('h', 'history_back')
map('l', 'history_forward')
map('H', 'history_list')
map('<c-f>', 'scroll_page_down')
map('<c-b>', 'scroll_page_up')
map('j', 'scroll_half_page_down')
map('k', 'scroll_half_page_up')
map('<c-j>', 'scroll_down')
map('<c-k>', 'scroll_up')
map('<c-a-h>', 'tab_select_first')
map('d', 'tab_close')
map('u', 'tab_restore')
map('U', 'tab_restore_list')
map('zf', 'click_browser_element')
map('/', 'find_highlight_all')
map('zw', 'window_new_private')

vimfx.addCommand({
    name: 'goto_addons',
    description: 'Addons',
}, ({vim}) => {
    vim.window.BrowserOpenAddonsMgr()
})


map('za', 'goto_addons', true)

vimfx.addCommand({
    name: 'goto_config',
    description: 'Config',
}, ({vim}) => {
    vim.window.switchToTabHavingURI('about:config', true)
})
map('zc', 'goto_config', true)

vimfx.addCommand({
    name: 'goto_downloads',
    description: 'Downloads',
}, ({vim}) => {
    vim.window.switchToTabHavingURI('about:downloads', true)
})
map('zd', 'goto_downloads', true)

vimfx.addCommand({
    name: 'goto_preferences',
    description: 'Preferences',
}, ({vim}) => {
    vim.window.openPreferences()
})
map('zp', 'goto_preferences', true)
