# 7MinSecWikiScripts

Scripts to accompany the [7MinSec.wiki](https://7minsec.wiki) project.

These scripts are developed and tested elsewhere, then copied here when a major
update is ready. They're meant to be readable and re-runnable — many of them back
a wiki article, so you can copy/paste with confidence.

## Layout

| Directory | What lives here |
|-----------|-----------------|
| [`labs/`](labs/) | Deploy and configure lab/practice environments (e.g. Exegol, GOAD, AD targets). |
| [`dropboxes/`](dropboxes/) | Automate deploying Proxmox VMs used as pentest dropboxes. |
| [`maintenance/`](maintenance/) | System upkeep — updates, cleanup, backups, snapshots. |
| [`pentesting/`](pentesting/) | Offensive tooling and helpers used during engagements. |

## Scripts

| Script | Purpose | Wiki |
|--------|---------|------|
| [`labs/install-exegol.sh`](labs/install-exegol.sh) | One-shot [Exegol](https://exegol.com) installer for Kali. | [7minsec.wiki/software/exegol](https://7minsec.wiki/software/exegol/) |
