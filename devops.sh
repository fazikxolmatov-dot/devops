#!/bin/bash 
# Muallif: DevOps Mentor
# Vazifa: Interaktiv fayl va matn tadqiqotchisi

echo "Welcome to the Interactive File and Directory Explorer!"

# 1-Qism: Fayllar ro'yxatini ko'rsatish tsikli
while true; do
    echo -e "\nFiles and Directories in the Current Path:"
    
    # ls -lh: inson o'qiy oladigan hajmda ko'rsatish
    # awk: faqat 9-ustun (nomi) va 5-ustunni (hajmi) chop etish
    ls -lh | awk 'NR>1 {print "- " $9 " (" $5 ")"}'

    echo -e "\n--- Part 2: Character Counting ---"
    
    # 2-Qism: Foydalanuvchidan matn kiritishni so'rash
    while true; do
        read -p "Enter a line of text (Press Enter without text to exit): " input
        
        # Agar foydalanuvchi bo'sh joy qoldirib Enter bossa, tsikldan chiqamiz
        if [[ -z "$input" ]]; then
            echo "Exiting the Interactive Explorer. Goodbye!"
            exit 0
        fi
        
        # Belgilar sonini hisoblash
        # echo -n yangi qator belgisini (\n) sanamaslik uchun kerak
        char_count=$(echo -n "$input" | wc -m)
        echo "Character Count: $char_count"
        echo ""
    done
done
