#!/bin/bash

# Function to check if a year is a leap year
is_leap_year() {
    year=$1
    if [ $((year % 4)) -eq 0 ] && [ $((year % 100)) -ne 0 ] || [ $((year % 400)) -eq 0 ]; then
        return 0  # It's a leap year
    else
        return 1  # Not a leap year
    fi
}

# Function to get the number of days in a month
get_days_in_month() {
    month=$1
    year=$2

    case $month in
        1|3|5|7|8|10|12) days=31 ;;
        4|6|9|11) days=30 ;;
        2)
            if is_leap_year $year; then
                days=29
            else
                days=28
            fi
            ;;
        *) echo "Invalid month"; exit 1 ;;
    esac

    echo $days
}

# Get the current month and year if not provided as arguments
if [ $# -eq 0 ]; then
    month=$(date +%m)
    year=$(date +%Y)
elif [ $# -eq 2 ]; then
    month=$1
    year=$2
else
    echo "Usage: $0 [month year]"
    exit 1
fi

# Convert month to integer
month=$((10#$month))  # 10# ensures it's treated as base 10, even if it starts with 0

# Get the number of days in the month
days=$(get_days_in_month $month $year)

# Print the days of the month
echo "Days of month $month/$year:"
for ((day=1; day<=days; day++)); do
    printf "%2d " $day
    if [ $((day % 7)) -eq 0 ]; then
        echo ""  # Start a new line after every 7 days
    fi
done
echo ""  # Ensure a newline at the end
