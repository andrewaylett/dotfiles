function fish_jj_prompt
    # If jj isn't installed, there's nothing we can do
    # Return 1 so the calling prompt can deal with it
    if not command -sq jj
        return 1
    end
    set -l cur "$(
        jj log 2>/dev/null --no-graph --color=always --revisions @ \
            --ignore-working-copy \
            --template 'commit_and_parents_info'
    )"
    or return 1
    if test -n "$cur"
        printf '(%s)' $cur
    end
end
