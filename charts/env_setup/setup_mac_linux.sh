#!/usr/bin/env bash
# ---
# name: charts-env-setup (macOS / Linux)
# description: Environment detection, dependency check & install for Charts skill on macOS and Linux.
# ---
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
ok()   { echo -e "  ${GREEN}✓${NC} $1"; }
fail() { echo -e "  ${RED}✗${NC} $1"; }
warn() { echo -e "  ${YELLOW}○${NC} $1"; }
info() { echo -e "  ${BLUE}→${NC} $1"; }

# ── Resolve CHARTS_SKILL_DIR ──
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CHARTS_SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
export CHARTS_SKILL_DIR

echo "============================================"
echo "  Charts Skill — Environment Setup"
echo "  (macOS / Linux)"
echo "============================================"
echo ""

# ── Step 1: Platform Detection ──
OS="$(uname -s)"
ARCH="$(uname -m)"
echo "Platform: $OS $ARCH"

if [ "$OS" = "Darwin" ]; then
    PLATFORM="mac"
elif [ "$OS" = "Linux" ]; then
    PLATFORM="linux"
else
    echo "Unsupported platform: $OS. This script supports macOS and Linux only."
    echo "For Windows, use env_setup/setup_windows.ps1"
    exit 1
fi

echo "Detected: $PLATFORM"
echo "CHARTS_SKILL_DIR=$CHARTS_SKILL_DIR"
echo ""

# ── China mirror detection & config ──
USE_CN_MIRROR=false
PIP_MIRROR_ARGS=""
NPM_MIRROR_ARGS=""
PLAYWRIGHT_HOST=""

# Auto-detect: if in China (check common China DNS or env var)
if [ "${USE_CN_MIRROR_FORCE:-}" = "true" ]; then
    USE_CN_MIRROR=true
elif curl -s --connect-timeout 3 https://pypi.org > /dev/null 2>&1; then
    USE_CN_MIRROR=false
else
    warn "pypi.org unreachable — enabling China mirrors"
    USE_CN_MIRROR=true
fi

if [ "$USE_CN_MIRROR" = true ]; then
    PIP_MIRROR_ARGS="-i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host pypi.tuna.tsinghua.edu.cn"
    NPM_MIRROR_ARGS="--registry https://registry.npmmirror.com"
    PLAYWRIGHT_HOST="https://npmmirror.com/mirrors/playwright/"
    info "China mirrors enabled (pip: tuna, npm: npmmirror, playwright: npmmirror)"
    echo ""
fi

ERRORS=0

# ── Step 2a: Homebrew (macOS only) ──
if [ "$PLATFORM" = "mac" ]; then
    echo "--- [1/8] Homebrew (macOS package manager) ---"
    if command -v brew &>/dev/null; then
        ok "brew installed"
    else
        fail "brew not found — needed for installing python3 and node on macOS"
        info "Install: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        ERRORS=$((ERRORS + 1))
    fi
    echo ""
fi

# ── Step 2b: Python 3 ──
echo "--- [2/8] Python 3 ---"
if command -v python3 &>/dev/null; then
    PY_VER=$(python3 --version 2>&1)
    ok "python3 ($PY_VER)"
    if [ "$PLATFORM" = "mac" ]; then
        PY_PATH=$(which python3 2>/dev/null)
        if [[ "$PY_PATH" == "/usr/bin/python3" ]]; then
            warn "Using macOS system Python (limited). Recommend: brew install python3"
        fi
    fi
else
    fail "python3 not found"
    case "$PLATFORM" in
        mac)   info "Install: brew install python3" ;;
        linux) info "Install: sudo apt install python3 python3-pip   (Debian/Ubuntu)"
               info "         sudo dnf install python3 python3-pip   (Fedora/RHEL)" ;;
    esac
    ERRORS=$((ERRORS + 1))
fi
echo ""

# ── Step 2c: pip ──
echo "--- [3/8] pip ---"
if python3 -m pip --version &>/dev/null 2>&1; then
    ok "pip installed"
else
    fail "pip not found"
    case "$PLATFORM" in
        mac)   info "Install: python3 -m ensurepip --upgrade" ;;
        linux) info "Install: sudo apt install python3-pip   (Debian/Ubuntu)" ;;
    esac
    ERRORS=$((ERRORS + 1))
fi
echo ""

# ── Step 2d: Python packages ──
echo "--- [4/8] Python Packages (matplotlib, seaborn, numpy, adjustText) ---"
PY_PKGS=(
    "matplotlib:matplotlib"
    "seaborn:seaborn"
    "numpy:numpy"
    "adjustText:adjustText"
)

MISSING_PY=()
for entry in "${PY_PKGS[@]}"; do
    mod="${entry%%:*}"
    pkg="${entry##*:}"
    if python3 -c "import $mod" 2>/dev/null; then
        ver=$(python3 -c "import $mod; print(getattr($mod, '__version__', 'ok'))" 2>/dev/null)
        ok "$pkg ($ver)"
    else
        fail "$pkg not installed"
        MISSING_PY+=("$pkg")
    fi
done

if [ ${#MISSING_PY[@]} -gt 0 ]; then
    info "Installing missing Python packages: ${MISSING_PY[*]}"
    # shellcheck disable=SC2086
    python3 -m pip install -q $PIP_MIRROR_ARGS "${MISSING_PY[@]}" 2>/dev/null \
        || python3 -m pip install -q --user $PIP_MIRROR_ARGS "${MISSING_PY[@]}" 2>/dev/null \
        || python3 -m pip install -q --break-system-packages $PIP_MIRROR_ARGS "${MISSING_PY[@]}" 2>/dev/null \
        || { fail "pip install failed. Try: pip install $PIP_MIRROR_ARGS ${MISSING_PY[*]}"; ERRORS=$((ERRORS + 1)); }
    ok "Installed: ${MISSING_PY[*]}"
fi
echo ""

# ── Step 2e: Node.js + npm ──
echo "--- [5/8] Node.js + npm ---"
if command -v node &>/dev/null; then
    ok "node ($(node --version))"
else
    fail "node not found"
    case "$PLATFORM" in
        mac)   info "Install: brew install node" ;;
        linux) info "Install: curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -"
               info "         sudo apt install -y nodejs"
               if [ "$USE_CN_MIRROR" = true ]; then
                   info "China alt: https://npmmirror.com/mirrors/node/ download and install manually"
               fi ;;
    esac
    ERRORS=$((ERRORS + 1))
fi

if command -v npm &>/dev/null; then
    ok "npm ($(npm --version))"
else
    fail "npm not found"
    ERRORS=$((ERRORS + 1))
fi
echo ""

# ── Step 2f: Playwright + Chromium ──
echo "--- [6/8] Playwright + Chromium ---"
if node -e "require('playwright')" 2>/dev/null; then
    PW_VER=$(node -e "console.log(require('playwright/package.json').version)" 2>/dev/null)
    ok "playwright ($PW_VER)"
else
    fail "playwright not installed"
    if [ "$USE_CN_MIRROR" = true ]; then
        info "Install: npm install -g playwright@1.50.0 $NPM_MIRROR_ARGS"
    else
        info "Install: npm install -g playwright@1.50.0"
    fi
    ERRORS=$((ERRORS + 1))
fi

if [ "$PLATFORM" = "mac" ]; then
    PW_CACHE="$HOME/Library/Caches/ms-playwright"
else
    PW_CACHE="$HOME/.cache/ms-playwright"
fi

if ls "$PW_CACHE"/chromium-* &>/dev/null 2>&1; then
    ok "chromium installed"
else
    fail "chromium not installed"
    if [ "$USE_CN_MIRROR" = true ]; then
        info "Install: PLAYWRIGHT_DOWNLOAD_HOST=$PLAYWRIGHT_HOST npx playwright install chromium"
    else
        info "Install: npx playwright install chromium"
    fi
    if [ "$PLATFORM" = "linux" ]; then
        info "         npx playwright install-deps   (system libs, needs sudo)"
    fi
    ERRORS=$((ERRORS + 1))
fi
echo ""

# ── Step 2g: Font Installation (from CDN) ──
echo "--- [7/8] Font Installation ---"
FONT_CDN_BASE="https://z-cdn.chatglm.cn/office-skill/fonts"
FONT_LIST="$SCRIPT_DIR/font_list.txt"

if [ "$PLATFORM" = "mac" ]; then
    USER_FONT_DIR="$HOME/Library/Fonts"
else
    USER_FONT_DIR="$HOME/.local/share/fonts"
fi
mkdir -p "$USER_FONT_DIR"

MARKER="$USER_FONT_DIR/.office-skill-fonts-installed"
if [ -f "$MARKER" ]; then
    ok "Fonts already installed (marker found). To re-install, delete $MARKER"
else
    if [ ! -f "$FONT_LIST" ]; then
        fail "Font list not found: $FONT_LIST"
        ERRORS=$((ERRORS + 1))
    else
        TOTAL=$(wc -l < "$FONT_LIST" | tr -d ' ')
        INSTALLED=0
        SKIPPED=0
        FAILED=0
        info "Downloading $TOTAL fonts from CDN..."
        
        while IFS= read -r rel_path || [ -n "$rel_path" ]; do
            [ -z "$rel_path" ] && continue
            fname="$(basename "$rel_path")"
            
            if [ -f "$USER_FONT_DIR/$fname" ]; then
                SKIPPED=$((SKIPPED + 1))
                continue
            fi
            
            # URL-encode special chars (brackets)
            encoded=$(echo "$rel_path" | sed 's/\[/%5B/g; s/\]/%5D/g; s/ /%20/g')
            url="$FONT_CDN_BASE/$encoded"
            
            if curl -fSL --connect-timeout 15 --retry 2 -o "$USER_FONT_DIR/$fname" "$url" 2>/dev/null; then
                INSTALLED=$((INSTALLED + 1))
            else
                warn "Failed to download: $rel_path"
                FAILED=$((FAILED + 1))
                rm -f "$USER_FONT_DIR/$fname" 2>/dev/null
            fi
        done < "$FONT_LIST"
        
        if [ "$PLATFORM" = "linux" ] && [ $INSTALLED -gt 0 ]; then
            fc-cache -f "$USER_FONT_DIR" 2>/dev/null
        fi
        
        if [ $FAILED -eq 0 ]; then
            touch "$MARKER"
            ok "Fonts: $INSTALLED newly installed, $SKIPPED already present (target: $USER_FONT_DIR)"
        else
            warn "Fonts: $INSTALLED installed, $SKIPPED skipped, $FAILED failed (marker not written, will retry next run)"
            ERRORS=$((ERRORS + 1))
        fi
    fi
fi

# Set CHARTS_FONTS_DIR to user font directory (fonts are now installed there)
CHARTS_FONTS_DIR="$USER_FONT_DIR"
export CHARTS_FONTS_DIR
echo ""

# ── Step 2h: Verify CJK Fonts ──
echo "--- [8/8] CJK Font Verification ---"
CJK_FOUND=false

if [ "$PLATFORM" = "mac" ]; then
    if [ -f "$HOME/Library/Fonts/NotoSansSC[wght].ttf" ] || fc-list :lang=zh 2>/dev/null | head -1 | grep -q .; then
        ok "CJK fonts available (Noto Sans SC or system)"
        CJK_FOUND=true
    fi
    if [ -f "$HOME/Library/Fonts/NotoSansSC[wght].ttf" ]; then
        ok "Noto Sans SC (user fonts)"
        CJK_FOUND=true
    fi
elif [ "$PLATFORM" = "linux" ]; then
    if fc-list :lang=zh 2>/dev/null | head -1 | grep -q .; then
        ok "CJK fonts available (fc-list)"
        CJK_FOUND=true
    fi
fi

if [ "$CJK_FOUND" = false ]; then
    warn "No CJK font detected — Chinese labels may show as squares"
    info "Bundled fonts were copied; restart your app or rebuild font cache"
fi
echo ""

# ── Summary ──
echo "============================================"
if [ $ERRORS -eq 0 ]; then
    echo "  All dependencies OK."
else
    echo "  $ERRORS issue(s) found. Fix them above."
fi
echo "  CHARTS_SKILL_DIR=$CHARTS_SKILL_DIR"
echo "  CHARTS_FONTS_DIR=$CHARTS_FONTS_DIR (user font directory)"
echo "============================================"
