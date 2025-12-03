#!/bin/bash
source "$SCRIPT_DIR/settings.sh" 

# 설정 메뉴
settings_menu() {
    while true; do
        clear
        echo "==========================="
        echo "        설정"
        echo "==========================="
        echo "1) 환경변수 보기"
        echo "2) 환경변수 설정 (export)"
        echo "3) 단어 파일 경로 변경"
        echo "4) 설정"
        echo "0) 돌아가기"
        echo "---------------------------"
        read -p "선택: " choice

        case "$choice" in
            1)
                show_env_variables
                ;;
            2)
                set_env_variable
                ;;
            3)
                change_word_file
                ;;
            4)
                settings_menu 
                ;;
            0)
                return
                ;;
            *)
                echo "❌ 잘못된 입력입니다."
                sleep 1
                ;;
        esac
    done
}

# 환경변수 보기
show_env_variables() {
    clear
    echo "==========================="
    echo "     현재 환경변수"
    echo "==========================="
    echo "HOME: $HOME"
    echo "USER: $USER"
    echo "SHELL: $SHELL"
    echo "PWD: $PWD"
    echo "LANG: ${LANG:-not set}"
    echo "TERM: ${TERM:-not set}"
    echo
    echo "게임 설정:"
    echo "WORD_FILE: $WORD_FILE"
    echo "RANKING_FILE: $RANKING_FILE"
    echo "LOG_FILE: $LOG_FILE"
    echo
    read -p "엔터를 누르세요..." _wait
}

# 환경변수 설정
set_env_variable() {
    clear
    echo "==========================="
    echo "   환경변수 설정"
    echo "==========================="
    echo
    read -p "변수 이름 (예: GAME_AUTHOR): " var_name
    read -p "변수 값: " var_value

    if [[ -n "$var_name" && -n "$var_value" ]]; then
        export "$var_name=$var_value"
        echo "✅ $var_name=$var_value 설정 완료"
        log_message "INFO" "Environment variable set: $var_name=$var_value"
    else
        echo "❌ 변수 이름과 값을 모두 입력해주세요."
    fi

    echo
    read -p "엔터를 누르세요..." _wait
}

# 단어 파일 경로 변경
change_word_file() {
    clear
    echo "==========================="
    echo "   단어 파일 경로 변경"
    echo "==========================="
    echo
    echo "현재 경로: $WORD_FILE"
    echo
    read -p "새로운 경로 (엔터=취소): " new_path

    if [[ -z "$new_path" ]]; then
        echo "취소되었습니다."
    elif [[ -f "$new_path" ]]; then
        WORD_FILE="$new_path"
        export WORD_FILE
        echo "✅ 단어 파일이 변경되었습니다: $WORD_FILE"
        log_message "INFO" "Word file changed to: $WORD_FILE"
    else
        echo "❌ 파일이 존재하지 않습니다: $new_path"
    fi

    echo
    read -p "엔터를 누르세요..." _wait
}