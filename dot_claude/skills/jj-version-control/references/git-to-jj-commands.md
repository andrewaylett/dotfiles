# Git to Jujutsu Command Reference

Comprehensive mapping of Git commands to their Jujutsu equivalents.

## Repository Operations

| Git | jj | Notes |
|-----|-------|-------|
| `git init` | `jj git init` | Creates jj repo with Git backend |
| `git clone <url>` | `jj git clone <url>` | Clones and creates jj repo |
| `git remote add` | `jj git remote add` | Add remote repository |
| `git remote -v` | `jj git remote list` | List remotes |
| `git fetch` | `jj git fetch` | Fetch from all remotes |
| `git fetch origin` | `jj git fetch --remote origin` | Fetch from specific remote |
| `git push` | `jj git push` | Push all tracked bookmarks |
| `git push origin branch` | `jj git push --bookmark branch` | Push specific bookmark |
| `git pull` | `jj git fetch` | No direct equivalent; fetch then rebase manually |

## Working with Changes

| Git | jj | Notes |
|-----|-------|-------|
| `git status` | `jj st` or `jj status` | Show working copy status |
| `git diff` | `jj diff` | Diff of working copy |
| `git diff --staged` | N/A | No staging in jj |
| `git diff HEAD~1` | `jj diff -r @-` | Diff of parent commit |
| `git diff branch1..branch2` | `jj diff --from branch1 --to branch2` | Compare revisions |
| `git add <file>` | N/A | Not needed - all changes auto-tracked |
| `git add -p` | `jj split` | Interactive splitting of changes |
| `git commit -m "msg"` | `jj commit -m "msg"` | Commit and create new working copy |
| `git commit --amend` | `jj squash` or `jj desc -m "new msg"` | Amend message or content |
| `git commit --amend -m "msg"` | `jj desc -m "msg"` | Amend commit message only |
| `git reset HEAD <file>` | `jj restore <file>` | Restore file to parent state |
| `git reset --hard` | `jj abandon` | Discard current commit |
| `git reset --soft HEAD~1` | `jj squash --into @--` | Move changes to grandparent |
| `git checkout -- <file>` | `jj restore <file>` | Discard changes to file |
| `git clean -fd` | `jj abandon` | Discard all uncommitted changes |
| `git stash` | N/A | Not needed - working copy is a commit |
| `git stash pop` | N/A | Just `jj edit` back to your commit |

## Viewing History

| Git | jj | Notes |
|-----|-------|-------|
| `git log` | `jj log` | Show commit history |
| `git log --oneline` | `jj log --no-graph` | Compact log |
| `git log -n 5` | `jj log -n 5` | Limit entries |
| `git log --all` | `jj log -r 'all()'` | Show all commits |
| `git log --graph` | `jj log` | Graph is default |
| `git log -p` | `jj log -p` | Show patches |
| `git log -- <file>` | `jj log <file>` | History of file |
| `git show` | `jj show` | Show current commit |
| `git show <rev>` | `jj show <rev>` | Show specific revision |
| `git show <rev>:<file>` | `jj file show <rev> <file>` | Show file at revision |
| `git blame <file>` | `jj file annotate <file>` | Annotate file with authors |
| `git reflog` | `jj op log` | Operation history |

## Bookmarks (Branches)

| Git | jj | Notes |
|-----|-------|-------|
| `git branch` | `jj bookmark list` | List local bookmarks |
| `git branch -a` | `jj bookmark list --all` | List all bookmarks |
| `git branch <name>` | `jj bookmark create <name>` | Create bookmark at @ |
| `git branch <name> <rev>` | `jj bookmark create <name> -r <rev>` | Create at revision |
| `git branch -d <name>` | `jj bookmark delete <name>` | Delete bookmark |
| `git branch -D <name>` | `jj bookmark delete <name>` | Force delete (same in jj) |
| `git branch -m old new` | `jj bookmark rename old new` | Rename bookmark |
| `git checkout <branch>` | `jj edit <bookmark>` | Edit that commit |
| `git checkout -b <name>` | `jj new` then `jj bookmark create <name>` | New commit with bookmark |
| `git switch <branch>` | `jj new <bookmark>` | Create child of bookmark |
| `git push -u origin <name>` | `jj git push --bookmark <name>` | Push and track |
| `git branch --set-upstream-to` | `jj bookmark track <name>@<remote>` | Set tracking |

## Navigation and Editing

| Git | jj | Notes |
|-----|-------|-------|
| `git checkout <rev>` | `jj new <rev>` | Create new commit at rev |
| `git checkout <rev>` (to edit) | `jj edit <rev>` | Edit existing commit |
| `git checkout HEAD~1` | `jj new @-` | New commit from parent |
| `git checkout -` | `jj edit @-` | Edit parent |

## Merging and Rebasing

| Git | jj | Notes |
|-----|-------|-------|
| `git merge <branch>` | `jj new @ <branch>` | Create merge commit |
| `git merge --squash` | `jj squash --from <branch>` | Squash merge |
| `git rebase <dest>` | `jj rebase -d <dest>` | Rebase onto destination |
| `git rebase -i` | `jj squash`, `jj split`, `jj edit` | Interactive editing |
| `git rebase --onto` | `jj rebase -s <source> -d <dest>` | Rebase subset |
| `git cherry-pick <rev>` | `jj duplicate <rev>` | Copy commit |
| `git revert <rev>` | `jj backout -r <rev>` | Create reverting commit |

## Conflict Resolution

| Git | jj | Notes |
|-----|-------|-------|
| `git status` (conflicts) | `jj st` | Shows conflicted files |
| `git mergetool` | `jj resolve` | Launch merge tool |
| `git add <file>` (mark resolved) | Auto-detected | No marking needed |
| `git rebase --continue` | N/A | Conflicts are commits; just edit |
| `git rebase --abort` | `jj undo` | Undo the rebase operation |

## Undoing Operations

| Git | jj | Notes |
|-----|-------|-------|
| `git reflog` | `jj op log` | View operation history |
| `git reset --hard <reflog>` | `jj op restore <op-id>` | Restore to operation |
| N/A | `jj undo` | Undo last operation |
| N/A | `jj redo` | Redo undone operation |

## Advanced Operations

| Git | jj | Notes |
|-----|-------|-------|
| `git bisect` | `jj util bisect` | Binary search for bugs |
| `git worktree` | `jj workspace` | Multiple working directories |
| `git submodule` | N/A | Not yet supported |
| `git lfs` | N/A | Not yet supported |
| N/A | `jj absorb` | Auto-amend changes to relevant commits |
| N/A | `jj fix` | Run formatter on commits |
| N/A | `jj split` | Split commit interactively |
| N/A | `jj parallelize` | Make sequential commits parallel |

## Revset Syntax Quick Reference

Instead of Git's revision syntax, jj uses revsets:

| Git | jj Revset                         | Meaning |
|-----|-----------------------------------|---------|
| `HEAD` | `@`                               | Working copy commit |
| `HEAD~1` | `@-`                              | Parent of working copy |
| `HEAD~n` | `@---...` or `ancestors(@, n)`    | n-th ancestor |
| `branch` | `branch`                          | Bookmark/branch name |
| `origin/main` | `main@origin`                     | Remote bookmark |
| `HEAD^1` | `@-`                              | First parent |
| `HEAD^2` | N/A (use explicit rev)            | Second parent |
| `rev1..rev2` | `rev1::rev2`                      | Range of commits |
| `rev1...rev2` | `(rev1 \| rev2) & ~(rev1 & rev2)` | Symmetric difference |
