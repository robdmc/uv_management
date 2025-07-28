# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a Python development environment management repository using `uv` for dependency and virtual environment management. The project uses a date-based directory structure where each dated directory (e.g., `2025-07-28/`) contains a complete, isolated Python environment. The project also contains:
- `graveyard/` - Archive/backup directory

## Date-Based Environment Management

### Creating New Environments
```bash
# Create a new dated environment from the latest existing one
make new
```

This command:
- Finds the latest dated directory (highest YYYY-MM-DD lexicographically)
- Creates a new directory with today's date
- Copies `Makefile`, `pyproject.toml`, `ai/` directory, and `ad_hoc_installs.txt`
- Overwrites any existing directory with today's date

### Working with Dated Environments
Each dated directory (e.g., `2025-07-28/`) contains:
- `pyproject.toml` - Project configuration and dependencies (pure uv/pyproject.toml workflow)
- `Makefile` - Environment management commands (env, sync, lock, activate, nuke)
- `ai/` - Package code directory
- `ad_hoc_installs.txt` - Additional packages to be manually integrated

### Virtual Environment Setup (within dated directories)
```bash
cd 2025-07-28/  # Navigate to specific dated environment

# Create a new virtual environment
make env

# Install dependencies from lock file (or create if needed)
make sync

# Create lock file
make lock

# Activate virtual environment
make activate

# Delete the virtual environment
make nuke
```

## Code Quality Tools
The project includes comprehensive code quality tooling in dependencies:
- `ruff` - Fast Python linter and formatter
- `black` - Code formatter
- `mypy` - Static type checker
- `flake8` - Style guide enforcement
- `pytest` - Testing framework

Run these tools with uv:
```bash
uv run ruff check .
uv run black .
uv run mypy .
uv run pytest
```

## Project Structure
- Only package code lives in dated directory's `ai/` subdirectory (currently minimal - just `__init__.py`)
- The `__init__.py` indicates this is primarily an environment management setup
- Dependencies are extensive ML/AI focused (pandas, torch, scikit-learn, jupyter, etc.)

## Working Directory
Always work from the appropriate dated subdirectory (e.g., `2025-07-28/`) or `graveyard/` as each has its own isolated environment configuration.

## Ad Hoc Package Management Instructions for Claude

### When asked to "add packages from ad_hoc_installs.txt to pyproject.toml":

1. **Find the latest dated directory**: Look for the highest YYYY-MM-DD directory name lexicographically
2. **Read the ad_hoc_installs.txt file** in that directory
3. **Process only non-commented lines**: Ignore lines starting with `#` or empty lines
4. **Add packages to pyproject.toml dependencies**: Append the packages to the `dependencies` array in the `[project]` section
5. **Maintain existing format**: Keep the current dependency list structure and formatting

### Example workflow:
```bash
# User runs: make new
# User edits: 2025-07-28/ad_hoc_installs.txt (adds packages)
# User says: "Can you add the non-commented-out packages from ad-hoc installs into pyproject.toml"
# Claude should:
#   - Find latest directory (2025-07-28)
#   - Read 2025-07-28/ad_hoc_installs.txt
#   - Add non-commented packages to 2025-07-28/pyproject.toml dependencies
```

## Git Workflow Instructions for Claude

### When to Propose Git Commits
After completing any task and verifying the changes are correct, Claude should propose a git commit command to the user. This includes:
- Environment management changes (new environments, Makefile updates)
- Package dependency modifications
- Configuration file updates
- Documentation changes
- Bug fixes or feature implementations

### Commit Message Guidelines
1. **Use conventional commit format** when appropriate:
   - `feat:` for new features
   - `fix:` for bug fixes
   - `docs:` for documentation changes
   - `refactor:` for code refactoring
   - `chore:` for maintenance tasks

2. **Focus on the "why" rather than the "what"**
3. **Be concise but descriptive** (50 characters or less for subject)
4. **Use imperative mood** ("Add" not "Added" or "Adds")

### Command Format
Always provide the exact commands:
```bash
git add [specific files or . for all changes]
git commit -m "commit message"
```

### Branch Management
Branch management (creating, switching, merging) is the user's responsibility. Claude should only propose the commit commands, not branch operations.

### Example Commit Messages for This Project
- `feat: implement date-based environment management system`
- `fix: prevent Makefile from deleting source directory on same-day runs`
- `docs: add git workflow instructions to CLAUDE.md`
- `chore: add pandas and scikit-learn to environment dependencies`
- `refactor: migrate from requirements.txt to pure pyproject.toml workflow`

### Sample Proposal Format
After completing a task, Claude should say:
> "The changes look correct. I recommend committing these changes:
> ```bash
> git add .
> git commit -m "feat: implement date-based environment management"
> ```"