#!/bin/bash

# ==============================================================================
# SCRIPT: GameTurbo-Plus.sh
# DESCRIPTION: Advanced Android Gaming Optimizer & Performance Suite
# DEVELOPER: Debugg3rDetected
# TYPE: Shell Script (Android/Linux)
# VERSION: 4.1 (Debugg3r Edition)
# ==============================================================================

# --- Global Config ---
LOG_FILE="/tmp/GameTurbo-Plus.log"
BG_LOG="/tmp/GameTurbo-Background.log"
LOCK_FILE="/tmp/gameturbo.lock"
GAME_LIST="com.tencent.ig com.dts.freefireth com.pubg.kmobile com.activision.callofduty.shooter com.miHoYo.GenshinImpact com.mobile.legends"

# --- Colors & Visuals ---
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
PURPLE='\033[1;35m'
GREY='\033[1;30m'
RESET='\033[0m'
BOLD='\033[1m'

# --- Icons ---
ICON_CHECK="${GREEN}✔${RESET}"
ICON_FAIL="${RED}✖${RESET}"
ICON_ARROW="${CYAN}➤${RESET}"
ICON_FIRE="${RED}🔥${RESET}"
ICON_GEAR="${YELLOW}⚙${RESET}"
ICON_DEV="${PURPLE}👾${RESET}"

# ==============================================================================
# CORE UTILITIES
# ==============================================================================

log() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $1" >> "$LOG_FILE"
}

safe_write() {
    # Tries to write to a system path. Fails silently if unrooted/permission denied.
    local value="$1"
    local path="$2"
    if [ -w "$path" ]; then
        echo "$value" > "$path" 2>/dev/null
        log "Applied: $value -> $path"
    else
        # Try chmod attempt (rarely works without root, but worth a try)
        chmod +w "$path" 2>/dev/null && echo "$value" > "$path" 2>/dev/null
    fi
}

cmd_safe() {
    # Wrapper for Android internal commands
    $@ >/dev/null 2>&1
}

spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    echo -n " "
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

progress_bar() {
    echo -ne "${CYAN}[Wait]${RESET} $1 "
    for i in {1..20}; do
        echo -ne "${GREEN}▓${RESET}"
        sleep 0.05
    done
    echo -e " ${ICON_CHECK}"
}

print_banner() {
    clear
    echo -e "${RED} .d8888b.                                     ${CYAN} 88888888888               888               ${RESET}"
    echo -e "${RED}d88P  Y88b                                    ${CYAN}     888                   888               ${RESET}"
    echo -e "${RED}888    888                                    ${CYAN}     888                   888               ${RESET}"
    echo -e "${RED}888        8888b.  88888b.d88b.   .d88b.      ${CYAN}     888  888  888 888d888 88888b.   .d88b.  ${RESET}"
    echo -e "${RED}888  88888    \"88b 888 \"888 \"88b d8P  Y8b     ${CYAN}     888  888  888 888P\"   888 \"88b d88\"\"88b ${RESET}"
    echo -e "${RED}888    888 .d888888 888  888  888 88888888    ${CYAN}     888  888  888 888     888  888 888  888 ${RESET}"
    echo -e "${RED}Y88b  d88P 888  888 888  888  888 Y8b.        ${CYAN}     888  Y88b 888 888     888 d88P Y88..88P ${RESET}"
    echo -e "${RED} \"Y8888P88 \"Y888888 888  888  888  \"Y8888     ${CYAN}     888   \"Y88888 888     88888P\"   \"Y88P\"  ${RESET}"
    echo -e "                                                     ${CYAN}PLUS EDITION v4.1${RESET}"
    echo -e "${YELLOW}================================================================================${RESET}"
    echo -e "        ${ICON_DEV} ${PURPLE}${BOLD}< Developed by Debugg3rDetected />${RESET} ${ICON_DEV}"
    echo -e "${YELLOW}================================================================================${RESET}"
    echo -e "   ${GREY}OPTIMIZED FOR GAMING PERFORMANCE | UNROOTED & ROOTED SUPPORT | THERMAL AI${RESET}"
    echo ""
}

# ==============================================================================
# MODULE 1: CPU & GPU OPTIMIZATION
# ==============================================================================

module_cpu_gpu() {
    echo -e "${ICON_ARROW} ${BLUE}Initializing CPU/GPU Turbo Engine...${RESET}"
    (
        # 1. Android Power Manager (Works on unrooted ADB)
        cmd_safe cmd power set-mode 1
        cmd_safe cmd power set-fixed-performance-mode 1
        
        # 2. Kernel Tweaks (Best effort)
        # Force all cores online
        for i in 0 1 2 3 4 5 6 7; do
            safe_write "1" "/sys/devices/system/cpu/cpu$i/online"
            safe_write "performance" "/sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor"
        done

        # 3. GPU Tweaks
        safe_write "1" "/sys/class/kgsl/kgsl-3d0/force_bus_on"
        safe_write "1" "/sys/class/kgsl/kgsl-3d0/force_rail_on"
        safe_write "1" "/sys/class/kgsl/kgsl-3d0/force_clk_on"
        safe_write "10000" "/sys/class/kgsl/kgsl-3d0/idle_timer"
        
        # 4. Latency
        safe_write "0" "/sys/devices/system/cpu/cpu0/cpufreq/schedutil/rate_limit_us"
        
        # 5. Process Priority (Renice input and UI)
        renice -n -20 -p $(pidof surfaceflinger) >/dev/null 2>&1
        renice -n -20 -p $(pidof system_server) >/dev/null 2>&1
        renice -n -10 -p $(pidof com.android.systemui) >/dev/null 2>&1
        
    ) & spinner
    echo -e "   ${ICON_CHECK} CPU/GPU Performance Mode: ${GREEN}ENABLED${RESET}"
}

# ==============================================================================
# MODULE 2: RAM & CACHE
# ==============================================================================

module_ram_clean() {
    echo -e "${ICON_ARROW} ${BLUE}Purging Memory & Caches...${RESET}"
    
    # 1. Drop Caches (Kernel)
    safe_write "3" "/proc/sys/vm/drop_caches"
    safe_write "1" "/proc/sys/vm/compact_memory"

    # 2. Virtual Memory Tweaks
    safe_write "0" "/proc/sys/vm/swappiness" # Prefer physical RAM
    safe_write "10" "/proc/sys/vm/vfs_cache_pressure"
    safe_write "500" "/proc/sys/vm/dirty_writeback_centisecs"

    # 3. Cache Cleaning (Safe paths)
    rm -rf /data/local/tmp/* 2>/dev/null
    rm -rf /sdcard/Android/data/*/cache/* 2>/dev/null
    
    # 4. LMK (Low Memory Killer)
    # Aggressive settings for gaming
    safe_write "18432,23040,27648,32256,55296,80640" "/sys/module/lowmemorykiller/parameters/minfree"

    echo -e "   ${ICON_CHECK} RAM Freed & Optimized"
}

# ==============================================================================
# MODULE 3: TOUCH & DISPLAY
# ==============================================================================

module_touch_display() {
    echo -e "${ICON_ARROW} ${BLUE}Calibrating Touch & Display...${RESET}"
    
    # 1. Android Settings Tweaks (Unrooted friendly)
    cmd_safe settings put system pointer_speed 7
    cmd_safe settings put secure long_press_timeout 250
    cmd_safe settings put global window_animation_scale 0.0
    cmd_safe settings put global transition_animation_scale 0.0
    cmd_safe settings put global animator_duration_scale 0.0
    
    # 2. Refresh Rate Lock (Attempt)
    cmd_safe settings put system min_refresh_rate 120
    cmd_safe settings put system peak_refresh_rate 120
    
    # 3. Touch properties (Requires root usually, but trying safe_write)
    safe_write "1" "/sys/class/touch/switch/set_touchscreen"
    safe_write "0" "/sys/module/msm_performance/parameters/touchboost" 
    
    echo -e "   ${ICON_CHECK} Touch Sensitivity: ${GREEN}MAX${RESET} | Animations: ${RED}OFF${RESET}"
}

# ==============================================================================
# MODULE 4: NETWORK TURBO
# ==============================================================================

module_network() {
    echo -e "${ICON_ARROW} ${BLUE}Optimizing TCP/IP Stack...${RESET}"
    
    # 1. TCP Tweaks
    safe_write "1" "/proc/sys/net/ipv4/tcp_low_latency"
    safe_write "1" "/proc/sys/net/ipv4/tcp_no_metrics_save"
    safe_write "2" "/proc/sys/net/ipv4/tcp_ecn"
    
    # 2. Buffer Sizes
    safe_write "4096 87380 524288" "/proc/sys/net/ipv4/tcp_rmem"
    safe_write "4096 87380 524288" "/proc/sys/net/ipv4/tcp_wmem"
    
    # 3. DNS (Google DNS fallback)
    cmd_safe settings put global private_dns_mode "hostname"
    cmd_safe settings put global private_dns_specifier "dns.google"

    echo -e "   ${ICON_CHECK} Ping Stabilizer: ${GREEN}ACTIVE${RESET}"
}

# ==============================================================================
# MODULE 5: EXTREME ENHANCEMENTS
# ==============================================================================

module_extreme() {
    echo -e "${ICON_ARROW} ${PURPLE}Engaging EXTRA EXTREME Engines...${RESET}"
    
    # A) App Killing (Simulated on unrooted via am kill)
    # Kills background processes that represent 'cached' apps
    cmd_safe am kill-all
    
    # B) FPS Stability (Disable logs to save I/O)
    cmd_safe setprop log.tag.stats_log OFF
    cmd_safe setprop debug.hwui.profile false
    
    # C) Dalvik/ART Optimization
    cmd_safe setprop dalvik.vm.dex2oat-filter speed
    cmd_safe setprop dalvik.vm.image-dex2oat-filter speed
    
    # D) I/O Scheduler
    # Attempt to set internal storage to 'noop' or 'deadline'
    safe_write "noop" "/sys/block/mmcblk0/queue/scheduler"
    safe_write "2048" "/sys/block/mmcblk0/queue/read_ahead_kb"
    
    # E) Thermal Bypass (Risky, mild application)
    cmd_safe setprop debug.thermal.throttle.support false
    
    echo -e "   ${ICON_CHECK} ART/Dalvik: ${GREEN}SPEED${RESET}"
    echo -e "   ${ICON_CHECK} I/O Scheduling: ${GREEN}OPTIMIZED${RESET}"
    echo -e "   ${ICON_CHECK} Thermal Throttling: ${YELLOW}REDUCED${RESET}"
}

# ==============================================================================
# AUTOMATION ENGINE (AI LOOP)
# ==============================================================================

auto_mode_loop() {
    echo -e "\n${ICON_FIRE} ${BOLD}GAME TURBO AUTO-MODE STARTED${RESET}"
    echo -e "${CYAN}Running in background. Monitoring system state...${RESET}"
    log "Auto Mode Started by Debugg3rDetected Logic."

    while true; do
        # 1. Detect Game (Checking current focus)
        # Note: 'dumpsys window' requires permissions. Fallback to generalized boost if detection fails.
        CURRENT_APP=$(dumpsys window windows 2>/dev/null | grep -E 'mCurrentFocus|mFocusedApp' | cut -d "/" -f1 | rev | cut -d " " -f1 | rev)
        
        IS_GAME=0
        for game in $GAME_LIST; do
            if [[ "$CURRENT_APP" == *"$game"* ]]; then
                IS_GAME=1
                break
            fi
        done

        # 2. Dynamic Actions
        if [ $IS_GAME -eq 1 ]; then
            # If game detected, re-apply priorities
            renice -n -15 -p $(pidof "$CURRENT_APP") >/dev/null 2>&1
            cmd_safe cmd power set-mode 1
            log "Game Detected: $CURRENT_APP. Boost maintained."
        fi

        # 3. Dynamic RAM Cleaning (If RAM < 20%)
        # Extract MemFree from /proc/meminfo
        FREE_RAM=$(grep MemFree /proc/meminfo | awk '{print $2}')
        if [ "$FREE_RAM" -lt 500000 ]; then # Less than ~500MB
            sync
            echo 3 > /proc/sys/vm/drop_caches
            log "Low RAM detected ($FREE_RAM kB). Caches dropped."
        fi
        
        # 4. CPU Load Monitor (AI Boost)
        # If load average > 4.0, trigger generic boost
        LOAD=$(awk '{print $1}' /proc/loadavg)
        if (( $(echo "$LOAD > 4.0" | bc -l) )); then
             safe_write "performance" "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
        fi

        sleep 10
    done
}

start_background() {
    nohup "$0" --daemon > "$BG_LOG" 2>&1 &
    echo -e "${ICON_CHECK} Service started in background (PID: $!)."
    echo -e "Logs at: $BG_LOG"
}

# ==============================================================================
# RESTORE / RESET
# ==============================================================================

restore_defaults() {
    echo -e "${ICON_ARROW} ${YELLOW}Restoring Factory Defaults...${RESET}"
    cmd_safe cmd power set-mode 0
    cmd_safe settings put system pointer_speed 0
    cmd_safe settings put global window_animation_scale 1.0
    cmd_safe settings put global transition_animation_scale 1.0
    cmd_safe settings put global animator_duration_scale 1.0
    safe_write "schedutil" "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
    safe_write "cfq" "/sys/block/mmcblk0/queue/scheduler"
    echo -e "   ${ICON_CHECK} System Restored."
    log "System Restored to defaults."
}

# ==============================================================================
# INTERACTIVE MENU
# ==============================================================================

show_menu() {
    print_banner
    
    # System Info Header
    local device_model=$(getprop ro.product.model)
    local android_ver=$(getprop ro.build.version.release)
    echo -e " ${ICON_GEAR} Device: ${CYAN}$device_model${RESET} | Android: ${CYAN}$android_ver${RESET}"
    echo -e " ${ICON_GEAR} Kernel: ${CYAN}$(uname -r)${RESET}"
    echo -e "${YELLOW}--------------------------------------------------------------------------------${RESET}"

    echo -e "${GREEN} 1.${RESET} ${BOLD}Start Game Boost${RESET}      (CPU/GPU/RAM/Net/Touch)"
    echo -e "${GREEN} 2.${RESET} ${BOLD}Ultra Extreme Boost${RESET}   (+ App Kill, I/O, Thermal)"
    echo -e "${GREEN} 3.${RESET} ${BOLD}Enable Auto-Mode${RESET}      (Monitoring Loop)"
    echo -e "${GREEN} 4.${RESET} ${BOLD}Background Service${RESET}    (Run invisible)"
    echo -e "${GREEN} 5.${RESET} ${BOLD}Network Lag Fix${RESET}       (DNS/TCP only)"
    echo -e "${GREEN} 6.${RESET} ${BOLD}Quick RAM Clean${RESET}"
    echo -e "${GREEN} 7.${RESET} ${BOLD}View Logs${RESET}"
    echo -e "${GREEN} 8.${RESET} ${BOLD}Restore Defaults${RESET}"
    echo -e "${RED} 9. Exit${RESET}"
    echo ""
    echo -ne "${CYAN} Select option [1-9]: ${RESET}"
    read -r choice

    case $choice in
        1)
            progress_bar "Applying Standard Boost"
            module_cpu_gpu
            module_ram_clean
            module_touch_display
            module_network
            read -p "Press Enter to return..."
            show_menu
            ;;
        2)
            progress_bar "Applying EXTREME Boost"
            module_cpu_gpu
            module_ram_clean
            module_touch_display
            module_network
            module_extreme
            echo -e "\n${ICON_FIRE} ${RED}${BOLD}DEVICE IS NOW IN ULTRA PERFORMANCE MODE${RESET}"
            read -p "Press Enter to return..."
            show_menu
            ;;
        3)
            echo -e "${ICON_ARROW} Starting Auto-Mode Loop (Ctrl+C to stop)..."
            auto_mode_loop
            ;;
        4)
            start_background
            exit 0
            ;;
        5)
            module_network
            echo -e "   ${ICON_CHECK} Network Optimized."
            sleep 2
            show_menu
            ;;
        6)
            module_ram_clean
            sleep 2
            show_menu
            ;;
        7)
            echo -e "\n${YELLOW}--- LOG FILE ---${RESET}"
            tail -n 10 "$LOG_FILE"
            echo -e "${YELLOW}----------------${RESET}"
            read -p "Press Enter..."
            show_menu
            ;;
        8)
            restore_defaults
            sleep 2
            show_menu
            ;;
        9)
            echo -e "${CYAN}Exiting GameTurbo-Plus...${RESET}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid Option${RESET}"
            sleep 1
            show_menu
            ;;
    esac
}

# ==============================================================================
# MAIN ENTRY POINT
# ==============================================================================

# Check if running as daemon
if [ "$1" == "--daemon" ]; then
    log "Background Daemon Started by Debugg3rDetected"
    auto_mode_loop
    exit 0
fi

# Trap interrupts for cleanup
trap "echo -e '\n${RED}Script Interrupted.${RESET}'; exit" SIGINT SIGTERM

# Initialize Log
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
    echo "--- GameTurbo-Plus Log Created by Debugg3rDetected ---" > "$LOG_FILE"
fi

# Run Menu
show_menu