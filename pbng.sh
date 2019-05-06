#!/bin/sh

SIXTIES_MODE=false
URL_ADJECTIVE="https://gist.githubusercontent.com/hugsy/8910dc78d208e40de42deb29e62df913/raw/eec99c5597a73f6a9240cab26965a8609fa0f6ea/english-adjectives.txt"
URL_NOUN="http://www.desiquintans.com/downloads/nounlist/nounlist.txt"
URL_VERB="https://raw.githubusercontent.com/aaronbassett/Pass-phrase/master/verbs.txt"

get_word() {
	echo "$(curl -s $1 | shuf -n 1)"
}

present_participlify() {
	verb=$1
	if [ $(echo $verb | grep -e '.*e$') ]; then
		verb=$(echo $verb | sed 's/.$//')
	fi
	echo "$(echo $verb)ing"
}

capitalize() {
	echo $(echo $1 | sed -e "s/\b\(.\)/\u\1/g")
}

### MAIN ###

while [ "$#" -gt 0 ]; do
	case "$1" in
		--sixties)
			SIXTIES_MODE=true
			;;
		*)
	esac
	shift
done

band_name="$(get_word $URL_ADJECTIVE) $(get_word $URL_NOUN)"
song_name="$(present_participlify $(get_word $URL_VERB)) $(get_word $URL_NOUN)"

if [ "$SIXTIES_MODE" = true ]; then
	band_name="the $(echo $band_name)s"
fi

echo "$song_name by $band_name"
return 0

