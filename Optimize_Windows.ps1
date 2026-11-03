# ==========================================
# WINDOWS 11 OPTIMIZATION SCRIPT
# Dibuat khusus untuk performa maksimal
# ==========================================

# Memastikan script dijalankan sebagai Administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Harap jalankan script ini sebagai Administrator! (Klik kanan -> Run with PowerShell)" -ForegroundColor Red
    Start-Sleep -Seconds 5
    exit
}

Clear-Host
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " MEMULAI OPTIMASI WINDOWS 11..." -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. MEMBERSIHKAN FILE SAMPAH & CACHE
Write-Host "`n[1/5] Membersihkan file sampah sistem dan cache..." -ForegroundColor Yellow
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Users\*\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
# Bersihkan Recycle Bin
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

# 2. MENGOPTIMALKAN VISUAL EFFECTS (Kinerja UI)
Write-Host "`n[2/5] Mengoptimalkan animasi visual untuk performa..." -ForegroundColor Yellow
# Mengatur Visual Effects untuk kinerja terbaik (Best Performance)
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00)) -ErrorAction SilentlyContinue

# 3. MENONAKTIFKAN TELEMETRI & APLIKASI LATAR BELAKANG
Write-Host "`n[3/5] Mengurangi beban latar belakang & telemetri..." -ForegroundColor Yellow
# Menonaktifkan Game DVR / Background Recording (jika tidak dipakai untuk rekam layar)
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -ErrorAction SilentlyContinue
# Menonaktifkan Tips dan Saran Windows
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0 -ErrorAction SilentlyContinue

# 4. MENGOPTIMALKAN JARINGAN & DNS
Write-Host "`n[4/5] Membersihkan cache jaringan (DNS)..." -ForegroundColor Yellow
Clear-DnsClientCache
ipconfig /flushdns | Out-Null

# 5. MENINGKATKAN KINERJA PENYIMPANAN
Write-Host "`n[5/5] Mengoptimalkan manajemen daya..." -ForegroundColor Yellow
# Mengaktifkan Ultimate Performance / High Performance secara otomatis jika tersedia
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null

Write-Host "`n==========================================" -ForegroundColor Green
Write-Host " OPTIMASI SELESAI!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Disarankan untuk me-restart laptop kamu agar semua perubahan diterapkan dengan sempurna." -ForegroundColor Yellow

Read-Host "`nTekan Enter untuk keluar"