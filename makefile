test_key: main.o gen_key.o print_key.o modulo.o get_user_input.o print_string_int.o find_correct_color.o
	gcc -o test_key main.o gen_key.o print_key.o modulo.o get_user_input.o print_string_int.o find_correct_color.o

main.o: main.s
	gcc -c -g main.s

gen_key.o: gen_key.s
	gcc -c -g gen_key.s

print_key.o: print_key.s
	gcc -c -g print_key.s

modulo.o: modulo.s
	gcc -c -g modulo.s

get_user_input.o: get_user_input.s
	gcc -c -g get_user_input.s

print_string_int.o: print_string_int.s
	gcc -c -g print_string_int.s

find_correct_color.o: find_correct_color.s
	gcc -c -g find_correct_color.s

clean:
	rm test_key *.o

