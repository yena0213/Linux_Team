
calculate_score() {
    if (( TOTAL_WORDS == 0 )); then
        FINAL_SCORE=0
        return
    fi

    ACCURACY=$(( 100 * CORRECT_WORDS / TOTAL_WORDS ))

    BASE_SCORE=$(( ACCURACY * DIFF_MULTIPLIER ))

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
