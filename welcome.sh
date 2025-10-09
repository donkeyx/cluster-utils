#!/bin/sh

# Welcome message and tool inventory for cluster-utils container
# Colors for better readability
if [ -t 1 ]; then
    BOLD='\033[1m'
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    YELLOW='\033[1;33m'
    CYAN='\033[0;36m'
    NC='\033[0m' # No Color
else
    BOLD='' GREEN='' BLUE='' YELLOW='' CYAN='' NC=''
fi

echo ""
printf "${BOLD}${CYAN}"
cat << 'EOF'
╭────────────────────────────────────────╮
|         🐴 DonkeyX's Cluster Utils      │
╰────────────────────────────────────────╯

        //\\
       (/oo\)   .----.
       (____)  | K8s |
        /||\   '----'
       //||\\   🐛 Debug Mode
      ^^ ^^ ^^
   "Braying at broken clusters!"

EOF
printf "${NC}"
printf "${BOLD}${GREEN}🚀 Welcome to the Networking Cluster Utilities! 🚀${NC}\n"
printf "${BOLD}=====================================================${NC}\n"
echo ""
printf "${BOLD}${BLUE}📦 Available Tools:${NC}\n"
echo ""

# Network & DNS tools
printf "${CYAN}🌐 Network & DNS:${NC}\n"
echo "  • dig, nslookup, host (bind-tools)"
echo "  • nc (netcat-openbsd)"
echo "  • curl, wget"
echo ""

# Database clients
printf "${CYAN}🗄️  Database Clients:${NC}\n"
PG_VERSION=$(psql --version 2>/dev/null | cut -d' ' -f3 | cut -d'.' -f1-2 || echo 'N/A')
echo "  • psql (PostgreSQL client v${PG_VERSION})"
echo "  • redis-cli (Redis client)"
echo ""

# Development & utilities
printf "${CYAN}🛠️  Development & Utilities:${NC}\n"
echo "  • git (version control)"
echo "  • jq (JSON processor)"
echo "  • vim (text editor)"
echo "  • tmux (terminal multiplexer)"
echo "  • npm/node (JavaScript runtime)"
echo ""

# Load testing
printf "${CYAN}⚡ Load Testing:${NC}\n"
K6_VERSION=$(k6 version 2>/dev/null | head -1 || echo 'load testing tool')
echo "  • k6 (${K6_VERSION})"
echo ""

# Shell
printf "${CYAN}🐚 Shell Environment:${NC}\n"
echo "  • zsh with Oh My Zsh"
echo "  • Custom prompt and completions"
echo ""

printf "${BOLD}${YELLOW}💡 Tips:${NC}\n"
echo "  • Use 'kubectl exec -it <pod-name> -- zsh' for interactive shell"
echo "  • All tools are in PATH and ready to use"
echo "  • Container runs continuously - no timeouts!"
echo ""
printf "${BOLD}${GREEN}Happy cluster debugging! 🎯${NC}\n"
echo ""