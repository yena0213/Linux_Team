#!/bin/bash

# 게임 플레이 기능
play_game() {
    clear
    echo "==========================="
    echo "     타이핑 게임 시작!"
    echo "==========================="

    # 난이도 먼저 선택
    select_difficulty || return

    echo
    read -p "플레이어 이름을 입력하세요: " USERNAME
    USERNAME=$(trim "$USERNAME")
    if [[ -z "$USERNAME" ]]; then
        USERNAME="anonymous"
    fi

    echo
    echo "▶ $USERNAME 님, $DIFF_NAME 난이도로 시작합니다."
    echo "   아래에 보이는 단어를 그대로 입력하세요."
    echo "   (엔터로 제출)"
    echo
    read -p "준비되면 엔터를 누르세요..." _dummy

    clear

    TOTAL_WORDS=$DIFF_WORD_COUNT
    CORRECT_WORDS=0
    SECONDS=0           # SECONDS 변수 초기화 (bash 내장: 경과 시간)

    # ─────────────────────────────
    #  단어 하나씩 뽑아서 비교 (CRLF/공백 방어)
    # ─────────────────────────────
    for (( i=0; i<TOTAL_WORDS; i++ )); do
        # 랜덤 단어 1개 추출
        TARGET=$(shuf "$WORD_FILE" | head -n 1)

        # 줄 끝의 \r, 앞뒤 공백 제거
        TARGET_CLEAN=$(trim "$TARGET")

        clear
        echo "---------------------------"
        echo "단어 $((i+1)) / $TOTAL_WORDS"
        echo "---------------------------"
        echo "👉  $TARGET_CLEAN"
        echo
        read -r -p "입력: " INPUT

        # 입력값도 동일하게 정리
        INPUT_CLEAN=$(trim "$INPUT")

        if [[ "$INPUT_CLEAN" = "$TARGET_CLEAN" ]]; then
            echo "✅ 정답!"
            ((CORRECT_WORDS++))
        else
            echo "❌ 오답! (정답: $TARGET_CLEAN)"
        fi

        sleep 1
    done

    ELAPSED_TIME=$SECONDS   # 총 걸린 시간(초)
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
}
