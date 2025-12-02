calculate_score() {
    if (( TOTAL_WORDS == 0 )); then
        FINAL_SCORE=0
        return
    fi

    ACCURACY=$(( 100 * CORRECT_WORDS / TOTAL_WORDS ))

    BASE_SCORE=$(( ACCURACY * DIFF_MULTIPLIER ))