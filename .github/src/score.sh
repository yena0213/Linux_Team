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