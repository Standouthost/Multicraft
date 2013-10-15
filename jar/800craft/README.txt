Thank you for downloading 800Craft, a custom Minecraft server based on fCraft.

Special thanks to fragmer, what a bro!


=== Installation (Windows) ====================================================

800Craft requires Microsoft .NET Framework 4.0. Your system may already have it
installed, and you can download it from microsoft.com

=== Installation (Linux, Unix, MacOS X) =======================================

800Craft requires Mono 2.10 (recommended). You can
download it from www.mono-project.org, or (on some Linux distributions) install
it through your package manager.

To be able to use graphical 800Craft components (ServerGUI and ConfigGUI) you
will also need GDI+ library (libgdiplus). Before starting 800Craft, make sure
that it has read/write permissions in the 800Craft directory.

To run ".exe" files with Mono, use the following syntax:
Mono 2.6.4: "mono SomeFile.exe"
Mono 2.8+:  "mono --gc=sgen SomeFile.exe"

If you're intending to run a public server that appears on minecraft.net's server list, 
you need to import https certificates to tell mono you trust them, this can be done by 
running mozroots --import --ask-remove as the 800Craft user on your system.

=== Initial Setup =============================================================

Before starting the server for the first time, run ConfigGUI.exe to choose
your server's name and settings.

You may need to add firewall exceptions for 800Craft applications (ConfigGUI,
ServerGUI, or ServerCLI, or ServerWinService) to allow incoming TCP connections
on the listening port. Default port is 25565.

If your server is behind a router, you may also need to set up port forwarding
on the same port. See www.port-forward.com for further guidance.

When you are ready to start the server, run ONE of the available server
front-ends (GUI, CLI, or WinService).

=== Troubleshooting ===========================================================

Server does not show up on minecraft.net list:
    Make sure that server is public. Open ConfigGUI, set Visibility: [Public]
        (or set <IsPublic> to true in config.xml).

"Could not connect to server: it's probably down":
    Make sure that you added firewall exception for 800Craft (if applicable),
    and forwarded the port on your router. If you are connecting from same
    computer that the server is working on, try connecting to:
    https://minecraft.net/classic/play?ip=127.0.0.1&port=____
        (fill in the blank with your server's port number)

"Could not verify player name":
    Verification problems occur when your 800Craft server cannot verify identity
    of connecting players. Here are some things that may cause or fix
    verification problems:
    1. If minecraft.net is offline or slow, wait for it to stabilize.
    2. If minecraft.net is working but you still cant verify name, log out then
        log back in.
    3. Try restarting your server. Wait a couple minutes before trying to
        connect to a newly-restarted server (to give your server time to
        synchronize with minecraft.net).
    4. If you (or your players) are using WoM client's "Resume" function, which
        uses cached verification information, use the proper log-in procedure
        in WoM. The "Resume" function only works as long as your IP does not
        change and as long as the server does not restart.
    5. If you are using WoM and connecting with a bookmark, make sure that the
        bookmarked address starts with "http://minecraft.net/..." and not
        "mc://...". Addresses in the form "mc://" are temporary, and will stop
        working whenever the server is restarted.

Other players cannot connect from the same LAN/network as me:
    Minecraft client has a lot of trouble working on LAN. You probably will not
    be able to connect via the public URL. There is a workaround:

    1. Check "Allow connections from LAN without verification" in ConfigGUI.
        (or set <AllowUnverifiedLAN> to true in config.xml).
    2. Find your local IP address.
        * In Windows XP+, go to Start -> type "cmd" to open a terminal ->
            type "ipconfig". The address you need is labeled "IPv4 Address"
            under "Local Area Connection".
        * In Unix/Linux, use "ifconfig" utility. 
   3. Connect to https://minecraft.net/classic/play?ip=____&port=____
        (fill in the blanks with your server's IP address and port number)



=== List of Files =============================================================

       ConfigGUI.exe - Graphical interface for editing your server's settings,
                       rank setup, and world list. Also includes a map coverter
                       and terrain generator. If you alter configuration while
                       the server is running, use /reloadconfig command to
                       apply the changes. Note that some changes (like changes
                       to the rank list and IRC configuration) require a full
                       server restart.
       ConfigCLI.exe - A simple command-line configuration tool.

          fCraft.dll - Core of the server, used by all other applications.
          fCraftGUI.dll - Provides shared functionality for Config and Server GUI.

       ServerCLI.exe - Command-line interface for the server.
       ServerGUI.exe - Graphical interface for the server.



=== Command-line Options ======================================================

In addition to many settings stored in config.xml, 800Craft has several special
options that can only be set via command-line switches:

    --path=<path>       Working path (directory) that 800Craft should use. If the
                        given path is relative, it's computed against the
                        location of fCraft.dll

    --logpath=<path>    Path (directory) where the log files should be placed.
                        If the given path is relative, it's computed against the
                        working path.

    --mappath=<path>    Path (directory) where the map files should be loaded
                        from/saved to.  If the given path is relative, it's
                        computed against the working path.

    --config=<file>     Path (file) of the configuration file, including the
                        filename (typically "config.xml"). If the given path
                        is relative, it's computed against the working path.

    --norestart         If this flag is present, 800Craft will shutdown whenever
                        it would normally restart (e.g. automatic updates or
                        /restart command). This may be useful if you are using
                        an auto-restart script or a process monitor.

    --exitoncrash       If this flag is present, 800Craft frontends will exit
                        at once in the event of an unrecoverable crash, instead
                        of showing a message and prompting for user input.

    --nolog             If this flag is present, all logging is disabled.

    --nocolor           If this flag is present, ServerCLI will not use any
                        colors or formatting in its console output.



=== Help & Support ============================================================

When you first join the server, promote yourself by typing...
    /rank YourNameHere owner
...in the server's console. Replace "owner" if you renamed your highest rank.

Type "/help" in-game or in server console to get started. Type "/commands" for
a list of available commands. 

To request features, report bugs, or receive support, please visit:
    http://au70.net



=== Licensing =================================================================

800Craft code and binaries are covered by the GPLv3 license, and distributed using both licences.

The 800Craft HeartBeatSaver is Copyright (C) <2011, 2012> Jon Baker 
and is ONLY to be distributed with copies of 800Craft.

800Craft's license:
Copyright (C) <2012> <Jon Baker, Glenn Mari�n and Lao Tszy>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.


fCraft code and binaries are
licensed and distributed under the permissive MIT License, reproduced here:

----
Copyright 2009, 2010, 2011, 2012 Matvei Stefarov <me@matvei.org>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
----

If you create 800Craft plugins that do not include any substantial portions of
fCraft's original code or 800Craft's code, they belong to you and you are free to do absolutely
anything with them. However, if you would like to distribute whole modified
copies of 800Craft, please follow the MIT and the GPLv3 License terms.

Original Minecraft was developed by Markus "Notch" Petersson of Mojang, and is 
not affiliated with fCraft in any way. fCraft does not use any code, assets,
or any other files from Minecraft... neither does 800Craft.



=== Credits ===================================================================

800Craft was developed by Jonty800, GlennMR and LaoTszy.

Thanks again to fragmer, what a bro.

Thanks to 800Craft code contributers:
    Rebelliousdude, boblol0909, WaterGod469 and Maicke98 for trying. 

With testing from Pure2K12, LeChosenOne and Xanderortiz.

And suggestions from Project-Vanilla and the Au70 Community

Thanks to Minecraft servers that helped test and improve 800Craft:
    Au70 Galaxy, Project Vanilla and [AWESOME+PROTECTED] Xander Ortiz

Thanks to fCraft code contributors and modders:
    Asiekierka, Dag10, Destroyer, FontPeg, M1_Abrams, Optical-Lza,
    Redshift, SystemX17, TkTech, Wootalyzer

Thanks to people who supported fCraft development through donations:
    800Craft.net community, Astelyn, D3M0N, Destoned, DreamPhreak, Pandorum,
    Redshift, TkTech, ven000m,  wtfmejt, Team9000 and SpecialAttack.net
    communities, and others who donated anonymously

Thanks to people whose code has been ported to fCraft:
    Dudecon (Forester), Osici (Omen), vLK (MinerCPP), Tim Van Wassenhove,
    Paul Bourke

Thanks to Minecraft servers that helped test and improve fCraft:
    TheOne's Zombie Survival, SpecialAttack.net Freebuild, Team9000 Freebuild,
    D3M0Ns FreeBuild, ~The Best Freebuild 24/7~, 800Craft Freebuild Official

Thanks to people who submitted bug reports and feature requests:
    Astelyn, Clhdrums87, Darklight, David00143, Dogwatch, Epiclolwut, Fehzor,
    Gamma-Metroid, Hellenion, Sunfall, maintrain97, Mavinstar, Unison,
    and all others.

Special thanks for inspiration and suggestions:
    CO2, Descension, ElectricFuzzball, Exe, Hearty0, iKJames, LG_Legacy,
    PyroPyro, Revenant, Varriount, Voziv, Zaneo, #mcc on Esper.net,
    HyveBuild/iCraft team, MinerCPP team, OpenCraft team

And thank You for using 800Craft!