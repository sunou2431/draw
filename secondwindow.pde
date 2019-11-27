class SecondWindow extends PApplet {
  PApplet parent;
  import controlP5.*;
  ControlP5 cp5;
  int pX;
  int pY;
  int num_b=0;
  String RGB_b ="";
  
  SecondWindow(PApplet _parent) {
    super();
    // set parent
    this.parent = _parent;
    //// init window
    try {
      java.lang.reflect.Method handleSettingsMethod =
        this.getClass().getSuperclass().getDeclaredMethod("handleSettings", null);
      handleSettingsMethod.setAccessible(true);
      handleSettingsMethod.invoke(this, null);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    
    PSurface surface = super.initSurface();
    surface.placeWindow(new int[]{0, 0}, new int[]{0, 0});
    
    this.showSurface();
    this.startSurface();
  }
  
  void settings() {
    size(500, 500);
  }
  
  String textValue = "0";
  
  void setup() {
    PFont font = createFont("arial",20);
    cp5 = new ControlP5(this);
  
  cp5.addTextfield("select_RGB")
     .setPosition(30,30)
     .setSize(100,40)
     .setFont(font)
     .setFocus(true)
     ;
                 
  cp5.addTextfield("0-255")
     .setPosition(30,130)
     .setSize(100,40)
     .setFont(font)
     .setFocus(true)
     ;
     
  textFont(font);
  background(0);
  }
  
  void draw() {
    fill(255);
    String RGB = cp5.get(Textfield.class,"select_RGB").getText();
    int num = int(cp5.get(Textfield.class,"0-255").getText());
    if(num <= 0){
      num = 0;
    }
    if(num >= 255){
      num = 255;
    }
    
    if((num != num_b)|| !(RGB.equals(RGB_b))){
      if(RGB.equals("R")){
        drawimage(0,num);
      }
      if(RGB.equals("G")){
        drawimage(1,num);
      }
      if(RGB.equals("B")){
        drawimage(2,num);
      }
      num_b = num;
      RGB_b = RGB;
    }
    //backimageの変わり
    fill(0);
    stroke(0);
    rect(0,0,200,400);
    rect(0,300,500,200);
    
    //文字軍の表示
    fill(255);
    stroke(255);
    text("image_color",30,240);
    text("datasave",30,350);
    text("dataload",30,400);
    text("datareset",30,450);
    
    //ボタンの設置
    noFill();
    rect(25,330,90,30);
    rect(25,380,90,30);
    rect(25,430,90,30);
    
    //image_colorの表示
    fill(iro/256/256,iro/256%256,iro%256);
    stroke(iro/256/256,iro/256%256,iro%256);
    rect(30,250,30,30);
    fill(iro2/256/256,iro2/256%256,iro2%256);
    stroke(iro2/256/256,iro2/256%256,iro2%256);
    rect(70,250,30,30);
    println(mouseButton);
  }
  
  void drawimage(int a,int b){
    int i;
    int j;
    background(0);
    strokeWeight(1);
    for(i = 0;i <= 255;i++){
      for(j = 0;j <= 255;j++){
        if(a == 0){
          fill(b,i,j);
          stroke(b,i,j);
        }
        else{
          if(a == 1){
            fill(i,b,j);
            stroke(i,b,j);
          }
          else{
            fill(i,j,b);
            stroke(i,j,b);
          }
        }
        rect(230+i,30+j,1,1);
      }
    }
  }
  ////////////////////////////////////////////////////
  ////////////////マウスを押したときの処理
  ////////////////////////////////////////////
  void mousePressed() {
  }
  ///////////////////////////////////////////
//マウスを動かしたときの処理
////////////////////////////////////////////
  void mouseMoved() {
    if((mouseX >= 230) && (mouseX <= 485)){
      if((mouseY >= 30) && (mouseY <= 285)){
        pX = mouseX - 230;
        pY = mouseY - 30;
      }
    }
  }
  
  /////////////////////////////////
//マウスが押して離れた時の処理\\
//////////////////////////////////
  void mouseReleased() {
    String RGB = cp5.get(Textfield.class,"select_RGB").getText();
    int num = int(cp5.get(Textfield.class,"0-255").getText());
    if(num <= 0){
      num = 0;
    }
    if(num >= 255){
      num = 255;
    }
    if((mouseX >= 230) && (mouseX <= 485)){
      if((mouseY >= 30) && (mouseY <= 285)){
        pX = mouseX - 230;
        pY = mouseY - 30;
        if(mouseButton == 37){
          if(RGB.equals("R")){
            iro = num*256*256+pX*256+pY;
          }
          if(RGB.equals("G")){
            iro = pX*256*256+num*256+pY;
          }
          if(RGB.equals("B")){
            iro = pX*256*256+pY*256+num;
          }
        }
        if(mouseButton == 39){
          if(RGB.equals("R")){
            iro2 = num*256*256+pX*256+pY;
          }
          if(RGB.equals("G")){
            iro2 = pX*256*256+num*256+pY;
          }
          if(RGB.equals("B")){
            iro2 = pX*256*256+pY*256+num;
          }
        }
      }
    }
    if((mouseX>=25)&&(mouseX<=115)){
      if((mouseY>=330)&&(mouseY <= 360)){
        datasave();
      }
      if((mouseY >= 380)&&(mouseY <=410)){
        dataload();
      }
      if((mouseY >=430)&&(mouseY <= 460)){
        dataclear();
      }
    }
  }
}