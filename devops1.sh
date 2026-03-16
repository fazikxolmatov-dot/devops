#!/bin/bash

# Muallif: DevOps Mentor
# Vazifa: Foydalanuvchi hisoblarini boshqarish skripti

# 1-qism: Yordam (Help) funksiyasi
show_help() {
    echo "Foydalanish: ./user_management.sh [OPTION]"
    echo "Opsiyalar:"
    echo "  -c, --create    Yangi foydalanuvchi yaratish"
    echo "  -d, --delete    Mavjud foydalanuvchini o'chirish"
    echo "  -r, --reset     Parolni qayta o'rnatish"
    echo "  -l, --list      Barcha foydalanuvchilar ro'yxatini ko'rish"
    echo "  -h, --help      Yordam menyusini ko'rsatish"
}

# 2-qism: Foydalanuvchi yaratish
create_user() {
    read -p "Yangi foydalanuvchi nomini kiriting: " username
    # Foydalanuvchi mavjudligini tekshirish
    if id "$username" &>/dev/null; then
        echo "Xato: '$username' foydalanuvchisi tizimda mavjud!"
        exit 1
    else
        read -s -p "Parolni kiriting: " password
        echo
        sudo useradd -m "$username"
        echo "$username:$password" | sudo chpasswd
        echo "Muvaffaqiyatli: '$username' yaratildi."
    fi
}

# 3-qism: Foydalanuvchini o'chirish
delete_user() {
    read -p "O'chirmoqchi bo'lgan foydalanuvchi nomini kiriting: " username
    if id "$username" &>/dev/null; then
        sudo userdel -r "$username"
        echo "Muvaffaqiyatli: '$username' va uning uy papkasi o'chirildi."
    else
        echo "Xato: '$username' foydalanuvchisi topilmadi!"
        exit 1
    fi
}

# 4-qism: Parolni yangilash
reset_password() {
    read -p "Foydalanuvchi nomini kiriting: " username
    if id "$username" &>/dev/null; then
        read -s -p "Yangi parolni kiriting: " password
        echo
        echo "$username:$password" | sudo chpasswd
        echo "Muvaffaqiyatli: '$username' paroli yangilandi."
    else
        echo "Xato: '$username' topilmadi!"
        exit 1
    fi
}

# 5-qism: Ro'yxatni ko'rish
list_users() {
    echo "Tizimdagi foydalanuvchilar (Username:UID):"
    # /etc/passwd faylidan foydalanuvchi nomi va UIDni ajratib olish
    awk -F: '{ printf "User: %-15s UID: %s\n", $1, $3 }' /etc/passwd
}

# 6-qism: Argumentlarni tahlil qilish (Main Logic)
if [[ $# -eq 0 ]]; then
    show_help
    exit 1
fi

case "$1" in
    -c|--create) create_user ;;
    -d|--delete) delete_user ;;
    -r|--reset)  reset_password ;;
    -l|--list)   list_users ;;
    -h|--help)   show_help ;;
    *) echo "Noto'g'ri opsiya!"; show_help; exit 1 ;;
esac
