#  Codependent Repo Continuous Integration and Deployment

## Summary
Path filtered testing. Detect changes, and only run the relevant subprojects' tests.

## Work in progress
This is an active project, and current state is only meant to show a proof of concept.

## Purpose
Demonstrates a repo-of-repos pattern or mono-repo pattern. Combines the advantages of a monorepo with those of a multirepo approach.  Many companies have a monorepo-strategy for performing some action only if changed/added files.

For each sub-project (folder) run the CI in parallel ignoring unchanged sub-projects, and add tag with the COMMIT_ID if scripts succeed. It was inspired by the need to manage source for multiple linked but separate packages for [dbt](https://github.com/dbt-labs/dbt-core)


## Considerations
A number of options were considered during planning. Utimately these approaches can be grouped into four unique ways to proceed
1. Mono repo 
1. Roll my own package manager
1. Git worktrees
1. Git submodules
   * Example https://github.com/jjcm/nonio/tree/d62ca321feb6b60820dd800b7cf6bfaa20fb1e26 
1. Github Actions (selected option)


## Design goals & design decisions
1. Uncomplicated testing
1. Single repo, and single programming language
   1. Multiple repos are more harder to setup, secure and maintain
1. Must be able to limit builds to only those packages that changed
1. Must be able to be able to version each subproject se
1. If possible avoid git submodules or worktrees
   1. Good for projects requiring several different package managers, or when a few libraries are shared across lots of projects
   1. Powerful, but tricky to setup right, and not familiar to many developers
   1. Lots of pitfalls and complexity 
1. Single version of the truth
   1. All updates should be synchronize, to allow refactoring cross repos
   1. One commit to change multiple sub-projects

## How it works
1. Create a list of folders with files that changed.
1. Uses Github's matrix workflow feature, however instead of a manual list I use the dynamically generated list
1. Sub-project CI spawns from primary workflow trigger
1. Run a common CI shell script for each, essentially any ci/build/test workflow to be executed
1. If success, tag the commit

## Test cases
- Changes to one directory trigger ci for that folder only
- Changes to two folders do not trigger sub-project ci for the third
- Commits without changes do nothing
- Successful PR merge triggers a tagging
  - Commit id will match master at that moment  


## Future work
1. Version bump
1. DBT example
1. git subtree?
