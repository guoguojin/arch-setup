# Computer setup steps for Arch based systems

1. Use installer to install base system, I would recommend either the Endeavour OS, or ArcoLinuXS installer for a minimal desktop install
2. Run all updates to bring system up to date

    ```bash
    yay -Syyu
    ```

3. Copy SSH keys and configs from your secure source to `$HOME/.ssh`
4. Execute installation scripts relevant to the machine you're installing from the scripts folder.
