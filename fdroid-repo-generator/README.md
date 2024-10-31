# F-Droid Repo Generator

Note: There is also an [official F-Droid image](https://gitlab.com/fdroid/docker-executable-fdroidserver).

I choose to write my own generator as:
* The official image is quite big (~2.5GB) and brings a lot of not required packages
* It's outdated and fails to process [certain APKs](https://gitlab.com/fdroid/fdroidserver/-/issues/1232)
