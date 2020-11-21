import controlP5.*;

ControlP5 cp5;
RadioButton r1;
Textlabel resultado1;
Textlabel resultado2;
Slider barra;
String texto;
float radioSelecionado;
float r,g,b;
float c,m,y,k;
float h,s,v;
float aux;

void setup(){
  size(859,479);
  
  // Trocar font
 PFont p = createFont("Verdana", 20);
 
 // inicializar
 cp5 = new ControlP5(this);
  
  // add textbox e estilizar
  cp5.addTextfield("a")
  .setPosition(199,210)
  .setSize(98,45)
  .setAutoClear(false)
  .setFont(p)
  .setColorBackground(color(247, 247, 247))
  .setColorValue(color(41,41,41))
  .setCaptionLabel("R");
  
  cp5.addTextfield("b")
  .setPosition(320,210)
  .setSize(98,45)
  .setAutoClear(false)
  .setFont(p)
  .setColorBackground(color(247, 247, 247))
  .setColorValue(color(41,41,41))
  .setCaptionLabel("G");
  
  cp5.addTextfield("c")
  .setPosition(441,210)
  .setSize(98,45)
  .setAutoClear(false)
  .setFont(p)
  .setColorBackground(color(247, 247, 247))
  .setColorValue(color(41,41,41))
  .setCaptionLabel("B");
  
  cp5.addTextfield("d")
  .setPosition(562,210)
  .setSize(98,45)
  .setAutoClear(false)
  .setFont(p)
  .setColorBackground(color(247, 247, 247))
  .setColorValue(color(41,41,41))
  .hide();
  
  fill(255,255,255);
  textFont(p);
  
  // add button e estilizar
  cp5.addButton("Converter")
  .setPosition(371,329)
  .setSize(135,41)
  .setFont(p)
  .setColorBackground(color(247, 247, 247))
  .setColorForeground(color(227,227,227))
  .setColorLabel(color(41,41,41))
  .setColorActive(color(217,217,217));
  
  cp5.setFont(p);
  
  // add radio button
  r1 = cp5.addRadioButton("shape picker")
  .setPosition(235,148)
  .setSize(20,20)
  .setItemsPerRow(4)
  .setSpacingColumn(130)
    .addItem("RGB", 1)
    .addItem("CMYK", 2)
    .addItem("HSV", 3)
    .activate(0);
    
  resultado1 = cp5.addTextlabel("resultado1")
     .setText("RGB: ")
     .setPosition(32,371)
     .setColorValue(color(255,255,255))
     .setFont(p)
     .hide();
  
  resultado2 = cp5.addTextlabel("resultado2")
     .setText("RGB: ")
     .setPosition(32,405)
     .setColorValue(color(255,255,255))
     .setFont(p)
     .hide();
     
  barra = cp5.addSlider("color")
             .setPosition(0,443)
             .setSize(859,37)
             .setColorValue(color(41,41,41))
             .setColorForeground(color(41,41,41))
             .setValue(100).lock();
  
}

void draw(){
  background(41,41,41);
  text("Digite a cor que deseja converter",262,108);
  
}

void Converter(){
  radioSelecionado = cp5.get(RadioButton.class, "shape picker").getValue();
  if(radioSelecionado == 1.0){
    r = Integer.valueOf(cp5.get(Textfield.class, "a").getText());
    g = Integer.valueOf(cp5.get(Textfield.class, "b").getText());
    b = Integer.valueOf(cp5.get(Textfield.class, "c").getText());
    
    converterDeRGB(r, g, b);
    
  }
  else if(radioSelecionado == 2.0){
    c = Integer.valueOf(cp5.get(Textfield.class, "a").getText());
    m = Integer.valueOf(cp5.get(Textfield.class, "b").getText());
    y = Integer.valueOf(cp5.get(Textfield.class, "c").getText());
    k = Integer.valueOf(cp5.get(Textfield.class, "d").getText());
    
    converterDeCMYK(c, m, y, k);
    
  }
  else if(radioSelecionado == 3.0){
    h = Integer.valueOf(cp5.get(Textfield.class, "a").getText());
    s = Integer.valueOf(cp5.get(Textfield.class, "b").getText());
    v = Integer.valueOf(cp5.get(Textfield.class, "c").getText());
    
    converterDeHSV(h, s, v);
    
  }
}

float GetMax(float r,float g, float b){
  return max(r/255,g/255,b/255);
}

float GetMin(float r,float g, float b){
  return min(r/255,g/255,b/255);
}

void converterDeRGB(float r, float g, float b){
  // converter de RGB para CMYK
    k = 1 - GetMax(r,g,b);
    aux = (1 - k);
    if(aux == 0){
      aux = 1;
    }
    c = (1 - (r/255) - k) / aux;
    m = (1 - (g/255) - k) / aux;
    y = (1 - (b/255) - k) / aux;
    
    // converter de RGB para HSV
    if(GetMax(r,g,b) == GetMin(r,g,b)){
      h = 0;
    }
    else if((GetMax(r,g,b) == r) && (g>=b)){
      h = 60*((g-b)/(GetMax(r,g,b)-GetMin(r,g,b)));
    }
    else if((GetMax(r,g,b) == r) && (g<b)){
      h = 60*((g-b)/(GetMax(r,g,b)-GetMin(r,g,b)))+360;
    }
    else if((GetMax(r,g,b) == g)){
      h = 60*((b-r)/(GetMax(r,g,b)-GetMin(r,g,b)))+120;
    }
    else if((GetMax(r,g,b) == b)){
      h = 60*((r-g)/(GetMax(r,g,b)-GetMin(r,g,b)))+240;
    }
    
    if(GetMax(r,g,b) == 0){
      s = 0;
    }
    else{
      s = (GetMax(r,g,b)-GetMin(r,g,b))/GetMax(r,g,b);
    }
    
    v = GetMax(r,g,b);
    barra.setColorValue(color(r,g,b)).setColorForeground(color(r,g,b));
    resultado1.setText("CMYK: " + Math.round(c*100) + "," + Math.round(m*100) + "," + Math.round(y*100) + "," + Math.round(k*100)).show();
    resultado2.setText("HSV: " + Math.round(h % 360) + "," + Math.round(s * 100) + "," + Math.round(v * 100)).show();
}

void converterDeCMYK(float c, float m, float y, float k){
  
  // converter de CMYK para RGB
    r = 255*(1-c/100)*(1-k/100);
    g = 255*(1-m/100)*(1-k/100);
    b = 255*(1-y/100)*(1-k/100);
    
   // converter de RGB para HSV
    if(GetMax(r,g,b) == GetMin(r,g,b)){
      h = 0;
    }
    else if((GetMax(r,g,b) == r) && (g>=b)){
      h = 60*((g-b)/(GetMax(r,g,b)-GetMin(r,g,b)));
    }
    else if((GetMax(r,g,b) == r) && (g<b)){
      h = 60*((g-b)/(GetMax(r,g,b)-GetMin(r,g,b)))+360;
    }
    else if((GetMax(r,g,b) == g)){
      h = 60*((b-r)/(GetMax(r,g,b)-GetMin(r,g,b)))+120;
    }
    else if((GetMax(r,g,b) == b)){
      h = 60*((r-g)/(GetMax(r,g,b)-GetMin(r,g,b)))+240;
    }
    
    if(GetMax(r,g,b) == 0){
      s = 0;
    }
    else{
      s = (GetMax(r,g,b)-GetMin(r,g,b))/GetMax(r,g,b);
    }
    
    v = GetMax(r,g,b);
    barra.setColorValue(color(r,g,b)).setColorForeground(color(r,g,b));
    resultado1.setText("RGB: " + Math.round(r) + "," + Math.round(g) + "," + Math.round(b)).show();
    resultado2.setText("HSV: " + Math.round(h % 360) + "," + Math.round(s * 100) + "," + Math.round(v * 100)).show();
}

void converterDeHSV(float h, float s, float v){
  
  // converter de HSV para RGB
  int h1;
  float f, p, q, t;
  
  // verificar se não passou
  h = Math.max(0, Math.min(360, h));
  s = Math.max(0, Math.min(100, s));
  v = Math.max(0, Math.min(100, v));
  
  // calculando de 0 a 1 (0 a 100)
  s /= 100;
  v /= 100;
  
  if(s == 0) {
    //(grey)
    r = g = b = Math.round(v * 255);
  }
  else{
    h /= 60; //  0 a 5
    h1 = (int)Math.floor(h);
    f = h - h1;
    p = v * (1 - s);
    q = v * (1 - s * f);
    t = v * (1 - s * (1 - f));
    
    switch (h1) {
      case 0: 
        r = v*255;
        g = t*255;
        b = p*255;
        break;
      case 1: 
        r = q*255;
        g = v*255;
        b = p*255;
        break;
      case 2: 
        r = p*255;
        g = v*255;
        b = t*255;
        break;
      case 3: 
        r = p*255;
        g = q*255;
        b = v*255;
        break;
      case 4: 
        r = t*255;
        g = p*255;
        b = v*255;
        break;
      case 5: 
        r = v*255;
        g = p*255;
        b = q*255;
        break;
    }
  }
  
  
  // converter de RGB para CMYK
  k = 1 - GetMax(r,g,b);
  aux = (1 - k);
  if(aux == 0){
    aux = 1;
  }
  c = (1 - (r/255) - k) / aux;
  m = (1 - (g/255) - k) / aux;
  y = (1 - (b/255) - k) / aux;
  barra.setColorValue(color(r,g,b)).setColorForeground(color(r,g,b));
  resultado1.setText("RGB: " + Math.round(r) + "," + Math.round(g) + "," + Math.round(b)).show();
  resultado2.setText("CMYK: " + Math.round(c*100) + "," + Math.round(m*100) + "," + Math.round(y*100) + "," + Math.round(k*100)).show();
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(r1)) {
    if(theEvent.getValue() == 1.0){
      cp5.get("a").setCaptionLabel("R");
      cp5.get("b").setCaptionLabel("G");
      cp5.get("c").setCaptionLabel("B");
      cp5.get("d").hide();
    } 
    else if(theEvent.getValue() == 2.0){
      cp5.get("a").setCaptionLabel("C");
      cp5.get("b").setCaptionLabel("M");
      cp5.get("c").setCaptionLabel("Y");
      cp5.get("d").setCaptionLabel("K");
      cp5.get("d").show();
    }
    else if(theEvent.getValue() == 3.0){
      cp5.get("a").setCaptionLabel("H");
      cp5.get("b").setCaptionLabel("S");
      cp5.get("c").setCaptionLabel("V");
      cp5.get("d").hide();
    }
    
    clear();
    
  }
}

void clear(){
resultado1.hide();
resultado2.hide();
cp5.get(Textfield.class, "a").setText("");
cp5.get(Textfield.class, "b").setText("");
cp5.get(Textfield.class, "c").setText("");
cp5.get(Textfield.class, "d").setText("");
barra.setColorValue(color(41,41,41)).setColorForeground(color(41,41,41));
}
