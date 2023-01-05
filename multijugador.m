function multijugador=multijugador(a)
 disp('-----Bienvenido a 7 y medio modo multijugador-----')
 nombre1=input('Ingrese nombre de jugador 1: ', 's' ); 
 nombre2=input('Ingrese nombre de jugador 2: ', 's' );  
 #VARIABLES QUE SE VAN A IR MODIFICANDO
 turno=0; #Se guarda el numero de turno
 deseo=0; #Es la variable en la que el jugador 1 decide si volver a jugar o no (dependiendo del valor que elija)
 deseo2=0; #Es la variable en la que el jugador 2 decide si volver a jugar o no (dependiendo del valor que elija)
 deseobanca=0; #Es la variable en la banca decide si volver a jugar o no (dependiendo de la decision mas optima)
 valorbanca=0;  #Se guarda la suma de los valores de las cartas que saque la banca.
 valorjugador=0; #Se guarda la suma de los valores de las cartas que saque el jugador 1.
 valorjugador2=0; #Se guarda la suma de los valores de las cartas que saque el jugador 2.
 cartasbanca=[];  #Vector que guarda las cartas que salen en cada turno de la banca.
 cartasjugador=[]; #Vector que guarda las cartas que salen en cada turno del jugador 1.
 cartasjugador2=[]; #Vector que guarda las cartas que salen en cada turno del jugador 2.
 cartasgeneral=[1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 10 10 10 10 11 11 11 11 12 12 12 12]; #Vector con cartas de la baraja
 todaslasquesalieron=[]; #Vector que toma todas las cartas que salieron.
 cantrepbanca=0; #Te dice la cantidad de cartas repetidas de la carta que le salga a la banca en el turno.
 cantrepjugador=0; #Te dice la cantidad de cartas repetidas de la carta que le salga al jugador 1 en el turno.
 cantrepjugador2=0; #Te dice la cantidad de cartas repetidas de la carta que le salga al jugador 2 en el turno.
 
for i=1:10 #Con este for, voy asignando los turnos.
  
if deseobanca==0 || deseobanca==1
Cbanca=cartasgeneral(randi(40));  #Carta que le sale a la banca
endif
if deseo==0 || deseo==1
Cjugador=cartasgeneral(randi(40)); #Carta que le sale al jugador 1
endif
if deseo2==0 || deseo2==1
Cjugador2=cartasgeneral(randi(40)); #Carta que le sale al jugador 2  
endif
turno=i;
fprintf('Turno numero %g \n',turno)
 if Cbanca<=7 #Si el valor aleatorio que toca es 1, entonces elige cartas entre el 1 y el 7 esas valen el valor que corresponde al numero de cada carta.
   cartasbanca=[cartasbanca Cbanca];
   valorbanca=valorbanca+Cbanca;
 elseif Cbanca>7  #Como el valor es 2, entonces las cartas posibles son del 10 al 12, y esas valen medio punto
   cartasbanca=[cartasbanca Cbanca];
   valorbanca=valorbanca+0.5;
 endif
if Cjugador<=7 && deseo==0 || Cjugador<=7 && deseo==1 
  cartasjugador=[cartasjugador Cjugador];
  valorjugador=valorjugador+Cjugador;
elseif Cjugador>7 && deseo==0 || Cjugador>7  && deseo==1 
  cartasjugador=[cartasjugador Cjugador];
  valorjugador=valorjugador+0.5;
endif
if Cjugador2<=7 && deseo2==0 || Cjugador2<=7 && deseo2==1 
  cartasjugador2=[cartasjugador2 Cjugador2];
  valorjugador2=valorjugador2+Cjugador2;
elseif Cjugador2>7 && deseo2==0 || Cjugador2>7 && deseo2==1 
  cartasjugador2=[cartasjugador2 Cjugador2];
  valorjugador2=valorjugador2+0.5;
endif
if deseo==2 && (Cjugador<=7 || Cjugador>7)
  Cjugador=0;
  cartasjugador=[cartasjugador Cjugador];
  valorjugador=valorjugador;
endif
if deseo2==2 && (Cjugador<=7 || Cjugador>7)
  Cjugador2=0;
  cartasjugador2=[cartasjugador2 Cjugador2];
  valorjugador2=valorjugador2;
endif
cartabanca=cartasbanca(i);  #Elijo la carta de la banca de cada turno
if deseo==0 || deseo==1
cartajugador=cartasjugador(i); #Elijo la carta del jugador de cada turno
endif
if deseo2==0 || deseo2==1
cartajugador2=cartasjugador2(i);
endif

#Para controlar las repetidas
todaslasquesalieron=[cartasbanca cartasjugador cartasjugador2];
repetidabanca=find(todaslasquesalieron==cartabanca); #Busca la posicion en la que aparece la carta que busco y arma un vector con las posiciones
repetidajugador=find(todaslasquesalieron==cartajugador);
repetidajugador2=find(todaslasquesalieron==cartajugador2);
cantrepbanca=length(repetidabanca);  #Te da el tamaño del vector por lo tanto te da la cantidad de veces que se repite una carta
cantrepjugador=length(repetidajugador);
cantrepjugador2=length(repetidajugador2);

if cantrepbanca==4  
  cartasgeneral(repetidabanca)=[]; #Como repetidabanca te da la posición de cada numero repetido, lo evaluo en cartasgeneral y los quito igualandolos a []
elseif cantrepjugador==4
  cartasgeneral(repetidajugador)=[];
elseif cantrepjugador2==4
cartasgeneral(repetidajugador2)=[];
endif

if deseo==1 || deseo2==1 || deseo==2 || deseo2==2 #Este condicional hace que la carta de la banca despues del primer turno sea visible
   fprintf('La carta de la banca es %g \n', cartabanca)
endif

if deseo==3
  valorjugador=100;  #Hago que el valor sea 100 asi se deja de tener en cuenta al jugador que abandona.
end
if deseo2==3
  valorjugador2=100;
end
[reparto,fs]=audioread('reparto.wav');
sound(reparto,fs)
if deseo==0 || deseo==1
fprintf('%s su carta es %g \n', nombre1, cartajugador)
disp('-- Si desea pedir carta ingrese 1 --')
disp('-- Si desea plantarse ingrese 2 --')
disp('-- Si desea abandonar ingrese 3 --')
deseo=input('Ingrese valor: ');
endif
if deseo2==0 || deseo2==1
fprintf('%s su carta es %g \n', nombre2, cartajugador2)
disp('-- Si desea pedir carta ingrese 1 --')
disp('-- Si desea plantarse ingrese 2 --')
disp('-- Si desea abandonar ingrese 3 --')
deseo2=input('Ingrese valor: ');
endif
#Estos son condicionales de la decisión más optima de la maquina para plantarse.

if valorbanca>7.5 #La banca se excede del valor
    break; #Lo que hace es que al plantarse, se interrumpe el bucle y pasa a la sentencia siguiente al END
endif
if valorbanca>6 && valorbanca<=7.5 #La banca decide plantarse
    break; #Lo que hace es que al plantarse, se interrumpe el bucle y pasa a la sentencia siguiente al END
endif
if valorbanca<6.5  #La banca decide pedir otra carta
  deseobanca=1;
endif
endfor




#CONDICIONALES PARA LOS RESULTADOS
[resultados,fs]=audioread('resultados.wav');  #Se reproduce el audio cuando se llega al momento de dar los resultados.
sound(resultados,fs)
#Si abandonan los dos y queda la banca
if (deseo==3 && deseo2==3) && valorjugador==0 && valorjugador2==0
disp('La banca gano la ronda, los demas jugadores abandonaron')
endif
#if deseo~=3 && deseo2~=3 #Pido que los dos no hayan abandonado para entrar al ciclo.
#BANCA VS JUGADOR 1
if valorbanca==7.5 && valorjugador2==100 #Pido que valorjugador2==100 dado a que cuando tiene este valor, el segundo jugador abandono la partida.
  fprintf('La banca decidio plantarse, su valor es %g \n', valorbanca)
  fprintf('El valor de %s es %g \n', nombre1, valorjugador)
  disp('La banca gano la ronda')
elseif valorjugador==7.5 && valorjugador2==100 
  fprintf('El valor de %s es %g \n', nombre1, valorjugador)
  fprintf('El valor de la banca es %g \n' , valorbanca)
  fprintf('%s gano la ronda \n', nombre1)
  
elseif valorjugador>7.5 && valorbanca<=7.5 && valorjugador2==100 && valorjugador~=100 
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('La banca gano la ronda')

elseif valorbanca>7.5 && valorjugador<=7.5 && valorjugador2==100  
fprintf('La banca perdio la ronda, su valor es %g \n', valorbanca)
fprintf('%s gano la ronda, su valor es  %g \n', nombre1, valorjugador) 

elseif valorbanca>7.5 && valorjugador>7.5 && valorjugador2==100 && valorjugador~=100
fprintf('Como %s y la banca, superaron los 7 y medio \n', nombre1)
disp('Ambos perdieron la ronda')

elseif valorbanca==valorjugador && valorjugador2==100  
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('Hubo un empate')

elseif valorbanca<7.5 && valorbanca>valorjugador && valorjugador2==100  
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('La banca gano la ronda')

elseif valorbanca<7.5 && valorbanca<valorjugador && valorjugador2==100 && valorjugador~=100
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('El valor de la banca es %g \n', valorbanca)
  fprintf('%s gano la ronda \n', nombre1)
end

#BANCA VS JUGADOR 2
if valorbanca==7.5 && valorjugador==100 
  fprintf('El valor de %s es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('La banca gano la ronda')

elseif valorjugador2==7.5 && valorjugador==100 
  fprintf('El valor de %s es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n' , valorbanca)
  fprintf('%s gano la ronda \n', nombre2)

elseif valorjugador2>7.5 && valorbanca<7.5 && valorjugador==100 && valorjugador2~=100
  fprintf('%s su valor es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('La banca gano la ronda')

elseif valorbanca>7.5 && valorjugador2<7.5 && valorjugador==100  
fprintf('La banca perdio la ronda, su valor es %g \n', valorbanca)
fprintf('%s gano la ronda, su valor es  %g \n', nombre2, valorjugador2) 

elseif valorbanca>7.5 && valorjugador2>7.5 && valorjugador==100 && valorjugador2~=100 
fprintf('Como %s y la banca, superaron los 7 y medio \n', nombre2)
disp('Ambos perdieron la ronda')

elseif valorbanca==valorjugador2 && valorjugador==100 
  fprintf('%s su valor es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('Hubo un empate')

elseif valorbanca<7.5 && valorjugador2<valorbanca && valorjugador==100 
  fprintf('%s su valor es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('La banca gano la ronda')

elseif valorjugador2<7.5 && valorbanca<valorjugador2 && valorjugador==100 
  fprintf('%s su valor es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n', valorbanca)
  fprintf('%s gano la ronda \n', nombre2)
end

#BANCA VS JUGADOR 1 Y JUGADOR 2
if valorbanca==7.5 && valorjugador~=100 && valorjugador2~=100  
  fprintf('El valor de %s es %g \n', nombre1, valorjugador)
  fprintf('El valor de %s es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('La banca gano la ronda')
elseif valorjugador==7.5 && valorjugador~=100 && valorjugador2~=100 
  fprintf('El valor de %s es %g \n', nombre1, valorjugador)
  fprintf('El valor de %s es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n' , valorbanca)
  fprintf('%s gano la ronda \n', nombre1)
  
elseif valorjugador2==7.5 && valorjugador~=100 && valorjugador2~=100 
  fprintf('El valor de %s es %g \n', nombre1, valorjugador)
  fprintf('El valor de %s es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n' , valorbanca)
  fprintf('%s gano la ronda \n', nombre2)

elseif valorjugador>7.5 && valorjugador2>7.5 && valorbanca<7.5 && valorjugador~=100 && valorjugador2~=100 
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('%s su valor es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('La banca gano la ronda')

elseif valorbanca>7.5 && valorjugador<7.5 && valorjugador2>7.5 && valorjugador~=100 && valorjugador2~=100 
fprintf('La banca perdio la ronda, su valor es %g \n', valorbanca)
fprintf('%s gano la ronda, su valor es  %g \n', nombre1, valorjugador)

elseif valorbanca>7.5 && valorjugador<7.5 && valorjugador2<valorjugador && valorjugador~=100 && valorjugador2~=100 
fprintf('La banca perdio la ronda, su valor es %g \n', valorbanca)
fprintf('%s perdio la ronda, su valor es  %g \n', nombre2, valorjugador2) 
fprintf('%s gano la ronda, su valor es  %g \n', nombre1, valorjugador)  

elseif valorbanca>7.5 && valorjugador>7.5 && valorjugador2<7.5 && valorjugador~=100 && valorjugador2~=100 
fprintf('La banca perdio la ronda, su valor es %g \n', valorbanca)
fprintf('%s perdio la ronda, su valor es %g \n', nombre1,valorjugador)
fprintf('%s gano la ronda, su valor es  %g \n', nombre2, valorjugador2) 

elseif valorbanca>7.5 && valorjugador2<7.5 && valorjugador<valorjugador2 && valorjugador~=100 && valorjugador2~=100 
fprintf('La banca perdio la ronda, su valor es %g \n', valorbanca)
fprintf('%s gano la ronda, su valor es  %g \n', nombre2, valorjugador2) 

elseif valorbanca>7.5 && valorjugador>7.5 &&  valorjugador2>7.5 && valorjugador~=100 && valorjugador2~=100 
fprintf('Como %s , %s y la banca, superaron los 7 y medio \n', nombre1, nombre2)
disp('Todos perdieron la ronda')

  
elseif valorbanca==valorjugador==valorjugador2
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('%s su valor es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('Hubo un empate')
  
elseif (valorbanca==valorjugador && valorjugador2==100) || (valorbanca==valorjugador && valorjugador2~=100)
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('Hubo un empate')
elseif (valorbanca==valorjugador2 && valorjugador==100) || (valorbanca==valorjugador2 && valorjugador~=100) 
  fprintf('%s su valor es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('Hubo un empate')

elseif valorbanca<7.5 && valorbanca>valorjugador && valorbanca>valorjugador2 && valorjugador~=100 && valorjugador2~=100 
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('%s su valor es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n', valorbanca)
  disp('La banca gano la ronda')

elseif valorjugador<7.5 && valorbanca<valorjugador && valorjugador2<valorjugador && valorjugador~=100 && valorjugador2~=100 
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('%s su valor es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n', valorbanca)
  fprintf('%s gano la ronda \n', nombre1) 
elseif valorjugador2<7.5 && valorbanca<valorjugador2 && valorjugador<valorjugador2 && valorjugador~=100 && valorjugador2~=100 
  fprintf('%s su valor es %g \n', nombre1, valorjugador)
  fprintf('%s su valor es %g \n', nombre2, valorjugador2)
  fprintf('El valor de la banca es %g \n', valorbanca)
  fprintf('%s gano la ronda \n', nombre2) 
end
#end
#SECCIÓN DEDICADA PARA VOLVER A JUGAR O NO.
disp('-----Si desea volver a jugar ingrese 1, si desea terminar ingrese 2------')
volverosalir=input('Valor ingresado: ');
if volverosalir==1 
  multijugador 
 else
  menuprincipal
  end