#include <RTClib.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <SoftwareSerial.h>
#include <EEPROM.h>
#define INTERVAL 2000  //tiempo entre pantallas
#define RINGTIME 2000  //tiempo sonado timbre

LiquidCrystal_I2C lcd(0x27, 16, 2); // Dirección I2C del LCD y tamaño
RTC_DS3231 rtc;

volatile bool sonarTimbre = false;
unsigned long previousMillis = 0;
char daysOfTheWeek[7][4] = {"Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"};
char monthsOfTheYear[12][4] = {"Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"};

char dateTimeString[17]; // 16 caracteres + terminador nulo
int contadorAlarmas = 0;
SoftwareSerial BTSerial(0, 1); // RX, TX

struct Alarma {
  int horas;
  int minutos;
  int diasSemana; // Usaremos un entero para representar los días de la semana en los que suena la alarma
};

Alarma alarmas[10];

void cambiarRTC(String comando) { 
   if (comando.length() != 13) {
        Serial.println("Error: Formato incorrecto");
        Serial.println(comando.length());
        return;
    }
    int dia = comando.substring(1, 3).toInt();
    int mes = comando.substring(3, 5).toInt();
    int anio = comando.substring(5, 7).toInt() + 2000; // Suponiendo que el año está en formato YY
    int horas = comando.substring(7, 9).toInt();
    int minutos = comando.substring(9, 11).toInt();
    

    if (dia < 1 || dia > 31 || mes < 1 || mes > 12 || horas < 0 || horas > 23 || minutos < 0 || minutos > 59) {
        Serial.println("Error: Fecha u hora inválida");
        return;
    }


    DateTime now = rtc.now();
    DateTime nuevaFechaHora(anio, mes, dia, horas, minutos);

    rtc.adjust(nuevaFechaHora);
}

void AgregarAlarma(String alarmaString) {
  int posN = alarmaString.indexOf("n");
  int posD = alarmaString.indexOf("d");

  if (posN == -1 || posD == -1)
  {
    Serial.println("Error: Formato Incorrecto");
    return;
  }

  String horaStr = alarmaString.substring(posN + 1, posD);
  int horas = horaStr.substring(0, 2).toInt();   
  int minutos = horaStr.substring(3).toInt();  
  
  String diasStr = alarmaString.substring(posD + 1); 
  int diasBinario = diasStr.toInt(); 

  Alarma nuevaAlarma;
  nuevaAlarma.horas = horas;
  nuevaAlarma.minutos = minutos;
  nuevaAlarma.diasSemana = diasBinario;

  alarmas[contadorAlarmas++] = nuevaAlarma;

  guardarAlarmaEEPROM();
  Serial.println("Alarma guardada en EEPROM.");

  Serial.print("Alarma guardada: ");
  Serial.print(horas);
  Serial.print(":");
  Serial.print(minutos);
  Serial.print(" Dias: ");
  for (int i = 0; i < 7; i++) {
    // Aquí invertimos los días de la semana
    if (diasBinario & (1 << (7 - i))) {
      Serial.print(daysOfTheWeek[i]);
      Serial.print("/");
    }
  }
  Serial.println();

}

void guardarAlarmaEEPROM() {
  EEPROM.update(0, contadorAlarmas);
  for (int i = 0; i < contadorAlarmas; i++) {
    int direccion = 1 + i * 3; // Cada alarma ocupa 7 bytes
    int horas = alarmas[i].horas;
    int minutos = alarmas[i].minutos;
    int diasSemana = alarmas[i].diasSemana;
    EEPROM.update(direccion, alarmas[i].horas);
    EEPROM.update(direccion + 1, alarmas[i].minutos);
    EEPROM.update(direccion + 2, alarmas[i].diasSemana);
  }

}

void leerAlarmaEEPROM() {
  
  contadorAlarmas = EEPROM.read(0);
  Serial.print("Numero de alarmas guardadas: ");
  Serial.println(contadorAlarmas);
  for (int i = 0; i < contadorAlarmas; i++) {
    int direccion = 1 + i * 3; // Cada alarma ocupa 7 bytes
    alarmas[i].horas = EEPROM.read(direccion);
    alarmas[i].minutos = EEPROM.read(direccion + 1);
    alarmas[i].diasSemana = EEPROM.read(direccion + 2);
    int horas = alarmas[i].horas;
    int minutos = alarmas[i].minutos;
    int diasSemana = alarmas[i].diasSemana;

     Serial.print("Alarma ");
    Serial.print(i + 1);
    Serial.print(": ");
    Serial.print(horas);
    Serial.print(":");
    Serial.print(minutos);
    Serial.print("  Dias: ");
    for (int j = 0; j < 7; j++) {
      // Invertimos el orden de los días de la semana
      if (diasSemana & (1 << (7 - j))) {
        Serial.print(daysOfTheWeek[j]);
        Serial.print(", ");
      }
    }
    Serial.println();
  }
}

void borrarTodasAlarmasEEPROM() {
  contadorAlarmas = 0;
  EEPROM.update(0, contadorAlarmas);
  for (int i = 1; i < EEPROM.length(); i++) {
    EEPROM.update(i, 0xFF); // 0xFF es el valor por defecto de una EEPROM borrada
  }
  asm volatile ("  jmp 0");
        
}

DateTime proximaAlarma() {
  DateTime now = rtc.now();
  DateTime proximamente = now + TimeSpan(7, 0, 0, 0); // Inicialmente configuramos la próxima alarma a una semana de distancia
  if (contadorAlarmas == 0) {
    proximamente = DateTime(2100, 1, 1);  // Cualquier valor que no sea válido como fecha
  }
  else {
    for (int i = 0; i < contadorAlarmas; i++) {
      for (int j = 0; j < 7; j++) { // Recorre los próximos 7 días
        DateTime posibleAlarma = DateTime(now.year(), now.month(), now.day() + j, alarmas[i].horas, alarmas[i].minutos, 0);
        int diaSemana = (now.dayOfTheWeek() + j) % 7;
        
        if ((alarmas[i].diasSemana & (1 << (7 - diaSemana))) && posibleAlarma > now && posibleAlarma < proximamente) {
          proximamente = posibleAlarma;
        }
      }
    }
  }

  return proximamente;
}

void buttonISR() {
  sonarTimbre = true;
}

void imprimirHora() {
  DateTime now = rtc.now(); //REMOVER

  snprintf(dateTimeString, sizeof(dateTimeString), "%s %02d %s %02d:%02d",
           daysOfTheWeek[now.dayOfTheWeek()],
           now.day(),
           monthsOfTheYear[now.month() - 1],
           now.hour(),
           now.minute());
}

void setup() {

  if (!rtc.begin()) {
    Serial.println("No se encuentra el RTC");
    while (1);
  }

  pinMode(2, INPUT);
  pinMode(13, OUTPUT);
  Serial.begin(9600);
  BTSerial.begin(9600);
  attachInterrupt(digitalPinToInterrupt(2), buttonISR, RISING);

  // Inicializa el LCD
  lcd.init();
  lcd.backlight();

  byte bell[8] = {
    B00000,
    B00100,
    B01110,
    B01110,
    B01110,
    B11111,
    B00100,
    B00000
  };
  byte clock[8] = {
    B01110,
    B10001,
    B10101,
    B10111,
    B10001,
    B10001,
    B01110,
    B00000
  };
  byte buttonRight[8] = {
    B00000,
    B11110,
    B00010,
    B11010,
    B11010,
    B00010,
    B11110,
    B00000
  };
  byte upArrow[8] = {
    B00000,
    B00000,
    B00000,
    B00100,
    B01110,
    B11111,
    B00000,
    B00000
  };
  byte downArrow[8] = {
    B00000,
    B00000,
    B00000,
    B11111,
    B01110,
    B00100,
    B00000,
    B00000
  };
  byte leftArrow[8] = {
    B00000,
    B00000,
    B00010,
    B00110,
    B01110,
    B00110,
    B00010,
    B00000
  };
  byte rightArrow[8] = {
    B00000,
    B00000,
    B01000,
    B01100,
    B01110,
    B01100,
    B01000,
    B00000
  };
  byte tick[8] = {
    B00000,
    B00000,
    B00001,
    B00010,
    B10100,
    B01000,
    B00000,
    B00000  
  };
  byte reset[8] = {
    B11111,
    B10001,
    B11011,
    B10101,
    B11011,
    B10001,
    B11111,
    B00000
  };
  lcd.createChar(0, bell);
  lcd.createChar(1, clock);
  lcd.createChar(2, buttonRight);
  lcd.createChar(3, upArrow);
  lcd.createChar(4, reset);
  lcd.createChar(5, leftArrow);
  lcd.createChar(6, rightArrow);
  lcd.createChar(7, tick);
  
  leerAlarmaEEPROM();
}

void loop() {
  unsigned long currentMillis = millis();
  DateTime now = rtc.now();

  if (BTSerial.available()) {
    String inputString = BTSerial.readStringUntil(';');
    Serial.print("Comando recibido: ");
    Serial.println(inputString);
    if (inputString == "BORRAR") {
        borrarTodasAlarmasEEPROM();
    } 
    else if (inputString.startsWith("c")) {
        cambiarRTC(inputString);
    } 
    else {
        AgregarAlarma(inputString + ';');
    }
  }

  if (sonarTimbre) {
    digitalWrite(13, HIGH);
    lcd.clear();
    lcd.print("Sonando Timbre ");
    lcd.write(byte (0));
    delay(RINGTIME);
    digitalWrite(13, LOW);
    lcd.clear();
    sonarTimbre = false;
  }

  for (int i = 0; i < sizeof(alarmas)/sizeof(alarmas[0]); i++) {
    if (alarmas[i].horas == now.hour() && alarmas[i].minutos == now.minute() && now.second() == 0) {
      int diaSemanaActual = now.dayOfTheWeek();
      if (alarmas[i].diasSemana & (1 << (7-diaSemanaActual))) {
      sonarTimbre = true;
      }
    }
  }

  if (currentMillis - previousMillis >= INTERVAL) {
    previousMillis = currentMillis;
    static int state = 0;
    lcd.clear();

    lcd.setCursor(1, 1);
    lcd.write(byte (0));
    lcd.print(" Sonar timbre");

    if (state == 0) {
      lcd.setCursor(0, 0);
      imprimirHora();
      lcd.print(dateTimeString);
    } 
      else if (state == 1) {
      lcd.setCursor(0, 0);
      lcd.print("Proximo: ");
      lcd.write(byte (1));
      lcd.print(" ");
      DateTime proxAlarma = proximaAlarma();
      if (proxAlarma.year() == 2100) {
        lcd.print("N/A");
      } else {
      snprintf(dateTimeString, sizeof(dateTimeString), "%02d:%02d", proxAlarma.hour(), proxAlarma.minute());
      lcd.print(dateTimeString);
    
    }
    } 
      else if (state == 2) {
      lcd.setCursor(0, 0);
      lcd.print("Cant Alarmas: ");
      lcd.print(contadorAlarmas);
    }
    state = (state + 1) % 3;
  }
}
