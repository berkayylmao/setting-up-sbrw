# So you want to host an SBRW server?

You better buckle up, because this thing is as tedious as they get. This entire guide will focus on a Windows installation, although it shouldn't be any more difficult for a *nix user to follow.

## *Step 0.* Foreshadowing

You should set this whole thing up in a VPS, but your computer at home will do just fine as well. A VPS will offer the ability of hosting this 24/7 and being able to handle many concurrent users, probably better server performance and a much better data security.

So you have two options from the get-go:

 - Rent a VPS. Really the better option in all cases, but may cost you $6-50USD each month. For around 50-100 concurrent users, at least 6GBs of RAM is advised. Dormant memory footprint of the server and all its dependencies is around 2GBs.

- Use your computer and your own internet connection. You will need a stable, and preferably fast, internet connection and above OK specs to be able to host the server reliably. If you intend to use the server to play with some friends every now and then, LAN or otherwise, this option is the best.

After you decide on that, you need to know that in this guide, you'll be required to download over 500MBs of source code and probably almost as much of applications. If you already have a VPS, follow the guide from within that.

## *Step 1.* Setting up the environment

### Get Git

You'll want to grab a Git shell first. [This one](https://git-scm.com/download/win) is pretty popular and the one used in this guide as well. The installation offers *many* options, so just don't touch anything you don't know about. The default options work just fine. Just make sure to have Git add to `PATH`, like here:
![Imgur](https://i.imgur.com/0iKcd5e.png)

### Set up project base

Next, find which one of your hard drives have the most space; you'll need at least 2 gigabytes of it. Now open up [`Command Prompt`](https://www.howtogeek.com/235101/10-ways-to-open-the-command-prompt-in-windows-10/) and switch to that drive. So if it's driver `D:`, just type in `D:`.

![Imgur](https://i.imgur.com/7Cix7pu.png)

Create a folder somewhere in that drive and copy its path, now do `cd [space] [your path]` in the command prompt. For example, `cd D:\Somewhere\Elsewhere`

### Get the code

Time to get all them codes! Execute these commands on the command prompt (you can copy+paste them). The order is irrelevant and you can open multiple command prompts to have them all done at once, just make sure to `cd` into the directory you created previously.

 - `git clone https://github.com/SoapboxRaceWorld/soapbox-race-core`
 - `git clone https://github.com/VladManyanov/sbrw-mp-sync-2018`
 - `git clone https://github.com/WorldUnitedNFS/freeroam`
 - `git clone https://github.com/SoapboxRaceWorld/openfire`
 - `git clone https://github.com/igniterealtime/openfire-nonSaslAuthentication-plugin`
 - `git clone https://github.com/SoapboxRaceWorld/openfire-restAPI-plugin`
 - `git clone https://github.com/berkayylmao/setting-up-sbrw`

### Install and configure the necessary applications

You now have the code, but you'll need applications to make use of them. The following are merely suggestions, but are used in this guide, tested thoroughly and practically work out-of-the-box.

 - A database service: [MySQL](https://dev.mysql.com/downloads/installer/)
	 - Select `Custom` for the setup type and only pick the following (the versions should match, in my case they are all version `8.0.23`):
![Imgur](https://i.imgur.com/Pk6tHxy.png)

	 - Select `Development Computer` if you're installing MySQL on your home computer, `Server Computer` otherwise.
![Imgur](https://i.imgur.com/Y9Hrvix.png)

	 - Uncheck `Open Windows Firewall ports for network access`.
![Imgur](https://i.imgur.com/lc8qlIb.png)

	 - Just click `Next` here.	![Imgur](https://i.imgur.com/XRBWVx8.png)

	 - Pick a nice password for the root user here and make sure to save it somewhere and have backups of it as well. I recommend using [this](https://passwordsgenerator.net/?length=24&symbols=1&numbers=1&lowercase=1&uppercase=1&similar=0&ambiguous=0&client=1&autoselect=0) to generate passwords (you'll need to do more of this later).
![Imgur](https://i.imgur.com/z0Ihdc5.png)

	- Then keep clicking `Next` until the installation finishes.

	- MySQL Workbench will open, just click on the `Local instance` connection.
![Imgur](https://i.imgur.com/QfbEER1.png)

	- Click on `File->Open SQL Script`
![Imgur](https://i.imgur.com/RbwMqVW.png)

	- Go to the folder where you downloaded all the code. Open the three scripts inside `setting-up-sbrw/Files/MySQL scripts`.
![Imgur](https://i.imgur.com/l8ECMWP.png)

	- Switch to `1. Base`'s tab and change the 2 passwords, preferably generating them from the link before.
![Imgur](https://i.imgur.com/7aHDl86.png)

	- Execute them in the displayed order (1. -> 2. -> 3.). To execute one of them, just select its tab and click on `Query->Execute (All or Selection)`. 
![Imgur](https://i.imgur.com/OhSyIdY.png)

	- Minimize `MySQL Workbench`. We'll come back to it later.

 - JDK10: [AdaptOpenJDK10](https://github.com/AdoptOpenJDK/openjdk10-binaries/releases/download/jdk-10.0.2%2B13.1/OpenJDK10U-jdk_x64_windows_hotspot_10.0.2_13.zip)
	- Preferably extract this to C:\AdaptOpenJDK10.
![Imgur](https://i.imgur.com/ZbdBjGX.png)

	- [Set a user environment variable](https://www.architectryan.com/2018/08/31/how-to-change-environment-variables-on-windows-10/) named `JAVA_HOME` and set its value to `C:\AdaptOpenJDK10`.

	- [Edit the user or system PATH environment variable](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/) and add the folder `C:\AdaptOpenJDK10\bin`.

 - Maven: [Apache Maven](https://ftp.itu.edu.tr/Mirror/Apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip)
	- Preferably extract this to C:\ApacheMaven.
![Imgur](https://i.imgur.com/A4xAO6i.png)

	- [Edit the user or system PATH environment variable](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/) and add the folder `C:\ApacheMaven\bin`.

 - GoLang: [GoLang](https://golang.org/dl/)
	- Preferably install this to C:\Go.

## *Step 2.* Compiling the code

- Go to the folder where you downloaded all the code. Run `setting-up-sbrw/Files/build-script.bat`.
![Imgur](https://i.imgur.com/ZZSOC6V.png)

- This script should work fine if you followed all of the steps correctly. It has no error checking itself, so keep your eyes on the window to see if something goes wrong. **!! DO NOT CONTINUE TO THE NEXT STEP IF YOU SEE ANY ERRORS !!**

## *Step 3.* Setting up Openfire

- Go to the folder where you downloaded all the code. Run `setting-up-sbrw/Files/start-sbrw.bat`.
![Imgur](https://i.imgur.com/ypfHDxl.png)

- There will be errors and the core server can close itself at this time, this is okay.

- Open your favourite browser and navigate to `http://localhost:9090/setup/index.jsp`. My setup and Openfire pages can look visually different, e.g. the Openfire version at the top-right, but you should be able to follow this 1:1.

- Select a language and click `Continue`.
![Imgur](https://i.imgur.com/bJJc9yT.png)

- Change the `XMPP Domain Name` and `Server Host Name` to your IP address. The IP address should be in the IPv4 format, e.g., `xxx.xxx.xxx.xxx`. Afterwards, click `Continue`.
	- If you're on a VPS, this is your remote connection IP.
	- If you're doing this from your home computer and want to host this server worldwide, enter your public IP. (Google this if you don't know it.)
	- If you're doing this from your home computer and want to use this server for LAN play, enter your computer's local IP. (Google this if you don't know it.)
	- **Note down the IP address you enter here, you'll need it later.**

![Imgur](https://i.imgur.com/xaf51Hm.png)

- Select `Standard Database Connection` and click `Continue`.
![Imgur](https://i.imgur.com/JqLLEfs.png)

- Pick the MySQL driver preset.
![Imgur](https://i.imgur.com/sl8tx4g.png)

- Change the `Database URL` to `jdbc:mysql://localhost:3306/OPENFIRE?rewriteBatchedStatements=true&characterEncoding=UTF-8&characterSetResults=UTF-8&serverTimezone=UTC`.
![Imgur](https://i.imgur.com/JIk1q0R.png)

- Enter `openfire` as the `Username` and the password you chose for the openfire user back in the `1. Base` MySQL script as the `Password`.
![Imgur](https://i.imgur.com/wBvP5j3.png)

- Select `Default` and click `Continue`.
![Imgur](https://i.imgur.com/xbfWC9L.png)

- Enter an e-mail address that belongs to you and pick a password for the Openfire panel. Click `Continue`.
![Imgur](https://i.imgur.com/ehuxtqb.png)

- Click `Login to the admin console`.
![Imgur](https://i.imgur.com/pTsTl8i.png)

- Enter `admin` as the username and the password you just picked as the password. 
![Imgur](https://i.imgur.com/jp8OmEq.png)

- Go to `Server Settings->Registration & Login` and disable `Inband Account Registration`. Click `Save Settings`.
![Imgur](https://i.imgur.com/ykG7bW6.png)

- Go to `Server Settings->Compression Settings` and set both settings to `Not Available`. Click `Save Settings`.
![Imgur](https://i.imgur.com/olOZY22.png)

- Go to `Server Settings->REST API (SBRW)` and set it to `Enabled`. Pick the `Secret key auth` option and note down the `Secret key` (this is unique already, so you don't need to change it). Click `Save Settings`.
![Imgur](https://i.imgur.com/yDsEOBz.png)

- That's it for the Openfire panel configuration.

## *Step 4.* Finalizing server configuration

- Close all of the command prompt windows that are open.

- Make sure no Java process is left hanging.
	- You can do this by opening the `Task Manager`, going to the `Details` tab and killing all `java.exe`/`javaw.exe` processes.
![Imgur](https://i.imgur.com/Ya3toPG.png)

- Open the `MySQL Workbench` that you minimized before.

	- Right-click on an empty space in the `Schemas` panel. Click on `Refresh All`.
![Imgur](https://i.imgur.com/vZ61E2O.png)

	- Open the `soapbox->Tables` and select the `parameter` table. Click on the rightmost icon with a lighting bolt on it.
![Imgur](https://i.imgur.com/jLCQJ3q.png)

	- Double-click on `ENABLE_REDIS`' value and change it to `false`.
![Imgur](https://i.imgur.com/I5ZbmdV.png)

	- Scroll down and find `OPENFIRE_TOKEN`. Double click on its value and change it to the `secret key` you noted down (from the Rest API section in Openfire).
![Imgur](https://i.imgur.com/eoDpPJW.png)

	- Scroll down and find `SERVER_ADDRESS`. Double click on its value and change it to the the IP address you noted down back in the Openfire setup in this format: `http://THE_IP_ADDRESS_HERE`.
![Imgur](https://i.imgur.com/nCNbVUD.png)

	- Scroll down to the bottom. Change the value of `UDP_FREEROAM_IP`, `UDP_RACE_IP` and `XMPP_IP` to the IP address you noted down back in the Openfire setup.
![Imgur](https://i.imgur.com/LtcGDA6.png)

	- Click on `Apply`, then `Apply` again.
![Imgur](https://i.imgur.com/4TXRdBK.png)

	- Click on `Finish` and close `MySQL Workbench`.
![Imgur](https://i.imgur.com/bJuXaei.png)

- Go to the folder where you downloaded all the code. Open `setting-up-sbrw/Files/sbrw/core/project-defaults.yml` in a text editor, I recommend [Notepad++](https://notepad-plus-plus.org/downloads/). If you don't want to install any more things, you can use WordPad.
	- Change the value of `password` (by default, `secret`) to the password you chose for the soapbox user back in the `1. Base` MySQL script.
![Imgur](https://i.imgur.com/j9lyUgq.png)
	-	Save and exit.

- Open `Windows Firewall with Advanced Security`.
![Imgur](https://i.imgur.com/n6kf5OR.png)
	
	- Select `Inbound Rules` and then click on `New Rule...` on the right panel.
![Imgur](https://i.imgur.com/l0nRT3K.png)

	- Select `Port`. Click `Next`.


	- Select `TCP`, enter `80, 8080, 5222` as the ports. Click `Next`.
![Imgur](https://i.imgur.com/volRAOY.png)

	-	Select `Allow the connection`. Click `Next`.
![Imgur](https://i.imgur.com/HXxbMYF.png)

	-	Select all of the three options. Click `Next`.
![Imgur](https://i.imgur.com/eEaymlN.png)

	-	Give the rule a unique name and click `Finish`.
![Imgur](https://i.imgur.com/7x5hvpp.png)

	-	Repeat the same steps, but this time select `UDP` and enter `9998, 9999` as the ports.
	-	Repeat the same steps in `Outbound Rules` (for TCP and UDP).

## *Step 5.* Running the server

All that's left now is to run it. Go to the folder where you downloaded all the code. Run `setting-up-sbrw/Files/start-sbrw.bat`.
![Imgur](https://i.imgur.com/ypfHDxl.png)

If you did everything correctly *and no breaking changes happened in SBRW after this guide was written*, the server will start without any errors. You'll know if it ran successfully by seeing the statement `Thorntail is Ready` on the core server's console window.

![Imgur](https://i.imgur.com/WV5M8nK.png)

## *Step 6.* Connecting to the server

- Open the [SBRW Launcher](https://github.com/SoapboxRaceWorld/GameLauncher_NFSW/releases/latest).

- Click on the `+` button at the top-right.
![Imgur](https://i.imgur.com/abLovtB.png)

- Add your server information in this format:
![Imgur](https://i.imgur.com/Nw6Yleq.png)

- Click `OK`. Restart the launcher, select your server from the list, register, login and play!

## Known issues

- The scripts `build-script.bat` and `start-sbrw.bat` won't work if you install anything to a path different than what is advised in this guide. Their goal is to help you build the code, they depend on those paths.

- Powerups, events or anything related to multiplayer will not work by default. This is partly caused by the current SBRW team relying on their mod framework `ModNet` to do it instead of adding the necessary code to the core server itself. To get a very basic ModNet setup for your server:

	- You need to host an http server on port 80.

	- The server should have an `index.json` in its root folder with the following format:
	```json
	{
		"built_at": "2021-02-28T23:01:24.394847+03:00",
		"entries": []
	}
	```
	- You need to add the entries `MODDING_BASE_PATH (value: same as SERVER_ADDRESS)`, `MODDING_ENABLED (value: true)`, `MODDING_FEATURES (value: "")`, `MODDING_SERVER_ID (value: a unique name for your server, it won't be visible to the public)` to the `parameter` table in the `MySQL->soapbox` database.

## More information

**Note: This is a very basic setup of the SBRW server.** I only had the time to cover this much of it. 

If you encounter any issues, please open report it [here](https://github.com/berkayylmao/setting-up-sbrw/issues) for the community to discuss. Give as much detail as possible.

Any and all PRs are welcome.

## Disclaimer

I wrote this guide only to help people who didn't even know what to do with the code. I offer no support, so **please do not contact me asking for help/support**.