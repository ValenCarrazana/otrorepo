/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

//String dosValores = "0";
PImage foto, foto1;
  int x = 350;
  int y = 650;
  int radius = 200;
  String estado;
  
  boolean gatillo = false;

void setup() {
   estado = "inicio";
  
  fullScreen();
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  
  foto = loadImage("celu0.png");
   foto1 = loadImage("celu1.png");
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("192.168.0.28",9000);
  
  ellipseMode(RADIUS);
  
}


void draw() {
  
  println(estado);
  
   if( estado.equals("inicio") ){
     ellipse(x,y,radius,radius);
      image (foto,0,0,width,height);
  }
  
   if( estado.equals("inicio") && gatillo ){
    image(foto, 0, 0,width,height);
    estado = "pantalla uno";
    gatillo = false;
  }
  
     if( estado.equals("pantalla uno") && gatillo ){
    image(foto, 0, 0,width,height);
    estado = "pantalla dos";
    gatillo = false;
  }
  
  
    if( estado.equals("pantalla dos") && gatillo ){
    image(foto1, 0, 0,width,height);
    estado = "pantalla tres";
    gatillo = false;
  }
  
  

  

}


 void boton(){

    
 }

void touchStarted(){

 if(estado == "inicio" ){  
   float d = dist(mouseX, mouseY, x,y);
  if(d< radius){
    //  /* send the message */
   OscMessage myMessage1 = new OscMessage("/mensaje1/boton1/0" );
   myMessage1.add( 2.0 );
   oscP5.send(myMessage1, myRemoteLocation);
      gatillo = true;
  }
  }
  
}

//void touchIsMoving(){
////  /* send the message */

   
//   float d = dist(mouseX, mouseY, x,y);
//  if(d< radius){
//       OscMessage myMessage1 = new OscMessage("/mensaje1/boton1/0" );
//   myMessage1.add( 2.0 );
//   oscP5.send(myMessage1, myRemoteLocation);
//     gatillo = true;
//  }
//}

void touchEnded(){

  
  float d = dist(mouseX, mouseY, x,y);
  if(d< radius){
    
  OscMessage myMessage1 = new OscMessage("/mensaje1/boton1/1" );
  myMessage1.add( 1.0 );
  oscP5.send(myMessage1, myRemoteLocation);
      gatillo = true;
  }
  
}

//void mousePressed() {
//  /* in the following different ways of creating osc messages are shown by example */
//  OscMessage myMessage = new OscMessage("/test");
//  OscMessage myMessage1 = new OscMessage("/mensaje1");
  
//  myMessage.add(123); /* add an int to the osc message */
//  myMessage1.add(1.2);
//  /* send the message */
//  oscP5.send(myMessage, myRemoteLocation); 
//  oscP5.send(myMessage1, myRemoteLocation); 
//  println( "presionado" );
//}

//void mouseReleased(){
//  OscMessage myMessage1 = new OscMessage("/mensaje1");
//  myMessage1.add(1.1);
//  oscP5.send(myMessage1, myRemoteLocation); 
//}
