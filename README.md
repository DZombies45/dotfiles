# 🛠️ Dotfiles

Repo ini berisi konfigurasi pribadi saya untuk **Linux/Termux** yang dikelola menggunakan [GNU Stow](https://www.gnu.org/software/stow/).

> Klik di bawah untuk membaca versi bahasa Inggris.  
> *Click below to read the English version.*

<details>
<summary>🌐 English Version</summary>

This repository contains my personal configuration files for **Linux/Termux**, managed with [GNU Stow](https://www.gnu.org/software/stow/).  
It helps keep my setup consistent, portable, and version-controlled.

</details>

---

## 📂 Struktur Direktori

dotfiles/ ├── .stowrc                # konfigurasi ignore untuk stow ├── README.md              # dokumentasi ini ├── config/                # konfigurasi umum aplikasi ├── home/                  # file di $HOME ├── mc/                    # tools untuk Minecraft Bedrock dev ├── termux/                # konfigurasi khusus Termux └── conf-*/                # konfigurasi aplikasi spesifik (neofetch, nvim, dll)

Contoh isi aktual:

 ./ ├──  .git/ ├──  conf-bat/ ├──  conf-lazygit/ ├──  conf-neofetch/ ├──  conf-nvim/ ├──  conf-ranger/ ├──  conf-starship/ ├──  home/          # berisi file di $HOME (contoh: .bashrc) ├──  mc/            # alat bantu dev Minecraft ├──  termux/        # konfigurasi Termux ├──  .gitignore ├──  .stowrc └──  README.md

<details>
<summary>🌐 English</summary>

### Directory Structure

Each folder mirrors its destination in `$HOME`.  
Example:  
`home/.bashrc` → `~/.bashrc`  
`config/.config/nvim` → `~/.config/nvim`

</details>

---

## 🚀 Cara Pakai

### 1️⃣ Clone repo

```bash
git clone https://github.com/DZombies45/dotfiles.git ~/dotfiles
cd ~/dotfiles

<details>
<summary>🌐 English</summary>Clone this repository to your home directory.

</details>
---

2️⃣ Install GNU Stow

Debian/Ubuntu/Termux

sudo apt install stow

Arch Linux

sudo pacman -S stow

<details>
<summary>🌐 English</summary>Install GNU Stow according to your system.

</details>
---

3️⃣ Stow konfigurasi yang diinginkan

cd ~/dotfiles

# Untuk ~/.config
stow config

# Untuk file di $HOME
stow home

# Untuk Minecraft Bedrock dev tools
stow mc

# Untuk Termux setup
stow termux

Atau semua sekaligus:

stow */

<details>
<summary>🌐 English</summary>Use stow to symlink configurations.
You can link specific folders or all at once using stow */.

</details>
---

4️⃣ Verifikasi hasil

ls -l ~ | grep dotfiles

<details>
<summary>🌐 English</summary>Check whether symlinks were created successfully.

</details>
---

⚡ Catatan

Struktur setiap folder di repo harus mencerminkan struktur di $HOME.

Jika ada file existing di $HOME, pindahkan dulu sebelum stow agar tidak konflik:


mv ~/.bashrc ~/dotfiles/home/.bashrc
stow home

Untuk re-link dotfile pakai:


cd ~/dotfiles
stow -R */

<details>
<summary>🌐 English</summary>Each folder must mirror the path in $HOME.
Move existing files out before stowing to avoid conflicts.
To refresh symlinks:

cd ~/dotfiles
stow -R */

</details>
---

💡 Tips

stow -D <folder> untuk unstow konfigurasi (hapus symlink)

Simpan repo di ~/dotfiles agar path tetap konsisten

Untuk Termux, aktifkan izin penyimpanan:

termux-setup-storage


<details>
<summary>🌐 English</summary>Use stow -D <folder> to remove a symlink.

Keep this repo at ~/dotfiles for consistent paths.

In Termux, enable storage permissions:

termux-setup-storage


</details>
---

📌 Referensi

GNU Stow Manual

Managing Dotfiles with GNU Stow – Alex Pearce



---

🧠 Tujuan

Menjaga konfigurasi tetap sinkron, mudah dipindah, dan versioned.
Dengan satu perintah, seluruh lingkungan kerja bisa direplikasi.

<details>
<summary>🌐 English</summary>Keep configurations synchronized, portable, and versioned.
With a single command, the entire working environment can be replicated anywhere.

</details>
```
