#!/bin/bash

echo "Script yang akan mengorganisir file secara interaktif dengan menyalinnya ke dalam subdirektori.
      ----------------------------------------------------
      Dibuat oleh Flasher∅ / Fadhil Efendi Firdaus."

echo "Silakan pilih direktori untuk diorganisir (file akan disalin):"

# mencari semua direktori di lokasi saat ini dan simpan dalam sebuah array.
mapfile -t daftar_direktori < <(find . -maxdepth 1 -mindepth 1 -type d)

# memeriksa apakah ada direktori yang ditemukan.
if [ ${#daftar_direktori[@]} -eq 0 ]; then
  echo "Tidak ada subdirektori yang ditemukan di lokasi saat ini."
  exit 0
fi

# membuat menu untuk pemilihan direktori.
select direktori in "${daftar_direktori[@]}"; do
  if [[ -n "$direktori" ]]; then
    DIREKTORI_TUJUAN="$direktori"
    break
  else
    echo "Pilihan tidak valid. Silakan coba lagi."
  fi
done

# memastikan direktori tujuan ada sebelum melanjutkan.
if [ ! -d "$DIREKTORI_TUJUAN" ]; then
  echo "Error: Direktori '$DIREKTORI_TUJUAN' tidak ditemukan."
  exit 1
fi

echo "Mengorganisir direktori dengan menyalin file: $DIREKTORI_TUJUAN"

# pindah ke direktori tujuan untuk mempermudah operasi file.
cd "$DIREKTORI_TUJUAN" || exit

# pemeriksaan isi
for berkas in *; do
  # periksa apakah itu file biasa dan bukan direktori.
  if [ -f "$berkas" ]; then
    # ekstrak ekstensi file.
    ekstensi="${berkas##*.}"

    # jika file tidak memiliki ekstensi, gunakan folder 'lain-lain'.
    if [[ "$berkas" == "$ekstensi" ]]; then
      ekstensi="rareti_bruh"
    fi

    # mengubah ekstensi menjadi huruf kecil.
    nama_folder=$(echo "$ekstensi" | tr '[:upper:]' '[:lower:]')

    # membuat folder tujuan jika belum ada.
    mkdir -p "$nama_folder"

    # menyalin file ke folder yang sesuai.
    echo "Menyalin '$berkas' ke '$nama_folder/'"
    cp "$berkas" "$nama_folder/"
  fi
done

echo "Pengorganisasian direktori selesai."
