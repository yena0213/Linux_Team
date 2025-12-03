show_game_log() {
    clear
    echo "==========================="
    echo "      게임 로그 조회"
    echo "==========================="

    if [[ ! -f "$LOG_FILE" || ! -s "$LOG_FILE" ]]; then
        echo "로그 파일이 없습니다."
        echo
        return
    fi

    echo "1) 전체 로그 보기"
    echo "2) INFO 로그만 보기"
    echo "3) ERROR/WARN 로그만 보기"
    echo "4) 최근 20줄 보기"
    echo "0) 돌아가기"
    echo "---------------------------"
    read -p "선택: " choice

    echo

    case "$choice" in
        1)
            cat "$LOG_FILE"
            ;;
        2)
            sed -n '/\[INFO\]/p' "$LOG_FILE"
            ;;
        3)
            sed -n '/\[ERROR\]\|\[WARN\]/p' "$LOG_FILE"
            ;;
        4)
            tail -20 "$LOG_FILE"
            ;;
        0)
            return
            ;;
        *)
            echo "❌ 잘못된 입력입니다."
            ;;
    esac

    echo
}