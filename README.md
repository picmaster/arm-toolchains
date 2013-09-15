arm-toolchains
==============

This is a set of shell scripts for creating standalone cross-toolchain for different ARM-based CPUs.

Several important things were achieved:
- You can build/install the toolchain without having root privileges. This reduces the risk of running malicious or
  buggy shell scripts (which can delete all your local & remote filesystems by mistake). This also allows you to do
  embedded development on a machine where you don't have administrative privileges;
- You can rebuild/reinstall the toolchains at will, and they won't pollute your system directory tree;
- Multiple users can have multiple toolchains at the same time;
- The scripts are simple & straightforward, so feel free to experiment with them and achieve the best results for you.

These scripts were uploaded just because I've used them at some point and don't want to loose them on the hard-drive.
They are not revolutionary, as all of the information for cross-compilation was found on the Internet. Lots of people
had contributed to this knowledge, and I won't be able to list and thank them all without missing someone.
