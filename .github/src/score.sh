calculate_score() {
    if (( TOTAL_WORDS == 0 )); then
        FINAL_SCORE=0
        return
    fi