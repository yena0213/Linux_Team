#!/bin/bash

# 난이도 선택 기능
select_difficulty() {
    echo "==========================="
    echo "     난이도 선택"
    echo "==========================="
    echo "1) Easy   (단어 2개)"
    echo "2) Normal (단어 3개)"
    echo "3) Hard   (단어 5개)"
    echo "0) 돌아가기"
    echo "---------------------------"
    read -p "난이도 번호를 선택하세요: " diff

    case "$diff" in
        1)
            DIFF_NAME="Easy"
            DIFF_WORD_COUNT=2
            DIFF_MULTIPLIER=1
            ;;
        2)
            DIFF_NAME="Normal"
            DIFF_WORD_COUNT=3
            DIFF_MULTIPLIER=2
            ;;
        3)
            DIFF_NAME="Hard"
            DIFF_WORD_COUNT=5
            DIFF_MULTIPLIER=3
            ;;
        0)
            return 1
            ;;
        *)
            echo "❌ 잘못된 입력입니다."
            sleep 1
            return 1
            ;;
    esac

    echo "▶ 선택된 난이도: $DIFF_NAME (단어 ${DIFF_WORD_COUNT}개)"
    sleep 1
    return 0
}
