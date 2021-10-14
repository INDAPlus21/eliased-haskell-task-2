## Svar på frågorna

### 1. Varför kan man skriva utryck så som detta i Haskell?
```haskell
let evenNumbers = [ 2 * n | n <- [1..]]
print (take 1000000 evenNumbers)
```

evenNumbers använder en mängdbyggare (list comprehension) för att få en (uppräknelig;)) oändlig mängd av alla jämna tal. 

Det är möjligt eftersom Haskell använder lazy evaluation (call-by-need), dvs att alla värden tas fram när funktionerna används, inte när de definieras. 

Programmet ovan printar en lista med alla jämna tal från 2 till (o med) 2000000. 

### 2. Vad innebär rekursion? 
Att en funktion callar sig själv med parametrar som har räknats ut "i funktionens gång", och returnar ett resultat som både är användbart för sig själv samt  returnar (åtminstone) ett slutresultat när en viss condition är uppnådd. Rekursiva funktioner kan t.ex användas för att definiera en oändlig mängd med ett ändligt statement (som ovan; the list comprehension är bara syntatic sugar). 

Exempel på rekursivitet är en shackmotor som gör en rekursiv tree-search och använder resultatet från den evaluatade boardstaten. Ett annnat exempel är fibonnaci-programmen vi skrev till denna uppgift. 

Rekursion används mycket flitigt i Haskell p.g.a avsaknaden av while- och for-loopar. 

### 3. Varför fungerar följande funktion i språk så som haskell och inte i t.ex javascript
```haskell
sum :: Integral n, Num n => n -> n -> n
sum s 0 = s
sum s n = sum (s + n) (pred n)
```

```javascript
function sum(s, n) {
     if(n == 0){
         return s;
     } else{
         return sum(s + n, n - 1);
     }
}
```

Javascript-funktionen summerar talen s och n i varje iteration, och kallar sum() recursivt med summan av talen respektive n-1 som parameter. Den returnar till sist (när n har minskats till 0) slutsumman. T.ex sum(5, 3) kallar först sum(8, 2), sedan sum(10, 1), och till sist sum(11, 0) då den returnar 11. Funktionen kraschar med error-meddelandet "Uncaught RangeError: Maximum call stack size exceeded" när n är större tal (t.ex 50 000), eftersom alla funktionsargument måste få plats på callstacken (50 000 funktionscalls är i en enda lång lista att exekvera, för att datorn ska komma ihåg var någonstans den är i uträkningen) -- Javascript kan inte hantera oändlig rekursivitet (eller ens medelstor). 

"pred" returnar det föregående element i en enum, t.ex returnar pred 11 talet 10, och pred GGG FFF. Haskellfunktionen fungerar på samma sätt som Javascript-funktionen; den returnar slutsumman när andra argumentet är 0, och kallar annars sig själv rekursivt med summan av de två argumenten respektive n-1. Haskell hanterar utan problem tal (n) upp till runt en miljon (på kort tid), just för att alla calls inte hamnar på callstacken utan använder lika mycket minne som iterationer (de är svansrekursiva). Javascript behöver linjära O(n) space requirements, Haskell behöver bara konstanta O(1). 
