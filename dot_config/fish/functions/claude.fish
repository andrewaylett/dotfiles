function claude --description 'Launch Claude Code' --wraps claude
    fnox exec --profile claude -- command claude $argv
end
