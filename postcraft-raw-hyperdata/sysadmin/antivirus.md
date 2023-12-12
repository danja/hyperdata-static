# Malware on Linux

I've being using Linux for about 25 years, has been my main OS for the last 20 (nowadays Ubuntu on office & music room desktops, a fairly knackered laptop I only really use for TV/vids and a remote virtual server I use for my Web presence & experiments). This last week, for the first time, I've had to run antivirus scans.

My server appeared to be down while I was visiting the UK. Found my service provider (Linode) had blocked net access. I assumed this was the result of my last bit of play, in which I inadvertently hammered the bandwidth (trying Ollama on it). Back home, I've since discovered the actual problem.

Apparently my server had been used in a brute-force password attack attempt, hitting someone's port 22.

Linode support have been excellent and their online docs are good-enough for someone with a little server admin experience.

## My Fixing

Sooo... key tool is clamav malware scanner, which is in the main distros. This was runnable on the virtual host by booting into Rescue Mode (based on Finnix distro - new to me, looks useful for this kind of situation). But I soon hit snags. My server only has a cheapskate's 2GB RAM, 512MB swap partition. When I tried a recursive scan from / it soon crashed, out of memory. So then I went up a dir, scanning /var /home etc. one at a time.

But the stuff on the server is seriously disorganised, including tar.gz backups dumped all over the place. clamav works by comparing a few million malware signatures with file contents. Which is fine for normal files, but not big tar.gz files. Of course I hadn't named them sensibly, so I had to nosey inside to see if there was anything important.

DO SCAN OF USR etc

NGINX

my script

other tool

Daniel LastPass
Wordpress hack mysqladmin?

https://linode.abusehq.net/share/oysJCBLLcO6anmRXi2GX4ZwrS1yJkK584UkMEblpTMg6DZaRs4Io06oT5-WO4U4Si5Yg1O3-frkHJs6afgDbuA
