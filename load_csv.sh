#!/bin/bash
DEST_DIR="/var/lib/mysql-files"

echo "Copying CSV files to MySQL secure directory..."
sudo cp "Ceremony.csv" "$DEST_DIR"/
echo "✅ Ceremony CSV moved"



sudo cp "ACat.csv" "$DEST_DIR"/
echo "✅ ACat CSV moved and ready"


sudo cp "Nom.csv" "$DEST_DIR"/
echo "✅ Nom CSV moved and ready"


sudo cp "Person.csv" "$DEST_DIR"/
echo "✅ Person CSV moved and ready"


sudo cp "Film.csv" "$DEST_DIR"/
echo "✅ Film CSV moved and ready"


sudo cp "ApartOf.csv" "$DEST_DIR"/
echo "✅ ApartOf CSV moved and ready"


sudo cp "Awards.csv" "$DEST_DIR"/
echo "✅ Awards CSV moved and ready"


sudo cp "Presents.csv" "$DEST_DIR"/
echo "✅ Presents CSV moved and ready"

