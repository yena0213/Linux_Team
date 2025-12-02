#!/bin/bash

# 랭킹 저장 기능
save_ranking() {
    local today timestamp

    today=$(date +%Y-%m-%d)
    timestamp=$(date +%s)

    # 파일 없으면 생성
    if [[ ! -f "$RANKING_FILE" ]]; then
        touch "$RANKING_FILE"
    fi

    # 형식: 이름 | 점수 | 날짜 | 타임스탬프
    echo "$USERNAME | $FINAL_SCORE | $today | $timestamp" >> "$RANKING_FILE"

    echo "▶ 점수가 랭킹에 저장되었습니다."
    echo

    show_ranking
}

# 랭킹 출력 기능 (상위 5개)
show_ranking() {
    echo "==========================="
    echo "        랭킹 (Top 5)"
    echo "==========================="

    if [[ ! -s "$RANKING_FILE" ]]; then
        echo "아직 기록된 랭킹이 없습니다."
        echo
        return
    fi

    # CR 제거 후 2번째 필드(점수)를 기준으로 내림차순 정렬 (높은 점수 → 낮은 점수)
    tr -d '\r' < "$RANKING_FILE" \
        | sort -t'|' -k2,2nr \
        | head -n 5 \
        | awk -F'|' '
            BEGIN {
                printf "%-3s %-15s %-8s %-12s\n", "No", "Name", "Score", "Date"
                print "----------------------------------------"
            }
            {
                gsub(/^ +| +$/, "", $1)  # trim
                gsub(/^ +| +$/, "", $2)
                gsub(/^ +| +$/, "", $3)
                printf "%-3d %-15s %-8s %-12s\n", NR, $1, $2, $3
            }
        '

    echo
}
