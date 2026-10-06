status is-interactive
or exit 0

if status list-files completions/gradle.fish > /dev/null
    status get-file completions/gradle.fish | source
else if test -f $(brew --prefix fish)/share/fish/completions/gradle.fish
    source $(brew --prefix fish)/share/fish/completions/gradle.fish
end
if status list-files completions/gradlew.fish > /dev/null
    status get-file completions/gradlew.fish | source
else if test -f $(brew --prefix fish)/share/fish/completions/gradlew.fish
    source $(brew --prefix fish)/share/fish/completions/gradlew.fish
end
