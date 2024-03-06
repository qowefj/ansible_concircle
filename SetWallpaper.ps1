# PowerShell script to set wallpaper for the current user
[Reflection.Assembly]::LoadWithPartialName("System.Drawing")
$wallpaperPath = "C:\Windows\Web\Wallpaper\Wallpaper.jpeg"

# Use user32.dll to set the wallpaper
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# SPI_SETDESKWALLPAPER = 20, UpdateIniFile = 0x01, SendWinIniChange = 0x02
[void] [Wallpaper]::SystemParametersInfo(20, 0, $wallpaperPath, 0x01 + 0x02)
