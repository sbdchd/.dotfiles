# hide greating
set --erase fish_greeting

# enable vi mode
fish_vi_key_bindings

# setup keybinds (autoloaded function)
function fish_user_key_bindings

    fzf_key_bindings
    bind \ck history-search-backward
    bind -M insert \ck history-search-backward
    bind -M normal \ck history-search-backward
    bind -M visual \ck history-search-backward

    bind \cl accept-autosuggestion
    bind -M insert \cl accept-autosuggestion
    bind -M normal \cl accept-autosuggestion
    bind -M visual \cl accept-autosuggestion
end

function fish_mode_prompt
    # Turns off mode indicator
end
