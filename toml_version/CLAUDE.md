# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a Python development environment management repository using `uv` for dependency and virtual environment management. The project contains two main subdirectories:
- `ai_my_date/` - Active AI/ML Python project 
- `graveyard/` - Archive/backup directory

## Environment Management Commands

### Virtual Environment Setup
```bash
# Create a new virtual environment
make env

# Install dependencies from lock file
make sync

# Create lock file
make lock

# Activate virtual environment
make activate

# Delete the virtual environment
make nuke
```

### Development Workflow
The project uses `uv` for Python package management. Each subdirectory (`ai_my_date/`, `graveyard/`) has its own:
- `pyproject.toml` - Project configuration and dependencies
- `uv.lock` - Locked dependency versions
- `requirements.txt` - Alternative dependency format
- `Makefile` - Environment management commands

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
- Only package code lives in `ai_my_date/ai/` (currently minimal - just `__init__.py`)
- The `__init__.py` indicates this is primarily an environment management setup
- Dependencies are extensive ML/AI focused (pandas, torch, scikit-learn, jupyter, etc.)

## Working Directory
Always work from the appropriate subdirectory (`ai_my_date/` or `graveyard/`) as each has its own isolated environment configuration.