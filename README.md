# 7MinSecWikiScripts

Scripts to accompany the [7MinSec.wiki](https://7minsec.wiki) project.

These scripts are developed and tested elsewhere, then copied here when a major
update is ready. They're meant to be readable and re-runnable - many of them back
a wiki article, so you can copy/paste with confidence.

## Layout

| Directory | What lives here |
|-----------|-----------------|
| [`labs/`](labs/) | Deploy and configure lab/practice environments (e.g. GOAD, AD targets). |
| [`dropboxes/`](dropboxes/) | Automate deploying Proxmox VMs used as pentest dropboxes (e.g. Exegol). |
| [`maintenance/`](maintenance/) | System upkeep - updates, cleanup, backups, snapshots. |
| [`pentesting/`](pentesting/) | Offensive tooling and helpers used during engagements. |

## Scripts

| Script | Purpose | Wiki |
|--------|---------|------|
| [`dropboxes/install-exegol.sh`](dropboxes/install-exegol.sh) | One-shot [Exegol](https://exegol.com) installer for Kali. | [7minsec.wiki/software/exegol](https://7minsec.wiki/software/exegol/) |
| [`pentesting/Nessus_SortyMcSortleton.ps1`](pentesting/Nessus_SortyMcSortleton.ps1) | Turn a raw Nessus CSV export into a deduplicated, severity-sorted, color-coded Excel report. | [7minsec.wiki/software/nessus](https://7minsec.wiki/software/nessus/) |
| [`pentesting/hashcrack.ps1`](pentesting/hashcrack.ps1) | Hand-it-to-anyone hashcat bootstrapper + pausable cracking runner for Windows. | [7minsec.wiki/pentesting/internal/hashcat](https://7minsec.wiki/pentesting/internal/hashcat/) |
| [`pentesting/install-nessus.sh`](pentesting/install-nessus.sh) | Fast one-shot installer: fetch the latest Nessus `.deb` from Tenable and install it (Debian/Kali/Ubuntu). | [7minsec.wiki/software/nessus](https://7minsec.wiki/software/nessus/) |
| [`pentesting/nessus-setup.sh`](pentesting/nessus-setup.sh) | Menu-driven Nessus lifecycle helper: install, register, add admin user, restart, logs. | [7minsec.wiki/software/nessus](https://7minsec.wiki/software/nessus/) |
