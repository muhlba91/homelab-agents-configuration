# Homelab: Agents/Assistants - Configuration

[![](https://img.shields.io/github/license/muhlba91/homelab-agents-configuration?style=for-the-badge)](LICENSE.md)
[![](https://img.shields.io/github/actions/workflow/status/muhlba91/homelab-agents-configuration/verify.yml?style=for-the-badge)](https://github.com/muhlba91/homelab-agents-configuration/actions/workflows/verify.yml)
[![](https://api.scorecard.dev/projects/github.com/muhlba91/homelab-agents-configuration/badge?style=for-the-badge)](https://scorecard.dev/viewer/?uri=github.com/muhlba91/homelab-agents-configuration)

This repository contains configuration files and lifecycle scripts for personal agents and assistants.

---

## Configuration

Each agent or assistant has its own directory under [`agents`](agents/), which contains all necessary configuration files.

## Lifecycle Scripts

Each agent or assistant has a set of lifecycle scripts that can be used to manage its configuration and data.

At least a `sync.sh` script must be provided in the `<agent>/lifecycle/` directory, which is responsible for synchronizing the agent's configuration and data.

---

## Agents and Assistants

The following agents and assistants are currently configured:

- [OpsBot](agents/opsbot/): A [PicoClaw](https://github.com/sipeed/picoclaw) agent that supports in managing the homelab infrastructure, providing insights and automating routine tasks.
