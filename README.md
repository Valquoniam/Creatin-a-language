#Beatles Languages - AXEL DUMONT AND VALENTIN QUONIAM-BARRE

The Beatles Language is a C-like language designed for Beatles fans.

To run the code, open a terminal here and type :

"
cd Source/
make
cd ..
./Beatles "Examples/yourexample.btl"

"

***********************************************************

Since our presentation, we added some code :
	
	- error handling : we count lines and columns, to identify some errors. 
	(it made the interpreter a lot different and bigger)
	
	- Our code wasn't working after we added this functionality, so we changed the way our program works : there is no more a "definition section", which complicated things and wasn't very useful.
	
	- We allowed the user to write in the terminal (check "fibonnaci.btl")
	
	- We also dealt with the types in the interpreter, not in the parser, to avoid treating all the cases in the parser, and having too much tokens (+ an heavy parser). Instead, we use "Hey Jude" to define either a variable or a function, and our program will see the difference.
	
	-We didn't manage to do a "for" loop, so we made a "loop" instead, which just repeats the action n times if the input is n.

************************************************************
	
We really enjoyed working on this project, though it was wayyyy longer than we thought.

Thanks for looking at our work, hope you like it.

Valentin and Axel
