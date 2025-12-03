#!/bin/bash

# 시스템 정보 표시 기능
show_system_info() {
    clear
    echo "==========================="
    echo "      시스템 정보"
    echo "==========================="

    echo "👤 사용자: $(whoami)"

    echo "💻 호스트: $(hostname)"

    echo "🖥️  OS: $(uname -s) $(uname -r)"

    echo "📅 날짜: $(date '+%Y-%m-%d %H:%M:%S')"

    echo "🐚 Shell: $SHELL"

    if [[ "$(uname)" == "Darwin" ]]; then
        echo "⚡ 로드: $(sysctl -n vm.loadavg | awk '{print $2, $3, $4}')"
    else
        echo "⚡ 로드: $(uptime | awk -F'load average:' '{print $2}')"
    fi

    echo
    echo "📊 디스크 사용량:"
    df -h / | awk 'NR==2 {printf "   사용: %s / %s (%s)\n", $3, $2, $5}'

    PROCESS_COUNT=$(ps aux | wc -l)
    echo "🔢 실행 중인 프로세스: $((PROCESS_COUNT - 1))개"

    echo
    echo "💥 CPU 사용률 Top 5:"
    ps aux | sort -k3 -r | head -n 6 | tail -n 5 | \
        awk '{printf "   %s: %.1f%%\n", $11, $3}'

    echo
    echo "==========================="
}

# 게임 통계 기능
show_game_statistics() {
    clear
    echo "==========================="
    echo "      게임 통계"
    echo "==========================="

    # 단어 파일 통계
    if [[ -f "$WORD_FILE" ]]; then
        WORD_COUNT=$(wc -l < "$WORD_FILE")
        echo "📖 사전 단어 수: $WORD_COUNT 개"

        LONGEST=$(awk '{print length, $0}' "$WORD_FILE" | sort -rn | head -1)
        LONGEST_LEN=$(echo "$LONGEST" | awk '{print $1}')
        LONGEST_WORD=$(echo "$LONGEST" | awk '{$1=""; print $0}' | xargs)
        echo "📏 가장 긴 단어: $LONGEST_WORD (${LONGEST_LEN}자)"

        AVG_LEN=$(awk '{total += length($0); count++} END {printf "%.1f", total/count}' "$WORD_FILE")
        echo "📐 평균 단어 길이: ${AVG_LEN}자"
    fi

    echo

    # 랭킹 파일 통계
    if [[ -f "$RANKING_FILE" && -s "$RANKING_FILE" ]]; then
        TOTAL_PLAYS=$(wc -l < "$RANKING_FILE")
        echo "🎮 총 플레이 횟수: $TOTAL_PLAYS 회"

        AVG_SCORE=$(awk -F'|' '{sum += $2; count++} END {printf "%.0f", sum/count}' "$RANKING_FILE")
        echo "📊 평균 점수: ${AVG_SCORE}점"

        HIGH_SCORE=$(tr -d '\r' < "$RANKING_FILE" | sort -t'|' -k2,2nr | head -1)
        HIGH_PLAYER=$(echo "$HIGH_SCORE" | awk -F'|' '{gsub(/^ +| +$/, "", $1); print $1}')
        HIGH_POINTS=$(echo "$HIGH_SCORE" | awk -F'|' '{gsub(/^ +| +$/, "", $2); print $2}')
        echo "🏆 최고 기록: $HIGH_PLAYER ($HIGH_POINTS 점)"

        echo
        echo "👥 플레이어별 횟수:"
        tr -d '\r' < "$RANKING_FILE" | \
            awk -F'|' '{gsub(/^ +| +$/, "", $1); count[$1]++}
                 END {for (name in count) printf "   %s: %d회\n", name, count[name]}' | \
            sort -t':' -k2 -rn | head -5
    else
        echo "아직 게임 기록이 없습니다."
    fi

    echo
    echo "==========================="
}