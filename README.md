# GitHub Cloner

**GitHub Cloner** is a Ruby script to automate cloning all repositories from your GitHub account. It supports both public and private repositories, with a configurable clone path.

## Features

- Fetches all repositories (public and private) from your GitHub account.
- Clones repositories into a specified directory.
- Uses `.env` file for storing sensitive information like GitHub tokens.

## Requirements

- Ruby (>= 2.5)
- Git
- `dotenv` gem for managing environment variables

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/BaseMax/github-cloner.git
   cd github-cloner
   ```

2. Install the required gem:

    ```bash
    gem install dotenv
    ```

3. Copy the `.env.example` file to `.env`:

    ```bash
    cp .env.example .env
    ```

4. Edit the `.env` file to include your GitHub personal access token and desired clone path:

    ```
    GITHUB_TOKEN=your-personal-access-token
    CLONE_PATH=./../
    ```

    Replace your-personal-access-token with your GitHub token.

    Set `CLONE_PATH` to your desired directory for cloning (default is `./`).

    Note: To generate a personal access token, visit GitHub Token Settings.

## Using

```bash
ruby github_cloner.rb
```

The script will:

- Fetch all your repositories from GitHub.
- Clone them into the directory specified by `CLONE_PATH`.

### Example Output

```
Fetching repositories...
Cloning repo1 into ./../...
Cloning repo2 into ./../...
All repositories cloned successfully!
```

### License

This project is licensed under the MIT License.

Copyright 2025, Max Base