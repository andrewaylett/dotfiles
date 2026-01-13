# Jujutsu Concepts

Key conceptual differences between Jujutsu and Git that inform how to use jj effectively.

## The Working Copy is a Commit

In Git, your working directory contains uncommitted changes that exist in a liminal state. In jj, **the working copy is always a commit**, shown as `@` in the log.

Implications:
- Every file modification immediately updates the working copy commit
- There's no concept of "uncommitted changes" - all changes are committed
- "Stashing" is unnecessary - just create a new commit and come back later
- You're always working on a commit, never in an uncommitted state

## No Staging Area

Git's index/staging area doesn't exist in jj. All tracked files in the working directory are part of the current commit.

What this means:
- No `git add` before committing
- No partial staging of files
- To commit only some changes, use `jj split` to interactively divide the commit
- `jj restore <file>` removes changes from the current commit

## Change IDs vs Commit Hashes

Every jj commit has two identifiers:

1. **Commit hash**: Like Git, changes when the commit is rewritten
2. **Change ID**: Stable identifier that persists across rewrites

Change IDs let you:
- Reference a logical change even after rebasing
- Track the evolution of a change through history
- Use shorter, more memorable identifiers

In the log output:
```
◆  rlvkpnrz user@example.com 2024-01-15 15:30:00 bookmark-name 1a2b3c4d
│  Commit message here
```
- `rlvkpnrz` is the change ID (or a prefix of it)
- `1a2b3c4d` is the commit hash (or a prefix of it)

You can use either to reference the commit.

## Bookmarks vs Branches

What Git calls "branches" are "bookmarks" in jj. While similar, there are differences:

**Git branches:**
- Automatically move forward on commit
- Must be explicitly checked out
- Have complex tracking relationships

**jj bookmarks:**
- Don't move automatically - you explicitly move them
- Are just pointers to commits
- Can be "forgotten" (untracked) independently of deletion

Key commands:
- `jj bookmark create <name>` - Create bookmark at current commit
- `jj bookmark set <name>` - Move existing bookmark to current commit
- `jj bookmark list` - List all bookmarks
- `jj bookmark track <name>@origin` - Track remote bookmark

## Anonymous Heads

Unlike Git, jj allows commits without any bookmark pointing to them. These "anonymous heads" are valid and won't be garbage collected.

This enables workflows like:
- Creating experimental commits without naming them
- Working on multiple unrelated changes simultaneously
- Not worrying about branch names until you're ready to share

To find anonymous heads: `jj log -r 'heads(all())'`

## Conflicts are Commits

In Git, a conflict halts operations like merge or rebase until resolved. In jj, **conflicts are recorded in commits**.

This means:
- A conflicted merge creates a commit with conflict markers
- You can continue working, create new commits, even rebase
- Conflicts can be resolved at any time, not just immediately
- Multiple conflicted commits can exist simultaneously

Conflict workflow:
```bash
# See conflicted commits
jj log -r 'conflicts()'

# Edit a conflicted commit
jj edit <conflicted-change-id>

# Resolve conflicts in files
jj resolve  # Opens merge tool

# Or manually edit files, then jj automatically detects resolution
```

## Operation Log

Every state-changing jj command is recorded in the operation log. This provides:

**Complete undo capability:**
```bash
jj op log        # View all operations
jj undo          # Undo last operation
jj op restore <id>  # Restore to any point
```

**Safe experimentation:**
- Try complex rebases knowing you can undo
- Recover from any mistake
- See exactly what changed and when

Unlike Git's reflog:
- Operations are first-class, not just reference changes
- Undo affects all changes from an operation, not just HEAD
- Operations have human-readable descriptions

## Immutable History

By default, jj prevents rewriting commits that have been pushed to shared remotes. The `immutable_heads()` revset defines what's protected.

Protected commits can't be:
- Amended or squashed
- Rebased
- Abandoned

This prevents accidental history rewriting of shared work.

## The `@` Symbol

The `@` symbol always refers to the working copy commit. It's the most frequently used revset:

- `@` - The working copy commit
- `@-` - Parent of working copy
- `@--` - Grandparent
- `@+` - Children of working copy (if any)

## Revsets

Jj uses a powerful expression language called revsets to select commits:

**Basic:**
- `@` - Working copy
- `root()` - Repository root
- `all()` - All commits
- `heads(x)` - Commits in x with no children in x

**Operators:**
- `x & y` - Intersection
- `x | y` - Union
- `x ~ y` - Difference (in x but not y)
- `::x` - Ancestors of x
- `x::` - Descendants of x
- `x::y` - x to y (inclusive)

**Functions:**
- `ancestors(x)` - All ancestors
- `descendants(x)` - All descendants
- `parents(x)` - Direct parents
- `children(x)` - Direct children
- `conflicts()` - Commits with conflicts

## First-Parent History

Jj tracks a clear "first-parent" lineage, making history easier to follow even with merges. The default log shows this linear history while still representing the full DAG.

## Co-located Repositories

Jj can manage a repository alongside Git (co-located mode). This means:
- The `.git` directory exists alongside `.jj`
- Git tools continue to work
- Changes made with either tool are visible to both
- Useful for gradual migration or tool compatibility

Most repositories use co-located mode when working with GitHub.
