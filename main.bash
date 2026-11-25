printf "KingNullboy's Bash Number Guessing Game\n"

while true; do
	num=$(($RANDOM%100+1))
	guess=-1

	touch save.txt
	if [[ $(wc -c < save.txt) -eq 0 ]]; then
		printf "0,0\n" > save.txt
	fi
	content="$(<save.txt)"
	IFS=',' read -r plays wins <<< "$content"
	(( plays++ ))
	
	if ((plays-1 == 1)); then
		s=""
	else
		s="s"
	fi
	printf "You have played this game $((plays-1)) time%s, and won it %s of those times for a total win rate of $(((wins/(plays-1 > 1 ? plays-1 : 1)) * 100))\n" "$s" "$wins"

	while [[ $num -ne $guess ]]; do
		printf "What is your guess of the secret number? (1-100)\n> "
		read -r guess
		if [[ ! $guess =~ ^[0-9]+$ ]]; then
			printf "Buddy, that's not a number. Defaulting to 50.\n"
			guess=50
		fi

		if [[ $guess -lt 1 || $guess -gt 100 ]]; then
			printf "That's not a number between 1 and 100. Can't you read?\n"
		elif [[ $guess -gt $num ]]; then
			printf "That number is greater than the secret number.\n"
		elif [[ $guess -lt $num ]]; then
			printf "That number is less than the secret number.\n"
		elif [[ $guess -eq $num ]]; then
			printf "You win!\n"
			(( wins++ ))
			printf "%s,%s\n" $plays $wins > save.txt
			break
		fi
	done

	again="this is totally a boolean or maybe a None/null and not like a string or anything"
	while true; do
		printf "Play again? (Y/n)\n> "
		read -r again
		if [[ ! ${again,,} == y* && ! ${again,,} == n* ]]; then
			continue
		fi
		break
	done
	if [[ ${again,,} == y* ]]; then
		continue
	else
		break
	fi
done