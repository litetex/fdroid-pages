# fdroid-pages

Showcases how it's possible to provide an [F-Droid repo](https://f-droid.org/en/docs/Setup_an_F-Droid_App_Repo/) on a static site hosting service like GitHub Pages.

It currently is configured to contain [NewPipe-nightly](https://github.com/TeamNewPipe/NewPipe-nightly) and [NewPipe-refactor-nightly](https://github.com/TeamNewPipe/NewPipe-refactor-nightly).

Open https://litetex.github.io/fdroid-pages for a live demo.

## Initial setup

> [!IMPORTANT]
> If you want to [create your own repo](https://f-droid.org/en/docs/Setup_an_F-Droid_App_Repo/) and use this repo as a base, make sure to remove/customize all assets like images, links and names!

You need a few secrets that are used for verifying the repo.

To generate these you have to run the ``fdroid-repo-generator``-Docker image offline.

0. Ensure that you have Docker installed
1. Checkout the repo and open in your terminal
2. Select the directory [``fdroid-repo-generator``](./fdroid-repo-generator) using ``cd fdroid-repo-generator``
3. Build the image offline: ``docker build --tag fdroid-repo-generator .`` (the dot at the end is important)
4. Launch the container ``docker run --rm -it --entrypoint=/bin/bash -v %cd%/temp-repo:/repo -w /repo fdroid-repo-generator``
    * This will create a new directory ``temp-repo``, if this is already present you may need to clean it
    * After the container is launched a console should be visible
5. Execute ``fdroid init`` to initialize the repo
6. When this is done exit the container with typing ``exit``

You now should have a fresh F-Droid repo initialized in ``temp-repo``.

Now we need to get the following secrets and store them in GitHub Action secrets:

| What? | Secret name | Notes |
| --- | --- | --- |
| ``keystore.p12`` | ``KEYSTORE_BASE64`` | Needs to be converted to base64.<br/>Easiest way: ``cat keystore.p12 \| base64 > keystore_b64.txt`` |
| ``config.yml``→``repo_keyalias`` | ``REPO_KEYALIAS`` | |
| ``config.yml``→``keystorepass`` or ``keypass`` (identical) | ``KEYPASS`` | ``keystorepass`` and ``keypass`` are usually identical |
| ``config.yml``→``keydname`` | ``KEYDNAME`` | |

## Updating
Updates are checked for every night [using GitHub Actions](./.github/workflows/update.yml).
If an update is found, the repo is rebuilt.

## Mirroring
This example uses mirroring to [Codeberg](https://codeberg.org/litetex/fdroid-pages).

The mirrored Codeberg site is available at: https://litetex.codeberg.page/fdroid-pages

## Similar projects
* https://gitlab.com/julianfairfax/fdroid-repo
* https://github.com/breezy-weather/fdroid-repo
