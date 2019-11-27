import controlP5.*;

// Processing課題2
// (1) 最初に次の操作を行い、元のK2_FreeWorkフォルダーを残したままコピーを用意する。
//    (1.1) ファイル→名前を付けて保存...を実行
//    (1.2) 現れたウィンドウ（ファイルダイアログ）の「ファイル名」を自分の学籍番号（M01xxxxx）して「保存」
// (2)その後、M01xxxxxの中身を変更することで課題を完成させる。
// (3)完成したら、次の手順で提出
//    (3.1) ファイル→保存 を実行
//    (3.2) 発表資料・プログラム説明書（Kadai_2.pptx）を完成させ、フォルダーM01xxxxxの中に入れる
//    (3.3) そのフォルダーM01xxxxxをSAに提出（USBメモリにコピー。16:30までに）
//    (3.4) そのフォルダーをzip圧縮し、ファイルM01xxxxx.zipをMoodleで提出（16:35までに）
//　　　　zip圧縮は、フォルダーのアイコンを右クリックし、「送る」→「圧縮(zip形式)フォルダー」を実行する方法で行ってください。
//
// MOSHI JOUKI NO NIHONGO GA YOMENAI BAAI HA "File" MENYU KARA "Preferences" WO JIKKOU SHI, 
// "Editor and Console font" NO SHITEI WO "MS GOSHIKKU" (KATAKANA) NI SHITE "Ok" BOTAN WO OSU 
//

/////////////////////////////////////////////////////////////////////////////////////////
//// グローバル変数 ////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

int x = 0;//現在の座標
int y = 0;//現在の座標
int iro = 0;//色のデータ
int iro2 = 0;
int [][] data = new int[100][100]; //座標データ
SecondWindow second;

///////////////////////
//初期セットアップ //
/////////////////////
void settings(){
  size(1000,700);
}

void setup() {
  //size(1000, 700);
  second = new SecondWindow(this);
  dataload();
  strokeWeight(1);
  setupMisc();
}

////////////////////////////
//メイン関数（繰り返し）///
///////////////////////////
void draw() {
  background(255, 255, 255);
  drawall();
  drawRuler(width, height - 99);
  drawTitleAndName("お絵かきプログラム", "M0117210 西澤武");
  drawKadai2();
  //println(x,y,data[y][x]);
}

/////////////////////////////
//現在地をぬる ////////////
///////////////////////
void drawKadai2() {
  noFill();
  stroke(0,255,0);
  drawpick(x,y);
}

////////////////////////////
//一か所ぬる ////////////
///////////////////////////
void drawpick(int a,int b) {
  rect(10*a,10*b,10,10);
}

//////////////////////////////
//すべての個所を塗る //////
///////////////////////
void drawall(){
  int i;
  int j;
  for(i = 0;i < 60;i++){
    for(j = 0; j < 100;j++){
      fill(data[i][j] /256/256,data[i][j]/256%256,data[i][j] %256);
      stroke(data[i][j] /256/256,data[i][j]/256%256,data[i][j] %256);
      drawpick(j,i);
    }
  }
}

///////////////////////////
//マウスが押された時の処理 //
////////////////////////////
void mousePressed() {
  int a = mouseY/10;
  int b = mouseX/10;
  if(a < 0){ //mouseYが範囲外に出た時の処理
    a = 0;
  }
  if(a > 59){//mouseYが範囲外に出た時の処理
    a = 59;
  }
  if(b < 0){//mouseXが範囲外に出た時の処理
    b = 0;
  }
  if(b > 99){//mouseX範囲外に出た時の処理
    b = 99;
  }
  if(mouseButton == LEFT){
    kaku(a,b);
  }
  if(mouseButton == RIGHT){
    kaku2(a,b);
  }
}

/////////////////////////////////
//マウスが押して離れた時の処理\\
//////////////////////////////////
void mouseReleased() {
}

///////////////////////////////////
//マウスをドラッグした時の処理
//////////////////////////////////
void mouseDragged() {
  int a = mouseY/10;
  int b = mouseX/10;
  if(a < 0){//mouseYが範囲外に出た時の処理
    a = 0;
  }
  if(a > 59){//mouseYが範囲外に出た時の処理
    a = 59;
  }
  if(b < 0){//mouseX範囲外に出た時の処理
    b = 0;
  }
  if(b > 99){//mouseX範囲外に出た時の処理
    b = 99;
  }
  if(mouseButton == LEFT){
    kaku(a,b);
  }
  if(mouseButton == RIGHT){
    kaku2(a,b);
  }
}

///////////////////////////////////////////
//マウスを動かしたときの処理
////////////////////////////////////////////
void mouseMoved() {
}

/////////////////////////////////
//何かしらのkeyが押された時の処理
//////////////////////////////////
void keyPressed() {
  if(key == 'd' ){
    x = (x + 1) % 100; //x座標を右にずらす
  }
  if(key == 'a'){
    x = (x + 99) % 100;//x座標を左にずらす
  }
  if(key == 's' ){
    y = (y + 1) % 60;//y座標を下にずらす
  }
  if(key == 'w'){
    y = (y + 59) % 60;//y座標を上にずらす
  }
  if(key == ENTER){//描く
    data[y][x] = 1;
  }
  if(key == TAB){//消す
    data[y][x] = 0;
  }
  if(key == 'z'){//セーブ
    datasave();
  }
  if(key == 'c'){//全削除
    dataclear();
  }
}

////////////////////////////////////
//keyが離れた時の処理
//////////////////////////////
void keyReleased() {
}

////////////////////////////////
//dataを書く時の処理
/////////////////////////////
void kaku(int a,int b){
  data[a][b] = iro;
}

///////////////////////////////
//dataをケス時の処理
///////////////////////////
void kaku2(int a,int b){
  data[a][b] = iro2;
}

////////////////////////////
//dataをファイルから読み込む
//////////////////////////////
void dataload(){
  int a = 0;
  int b = 0;
  PrintWriter outfile;
  String[] datalines;
  datalines = loadStrings("data.txt");
  if(datalines != null){//dataがある確認
      for(int i = 0; i < datalines.length; i ++) {
        // 空白行でないかを確認
        if(datalines[i].length() != 0) {
          // 一行読み取ってカンマ区切りで格納
          String[] values = datalines[i].split("," , -1);
          // 列の数だけ読み取り
          for(int j = 0; j < 100; j ++) {
            if(values[j] != null && values[j].length() != 0) {
              data[i][j] = int(values[j]);
            }
          }
          a++;
          if( a > 60){
             return;
          }
        }
      }
  }
  else{//dataがないとき作成
    outfile = createWriter("data.txt");
    for(a = 0; a < 100 ; a++){
      for(b = 0 ; b < 100 ; b++){
        outfile.print("16777215,");
      }
      outfile.println("");
    }
  }  
}

///////////////////////////////////
//dataをファイルに保存
////////////////////////////////////
void datasave(){
  int a = 0;
  int b = 0;
  PrintWriter outfile;
  outfile = createWriter("data.txt");
  for(a = 0; a < 100 ;a++){
    for(b = 0; b < 100; b++){
      outfile.print(data[a][b]);
      outfile.print(",");
    }
    outfile.println("");
  }
}

///////////////////////////////////////
//errorが出るためdummyのデータを挿入
//////////////////////////////////////
void dummydata(){
  int a = 0;
  int b = 0;
  for(a = 60;a < 100;a++){
    for(b = 0;b < 100;b++){
      data[a][b] = 0;
    }
  }
}

/////////////////////////////////
//dataをすべて0にする
///////////////////////////////
void dataclear(){
  int a = 0;
  int b = 0;
  for(a = 0;a < 100;a++){
    for(b = 0;b < 100;b++){
      data[a][b] = 16777215;
    }
  }
}

///////////////////////////////////////////
//使わない関数
//////////////////////////////////
/*

//////////////////////
//文字を白色にする//
//////////////////////
void non(){
  fill(255,255,255);
  stroke(255,255,255);
}

/////////////////////
//文字を黒色にする //
////////////////////
void mob(){
  fill(0,0,0);
  stroke(0,0,0);
}
*/