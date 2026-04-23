---
description: Start Flutter with hot reload managed by Antigravity
---

// turbo-all
1. Start the Flutter app in the background. Choose your device (e.g., android, windows, etc.)
   `flutter run -d <device_id>`

2. Whenever you make a change, or I make a change, I will send the hot reload signal to the running command.
   `send_command_input -CommandId <ID> -Input "r"`

3. For a full hot restart, use "R".
   `send_command_input -CommandId <ID> -Input "R"`

[!TIP]
If you want me to automatically hot-reload after every edit I make, just let me know!
