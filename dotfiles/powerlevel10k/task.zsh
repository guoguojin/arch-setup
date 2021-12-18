if [[ "$_POWERLEVEL9K_COLOR_SCHEME" == "light" ]]; then
  DEFAULT_COLOR=white
  DEFAULT_COLOR_INVERTED=black
else
  DEFAULT_COLOR=black
  DEFAULT_COLOR_INVERTED=white
fi


function tw_regex {
  gawk 'match($0,/'$1'/, ary) {print ary['${2:-'3'}']","ary['${2:-'4'}']","ary['${2:-'5'}']}';
}

function tw_dateconv() {
    date --date=${1:0:4}-${1:4:2}-${1:6:2}T${1:9:2}:${1:11:2}:${1:13:2} +%s
}

# taskwarrior: show data from taskwarrior
prompt_task() {
  if $(hash task 2>&-); then
    typeset -gAH tw_colors
    tw_colors=(
      'finishedall'        "$DEFAULT_COLOR"
      'finishedtoday'      "$DEFAULT_COLOR"
      'todaypending'       "green"
      'todayonly'          "green"
      'late'               "yellow"
    )
    local current_state=""; local today=0; local over=0; local pending=0;
    # local data=$(task +PENDING export | tw_regex '{.*"description":"([^,]*)","due":"([^,]*)"(,[^,]*)*,"project":"([^,]*)"(,[^,]*)*,"status":"([^,]*)",.*},?' )
    # local data=$(task +PENDING export | tw_regex '{.*"description":"([^,]*)",.*,"project":"([^,]*)","status":"([^,]*)",.*},?' )
    local data=$(task +PENDING export $(task _get rc.context.$(task _get rc.context)) | tw_regex '{.*"description":"([^,]*)",("due":"([^,]*)")?.*,"project":"([^,]*)".*,"status":"([^,]*)",.*},?' )
    
    # split string to array of strings
    data=(${=data})

    local currentdate_seconds=$(date +"%s")
    for line in $data ; do
      # IFS=',' read -r duedate projectname currentstatus <<<"$line"
      IFS=',' read -r duedate projectname currentstatus <<<"$line"

      if [[ -n $duedate ]]; then

        local duedate_seconds=$(tw_dateconv $duedate)
        if [[ $(( $currentdate_seconds - $duedate_seconds )) -gt 0  ]]
        then
          over=$((over+1))
        else
          # FIXME: this checks if the date is in the next 24h period
          if [[ $(( $duedate_seconds - $currentdate_seconds )) -lt 86400 ]]
          then
            today=$((today+1))
          fi
        fi
      fi
      # every task is pending
      pending=$((pending+1))
    done

    typeset -gAH tw_messages
    tw_messages=(
      'finishedall'      ""
      'finishedtoday'    "${pending} Pending"
      'todaypending'     "${today} Due/$(( $pending-$today )) Pending"
      'todayonly'        "${today}Due"
      'late'             "${over} Late/$(( $pending-$over )) Pending"
    )

    if [[  $today -gt 0  ]]; then
      if [[  $pending-$today -gt 0  ]]; then
        current_state="todaypending"
      else
        current_state="todayonly"
      fi
    else
      current_state="finishedtoday"
    fi
    if [[  $over -gt 0 ]]; then
      current_state="late"
    fi
    if [[ $pending -eq 0 ]]; then
      current_state="finishedall"
    fi
    # "$1_prompt_segment" "$0" "$2" "${tw_colors[$current_state]}" "$DEFAULT_COLOR_INVERTED" "${tw_messages[$current_state]}" 'TODO_ICON'
    _p9k_prompt_segment "$0" "honeydew2" "${tw_colors[$current_state]}" 'TODO_ICON' 0 '' "${tw_messages[$current_state]}"
  fi
}
