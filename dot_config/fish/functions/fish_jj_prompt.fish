function fish_jj_prompt
    # If jj isn't installed, there's nothing we can do
    # Return 1 so the calling prompt can deal with it
    if not command -sq jj
        return 1
    end
    set -l cur "$(
        jj log 2>/dev/null --no-graph --ignore-working-copy --color=always --revisions @ \
            --template '
                separate(" ",
                    coalesce(if(empty, label("empty", "empty")), change_id.shortest()),
                    if(conflict, label("conflict", "×")),
                )
            '
    )"
    or return 1
    set -l prev "$(
        jj log 2>/dev/null --no-graph --ignore-working-copy --color=always --revisions @- \
            --template '
                separate(" ",
                    coalesce(if(empty, label("empty", "empty")), change_id.shortest()),
                    if(conflict, label("conflict", "×")),
                )
            '
    )"
    or return 1
    if test -n "$cur"
        printf ' (%s' $cur
        if test -n "$prev"
            printf ', %s' $prev
        end
        printf ')'
    end
end
