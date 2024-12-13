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

By default, RPMs are built from the latest tag of the latest branch,
e.g., tag zfs-2.3.0-rc4 of branch zfs-2.3-release.  To apply pull
requests, say *rc5*, replace `make rpms` with:

```
make rpms PRS=16875
```

where 16875 is the number of the *rc5* pull request. The command
```
make rpms PRS=X,Y,Z
```
can be run multiple times.  Each time, new pull requests are
applied on top of previous ones.

To build RPMs from, say, the HEAD of the master branch, replace `../configure` above with:

```
../configure ZFS_BRANCH=master ZFS_TAG=HEAD
```

To later sync against upstream master, use:

```
make rpms FORCE=
```
