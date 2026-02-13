# phisch's MAC dotfiles

These are the dotfiles for my M4 Mac Mini. It has a DAS connected to it, and acts as a NAS. This documentation is just for myself.

## Preparing the MAC

Before running the setup script, you need to prepare the Mac for it by configuring a few things that are necessary for it to run successfully.

### Allow third-party kernel extensions

OpenZFS requires lowering system security settings to allow third-party kernel extensions (kexts).

1) **Shut down** the Mac
2) Press and **hold the power button** until you see **"Loading startup options"**
3) Select **Options**, then click **Continue**
4) If prompted, select a user and enter the administrator password
5) In the menu bar, go **Utilities -> Startup Security Utility**
6) Select your system drive (e.g. "Macintosh HD")
7) Click **Security Policy**
8) Select **Reduced Security**
9) Check the box **"Allow user management of kernel extensions from identified developers"**
10) Click **OK** and **Restart** the Mac

### Allow full disk access for Terminal

The setup script enables remote login via SSH, this requires **Full Disk Access**, to allow this:

1) Open **System Settings**
2) Navigate to Privacy & Security -> Full Disk Access
3) Click on **+**, then navigate to and select **Applications -> Utilities -> Terminal**

## Updates

I do not want MacOS to automatically update and restart. The only updates I want to happen automatically are background security updates. For that:

1) Go to `System Settings -> General -> Software update`
2) Click on the `i` next to `Automatic Updates`
3) Enable `Download new updates when available`
4) Disable `Install macOS updates`
5) Enable `Install system data files and security updates`

### Manual updates

Some updates require a reboot, so lets pre-authenticate the next reboot using:

```
sudo fdesetup authrestart -delayminutes -1
```

After which macOS can be updated using:

```
sudo softwareupdate --install --all --restart
```
