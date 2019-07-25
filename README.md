# Run the code
## Load the code
```
sudo ip link set dev {interface} xdpgeneric obj progname.o sec xdp_drop
```

## Unload the code
```
sudo ip link set dev {interface} xdpgeneric off
```


# Compile the code
## Dependency

### Archlinux
```
pacman -S kernel-headers clang llvm
```
