%estado_inicial
%representacion: tiempo que le queda en la parte superior al primer reloj, tiempo que le queda en la parte superior al reloj2

inicial(estado(7, 11)).

%estados_finales

objetivo(estado(3, _)). %tienen 3 minutos en el lado superior
objetivo(estado(_, 3)).
objetivo(estado(4, _)). %tienen 3 minutos en el lado inferior
objetivo(estado(_, 8)).

%operaciones

%Si el reloj no tiene arena la unica operacion posible es girar el reloj.
%Restamos el reloj que menos arena tiene al que mas tiene y el menor lo dejamos a 0.
%Dejamos caer arena de golpe, hasta que uno llega a 0, punto en el que se bloquea la accion.

movimiento(estado(X, Y),
		estado(Z, W),
		caeArena) :- \+ vacio(X), \+ vacio(Y), C is min(X, Y), Z is X - C, W is Y - C.


%al girar un reloj u otro, el tiempo restante en el contrario se mantiene
%esta operacion no consume tiempo

movimiento(estado(Y, X),
	  estado(Z, X),
	  girarMenor):- Z is 7 - Y.

movimiento(estado(X, Y), 
	  estado(X, Z),
	  girarReloj2):- Z is 11 - Y.

%esta regla comprueba que el valor de X no sea 0, o menor para mayor seguridad, o sea, que el reloj no 
%se haya quedado sin arena.

vacio(X) :- (X =< 0).

% Encontrar la secuencia de movimientos
puede(Estado,_, [], [Estado]) :- objetivo(Estado), nl, write('Hemos llegado al OBJETIVO: '), write(Estado).
											
puede(Estado,Visitados, [Operador|Operadores],[Estado|EstadosCamino] ) :- movimiento(Estado, Estado2, Operador), \+member(Estado2, Visitados), 
																		  puede(Estado2,[Estado2|Visitados], Operadores, EstadosCamino).

% CONSULTA:
consulta :-	inicial(Estado), puede(Estado,[Estado], Operadores, Estados), nl, 
			nl, write('SOLUCION ENCONTRADA sin repeticion de estados: '), nl, write(Estados), 
			nl, nl, write('Usando los operadores: '), nl, write(Operadores).
