### 1. Install Kanata (v1.6.1)
       https://github.com/jtroo/kanata/releases/tag/v1.6.1

### 2. Copy the service file to system-wide
        ```bash
        mkdir etc/kanata
        sudo ln -s kanata/kanata.service /etc/kanata/kanata.service
        ```

### 3. Create the service
        ```bash
        sudo install -m 644 /etc/kanata/kanata.service /lib/systemd/system/kanata.service
        ```

### NOTES:
    - Commands to reload the service after making changes to config

    ``` bash
        systemctl daemon-reload
        sudo systemctl restart kanata
    ```
