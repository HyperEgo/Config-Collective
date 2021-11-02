#!/bin/bash

# one-time execution input example, echo valid user selection only

echo "Choose your animal (input number)."
select option in "cat" "dog" "bird" "fish"
do
	echo "You selected $option animal!"
	break
done
