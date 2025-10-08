FROM alpine:latest

ENV TZ="Australia/Adelaide"

WORKDIR /app

# Copy scripts
COPY sleeper.sh /app/runner.sh
COPY welcome.sh /app/welcome.sh

# Install packages, setup tools, and cleanup in a single layer
RUN set -eux && \
    # Install system packages
    apk add --no-cache \
        bind-tools \
        netcat-openbsd \
        curl \
        wget \
        git \
        jq \
        vim \
        tmux \
        zsh \
        postgresql-client \
        redis \
        npm \
        tar && \
    # Install oh-my-zsh
    sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
    # Install k6 (lighter than vegeta) - always get the latest version
    K6_VERSION=$(curl -s https://api.github.com/repos/grafana/k6/releases/latest | jq -r '.tag_name') && \
    curl -sS -L https://github.com/grafana/k6/releases/download/${K6_VERSION}/k6-${K6_VERSION}-linux-amd64.tar.gz | tar -xz --strip-components=1 && \
    mv k6 /usr/local/bin/ && \
    # Make scripts executable and configure welcome message
    chmod +x /app/runner.sh /app/welcome.sh && \
    echo "# Show welcome message on interactive shell login" >> /root/.zshrc && \
    echo "if [[ \$- == *i* ]] && [[ -z \$WELCOME_SHOWN ]]; then" >> /root/.zshrc && \
    echo "    export WELCOME_SHOWN=1" >> /root/.zshrc && \
    echo "    /app/welcome.sh" >> /root/.zshrc && \
    echo "fi" >> /root/.zshrc && \
    # Set zsh as the default shell for root user in multiple ways for compatibility
    sed -i 's|root:.*:/bin/.*sh|root:x:0:0:root:/root:/bin/zsh|g' /etc/passwd && \
    # Also set SHELL environment variable as fallback
    echo 'export SHELL=/bin/zsh' >> /root/.profile && \
    echo 'export SHELL=/bin/zsh' >> /root/.zshrc && \
    # Create a .profile that auto-switches to zsh if we're in an interactive session with sh/ash
    echo '# Auto-switch to zsh if in interactive mode and not already in zsh' >> /root/.profile && \
    echo 'if [ -t 0 ] && [ "$0" != "/bin/zsh" ] && [ "$0" != "zsh" ] && [ -z "$ZSH_SWITCHED" ]; then' >> /root/.profile && \
    echo '    export ZSH_SWITCHED=1' >> /root/.profile && \
    echo '    exec /bin/zsh' >> /root/.profile && \
    echo 'fi' >> /root/.profile && \
    # Make sure .profile is sourced by ash/sh
    ln -sf /root/.profile /root/.ashrc && \
    # Cleanup to reduce image size
    rm -rf /var/cache/apk/* /tmp/* /root/.oh-my-zsh/.git

ENTRYPOINT ["sh", "/app/runner.sh"]

