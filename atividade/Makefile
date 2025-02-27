calc: lang.y lang.l
	bison -d lang.y
	flex  -o lang.lex.c lang.l
	gcc -Wall -o lang lang.lex.c lang.tab.c -lfl -lm 

clean:
	rm -rf calc
