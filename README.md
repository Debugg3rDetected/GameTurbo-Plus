# 🚀 GameTurbo-Plus

![Version](https://img.shields.io/badge/version-4.1-blue.svg?style=flat-square) 
![Platform](https://img.shields.io/badge/platform-Android%20%7C%20Termux-green.svg?style=flat-square) 
![Root](https://img.shields.io/badge/root-Recommended-red.svg?style=flat-square) 
![License](https://img.shields.io/badge/license-MIT-orange.svg?style=flat-square)  

> **Advanced Gaming Optimizer & Performance Suite for Android Termux.**  

![GameTurbo Preview](assets/screenshot.png)  
*Ensure you create an 'assets' folder and place your 'screenshot.png' there.*

---

## 📖 About
**GameTurbo-Plus** pushes your Android device to its limits for gaming. It tweaks CPU/GPU, RAM management (LMK), and network settings to eliminate lag.

**Auto-Mode** runs in the background, detecting games and dynamically applying boosts.

---

## ✨ Key Features
- 🔥 **CPU & GPU Unlock:** Forces performance governors and keeps cores online.  
- 🚀 **RAM Optimization:** Aggressive Low Memory Killer (LMK) tuning & cache purging.  
- 📶 **Ping Stabilizer:** TCP/IP stack tweaks and DNS optimization for lower latency.  
- 📱 **Touch & Display:** Calibrates touch sensitivity and disables UI animations.  
- 🤖 **AI Auto-Mode:** Background service that detects games and boosts automatically.  
- 🛡️ **Safe & Secure:** Includes safety checks (`safe_write`) to prevent system instability.

---

## 📋 Requirements
1. **Termux App** (latest version)  
2. **Root Access** (Recommended for full features)  
   - Non-root works, but limited to RAM/DNS tweaks  
3. **Dependencies:** `git`, `bc`, `tsu`  

---

## 📥 Installation

### ⚡ Quick Install
```bash
pkg update -y && pkg install git bc tsu -y && git clone https://github.com/Debugg3rDetected/GameTurbo-Plus.git && cd GameTurbo-Plus && chmod +x GameTurbo-Plus.sh && ./GameTurbo-Plus.sh
```

### 🛠️ Manual Installation
**Step 1: Update Termux & Install Dependencies**
```bash
pkg update -y
pkg install git bc tsu -y
```

**Step 2: Clone Repository**
```bash
git clone https://github.com/Debugg3rDetected/GameTurbo-Plus.git
```

**Step 3: Enter Directory & Run**
```bash
cd GameTurbo-Plus
chmod +x GameTurbo-Plus.sh

# Run with Root (Recommended)
sudo ./GameTurbo-Plus.sh

# Or without Root (Limited features)
./GameTurbo-Plus.sh
```

---

## 🎮 How to Use
1. **Start Game Boost** – Applies standard tweaks  
2. **Ultra Extreme Boost** – Aggressive tweaks (Use carefully)  
3. **Enable Auto-Mode** – Keeps Termux monitoring games  
4. **Network Lag Fix** – Internet optimizations only  
5. **Restore Defaults** – Reverts to stock settings  

### ⚠️ Auto-Mode Notes
- Do **not** kill Termux from recent apps  
- Lock Termux in your recents menu  
- Disable Battery Saver for Termux  

---

## 🤝 Contributing
1. Fork the Project  
2. Create Feature Branch:  
```bash
git checkout -b feature/AmazingFeature
```

3. Commit Changes:  
```bash
git commit -m 'Add some AmazingFeature'
```

4. Push Branch:  
```bash
git push origin feature/AmazingFeature
```

5. Open a Pull Request  

---

## ⚠️ Disclaimer
**Use at your own risk.** Modifies low-level system files. Developer not responsible for damage, data loss, or overheating.

---

## 📄 License
MIT License – see `LICENSE` file  

<div align="center">Developed with ❤️ by <b>Debugg3rDetected</b></div>
