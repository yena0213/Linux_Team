
play_game() {
    clear
    echo "==========================="
    echo "     타이핑 게임 시작!"
    echo "==========================="

   
    select_difficulty || return

    echo
    read -p "플레이어 이름을 입력하세요: " USERNAME
    USERNAME=$(trim "$USERNAME")
    if [[ -z "$USERNAME" ]]; then
        USERNAME="anonymous"
    fi

    log_message "INFO" "Game started: Player=$USERNAME, Difficulty=$DIFF_NAME, Words=$DIFF_WORD_COUNT"

    echo
    echo "▶ $USERNAME 님, $DIFF_NAME 난이도로 시작합니다."
    echo "   아래에 보이는 단어를 그대로 입력하세요."
    echo "   (엔터로 제출)"
    echo
    read -p "준비되면 엔터를 누르세요..." _dummy

    clear

    TOTAL_WORDS=$DIFF_WORD_COUNT
    CORRECT_WORDS=0
    SECONDS=0           
    for (( i=0; i<TOTAL_WORDS; i++ )); do
        
        TARGET=$(shuf "$WORD_FILE" | head -n 1)
        TARGET_CLEAN=$(trim "$TARGET")

        clear
        echo "---------------------------"
        echo "단어 $((i+1)) / $TOTAL_WORDS"
        echo "---------------------------"
        echo "👉  $TARGET_CLEAN"
        echo
        read -r -p "입력: " INPUT

        INPUT_CLEAN=$(trim "$INPUT")

        if [[ "$INPUT_CLEAN" = "$TARGET_CLEAN" ]]; then
            echo "✅ 정답!"
            ((CORRECT_WORDS++))
        else
            echo "❌ 오답! (정답: $TARGET_CLEAN)"
            log_message "DEBUG" "Wrong answer: Expected='$TARGET_CLEAN', Got='$INPUT_CLEAN'" 
        fi

        sleep 1
    done

    ELAPSED_TIME=$SECONDS   
    echo
    echo "==========================="
    echo "   게임 종료!"
    echo "==========================="
    echo "총 단어 수   : $TOTAL_WORDS"
    echo "맞춘 단어 수 : $CORRECT_WORDS"
    echo "걸린 시간    : ${ELAPSED_TIME}초"
    echo

    calculate_score
    save_ranking

    log_message "INFO" "Game finished: Player=$USERNAME, Score=$FINAL_SCORE, Correct=$CORRECT_WORDS/$TOTAL_WORDS, Time=${ELAPSED_TIME}s"
}