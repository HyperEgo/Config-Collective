#!/bin/bash

# switch-case input example, endless loop until user selects 'quit'

echo "Choose your animal (input number)."
select option in "cat" "dog" "bird" "fish" "quit"
do
	case $option in
		cat) echo "Cats sleep.";;
		dog) echo "Dogs sheet.";;
		bird) echo "Birds peep.";;
		fish) echo "Fish weep.";;
		quit) break;;
		*) echo "Invalid input - not sure what that is.";;
	esac
done
