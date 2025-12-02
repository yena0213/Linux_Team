#!/bin/bash

# 점수 계산 기능
calculate_score() {
    if (( TOTAL_WORDS == 0 )); then
        FINAL_SCORE=0
        return
    fi

    # 정수 계산용 정확도(%)
    ACCURACY=$(( 100 * CORRECT_WORDS / TOTAL_WORDS ))

    # 기본 점수: 정확도 × 난이도 배수
    BASE_SCORE=$(( ACCURACY * DIFF_MULTIPLIER ))

    # 시간 페널티: 걸린 초만큼 빼기
    RAW_SCORE=$(( BASE_SCORE - ELAPSED_TIME ))

    if (( RAW_SCORE < 0 )); then
        RAW_SCORE=0
    fi

    FINAL_SCORE=$RAW_SCORE

    echo "정확도       : ${ACCURACY}%"
    echo "난이도 배수  : x${DIFF_MULTIPLIER}"
    echo "기본 점수    : ${BASE_SCORE}점"
    echo "시간 페널티  : -${ELAPSED_TIME}"
    echo "▶ 최종 점수  : ${FINAL_SCORE}점"
    echo
}
