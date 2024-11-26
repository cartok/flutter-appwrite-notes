# Guide to connect my smartphone
I've set a fixed IP in the router.
1. Connect the smartphone via USB Cable and accept on the device.
2. (optional) Open port and connect to the smartphone via network. Then Unplug the USB cable, to only have one device usable for `scrcopy`.
> adb tcpip 5555
> adb connect 192.168.178.20:5555
3. Launch `scrcopy` via dmenu.
4. Use vscode to run the code on the device or connect from the project root like this:
> cd /home/cartok/code/flutter/notes_tasks
> flutter run -d 192.168.178.20:5555
