# 🛠️ Dotfiles

Repo ini berisi konfigurasi pribadi saya untuk **Linux/Termux** yang dikelola dengan [GNU Stow](https://www.gnu.org/software/stow/).

## 📦 Struktur Direktori

```
dotfiles/
├── .stowrc                # untuk mengsetup custom ignore
├── README.md              # Dokumentasi ini
├── config/                # Konfigurasi aplikasi umum
├── home/                  # File di $HOME
├── mc/                    # Tools untuk minecraft bedrock dev
└── termux/                # Konfigurasi khusus Termux
```

## 🚀 Cara Pakai

### 1. Clone repo

```bash
git clone https://github.com/DZombies45/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Install GNU Stow

- **Debian/Ubuntu/Termux**:
  ```bash
  sudo apt install stow
  ```
- **Arch Linux**:
  ```bash
  sudo pacman -S stow
  ```

### 3. Stow konfigurasi yang diinginkan

Contoh:

```bash
cd ~/dotfiles

# Untuk config di ~/.config
stow config

# Untuk .bashrc
stow home

# Untuk Minecraft bedrock dev tools
stow mc

# Untuk Termux
stow termux
```

Atau stow semua sekaligus:

```bash
stow */
```

### 4. Verifikasi

Cek apakah symlink sudah terbentuk:

```bash
ls -l ~ | grep dotfiles
```

---

## ⚡ Catatan

- Struktur setiap folder di repo **harus mencerminkan struktur di `$HOME`**.  
  Contoh: `home/.bashrc` → `~/.bashrc`, `config/.config/nvim` → `~/.config/nvim`.
- Jika ada file existing di `$HOME`, **pindahkan dulu** sebelum stow, agar tidak konflik.
  ```bash
  mv ~/.bashrc ~/dotfiles/home/.bashrc
  stow home
  ```

---

## 📌 Referensi

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Managing Dotfiles with GNU Stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
