# libretro-snapshots

Following [libretro getting hacked, with the attacker deleting some of the repositories](https://www.libretro.com/index.php/hacker-vandalised-our-buildbot-and-github-organization/)

This repository pushes [releases of github.com/retrolib](https://github.com/chauffer/libretro-snapshots/releases) Git repositories twice a day.

Should you need to restore a repository, you can untar its latest release, it will contain a [bare Git repository](#).

## Notes

- The repository [libretro-thumbnails](https://github.com/retrolib/libretro-thumbnails) is ignored as it's 16GB and seems unused.
- Feel free to fork this project and run it for your organization, although it should not replace regular verified backups, I personally like [restic](https://restic.net/) or [stash](https://github.com/stashed/stash).
- Let me know if you end up using this, so I can add you to this readme.

## Running it yourself
- Add `GITHUB_TOKEN` to GitHub Actions secret with only read public repo and user read permissions
- Create `.github/workflow/workflow.yml` containing:

```
# change the name to whatever you want
name: Backup libretro organization
on:
  push:
  schedule:
    - cron: "15 0,12 * * *"
jobs:
  libretro-snapshots:
    runs-on: ubuntu-latest
    needs: dockerhub
    container:
      image: chauffer/libretro-snapshots
      env:
        GITHUB_TOKEN: "${{ secrets.GITHUB_TOKEN }}"
        ORGANIZATION: "<the-org-you-wanna-backup>"
        REPO: "<the-repo-you-wanna-push-releases-to>"
    steps:
      - name: run
        run: /app/run.sh
```
