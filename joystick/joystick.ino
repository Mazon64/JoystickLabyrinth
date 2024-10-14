#include <Keyboard.h>
const int potX = A4; // Potenciómetro en eje X
const int potY = A5; // Potenciómetro en eje Y
int threshold = 25; // Umbral para determinar el movimiento
void setup() {
pinMode(potX, INPUT);
pinMode(potY, INPUT);
delay(10000);
Keyboard.begin(); // Inicia el teclado
}
void loop() {
int xValue = analogRead(potX); // Lee el valor del potenciómetro X
int yValue = analogRead(potY); // Lee el valor del potenciómetro Y
// Movimientos en X

if (xValue < 555 - threshold) {
Keyboard.press('d'); // Izquierda
} else if (xValue > 555 + threshold) {
Keyboard.press('a'); // Derecha
} else {
Keyboard.release('a');
Keyboard.release('d');
}
// Movimientos en Y
if (yValue < 460 - threshold) {
Keyboard.press('w'); // Arriba
} else if (yValue > 460 + threshold) {
Keyboard.press('s'); // Abajo
} else {
Keyboard.release('w');
Keyboard.release('s');
}
delay(100); // Pequeño retraso para evitar spam excesivo en el
teclados
}