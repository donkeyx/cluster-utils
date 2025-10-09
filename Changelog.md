# Changelog

## [3.0.0] - 2025-10-08
### Added
- 🐴 ASCII donkey mascot with colorized welcome message
- Auto-updating k6 load testing tool (fetches latest version)
- Zsh as default shell with Oh My Zsh configuration
- Multi-shell auto-switching capability

### Changed
- **BREAKING**: Converted from Job to Deployment for continuous operation
- Replaced vegeta with k6 for modern load testing
- Optimized Docker layers for smaller image size (~220MB)
- Enhanced README with comprehensive usage examples

### Removed
- All timeout configurations (RUNTIME env, ttlSecondsAfterFinished)
- MongoDB tools (reduced bloat)
- Separate kickstart.sh script (consolidated into Dockerfile)