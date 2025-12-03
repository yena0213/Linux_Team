
WORD_FILE="./word.txt"         
RANKING_FILE="./ranking.txt"
LOG_FILE="./game.log" 

USERNAME=""                    
DIFF_NAME=""                    
DIFF_WORD_COUNT=0              
DIFF_MULTIPLIER=1              

TOTAL_WORDS=0                   
CORRECT_WORDS=0                 
ELAPSED_TIME=0                  
FINAL_SCORE=0                  


trim() {
    printf "%s" "$1" | tr -d '\r' | xargs
}

handle_sigint() {
    echo
    echo "⚠  게임이 강제 종료되었습니다. (Ctrl+C)"
    echo "   진행 중이던 점수는 저장되지 않습니다."
    log_message "WARN" "Game interrupted by user (Ctrl+C)" 
    exit 1
}
trap handle_sigint SIGINT

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
