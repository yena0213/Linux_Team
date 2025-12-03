
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/difficulty.sh"
source "$SCRIPT_DIR/score.sh"
source "$SCRIPT_DIR/ranking.sh"
source "$SCRIPT_DIR/game.sh"
source "$SCRIPT_DIR/log_viewer.sh"
source "$SCRIPT_DIR/setting.sh"
source "$SCRIPT_DIR/system_info.sh"

main_menu() {
    while true; do
        clear
        echo "==========================="
        echo "   Shell 타이핑 게임"
        echo "==========================="
        echo "1) 게임 시작"
        echo "2) 랭킹 보기"
        echo "3) 로그 조회"      
        echo "4) 설정"
        echo "5) 시스템 정보"         
        echo "6) 게임 통계"       
        echo "0) 종료"
        echo "---------------------------"
        read -p "메뉴를 선택하세요: " menu

        case "$menu" in
            1)
                play_game
                read -p "엔터를 누르면 메뉴로 돌아갑니다..." _wait
                ;;
            2)
                clear
                show_ranking
                read -p "엔터를 누르면 메뉴로 돌아갑니다..." _wait
                ;;
            3)
                show_game_log
                read -p "엔터를 누르면 메뉴로 돌아갑니다..." _wait
                ;;
            4)
                settings_menu    
                read -p "엔터를 누르면 메뉴로 돌아갑니다..." _wait
                ;;
            5)
                show_system_info
                read -p "엔터를 누르면 메뉴로 돌아갑니다..." _wait
                ;;
            6)
                show_game_statistics
                read -p "엔터를 누르면 메뉴로 돌아갑니다..." _wait
                ;;
            0)
                echo "게임을 종료합니다. 👋"
                log_message "INFO" "Application terminated"  
                exit 0
                ;;
            *)
                echo "❌ 잘못된 입력입니다."
                sleep 1
                ;;
        esac
    done
}

init_word_file
main_menu