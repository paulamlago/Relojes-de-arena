%estado_inicial

inicial(estado(reloj1, 7, reloj2, 11)).

%estados_finales

objetivo(estado(reloj1, 3, reloj2, _)). %tienen 3 minutos en el lado superior
objetivo(estado(reloj1, _, reloj2, 3)).
objetivo(estado(reloj1, 4, reloj2, _)). %tienen 3 minutos en el lado inferior
objetivo(estado(reloj1, _, reloj2, 8)).

%operaciones

%puesto que el tiempo pasa igual para ambos relojes, no necesitaremos más que 
%una función que les reste el tiempo a los dos a la vez, siempre comprobando que 
%no se queden sin arena, en ese caso se detienen ambos relojes

movimiento(estado(reloj1, X, reloj2, Y),
		estado(reloj1, Z, reloj2, W),
		restarTiempo) :- \+vacio(X), \+vacio(Y), Z is X - 1, W is Y - 1.

%al girar un reloj u otro el tiempo restante en el contrario se mantiene

movimiento(estado(reloj1, Y, reloj2, X), 
	  estado(reloj1, Z, reloj2, X),
	  girarReloj(reloj1)):- Z is 7 - Y.

movimiento(estado(reloj1, X, reloj2, Y), 
	  estado(reloj1, X, reloj2, Z),
	  girarReloj(reloj2)):- Z is 11 - Y.


%esta regla comprueba que el valor de X no sea 0, o menor, o sea, que el reloj no 
%se haya quedado sin arena. Si es así aplicamos el corte para detener la búsqueda de 
%más soluciones por esta rama.

vacio(X) :- (X =< 0).

% Encontrar la secuencia de movimientos
puede(Estado,_, [], [Estado]) :- objetivo(Estado), nl, write('Hemos llegado al OBJETIVO: '), write(Estado).
											
puede(Estado,Visitados, [Operador|Operadores],[Estado|EstadosCamino] ) :- movimiento(Estado, Estado2, Operador), \+member(Estado2, Visitados), 
																		  puede(Estado2,[Estado2|Visitados], Operadores, EstadosCamino).

% CONSULTA:
consulta :-	inicial(Estado), puede(Estado,[Estado], Operadores, Estados), nl, 
			nl, write('SOLUCION ENCONTRADA sin repeticion de estados: '), nl, write(Estados), 
			nl, nl, write('Usando los operadores: '), nl, write(Operadores).
