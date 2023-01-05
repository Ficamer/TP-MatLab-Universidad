function unjugador = unjugador(A)
 disp('-----Bienvenido a 7 y medio modo single player-----')
 nombre1=input('Ingrese nombre de jugador: ', 's' );   #En el fprintf lo vamos a llamar con %s 
 turno=0;
 deseo=0;
 valorbanca=0;  #Acá se va guardando la suma de los valores de las cartas que saque la banca.
 valorjugador=0; #Acá se va guardando la suma de los valores de las cartas que saque el jugador.
 cartasbanca=[];
 cartasjugador=[];
 cartasgeneral=[1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 10 10 10 10 11 11 11 11 12 12 12 12];
 todaslasquesalieron=[]; #Vector que toma todas las cartas que salieron
 cantrepbanca=0; 
 cantrepjugador=0;
 deseobanca=0;
for i=1:10 #Con este for, voy asignando los turnos.  
if deseobanca==0 || deseobanca==1
Cbanca=cartasgeneral(randi(40));  #Carta que le sale a la banca
endif
if deseo==0 || deseo==1
Cjugador=cartasgeneral(randi(40)); #Carta que le sale al jugador
endif  
turno=i;
fprintf('Turno numero %g \n',turno)

 if Cbanca<=7 
   cartasbanca=[cartasbanca Cbanca];
   valorbanca=valorbanca+Cbanca;
 elseif Cbanca>7  
   cartasbanca=[cartasbanca Cbanca];
   valorbanca=valorbanca+0.5;
 endif
if Cjugador<=7 && (deseo==0 || deseo==1) 
  cartasjugador=[cartasjugador Cjugador];
  valorjugador=valorjugador+Cjugador;
elseif Cjugador>7 && (deseo==0 || deseo==1) 
  cartasjugador=[cartasjugador Cjugador];
  valorjugador=valorjugador+0.5;
endif
if deseo==2 && (Cjugador<=7 || Cjugador>7)
  Cjugador=0;
  cartasjugador=[cartasjugador Cjugador];
  valorjugador=valorjugador;
endif
cartabanca=cartasbanca(i); #Elijo la carta de la banca de cada turno
cartajugador=cartasjugador(i); #Elijo la carta del jugador de cada turno
todaslasquesalieron=[cartasbanca cartasjugador];
repetidabanca=find(todaslasquesalieron==cartabanca); #Busca la posicion en la que aparece la carta que busco y arma un vector con las posiciones
repetidajugador=find(todaslasquesalieron==cartajugador);
cantrepbanca=length(repetidabanca);  #Te da el tamaño del vector por lo tanto te da la cantidad de veces que se repite una carta
cantrepjugador=length(repetidajugador);

#Quito del maso las cartas que van saliendo 4 veces 
if cantrepbanca==4  
  cartasgeneral(repetidabanca)=[];  #Como repetidabanca te da la posición de cada numero repetido, lo evaluo en cartasgeneral y los quito igualandolos a []
elseif cantrepjugador==4
  cartasgeneral(repetidajugador)=[];
endif
if deseo==1 || deseo==2 #Este condicional hace que la carta de la banca despues del primer turno sea visible
   fprintf('La carta de la banca es %g \n', cartabanca)
endif

[reparto,fs]=audioread('reparto.wav');
sound(reparto,fs)

if cartajugador~=0
fprintf('%s su carta es %g \n', nombre1, cartajugador)
disp('-- Si desea pedir carta ingrese 1 --')
disp('-- Si desea plantarse ingrese 2 --')
disp('-- Si desea abandonar ingrese 3 --')
deseo=input('Ingrese valor: ');
endif

if deseo==3
  menuprincipal
endif


#Estos son condicionales de la decisión más optima de la maquina para plantarse.
# la decisión de la banca (si se planta
#o no) no debe tener en cuenta la primer carta del jugador (que se supone tapada).
if valorbanca>7.5 #La banca se excede del valor
    break; #Lo que hace es que al plantarse, se interrumpe el bucle y pasa a la sentencia siguiente al END
endif
if (valorbanca>6 && valorbanca<=7.5) #La banca decide plantarse
    break; #Lo que hace es que al plantarse, se interrumpe el bucle y pasa a la sentencia siguiente al END
endif
if valorbanca<6.5  #La banca decide pedir otra carta
  deseobanca=1;
endif
if valorjugador>=7.5 
    break; 
endif

endfor

#Los siguientes condicionales, te dan información de si alguno de los dos decidio plantarse y los valores que sumaron.
[resultados,fs]=audioread('resultados.wav');
sound(resultados,fs)
if valorbanca==7.5 #Cuando la banca decide plantarse
  fprintf('%s su carta es %g \n', nombre1, cartajugador)
  fprintf('La banca decidio plantarse, su valor es %g \n', valorbanca)
  fprintf('%s su valor es de %g \n', nombre1, valorjugador)
  disp('La banca gano la ronda')

elseif valorjugador>7.5 && valorbanca<7.5
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('La banca gano la ronda')

elseif valorbanca>7.5 && valorjugador<7.5
fprintf('La banca perdio la ronda, su valor es %g \n', valorbanca)
fprintf('%s gano la ronda, su valor es  %g \n', nombre1, valorjugador) 

elseif valorbanca>7.5 && valorjugador>7.5
fprintf('Como %s y la banca, superaron los 7 y medio \n', nombre1)
disp('Ambos perdieron la ronda')

elseif valorbanca==valorjugador
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('Hubo un empate')

elseif valorjugador==7.5 
  fprintf('El valor de %s es %g \n', nombre1, valorjugador)
  fprintf('El valor de la banca es %g \n' , valorbanca)
  fprintf('%s gano la ronda \n', nombre1)

elseif valorbanca<7.5 && valorbanca>valorjugador
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('La banca gano la ronda')

elseif valorbanca<7.5 && valorbanca<valorjugador
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('El valor de la banca es %g \n', valorbanca)
  fprintf('%s gano la ronda \n', nombre1)
end
#Esta sección está dedicada por si el jugador desea jugar de nuevo o no.
disp('-----Si desea volver a jugar ingrese 1, si desea terminar ingrese 2------')
volverosalir=input('Valor ingresado: ');
if volverosalir==1 
  unjugador 
 else
  menuprincipal
  end