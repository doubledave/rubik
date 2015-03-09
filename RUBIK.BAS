DECLARE SUB solve ()
DECLARE SUB randomizeCube ()
DECLARE SUB B ()
DECLARE SUB Bi ()
DECLARE SUB randomMove ()
DECLARE SUB rotateDown ()
DECLARE SUB Fi ()
DECLARE SUB F ()
DECLARE SUB RotateUp ()
DECLARE SUB Li ()
DECLARE SUB middledown ()
DECLARE SUB Ri ()
DECLARE SUB L ()
DECLARE SUB middleUp ()
DECLARE SUB R ()
DECLARE SUB D ()
DECLARE SUB Ui ()
DECLARE SUB middleRight ()
DECLARE SUB Di ()
DECLARE SUB middleLeft ()
DECLARE SUB rotateLeft ()
DECLARE SUB rotateRight ()
DECLARE SUB U ()
DECLARE SUB drawcube ()
DECLARE SUB initiateSolved ()
COMMON SHARED cs, lastmove
DIM SHARED side(6, 9)
DIM SHARED temp(6, 9)'temporary cube for rotating
' 6 sides, 9 pieces on each side, each side is identified by
' the middle piece (#5), 6 possible colors on each piece:
' 1=White 2=Red 3=Blue 4=Orange 5=Green 6=Yellow
' sides represented by the way it is being held: F:1 U:2 L:3 D:4 R:5 back:6

cs = 72 'size in pixels of each cubelet, must be common denominator of 3 & 4
RANDOMIZE TIMER

initiateSolved

10 a$ = INKEY$: IF a$ = "" THEN 10
IF a$ = "r" THEN R: drawcube: GOTO 10
IF a$ = "R" THEN Ri: drawcube: GOTO 10
IF a$ = "l" THEN L: drawcube: GOTO 10
IF a$ = "L" THEN Li: drawcube: GOTO 10
IF a$ = "u" THEN U: drawcube: GOTO 10
IF a$ = "U" THEN Ui: drawcube: GOTO 10
IF a$ = "d" THEN D: drawcube: GOTO 10
IF a$ = "D" THEN Di: drawcube: GOTO 10
IF a$ = "f" THEN F: drawcube: GOTO 10
IF a$ = "F" THEN Fi: drawcube: GOTO 10
IF a$ = "b" THEN B: drawcube: GOTO 10
IF a$ = "B" THEN Bi: drawcube: GOTO 10
IF a$ = CHR$(12) THEN rotateLeft: drawcube: GOTO 10
IF a$ = CHR$(18) THEN rotateRight: drawcube: GOTO 10
IF a$ = CHR$(21) THEN RotateUp: drawcube: GOTO 10
IF a$ = CHR$(4) THEN rotateDown: drawcube: GOTO 10
IF a$ = "m" THEN randomMove: drawcube: GOTO 10
IF a$ = "M" THEN randomizeCube: GOTO 10
IF a$ = CHR$(27) THEN END
IF a$ = "s" THEN solve: GOTO 10

PRINT ASC(a$);

END

SUB B

'rotate back side clockwise


'first rotate it towards you
rotateLeft
rotateLeft

F

'now turn it back the way it was
rotateLeft
rotateLeft

END SUB

SUB Bi

rotateLeft
rotateLeft

Fi

rotateLeft
rotateLeft

END SUB

SUB D

Di
Di
Di

END SUB

SUB Di

FOR s = 1 TO 6
FOR c = 1 TO 9
temp(s, c) = side(s, c)
NEXT c
NEXT s

'Down side rotates counterclockwise
temp(4, 1) = side(4, 7)
temp(4, 2) = side(4, 4)
temp(4, 3) = side(4, 1)
temp(4, 4) = side(4, 8)
temp(4, 6) = side(4, 2)
temp(4, 7) = side(4, 9)
temp(4, 8) = side(4, 6)
temp(4, 9) = side(4, 3)

'edges
temp(1, 8) = side(5, 8)
temp(5, 8) = side(6, 8)
temp(6, 8) = side(3, 8)
temp(3, 8) = side(1, 8)

'corners
temp(1, 7) = side(5, 9)
temp(1, 9) = side(5, 7)
temp(5, 7) = side(6, 7)
temp(5, 9) = side(6, 9)
temp(6, 7) = side(3, 7)
temp(6, 9) = side(3, 9)
temp(3, 7) = side(1, 9)
temp(3, 9) = side(1, 7)

FOR s = 1 TO 6
FOR c = 1 TO 9
side(s, c) = temp(s, c)
NEXT c
NEXT s


END SUB

SUB drawcube

'draw front face
FOR x = 1 TO 3
FOR y = 1 TO 3
cl = (y - 1) * 3 + x 'cubelet # - 1=top left 3=top right 9=bottom right
LINE (x * cs + 2, 2 * cs + y * cs + 2)-((x + 1) * cs, 2 * cs + (y + 1) * cs), side(1, cl), BF
NEXT y
NEXT x

'draw up face
FOR x = 1 TO 3
FOR y = 1 TO 3
cl = (y - 1) * 3 + x'1= next to front side 1, 7 next to left side 3,back side 1, 9 next to right side 1 back side 3
x1 = cs / 3 * (3 + y) + (x - 1) * cs + 2
y1 = cs / 2 * (6 - y) + 2
x2 = cs / 3 * (3 + y) + (x - 1) * cs + cs / 1.5
y2 = cs / 2 * (7 - y)

FOR i = y1 TO y2
LINE (cs * (x + (y - 1) / 3) + 3 + (y2 - i) * 2 / 3, i)-(cs * (x + 1 + (y - 1) / 3) + (y2 - i) * 2 / 3 + 1, i), side(2, cl)
NEXT i
NEXT y
NEXT x

' draw right face (side 5)
FOR x = 1 TO 3
FOR y = 1 TO 3
cl = (y - 1) * 3 + x '1=near back 3, up 9, 3 near up 3, front 3, 9 near fron 9 down 9
x1 = 4 * cs + (3 - x) * cs / 3 + 2
y1 = cs * 3 + (y - 1) * cs + 2 - (3 - x) * cs / 2
x2 = 4 * cs + (4 - x) * cs / 3
y2 = cs * 3 + y * cs - cs / 2 - (3 - x) * cs / 2

FOR i = x1 TO x2
y3 = cs * 3 + (y - 1) * cs + 2 - (3 - x) * cs / 2 - (i - x1) * 3 / 2
y4 = cs * 3 + (y + 0) * cs - cs / 2 - (2 - x) * cs / 2 - (i - x1) * 3 / 2 - 1
LINE (i, y3)-(i, y4), side(5, cl)
NEXT i

'LINE (x1, y1)-(x2, y2), side(5, cl), BF
NEXT y
NEXT x

END SUB

SUB F

Fi
Fi
Fi

END SUB

SUB Fi

FOR s = 1 TO 6
FOR c = 1 TO 9
temp(s, c) = side(s, c)
NEXT c
NEXT s

'front side rotates counter-clockwise
temp(1, 1) = side(1, 3)
temp(1, 2) = side(1, 6)
temp(1, 3) = side(1, 9)
temp(1, 4) = side(1, 2)
temp(1, 6) = side(1, 8)
temp(1, 7) = side(1, 1)
temp(1, 8) = side(1, 4)
temp(1, 9) = side(1, 7)

'edges & corners
temp(2, 3) = side(5, 9)
temp(2, 2) = side(5, 6)
temp(2, 1) = side(5, 3)
temp(3, 1) = side(2, 3)
temp(3, 4) = side(2, 2)
temp(3, 7) = side(2, 1)
temp(4, 7) = side(3, 1)
temp(4, 8) = side(3, 4)
temp(4, 9) = side(3, 7)
temp(5, 9) = side(4, 7)
temp(5, 6) = side(4, 8)
temp(5, 3) = side(4, 9)

FOR s = 1 TO 6
FOR c = 1 TO 9
side(s, c) = temp(s, c)
NEXT c
NEXT s

END SUB

SUB initiateSolved

FOR s = 1 TO 6
FOR c = 1 TO 9
side(s, c) = s
NEXT c
NEXT s

SCREEN 12
CLS
LINE (0, 0)-(639, 479), 8, BF


'map colors
PALETTE 0, 65536 * 0 + 256 * 0 + 0    'Black
PALETTE 1, 65536 * 63 + 256 * 63 + 63 'White
PALETTE 2, 65536 * 0 + 256 * 0 + 63   'Red
PALETTE 3, 65536 * 63 + 256 * 0 + 0   'Blue
PALETTE 4, 65536 * 0 + 256 * 31 + 63  'Orange
PALETTE 5, 65536 * 0 + 256 * 63 + 0   'Green
PALETTE 6, 65536 * 0 + 256 * 63 + 63  'Yellow
PALETTE 7, 65536 * 31 + 256 * 31 + 31 'Gray

FOR i = 1 TO 4
'draw grid pattern
LINE (cs * i + 1, cs * 3 + 1)-(cs * i + 1, cs * 6 + 1), 0         'vertical
LINE (cs + 1, cs * (i + 2) + 1)-(cs * 4 + 1, cs * (i + 2) + 1), 0 'horizontal
'draw top grid pattern                           
LINE (cs * i + 1, cs * 3 + 1)-(cs * (i + 1) + 1, cs * 1.5 + 1), 0                                                 'diagonal
LINE (cs + 1 + cs * ((i - 1) / 3), cs * (7 - i) / 2 + 1)-(cs * 4 + 1 + cs * (i - 1) / 3, cs * (7 - i) / 2 + 1), 0 'horizontal
'draw right grid pattern
LINE (cs * 4 + 1, cs * (i + 2) + 1)-(cs * 5 + 1, cs * 1.5 + (i - 1) * cs + 1), 0
LINE (cs * 4 + cs * (i - 1) / 3 + 1, cs * 1.5 + cs * (4 - i) / 2 + 1)-(cs * 4 + cs * (i - 1) / 3 + 1, cs * 4.5 + cs * (4 - i) / 2 + 1), 0
NEXT i

drawcube

LOCATE 2, 48
PRINT "Ctrl-L:      Rotate cube left   ";
LOCATE 3, 48
PRINT "Ctrl-R:      Rotate cube right  ";
LOCATE 4, 48
PRINT "Ctrl-U:      Rotate cube up     ";
LOCATE 5, 48
PRINT "Ctrl-D:      Rotate cube down   ";
LOCATE 6, 48
PRINT "L/R/U/D/F/B: Rotate layer       ";
LOCATE 7, 48
PRINT "             clockwise          ";
LOCATE 8, 48
PRINT "Shift L/R/U/D/F/B: rotate layer ";
LOCATE 9, 48
PRINT "             counter-clockwise  ";
LOCATE 10, 48
PRINT "M:           Make a random move ";
LOCATE 11, 48
PRINT "Shift M:     26 random moves    ";
LOCATE 12, 48
PRINT "S: Solve     Esc: Exit          ";
LOCATE 29, 23
PRINT " D ";
LOCATE 6, 32
PRINT " U ";
LOCATE 14, 48
PRINT " R ";
LOCATE 21, 5
PRINT " L ";
LOCATE 14, 53
PRINT " F = Front";
LOCATE 14, 65
PRINT " B = Back ";

END SUB

SUB L

Li
Li
Li

END SUB

SUB Li

FOR s = 1 TO 6
FOR c = 1 TO 9
temp(s, c) = side(s, c)
NEXT c
NEXT s

'Left side rotates counterclockwise
temp(3, 3) = side(3, 1)
temp(3, 6) = side(3, 2)
temp(3, 9) = side(3, 3)
temp(3, 2) = side(3, 4)
temp(3, 8) = side(3, 6)
temp(3, 1) = side(3, 7)
temp(3, 4) = side(3, 8)
temp(3, 7) = side(3, 9)

'edges
temp(2, 4) = side(1, 4)
temp(6, 4) = side(2, 4)
temp(4, 4) = side(6, 4)
temp(1, 4) = side(4, 4)

'corners
temp(2, 7) = side(1, 1)
temp(2, 1) = side(1, 7)
temp(6, 1) = side(2, 1)
temp(6, 7) = side(2, 7)
temp(4, 7) = side(6, 7)
temp(4, 1) = side(6, 1)
temp(1, 7) = side(4, 1)
temp(1, 1) = side(4, 7)

FOR s = 1 TO 6
FOR c = 1 TO 9
side(s, c) = temp(s, c)
NEXT c
NEXT s


END SUB

SUB middledown

middleUp
middleUp
middleUp

END SUB

SUB middleLeft

FOR s = 1 TO 6
FOR c = 1 TO 9
temp(s, c) = side(s, c)
NEXT c
NEXT s

'horizontal middle layer rotates left, only for rotating cube
temp(5, 4) = side(6, 4)
temp(5, 5) = side(6, 5)
temp(5, 6) = side(6, 6)
temp(6, 4) = side(3, 4)
temp(6, 5) = side(3, 5)
temp(6, 6) = side(3, 6)
temp(3, 4) = side(1, 6)
temp(3, 5) = side(1, 5)
temp(3, 6) = side(1, 4)
temp(1, 4) = side(5, 6)
temp(1, 5) = side(5, 5)
temp(1, 6) = side(5, 4)

FOR s = 1 TO 6
FOR c = 1 TO 9
side(s, c) = temp(s, c)
NEXT c
NEXT s


END SUB

SUB middleRight

middleLeft
middleLeft
middleLeft

END SUB

SUB middleUp

FOR s = 1 TO 6
FOR c = 1 TO 9
temp(s, c) = side(s, c)
NEXT c
NEXT s

'vertical middle layer rotates up, only for rotating cube
temp(2, 8) = side(1, 2)
temp(2, 5) = side(1, 5)
temp(2, 2) = side(1, 8)
temp(1, 2) = side(4, 8)
temp(1, 5) = side(4, 5)
temp(1, 8) = side(4, 2)
temp(4, 8) = side(6, 8)
temp(4, 5) = side(6, 5)
temp(4, 2) = side(6, 2)
temp(6, 8) = side(2, 8)
temp(6, 5) = side(2, 5)
temp(6, 2) = side(2, 2)

FOR s = 1 TO 6
FOR c = 1 TO 9
side(s, c) = temp(s, c)
NEXT c
NEXT s

END SUB

SUB R

FOR s = 1 TO 6
FOR c = 1 TO 9
temp(s, c) = side(s, c)
NEXT c
NEXT s

'right side rotates clockwise
temp(5, 1) = side(5, 3)
temp(5, 2) = side(5, 6)
temp(5, 3) = side(5, 9)
temp(5, 4) = side(5, 2)
temp(5, 6) = side(5, 8)
temp(5, 7) = side(5, 1)
temp(5, 8) = side(5, 4)
temp(5, 9) = side(5, 7)

'edges & corners
temp(1, 3) = side(4, 9)
temp(1, 6) = side(4, 6)
temp(1, 9) = side(4, 3)
temp(4, 3) = side(6, 3)
temp(4, 6) = side(6, 6)
temp(4, 9) = side(6, 9)
temp(6, 3) = side(2, 3)
temp(6, 6) = side(2, 6)
temp(6, 9) = side(2, 9)
temp(2, 3) = side(1, 9)
temp(2, 6) = side(1, 6)
temp(2, 9) = side(1, 3)

FOR s = 1 TO 6
FOR c = 1 TO 9
side(s, c) = temp(s, c)
NEXT c
NEXT s

END SUB

SUB randomizeCube

LOCATE 30, 1
FOR i = 1 TO 26
randomMove

IF lastmove = 0 THEN move$ = "L  "
IF lastmove = 1 THEN move$ = "Li "
IF lastmove = 2 THEN move$ = "R  "
IF lastmove = 3 THEN move$ = "Ri "
IF lastmove = 4 THEN move$ = "U  "
IF lastmove = 5 THEN move$ = "Ui "
IF lastmove = 6 THEN move$ = "D  "
IF lastmove = 7 THEN move$ = "Di "
IF lastmove = 8 THEN move$ = "F  "
IF lastmove = 9 THEN move$ = "Fi "
IF lastmove = 10 THEN move$ = "B  "
IF lastmove = 11 THEN move$ = "Bi "

PRINT move$;

drawcube

NEXT i


END SUB

SUB randomMove

20 a = INT(RND * 12)

'prevent it from picking a random move that reverses the previous move
IF lastmove = 0 AND a = 1 THEN 20
IF lastmove = 1 AND a = 0 THEN 20
IF lastmove = 2 AND a = 3 THEN 20
IF lastmove = 3 AND a = 2 THEN 20
IF lastmove = 4 AND a = 5 THEN 20
IF lastmove = 5 AND a = 4 THEN 20
IF lastmove = 6 AND a = 7 THEN 20
IF lastmove = 7 AND a = 6 THEN 20
IF lastmove = 8 AND a = 9 THEN 20
IF lastmove = 9 AND a = 8 THEN 20
IF lastmove = 10 AND a = 11 THEN 20
IF lastmove = 11 AND a = 10 THEN 20


IF a = 0 THEN L
IF a = 1 THEN Li
IF a = 2 THEN R
IF a = 3 THEN Ri
IF a = 4 THEN U
IF a = 5 THEN Ui
IF a = 6 THEN D
IF a = 7 THEN Di
IF a = 8 THEN F
IF a = 9 THEN Fi
IF a = 10 THEN B
IF a = 11 THEN Bi

lastmove = a

END SUB

SUB Ri

R
R
R

END SUB

SUB rotateDown

'reorient cube so that side 2 becomes side 1
middledown
Ri
L

END SUB

SUB rotateLeft
'reorient cube so that side 5 becomes side 1

U
Di
middleLeft


END SUB

SUB rotateRight

'reorient cube so that side 3 becomes side 1

Ui
D
middleRight




END SUB

SUB RotateUp

'reorient cube so that side 4 becomes side 1

middleUp
R
Li


END SUB

SUB solve

'solve the top layer first
FOR z = 1 TO 8
rotateRight
drawcube

US = side(2, 5)
fs = side(1, 5)

IF (US <> side(2, 2)) OR (fs <> side(1, 2)) THEN Fi: U: Li: Ui: drawcube

IF (US <> side(2, 2)) OR (fs <> side(1, 2)) THEN
  'find matching edge piece
  IF (side(1, 4) = fs AND side(3, 4) = US) OR (side(1, 4) = US AND side(3, 4) = fs) THEN F
  IF (side(1, 6) = fs AND side(5, 6) = US) OR (side(1, 6) = US AND side(5, 6) = fs) THEN Fi
  IF (side(1, 4) = fs AND side(3, 4) = US) OR (side(1, 4) = US AND side(3, 4) = fs) THEN F
  IF (side(1, 8) = fs AND side(4, 8) = US) OR (side(1, 8) = US AND side(4, 8) = fs) THEN F: F
  IF (side(5, 4) = fs AND side(6, 6) = US) OR (side(5, 4) = US AND side(6, 6) = fs) THEN R: Di: Ri: F: F
  IF (side(6, 4) = fs AND side(3, 6) = US) OR (side(6, 4) = US AND side(3, 6) = fs) THEN Li: D: L: F: F
  IF (side(4, 4) = fs AND side(3, 8) = US) OR (side(4, 4) = US AND side(3, 8) = fs) THEN D: F: F
  IF (side(5, 8) = fs AND side(4, 6) = US) OR (side(5, 8) = US AND side(4, 6) = fs) THEN Di: F: F
  IF (side(4, 2) = fs AND side(6, 8) = US) OR (side(4, 2) = US AND side(6, 8) = fs) THEN D: D: F: F
  IF (side(2, 6) = fs AND side(5, 2) = US) OR (side(2, 6) = US AND side(5, 2) = fs) THEN Ri: Fi
  IF (side(2, 4) = fs AND side(3, 2) = US) OR (side(2, 4) = US AND side(3, 2) = fs) THEN L: F
  IF (side(2, 8) = fs AND side(6, 2) = US) OR (side(2, 8) = US AND side(6, 2) = fs) THEN B: B: D: D: F: F
  drawcube
  END IF

NEXT z
'Upper layer cross should be solved by this point.
'--------------------------------------------------------------

'solve upper layer corners

solveFirstLayer:
FOR z = 1 TO 5
US = side(2, 5)
fs = side(1, 5)
RS = side(5, 5)

'If upper right corner piece is already right...
IF side(2, 3) = US AND side(1, 3) = fs AND side(5, 3) = RS THEN GOTO solve1

'find piece that needs to be here
IF (side(1, 3) = fs OR side(2, 3) = fs OR side(5, 3) = fs) AND (side(1, 3) = US OR side(2, 3) = US OR side(5, 3) = US) AND (side(1, 3) = RS OR side(2, 3) = RS OR side(5, 3) = RS) THEN GOSUB step2
IF (side(1, 9) = fs OR side(4, 9) = fs OR side(5, 9) = fs) AND (side(1, 9) = US OR side(4, 9) = US OR side(5, 9) = US) AND (side(1, 9) = RS OR side(2, 9) = RS OR side(5, 9) = RS) THEN GOSUB step2
IF (side(1, 7) = fs OR side(3, 7) = fs OR side(4, 7) = fs) AND (side(1, 7) = US OR side(3, 7) = US OR side(4, 7) = US) AND (side(1, 7) = RS OR side(3, 7) = RS OR side(4, 7) = RS) THEN D: drawcube: GOSUB step2
IF (side(3, 9) = fs OR side(4, 1) = fs OR side(6, 7) = fs) AND (side(3, 9) = US OR side(4, 1) = US OR side(6, 7) = US) AND (side(3, 9) = RS OR side(4, 1) = RS OR side(6, 7) = RS) THEN D: drawcube: D: drawcube: GOSUB step2
IF (side(4, 3) = fs OR side(5, 7) = fs OR side(6, 9) = fs) AND (side(4, 3) = US OR side(5, 7) = US OR side(6, 9) = US) AND (side(4, 3) = RS OR side(5, 7) = RS OR side(6, 9) = RS) THEN Di: drawcube: GOSUB step2
IF (side(1, 1) = fs OR side(2, 1) = fs OR side(3, 1) = fs) AND (side(1, 1) = US OR side(2, 1) = US OR side(3, 1) = US) AND (side(1, 1) = RS OR side(2, 1) = RS OR side(3, 1) = RS) THEN L: drawcube: D: drawcube: Li: drawcube: GOSUB step2
IF (side(2, 7) = fs OR side(3, 3) = fs OR side(6, 1) = fs) AND (side(2, 7) = US OR side(3, 3) = US OR side(6, 1) = US) AND (side(2, 7) = RS OR side(3, 3) = RS OR side(6, 1) = RS) THEN Li: drawcube: D: drawcube: D: drawcube: L: drawcube: GOSUB step2
IF (side(2, 9) = fs OR side(5, 1) = fs OR side(6, 3) = fs) AND (side(2, 9) = US OR side(5, 1) = US OR side(6, 3) = US) AND (side(2, 9) = RS OR side(5, 1) = RS OR side(6, 3) = RS) THEN R: drawcube: Di: drawcube: Ri: drawcube: Di: drawcube: GOSUB  _
step2


solve1:
rotateRight
drawcube
NEXT z
GOTO continue

step2:  ' correct cubelet is in place (upper right corner) but oriented wrong
        ' or is in lower right corner.
count = 0
step2a:
IF count = 5 THEN RETURN
IF side(1, 3) = fs AND side(2, 3) = US AND side(5, 3) = RS THEN RETURN
Ri
drawcube
Di
drawcube
R
drawcube
D
drawcube
count = count + 1
GOTO step2a

continue: 'Upper layer should be solved; rotate cube to make upper layer
          'bottom layer
RotateUp
drawcube
RotateUp
drawcube


END SUB

SUB U

FOR s = 1 TO 6
FOR c = 1 TO 9
temp(s, c) = side(s, c)
NEXT c
NEXT s

'up side rotates clockwise
temp(2, 1) = side(2, 3)
temp(2, 2) = side(2, 6)
temp(2, 3) = side(2, 9)
temp(2, 4) = side(2, 2)
temp(2, 6) = side(2, 8)
temp(2, 7) = side(2, 1)
temp(2, 8) = side(2, 4)
temp(2, 9) = side(2, 7)

'upper edges
temp(1, 2) = side(5, 2)
temp(5, 2) = side(6, 2)
temp(6, 2) = side(3, 2)
temp(3, 2) = side(1, 2)

'upper corners
temp(1, 1) = side(5, 3)
temp(1, 3) = side(5, 1)
temp(5, 1) = side(6, 1)
temp(5, 3) = side(6, 3)
temp(6, 1) = side(3, 1)
temp(6, 3) = side(3, 3)
temp(3, 1) = side(1, 3)
temp(3, 3) = side(1, 1)

FOR s = 1 TO 6
FOR c = 1 TO 9
side(s, c) = temp(s, c)
NEXT c
NEXT s

END SUB

SUB Ui

U
U
U

END SUB

