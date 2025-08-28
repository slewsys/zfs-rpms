# Build OpenZFS Development RPMs With PRs on Fedora

These scripts automate OpenZFS development builds on Fedora, including
generating and enrolling a Machine Owner Key (MOK) on Secure Boot
systems. OpenZFS pull requests can be applied from any development
branch. By default, RPMs are built from *HEAD* of branch *master*.

Basic usage:

```
./autogen.sh
mkdir build
cd build
../configure
make rpms
```

If commands or packages are reported missing, they can be installed by
running the script `install-dependencies` with root privileges, e.g.:

```
sudo ./install-dependencies
```

If Secure Boot is enabled and it's reported that a Machine Owner Key
(MOK) has not been enrolled for Dynamic Kernel Module Support (DKMS),
then a key can be generated and installed by running the script
`enroll-mok` with root privileges, e.g.:

```
sudo ./enroll-mok
```

To apply pull requests, say PR #16967 *NFSv4 style ZFS ACL support*,
replace `make rpms` above with:

```
make rpms PRS=16967
```

A comma-separated list of PRs can be specified.  Furthermore, the command:

```
make rpms PRS=X,Y,Z
```

can be run multiple times.  Each time, new pull requests are
applied on top of previous ones.

## Examples
To build RPMs from branch *zfs-2.3-release* with PR #17656 *zfs-2.3.4 patchset*
applied, replace `../configure` and `make rpms` above with:

```
../configure ZFS_BRANCH=zfs-2.3-release
make rpms PRS=17656
```

To add pull request #16967 to the previous build, run:

```
make rpms PRS=16967
```

Since PR #16967 was created against the **main** branch, a warning is
issued and confirmation is requested.

The main script, `zfs-rpms`
