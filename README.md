# DevBox

![GitHub Release](https://img.shields.io/github/v/release/ebizbase/devbox?display_name=release&style=flat&label=Latest%20Version)
[![Open in Dev Container](https://img.shields.io/badge/Open%20in%20devcontainer-blue?logo=coder&style=flat)](https://vscode.dev/redirect?url=vscode://vscode-remote/containers/cloneFromGithub?url=https://github.com/ebizbase/devbox)


In a software development company, the development team always faces challenges in setting up and maintaining a consistent development environment. Each team member may use different operating systems, different software versions, and this leads to difficulties in reproducing bugs and ensuring that everyone is working on the same platform.

To solve this problem, the team decided to create a custom Docker image, called DevBox. DevBox not only helps to set up the development environment quickly and consistently but also includes all the necessary tools and configurations to support the software development process effectively.

## Features

- **Debian 12**
Debian is renowned for its stability and high security. Using Debian provides a solid and reliable foundation for the development environment, allowing the development team to focus on building and deploying software without worrying about environment-related issues.
- **Zsh**: 
The command line experience is an important part of developers' daily work. Zsh, along with Oh-My-Zsh and the Powerlevel10k theme, provides a powerful and user-friendly command line interface, helping to increase developers' productivity and satisfaction. Including Zsh, Oh-My-Zsh, and Powerlevel10k improves the command line experience, offering features like auto-completion, syntax highlighting, and a beautiful interface.
- **Docker**: 
Docker helps create consistent and easily reproducible development environments. Using Docker in Docker (DinD) allows the development team to run Docker inside a container, making it easy to test and develop containerized applications. Including Docker in Docker with a background process started with supervisord helps the development team easily test and develop containerized applications without needing to install Docker directly on their machines.
- **NodeJS**: 
NodeJS is a popular platform for web and backend application development. Using NX to manage monorepos helps the development team manage large projects efficiently. Including NodeJS and NX helps the development team easily manage and develop monorepo projects, ensuring they always use the latest NodeJS LTS version to take advantage of the latest features and improvements.
- **Nektos/Act**: 
CI/CD is an important part of modern software development processes. GitHub Actions is a powerful tool for CI/CD, and Nektos/Act allows the development team to run GitHub Actions workflows locally to test before pushing to GitHub. Including Nektos/Act helps the development team easily test GitHub Actions workflows locally, ensuring that CI/CD pipelines work correctly before pushing to GitHub.

## Usage

Example devcontainer.json

```json
{
    "name": "ebizops",
    "image": "ebizebase/devbox",
    "runArgs": [
        "--privileged",
        "--name=udevbox"
    ],
    "overrideCommand": false,
    "remoteUser": "root",
    "customizations": {
        "vscode": {
            "extensions": [
                "golang.go",
                "esbenp.prettier-vscode"
            ]
        }
    }
}
```

## Contributing

We welcome contributions! Please read our [contributing guidelines](../CONTRIBUTING.md) for more details.
