
# The Biota Computer
by Ward Cunningham


Biota is a simulation of an imaginary computer with some unusual
properties.  Its memory is addressed by points held in registers
that can be incremented in any of eight possible directions. 
Programs are interpreted by following strings of non-blank instructions
as they wind through memory.  Loops and branches appear as exactly
that.  The program counter turns to avoid blanks and failing
instructions.

New Classes
-----------

Biota -- A two dimensional space, addressed by points, which stores
the characters that are biota programs and data.  Class methods define
the size of the space and a single character, called empty, that marks
unused cells.

DisplayBiota -- A kind of biota that echos it's modifications the 
computer display.

BiotaIndex -- A kind of point that includes a direction and responds 
to turtle style protocol (go, turn).

BiotaEngine -- A processor that can interpret programs stored in a
biota.  Includes a loader and debugger.  A class method constructs
an instruction dispatch table from a method dictionary.

The loader expects data in odd numbered columns and control characters
in the others.  '�' marks the initial program counter; '' the initial
data pointer.  (Use cut and paste to type these characters.)

The debugger will single step with each press of the space bar.  Press
and hold 'r' to run at high speed.  'q' will quit.  (Collapse or frame
all windows to the bottom inch of the display before running.  Redraw
screen when finished.)

TestEngine -- An experimental biota engine with twelve instructions.
Class methods answer sample programs written for this engine. 

The instructions 't' and 'u' turn right and left.  's' and 'b' step
forward and backward.  'd' and 'r' duplicate data, 'r' more aggressively.
'c' clears data to blank.  'f' faces the data pointer at the nearest
data while 'h' alignes it with the program counter.  'g' combines 'f'
and 's'.  'a' and 'q' are obsolete and should be avoided.

  
New Methods
-----------

Point offset -- Computes the byte offset in a linear memory (i.e. a string)
corresponding to a given point.
              
