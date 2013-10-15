Thank you for downloading fCraft, the custom Minecraft server.

If you like fCraft, support its development by donating!
    http://donate.fCraft.net



=== Installation (Windows) ====================================================

fCraft requires Microsoft .NET Framework 3.5. Your system may already have it
installed, and you can download it from microsoft.com
For more information, see http://fCraft.net/wiki/Installation_Instructions



=== Installation (Linux, Unix, MacOS X) =======================================

fCraft requires Mono 2.6.4+ (minumum) or Mono 2.10+ (recommended). You can
download it from www.mono-project.org, or (on some Linux distributions) install
it through your package manager. To be able to use graphical fCraft components
(ServerGUI and ConfigGUI) you will also need GDI+ library (libgdiplus).

Before starting fCraft, make sure that it has read/write permissions in the
fCraft directory. Working directory and other paths can be set via command-
line options (see below).

To run ".exe" files with Mono, use the following syntax:
Mono 2.6.4: "mono SomeFile.exe"
Mono 2.8+:  "mono --gc=sgen SomeFile.exe"

Also check out "fcraftd", unofficial script by Hellenion that makes fCraft
easier to deploy and maintain under Linux: http://fCraft.net/wiki/fcraftd

For more information, see http://fCraft.net/wiki/Installation_Instructions



=== Initial Setup =============================================================

Before starting the server for the first time, run ConfigGUI.exe to choose
your server's name and settings.

By default, fCraft servers are private. That means it will not be listed on
minecraft.net, and only players who have the link will be able to join. To set
your server to public, set Visibility: [Public] in ConfigGUI, (or set
"IsPublic" key to "true" in config.xml). Remember that if the serveris running
while you make configuration changes, you need to restart it or use
"/Reload config" command.

You may need to add firewall exceptions for fCraft applications (ConfigGUI,
ServerGUI, or ServerCLI, or ServerWinService) to allow incoming TCP connections
on the listening port. Default port is 25565.

If your server is behind a router, you may also need to set up port forwarding
on the same port. See www.port-forward.com for further guidance.

When you are ready to start the server, run ONE of the available server
front-ends (GUI, CLI, or WinService).



=== Troubleshooting ===========================================================

Server does not show up on minecraft.net list:
    Make sure that server is public. See 2nd paragraph of "Initial Setup"
    section, above.

"Could not connect to server: it's probably down":
    Make sure that you added firewall exception for fCraft (if applicable),
    and forwarded the port on your router. If you are connecting from same
    computer that the server is working on, try connecting to:
    http://www.minecraft.net/classic/play?ip=127.0.0.1&port=_____
        (fill in the blank with your server's port number)

"Could not verify player name":
    Verification problems occur when your fCraft server cannot verify identity
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
        bookmarked address starts with "http://www.minecraft.net/..." and not
        "mc://...". Addresses in the form "mc://" are temporary, and will stop
        working whenever the server is restarted.

Other players cannot connect from the same LAN/network as me:
    Minecraft client has a lot of trouble working on LAN. You probably will not
    be able to connect via the public URL. There is a workaround:

    1. Check "Allow connections from LAN without verification" in ConfigGUI.
        (or set AllowUnverifiedLAN config key to "true").
    2. Find your local IP address.
        * In Windows XP+, go to Start -> type "cmd" to open a terminal ->
            type "ipconfig". The address you need is labeled "IPv4 Address"
            under "Local Area Connection".
        * In Unix/Linux, use "ifconfig" utility. 
   3. Connect to http://www.minecraft.net/classic/play?ip=_____&port=_____
        (fill in the blanks with your server's IP address and port number)

"Error getting response stream (Write: The authentication or decryption..."
    Common problem for Mono users. You need to import certificates for Mono to
    work with HTTPS. See http://is.gd/MonoHttps
    Alternatively, set BypassHttpsCertificateValidation config key to "true"
    (slightly less safe).

Other problems:
    See http://fCraft.net/wiki/Troubleshooting



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

       ServerCLI.exe - Command-line interface (CLI) for the server.
       ServerGUI.exe - Graphical interface (GUI) for the server.

  HeartbeatSaver.exe - Standalone heartbeat sender tool (CLI).
    MapConverter.exe - Batch map format converter tool (CLI).
     MapRenderer.exe - Tool that creates images of map files (CLI).



=== Command-line Options ======================================================

In addition to many settings stored in config.xml, fCraft has several special
options that can only be set via command-line switches:

    --path=<path>       Working path (directory) that fCraft should use. If the
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

    --norestart         If this flag is present, fCraft will shutdown whenever
                        it would normally restart (e.g. automatic updates or
                        /restart command). This may be useful if you are using
                        an auto-restart script or a process monitor.

    --exitoncrash       If this flag is present, fCraft frontends will exit
                        at once in the event of an unrecoverable crash, instead
                        of showing a message and prompting for user input.

    --noupdater         If this flag is present, fCraft will not launch the
                        downloaded UpdateInstaller.exe when restarting for
                        update/shutdown. It will handle all other aspects of
                        the update process, including exiting with the correct
                        exit-code, but not launch the updater.

    --nolog             If this flag is present, all logging is disabled.

    --noconsolecolor    If this flag is present, ServerCLI will not use any
                        colors or formatting in its console output.



=== Help & Support ============================================================

When you first join the server, promote yourself by typing...
    /rank YourNameHere owner
...in the server's console. Replace "owner" if you renamed your highest rank.

Type "/help" in-game or in server console to get started. Type "/commands" for
a list of available commands. For detailed information, please visit:
    http://fCraft.net/wiki

To request features, report bugs, or receive support, please visit:
    http://forum.fCraft.net

For quick help/support, join #fCraft.dev channel on Esper.net IRC:
    irc://irc.esper.net:5555/fCraft.dev

See CHANGELOG.txt or visit http://fCraft.net/wiki/Version_history for complete
information about changes in this release compared to previous versions of
fCraft.



=== Licensing =================================================================

fCraft is open-source and free for all uses. fCraft code and binaries are
licensed and distributed under the permissive MIT License, reproduced here:

----
Copyright 2009-2012 Matvei Stefarov <me@matvei.org>

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

If you create fCraft plugins that do not include any substantial portions of
fCraft's original code, they belong to you and you are free to do absolutely
anything with them. However, if you would like to distribute whole modified
copies of fCraft, please follow the MIT License terms.

Original Minecraft was developed by Markus "Notch" Persson of Mojang, and is 
not affiliated with fCraft in any way. fCraft does not use any code, assets,
or any other files from Minecraft.



=== Credits ===================================================================

fCraft was developed by Matvei Stefarov (me@matvei.org) in 2009-2012

Thanks to fCraft code contributors and modders:
    Asiekierka, Dag10, Destroyer, FontPeg, Hellenion, Jonty800, M1_Abrams,
    Optical-Lza, Redshift, SystemX17, TkTech, Wootalyzer

Thanks to people who supported fCraft development through donations:
    fCraft.net community, Astelyn, D3M0N, Destoned, DreamPhreak, Pandorum,
    Redshift, TkTech, ven000m, wtfmejt, Team9000 and SpecialAttack.net
    communities, and others who donated anonymously

Thanks to people whose code has been ported to fCraft:
    Dudecon (Forester), Osici (Omen), vLK (MinerCPP), Tim Van Wassenhove,
    Paul Bourke

Thanks to Minecraft servers that helped test and improve fCraft:
    TheOne's Zombie Survival, SpecialAttack.net Freebuild, Team9000 Freebuild,
    D3M0Ns FreeBuild, ~The Best Freebuild 24/7~, fCraft Freebuild Official

Thanks to people who submitted bug reports and feature requests:
    Astelyn, Clhdrums87, Darklight, David00143, Dogwatch, Epiclolwut, Fehzor,
    Gamma-Metroid, Hellenion, Sunfall, maintrain97, Mavinstar, Unison,
    and all others.

Special thanks for inspiration and suggestions:
    CO2, Descension, ElectricFuzzball, Exe, Hearty0, iKJames, LG_Legacy,
    PyroPyro, Revenant, Varriount, Voziv, Zaneo, #mcc on Esper.net,
    HyveBuild/iCraft team, MinerCPP team, OpenCraft team

And thank You for using fCraft!
