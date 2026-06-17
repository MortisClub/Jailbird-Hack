# 🔥 Jailbird Hack v2.3

<div align="center">

![Version](https://img.shields.io/badge/version-2.3-blue.svg)
![Status](https://img.shields.io/badge/status-beta-orange.svg)
![Platform](https://img.shields.io/badge/platform-Roblox-red.svg)
![Lua](https://img.shields.io/badge/lua-5.1-purple.svg)

**Продвинутый многофункциональный чит для Roblox Jailbreak**

*Created by MortisHAck | Powered by MortisClub*

[Installation](#-installation) • [Features](#-features) • [Usage](#-usage) • [FAQ](#-faq)

---

</div>

## 🚀 Quick Start

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/MortisClub/Jailbird-Hack/main/jailfuck.lua"))()
```

**Или сокращенная ссылка:**

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/MortisClub/Jailbird-Hack/main/script.lua"))()
```

---

## 📋 Table of Contents

- [Features](#-features)
- [Installation](#-installation)
- [Controls](#-controls)
- [Configuration](#-configuration)
- [Modules](#-modules)
  - [Aimbot](#-aimbot)
  - [ESP](#-esp)
  - [Movement](#-movement)
  - [Visual](#-visual)
  - [Misc](#-misc)
- [FAQ](#-faq)
- [Troubleshooting](#-troubleshooting)
- [Changelog](#-changelog)
- [Disclaimer](#-disclaimer)

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎯 Combat
- ✅ **Advanced Aimbot**
  - CFrame-based precision
  - FOV Lock protection
  - Target prediction
  - Humanizer system
- ✅ **ESP System**
  - 2D Boxes
  - Health bars
  - Distance display
  - Chams (Wallhack)

</td>
<td width="50%">

### 🏃 Movement
- ✅ **Gravity Control**
  - Custom gravity values
  - Planet presets
  - Visual indicator
- ✅ **Speed & Jump**
  - WalkSpeed modifier
  - JumpPower modifier
  - Infinite Jump
  - BunnyHop

</td>
</tr>
<tr>
<td width="50%">

### 🎨 Visual
- ✅ **Customization**
  - Custom crosshair
  - FOV changer
  - Third person view
  - Time & lighting control

</td>
<td width="50%">

### 🔧 Utilities
- ✅ **Quality of Life**
  - Anti-AFK
  - Recoil reduction
  - Config saving
  - Theme manager

</td>
</tr>
</table>

---

## 📦 Installation

### Method 1: Direct Execution (Recommended)

1. Open Roblox and join Jailbreak
2. Open your executor (Synapse X, KRNL, Fluxus, etc.)
3. Paste the loadstring:
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/MortisClub/Jailbird-Hack/main/obf_4gPh7M0718NQMMjbiEeuIIoW00gjUfRcuy41IpKK3LqFWU6eDbheeHfmj1T6Q7uf.lua"))()
```
4. Execute and wait for the GUI to load
5. Press `RightShift` to open menu

### Method 2: AutoExecute

1. Download the script file
2. Place it in your executor's `autoexec` folder
3. Restart executor
4. Script will auto-load on game join

### Method 3: Manual Load

1. Download the raw script
2. Copy the entire content
3. Paste into your executor
4. Click Execute

---

## ⌨️ Controls

| Key | Action |
|-----|--------|
| **RightShift** | Toggle Menu |
| **V** | Toggle Gravity Mode |
| **MouseButton2** (RMB) | Aimbot (default) |
| **Space** | Infinite Jump (when enabled) |

*All keybinds are customizable in the menu*

---

## 🎯 Aimbot

### Core Features

```lua
✅ Precise CFrame.Lerp aiming
✅ FOV Lock (animation-proof)
✅ Movement prediction
✅ Visibility checking
✅ Team detection
✅ Distance limiting
```

### Recommended Settings

| Setting | Value | Description |
|---------|-------|-------------|
| FOV | 150-200 | Target detection radius |
| Smoothness | 6-10 | Aim smoothing (higher = smoother) |
| Prediction | 0.135 | Movement prediction strength |
| Max Distance | 1000 | Maximum target distance |

### Humanizer System

Make your aim look natural:

| Feature | Recommended | Purpose |
|---------|-------------|---------|
| Reaction Time | 80-150ms | Delay before aiming |
| Shake Amount | 0.5-2.0 | Crosshair shake |
| Miss Chance | 5-15% | Occasional misses |
| Aim Drift | Enabled | Smooth sway |

**Preset Configurations:**

```lua
-- Legit Settings
FOV: 120
Smoothness: 12
Humanizer: Enabled
Reaction: 150ms
Shake: 2.0
Miss: 15%

-- Rage Settings
FOV: 300
Smoothness: 3
Humanizer: Disabled
Reaction: 0ms
Shake: 0
Miss: 0%

-- Balanced Settings
FOV: 180
Smoothness: 8
Humanizer: Enabled
Reaction: 80ms
Shake: 1.0
Miss: 5%
```

---

## 👁️ ESP

### Visual Elements

- **Box**: Outline around players
- **Box Fill**: Semi-transparent box fill
- **Name**: Player display name
- **Health Bar**: Color-coded health indicator
- **Distance**: Range in studs
- **Chams**: Highlight through walls

### Color System

```lua
Enemy Color: RGB(255, 85, 85)  -- Red
Ally Color:  RGB(85, 255, 85)  -- Green (when team check off)
Text Color:  RGB(255, 255, 255) -- White
```

### Settings

| Option | Default | Range |
|--------|---------|-------|
| Max Distance | 2000 | 100-5000 |
| Box Thickness | 2 | 1-6 |
| Name Size | 14 | 8-24 |
| Health Bar Width | 4 | 2-10 |
| Chams Transparency | 0.3 | 0.0-1.0 |

---

## 🌙 Movement

### Gravity Control

**How to use:**
1. Enable "Включить управление" in Movement tab
2. Press **V** to toggle gravity mode
3. Visual indicator shows status

**Presets:**

| Preset | Value | Effect |
|--------|-------|--------|
| 🌍 Earth | 196 | Default gravity |
| 🌙 Moon | 32 | Low gravity, high jumps |
| 🪐 Mars | 74 | Medium gravity |
| 🚀 Space | 0 | Zero gravity, float mode |

### Speed & Jump

```lua
-- Speed Settings
Default: 16
Range: 1-200
Recommended: 25-40 (not too obvious)

-- Jump Settings
Default: 50
Range: 1-500
Recommended: 75-120
```

### Advanced Movement

- **Infinite Jump**: Jump in mid-air
- **BunnyHop**: Auto-jump on landing
- **No Fall Damage**: Disable fall damage
- **Auto Sprint**: Always run at max speed

---

## 🎨 Visual

### Crosshair Customization

```lua
crosshair = {
    Size:      12,     -- Line length
    Gap:       5,      -- Center gap
    Thickness: 2,      -- Line width
    Color:     White,  -- Line color
    Dot:       false,  -- Center dot
}
```

### FOV Changer

**FOV Lock Feature:**
- Prevents FOV reset from animations
- Protects against gun ADS
- Maintains your preferred FOV

```lua
Default: 70
Range: 30-120
Recommended: 90-110 (wider view)
```

### Third Person

```lua
Distance: 10 (Default)
Range: 5-60
Usage: Better situational awareness
```

### Environment

- **Time of Day**: Set custom time (0-24 hours)
- **Ambient Color**: Custom world lighting
- **Brightness**: Visibility enhancement

---

## 🔧 Misc

### Anti-AFK

Automatically prevents being kicked for inactivity.

```lua
Status: Disabled by default
Method: VirtualUser input simulation
Safe: Yes
```

### Recoil Reduction

```lua
Reduction: 0-100%
Default: 100% (full reduction)
Recommended: 60-80% (balanced)
```

### Config Manager

**Save Configuration:**
1. Set all your preferences
2. Go to Settings tab
3. Enter config name
4. Click "Save"

**Load Configuration:**
1. Settings → Config list
2. Select saved config
3. Click "Load"

**Auto-load:**
Enable "Autoload Configuration" to load on startup

---

## ⚙️ Configuration

### Default Config Structure

```lua
Config = {
    ESP = {
        Enabled: false,
        Box: true,
        Name: true,
        HealthBar: true,
        Distance: true,
        Chams: false,
        TeamCheck: true,
        MaxDistance: 2000,
    },
    Aimbot = {
        Enabled: false,
        FOV: 150,
        Smoothness: 8.0,
        Prediction: false,
        Humanizer: false,
    },
    Movement = {
        Speed: 16,
        Jump: 50,
        Gravity: 196,
    },
}
```

### Saving Location

```
Executor/workspace/JailbirdConfigs/
```

---

## ❓ FAQ

<details>
<summary><b>Q: Is this safe to use?</b></summary>

**A:** No cheat is 100% safe. Use at your own risk on alt accounts. We use standard Roblox APIs, but anti-cheat can still detect abnormal behavior.
</details>

<details>
<summary><b>Q: Why isn't aimbot working?</b></summary>

**A:** Check:
- Aimbot is enabled
- Correct aim key is set
- FOV is large enough
- You're holding the aim key
- Target is within max distance
- Team check settings
</details>

<details>
<summary><b>Q: ESP not showing?</b></summary>

**A:** Verify:
- ESP enabled in settings
- Players are within max distance (default 2000)
- Team check isn't hiding allies
- Box/Name/Health options are enabled
</details>

<details>
<summary><b>Q: Gravity control not working?</b></summary>

**A:** Make sure:
1. "Включить управление" is enabled
2. Press **V** key to activate
3. Look for visual indicator at top of screen
</details>

<details>
<summary><b>Q: Can I use this on my main account?</b></summary>

**A:** **NOT RECOMMENDED!** Use alt accounts only. Cheating violates Roblox ToS and can result in permanent bans.
</details>

<details>
<summary><b>Q: Which executor should I use?</b></summary>

**A:** Compatible with most executors:
- ✅ Synapse X (Best)
- ✅ KRNL
- ✅ Fluxus
- ✅ Script-Ware
- ⚠️ Requires Drawing API support
</details>

<details>
<summary><b>Q: How to make aimbot legit?</b></summary>

**A:** Use these settings:
```
FOV: 120-150
Smoothness: 10-15
Humanizer: ON
Reaction: 120-180ms
Shake: 1.5-3.0
Miss: 10-20%
Visibility Check: ON
```
</details>

---

## 🔧 Troubleshooting

### Script won't load

```
1. Check internet connection
2. Verify executor supports HttpGet
3. Try alternative loadstring
4. Restart executor
5. Rejoin game
```

### Low FPS / Lag

```
1. Disable Chams
2. Reduce ESP max distance
3. Disable crosshair
4. Lower FOV circle sides
5. Disable unused features
```

### Detected / Kicked

```
1. Lower aimbot smoothness
2. Enable humanizer
3. Don't use rage settings
4. Avoid obvious speed values
5. Use on alt accounts
```

### Aimbot jittering

```
1. Increase smoothness
2. Reduce shake amount
3. Disable aim drift
4. Lower prediction value
5. Check FOV lock is enabled
```

---

## 📝 Changelog

### v2.3 - Current Release (Beta)

```diff
+ ✅ NEW: CFrame.Lerp precise aiming
+ ✅ NEW: FOV Lock system (animation-proof)
+ ✅ NEW: Gravity Control with presets
+ ✅ NEW: Advanced Humanizer system
+ ✅ NEW: Chams ESP (Highlight)
+ 🔧 IMPROVED: Camera angle calculation
+ 🔧 IMPROVED: Prediction system
+ 🔧 IMPROVED: Memory optimization
+ 🔧 IMPROVED: ESP performance
+ 🐛 FIXED: FOV resetting bug
+ 🐛 FIXED: Memory leaks
+ 🐛 FIXED: ESP flickering
```

### v2.2

```diff
+ ESP system implementation
+ Basic aimbot
+ Movement modifications
+ Config system
```

### v2.1

```diff
+ Initial release
+ Core features
+ Basic GUI
```

---

## 🗺️ Roadmap

### Planned Features

- [ ] Silent Aim mode
- [ ] Spinbot
- [ ] Auto-arrest (Police)
- [ ] Auto-rob (Criminal)
- [ ] Teleport waypoints
- [ ] Vehicle ESP
- [ ] Noclip
- [ ] Fly mode
- [ ] Auto-farm
- [ ] Weapon mods
- [ ] Discord webhooks
- [ ] Anti-exploit bypass
- [ ] Mobile support

### Under Consideration

- [ ] Rage mode toggle
- [ ] Kill-all
- [ ] Server-side exploits (if possible)
- [ ] Custom HUD
- [ ] Statistics tracker
- [ ] Replay system

---

## 🤝 Contributing

Contributions are welcome! Here's how:

1. **Fork** the repository
2. **Create** your feature branch
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit** your changes
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push** to the branch
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open** a Pull Request

### Contribution Guidelines

- Follow existing code style
- Comment your code
- Test thoroughly
- Update documentation
- No malicious code

---

## 📞 Support

**MortisClub Community:**
- 💬 Discord: *[Join Server]* (Coming Soon)
- 📱 Telegram: `@mortisclub`
- 🐙 GitHub: [Issues](https://github.com/MortisClub/Jailbird-Hack/issues)

**Report Bugs:**
Open an issue with:
- Executor used
- Error messages
- Steps to reproduce
- Screenshots (if applicable)

---

## ⚠️ Disclaimer

```
╔═══════════════════════════════════════════════╗
║              ⚠️  IMPORTANT NOTICE  ⚠️         ║
╠═══════════════════════════════════════════════╣
║                                               ║
║  This script is for EDUCATIONAL PURPOSES ONLY ║
║                                               ║
║  ❌ Using cheats violates Roblox Terms of Service
║  ❌ You WILL be banned if caught              ║
║  ❌ Use on ALT ACCOUNTS ONLY                  ║
║  ❌ Authors are NOT responsible for bans      ║
║                                               ║
║  ⚠️  USE AT YOUR OWN RISK  ⚠️                ║
║                                               ║
╚═══════════════════════════════════════════════╝

By using this script, you acknowledge:

1. You understand the risks of cheating
2. You accept full responsibility for consequences
3. You won't use this to harass other players
4. You won't distribute without credit
5. This is for learning/testing purposes

BE RESPONSIBLE. BE RESPECTFUL. USE ALT ACCOUNTS.
```

---

## 📜 License

```
MIT License

Copyright (c) 2026 MortisClub

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🏆 Credits

**Creator:** MortisHAck  
**Organization:** MortisClub  
**UI Library:** [LinoriaLib](https://github.com/violin-suzutsuki/LinoriaLib) by violin-suzutsuki  
**Special Thanks:** Roblox Scripting Community

---

## 🌟 Star History

If you found this useful, please consider giving it a ⭐!

[![Star History Chart](https://api.star-history.com/svg?repos=MortisClub/Jailbird-Hack&type=Date)](https://star-history.com/#MortisClub/Jailbird-Hack&Date)

---

<div align="center">

### 🎮 Happy Gaming! 

**Made with ❤️ and ☕ by MortisClub**

![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Roblox](https://img.shields.io/badge/Roblox-000000?style=for-the-badge&logo=roblox&logoColor=white)

---

*"If you can't beat them legitimately, beat them intelligently."*

**⚡ Jailbird Hack v2.3** | © 2026 MortisClub

[⬆ Back to Top](#-jailbird-hack-v23)

</div>