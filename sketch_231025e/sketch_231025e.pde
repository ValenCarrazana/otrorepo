import oscP5.*;
import netP5.*;
import gifAnimation.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
PImage foto1, foto2, foto3;
Gif gif1;
float boton;
String estado;
boolean gatillo = false;

void setup(){
   fullScreen();
  textAlign( CENTER );
  textSize( 20 );
  
  estado = "inicio";
  
  oscP5 = new OscP5(this,9000);
    foto1 = loadImage("imagen0.png");
    foto2 = loadImage("imagen1.png");
    foto3 = loadImage("imagen2.png");
    gif1= new Gif (this, "corazon.gif");
    gif1.loop();
  
  myRemoteLocation = new NetAddress("192.168.0.28",12000);
  
}

void draw() {
  text( estado, width/2, height/2 );
  if( estado.equals("inicio") ){
      image(gif1, height/2, width/2, 300,300  );
     image(foto1, 0, 0, 1366,768);
  }
  
  if( estado.equals("inicio") && gatillo ){
    image(foto2, 0, 0, 1366,768);
    estado = "pantalla uno";
    gatillo = false;
  }
  if( estado.equals("pantalla uno") && gatillo ){
    image(foto3, 0, 0, 1366,768);
    estado = "pantalla dos";
    gatillo = false;
  }
  if( estado.equals("pantalla dos") && gatillo ){
    estado = "pantalla tres";
    gatillo = false;
  }
  
  println( estado );
  
  //if( boton == 1.0 ){
  //  gatillo = true;
  //} else if( boton == 2.0 ){
  //  gatillo = false;
  //} else gatillo = false;
  
  
}

void oscEvent(OscMessage m) {

  print("### received an osc message.");
  print(" addrpattern: "+m.addrPattern());
  println(" typetag: "+m.typetag());
  
  if( m.addrPattern().equals("/mensaje1/boton1/0") ){
    gatillo = true;
    boton = m.get(0).floatValue();
  }
  if( m.addrPattern().equals("/mensaje1/boton1/1") ){
    gatillo = false;
    boton = m.get(0).floatValue();
  }
  
  //if( m.addrPattern().equals("/mensaje1/boton1/ 0") ){
  //  boton = m.get(0).floatValue();
  //  print("boton1 presionado"); }
  //} else if( m.addrPattern().equals("/mensaje1/boton1/ 1") ){
  //  boton = m.get(0).floatValue();
  //  print("boton1 suelto");
  //}

  
}
