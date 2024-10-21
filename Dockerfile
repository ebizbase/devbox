FROM debian:bookworm-slim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends \
    supervisor \
    ca-certificates \
    zsh \
    git \
    curl \
    wget \
    jq \
    tig \
    nano \
    exa \
    gh \
    # Install git-lfs
    && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash  \
    && apt-get install -y --no-install-recommends git-lfs \
    && git lfs version \ 
    # Install zsh and oh-my-zsh and setup powerlevel10k theme
    && curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh - \
    && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k \
    && sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc \
    && echo 'source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc \
    && echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions git-auto-fetch)/g' ~/.zshrc \
    && zsh --version \
    # Install docker
    && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc \
    && echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
    && docker --version \
    # Install latest node pnpm and playwright
    && curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && npm install -g npm pnpm nx playwright \
    && pnpx playwright install --with-deps \
    && node --version && pnpm --version \
    # Install act and image for local runner
    && curl -fsSL https://raw.githubusercontent.com/nektos/act/master/install.sh | bash  - \
    # Cleanup
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* 

COPY assets/p10k.zsh  ~/.p10k.zsh
COPY assets/supervisord.conf /etc/supervisor/supervisord.conf
COPY assets/supervisord.dockerd.conf /etc/supervisor/conf.d/supervisord.dockerd.conf

COPY assets/entrypoint.sh /etc/entrypoint/entrypoint.sh
RUN chmod +x /etc/entrypoint/entrypoint.sh 
COPY assets/entrypoint.supervisord.sh /etc/entrypoint/init.d/entrypoint.supervisord.sh
RUN chmod +x /etc/entrypoint/init.d/entrypoint.supervisord.sh

# Set the default shell to zsh
ENV SHELL=/bin/zsh

ENTRYPOINT ["/etc/entrypoint/entrypoint.sh"]    
CMD ["tail", "-f", "/dev/null"]

