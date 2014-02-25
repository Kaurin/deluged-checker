deluged-checker
===============

# Info
A script that keeps deluged in check, and sends out notifications regarding deluged health.

I've made it for personal use, because deluged would, on occasion, just die. Devs at deluge explained that this happens because of a libtorrent bug on my distro (Debian Wheezy). Regardless, if you need to be sure that your deluged is up and running, this script might just be for you.

It's not very big, and is easily editable for your own needs. I've tried to comment it as much as possible.

# Licence
Do whatever you want :)

# What it does
Checks if deluged is working via pid, and processlist. If not, it will be turned on, and an e-mail notification will be sent. There is a control variable for keeping deluged off. I've put it there because I don't always want deluged running, and I prefer not to edit the crontab :)

# Usage
Edit the script in your favorite text editor. Editable variables are on the top.

The script is best used via cron, for periodic checkups.

