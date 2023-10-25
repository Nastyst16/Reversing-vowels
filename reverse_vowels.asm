section .data
	; declare global vars here
	extern strlen

section .text
	global reverse_vowels

;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place
reverse_vowels:

	push DWORD [esp + 4]
	pop edx
	; mov eax, [edx] ; eax = string -> BIFAT

	xor ecx, ecx
	or ecx, edx ; eax = string -> BIFAT

	find_vowels:
		xor eax, eax
		or eax, [edx]

		cmp eax, 0
		je string1_end

		cmp al, 'a'
		je vowel_found
		cmp al, 'e'
		je vowel_found
		cmp al, 'i'
		je vowel_found
		cmp al, 'o'
		je vowel_found
		cmp al, 'u'
		je vowel_found

		increment1:
			inc DWORD edx
			jmp find_vowels
	string1_end:


	jmp next_step
	vowel_found:
		push eax
		jmp increment1

	next_step:

		insert_vowels:
			xor eax, eax
			or eax, [ecx]

			cmp eax, 0
			je string2_end

			cmp al, 'a'
			je insert
			cmp al, 'e'
			je insert
			cmp al, 'i'
			je insert
			cmp al, 'o'
			je insert
			cmp al, 'u'
			je insert

			increment2:
				inc DWORD ecx
				jmp insert_vowels
		string2_end:

		jmp end
		insert:
			pop eax

			and BYTE [ecx], 0
			or BYTE [ecx], al

			jmp increment2

		end:
	ret