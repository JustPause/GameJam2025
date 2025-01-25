# AI features

//TODO: put this into official ReadMe and pitching

Now 
we 
have 
already 
implemented 
relatively 
simple 
AI, 
to 
increase 
user 
engagement. 
Idea 
is 
simple: 
we 
record 
statistics 
of 
previous 
games 
of 
the 
user, 
to 
determine, 
when 
they 
are 
most 
likely 
to 
and 
at 
this 
moment 
we 
suggest 
them 
to 
try 
again, 
leave 
the 
game 
(i.e. 
because 
they 
fail), 
and 
if 
they 
win, 
they 
get 
a 
present. 
At 
the 
same 
time, 
we 
make 
the 
next 
round 
easier, 
so 
that 
the 
player 
definitely 
wins 
and 
continues 
playing.


From
technical
side 
we 
implemented 
the 
engine 
fully 
in 
Godot 
script. 
Firstly 
we 
were 
thinking 
of 
using 
Neural 
Collaborative 
Filtering 
(train 
in 
Python 
-> 
export 
in 
ONNX
 -> 
 upload
  and
   run
    in
     Godot
     )
     , 
but 
faced 
some 
technical 
issues, 
therefore 
we 
wrote 
our 
own 
simplified 
implementation 
of 
it 
fully 
in 
Godot


### Implemented
- Content-based filtering for increasing user engagement

### In progress/Scheduled
- Collaborative filtering for multiplayer picks
- Reinforcement learning for game analysis to modify enemies' waves in progress, (i.e. for impossible level of difficulty)
- Reinforcement learning for game analysis to suggest player where to put his turrets (when he starts loosing few times in a row)







