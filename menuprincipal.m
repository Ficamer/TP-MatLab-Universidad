
function menuprincipal=menuprincipal(A)
#Imagen del juego
I=imread('logo.jpg');
[ren col can]=size(I);
imshow(I)

disp('-------BIENVENIDOS A SIETE Y MEDIO---------')
disp('Para jugar individualmente contra la banca ingrese 1')
disp('Para jugar dos jugadores contra la banca ingrese 2')
A=input('Numero a ingresar: ');
if A==1
  unjugador
elseif A==2
  multijugador
end