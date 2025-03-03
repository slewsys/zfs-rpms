# Build ZFS point-release RPMs

Basic usage:

```
./autogen.sh
mkdir build
cd build
../configure
make rpms
make install-rpms
```

By default, RPMs are built from *HEAD* of branch *master*. To apply
pull requests, say *NFSv4 style ZFS ACL support*, replace `make rpms` with:

```
make rpms PRS=16967
```

where 16967 is the pull request number. The command
```
make rpms PRS=X,Y,Z
```
can be run multiple times.  Each time, new pull requests are
applied on top of previous ones.

To build RPMs from branch *zfs-2.3.1-staging* (tagged *zfs-2.3.0*) with pull request *zfs-2.3.1-patchset*
(PR #17097) applied, replace `../configure` and `make rpms` above with:

```
../configure ZFS_BRANCH=zfs-2.3.1-staging ZFS_TAG=zfs-2.3.0
make rpms PRS=17097
```
