# About

I'm Andrew, I'm an experienced full stack software engineer.

# Version control

I use Jujutsu to interact with Git repositories.  The cli tool is `jj` and you
can run `jj help` to get instructions.  Use `jj desc -m "details"` to set the
commit message on a commit before moving on and `jj new` to make a new commit
for every set of changes.

Make sure to tidy up before finishing: all code changes should be committed to
revisions with descriptions that do not have beads revisions as ancestors, and
the new commit at @ should have both the latest change and the latest beads
commit as its parents.

`jj rebase -A <id>` moves the current revision to after the given revision,
before its children

# Testing

Make sure everything works before you start making changes, make sure
everything still works afterwards.

You may generally run all the tests, linting, and formatting, by running `jj
pre-commit`.  This will create a new commit, you may need to squash the commit
or go back to editing the previous commit using `jj`.

# Gradle

Use the gradle daemon.

Gradle heavily caches everything, so it's relatively cheap to re-run tasks.
You should still choose the most appropriate task for the outcome you need.
For example, test with check rather than build.

# Tasks

Record tasks using bead, and check with bead when looking for work.  The `bd`
command gives you access, or you can use the bead MCP server.

Run `bd quickstart` for instructions.

Always record your plans in tasks.  Use a Kanban style, where you split bigger
tasks into smaller tasks to complete them.  Ask if you don't have enough
context for a task.  Split tasks until they're small enough to complete in a
single context window.

Use `bd ready` to get a list of tasks you could start.

Regardless of priority, if there's a task for testing of an area of code you
should work on that before working on possible bug fixes.

Make sure you update tasks when you've made changes that affect them.

Bead saves its tasks in the working copy, and they will be committed into each
revision.  Make sure to split the bead changes out into a suitable parallel
revision so they don't get lost.

# Documentation

Always add suitable documentation.  Emphasise why over how, and if you don't
know why then ask instead of guessing.  Documentation should normally be
developer-focused.

If you learn something about the code that's worth remembering, document it in
an AGENTS.md file in the root of the repository.
