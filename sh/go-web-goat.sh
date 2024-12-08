#!/bin/bash

SH_DIR=$(cd $(dirname $0); pwd)
ROOT_DIR=$(cd $(dirname $0); cd ../; pwd)
CLONE_DIR=$(cd $(dirname $0); cd ../clone; pwd)

# GOATリポジトリのクローン
rm -rf "$CLONE_DIR/goat"
if ! git clone https://github.com/kodaimura/goat.git "$CLONE_DIR/goat"; then
    echo -e "\033[31m❌ Error: Failed to clone the GOAT repository.\033[0m"
    exit 1
fi
chmod -R +x "$CLONE_DIR/goat/bin"

# プロジェクト名の取得
while true; do
    echo ""
    echo -e "\033[32m🐐 Please enter your GOAT Project Name:\033[0m"
    echo -n ">> "
    read appname
    
    if [ -n "$appname" ]; then
        break
    fi
    echo -e "\033[31m⚠️ Error: Project name cannot be empty. Please try again.\033[0m"
done

# データベースタイプの取得
while true; do
    echo ""
    echo -e "\033[32m🔌 Please enter the type of database (sqlite3 | postgres | mysql):\033[0m"
    echo -n ">> "
    read database
    
    case $database in
        sqlite3|postgres|mysql)
            break
            ;;
        *)
            echo -e "\033[31m⚠️ Error: Invalid database type. Please choose sqlite3, postgres, or mysql.\033[0m"
            ;;
    esac
done

# アプリケーションの作成
if ! "$CLONE_DIR/goat/bin/goat-create-app" "$appname" -db "$database"; then
    echo -e "\033[31m❌ Error: Failed to create the application.\033[0m"
    exit 1
fi

echo ""
echo -e "\033[34m🎉 Success! Your GOAT project '$appname' has been created with the '$database' database!\033[0m"
