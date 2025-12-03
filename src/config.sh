#!/bin/bash

# ================================
# 공통 설정 / 전역 변수
# ================================
WORD_FILE="./word.txt"          # 없으면 /usr/share/dict/words 사용
RANKING_FILE="./ranking.txt"
LOG_FILE="./game.log" 

USERNAME=""                     # 사용자 이름 저장
DIFF_NAME=""                    # 난이도 이름 (Easy/Normal/Hard)
DIFF_WORD_COUNT=0               # 난이도별 단어 개수
DIFF_MULTIPLIER=1               # 점수 보정용 배수 (Easy=1, Normal=2, Hard=3)

TOTAL_WORDS=0                   # 전체 출제 단어 수
CORRECT_WORDS=0                 # 맞춘 단어 수
ELAPSED_TIME=0                  # 걸린 시간(초)
FINAL_SCORE=0                   # 최종 점수

# ==========================================
# 공백/CRLF 제거용 공통 함수
# ==========================================
trim() {
    # 인자로 받은 문자열에서 \r 제거하고, 앞뒤 공백/탭/개행 제거
    printf "%s" "$1" | tr -d '\r' | xargs
}

# ==========================================
# Ctrl+C(SIGINT) 처리
# ==========================================
handle_sigint() {
    echo
    echo "⚠  게임이 강제 종료되었습니다. (Ctrl+C)"
    echo "   진행 중이던 점수는 저장되지 않습니다."
    log_message "WARN" "Game interrupted by user (Ctrl+C)" 
    exit 1
}
trap handle_sigint SIGINT

# ==========================================
# 단어 파일 존재 여부 확인
# ==========================================
init_word_file() {
    if [[ ! -f "$WORD_FILE" ]]; then
        if [[ -f "/usr/share/dict/words" ]]; then
            WORD_FILE="/usr/share/dict/words"
            log_message "INFO" "Using system dictionary: /usr/share/dict/words"  # 🆕
        else
            echo "❌ word.txt 또는 /usr/share/dict/words 를 찾을 수 없습니다."
            log_message "ERROR" "No dictionary file found" 
            exit 1
        fi
    else
        log_message "INFO" "Using word file: $WORD_FILE" 
    fi
}
