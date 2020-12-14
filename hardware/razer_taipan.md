# Getting the Razer Taipan middle mouse button (scroll wheel click) to work on Xubuntu 18.04:

```
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt update
sudo apt install razercfg qrazercfg
qrazercfg 
```

- Uncheck "LED" options
- Set `X Scan Resolution` to `Scan resolution 25`
- `Razer > Re-apply all hardware settings`

Yaay...
