{****************************************************************************
**        Programme CAMPUS r‚alis‚ fin aout 1993 par Pierre Neyron         **
****************************************************************************}
program  campus;
uses graph,crt;

var att:char;
    cond,t:boolean;
    grmode,grpilote:integer;
    npd,z,comp,scr:integer;
    sscr:string;

{***************************************************************************}
type
 cases = record
  x,y,a:integer;
  v: 1..25;
end;
 valeurs = record
 n:byte;
 m:byte;
end;
 de = record
  x,y:integer;
  v:1..6;
 end;

{***************************************************************************}
var c: array [1..36] of cases;
    v: array [0..25] of valeurs;
    d: array [1..2] of de;
    sd: byte;
    ssd:string;
    id,iu,k:integer;

{***************************************************************************}
procedure son(f,d:word);
begin
sound (f);
delay (d);
nosound;
end;
{***************************************************************************}
procedure effson;
begin
son (50,50);son(60,100);son(50,200);
end;
{***************************************************************************}
procedure croix(ca:byte);
begin
setlinestyle (SolidLn,1,ThickWidth );
line (c[ca].x-20,c[ca].y-15,c[ca].x+20,c[ca].y+25);
line (c[ca].x-20,c[ca].y+25,c[ca].x+20,c[ca].y-15);
setlinestyle (SolidLn,1,NormWidth );
effson;
end;
{***************************************************************************}
procedure tab;
var i,u:integer;
    j:string;
begin
setbkcolor(7);
SetFillStyle(1,14);
bar (0,0,419,419);
setcolor (1);
rectangle (0,0,419,419);
for i:=0 to 5 do for u:=0 to 5 do rectangle (i*70,u*70,i*70+70,u*70+70);

for i:=0 to 5 do for u:=1 to 6 do c[u+i*6].x:=(u-1)*70+35;
for i:=0 to 5 do for u:=1 to 6 do c[u+i*6].y:=i*70+25;
setcolor (0);
settextjustify (0,2);
settextstyle (0,0,0);
for i:=1 to 36 do begin
    str (i,j);
    outtextxy (c[i].x-30,c[i].y+34,j);
    end;
end;

{***************************************************************************}
procedure initval;
var i:integer;
begin
for i:=1 to 25 do v[i].n:=0;
v[0].m:=0;
for i:=1 to 25 do v[i].m:=3;
v[4].m:=4;
v[8].m:=4;
v[9].m:=3;
v[10].m:=2;
for i:=11 to 24 do v[i].m:=1;
for i:=8 to 11 do v[i*2+1].m:=0;
end;

{***************************************************************************}
procedure initcases;
var u,i:integer;
begin
randomize;
for i:=1 to 36 do begin
    c[i].a:=1;
    repeat begin
    u:=random(25+1);
    cond:=false;
    if v[u].n<v[u].m then begin
       c[i].v:=u;
       if u=25 then c[i].a:=100;
       v[u].n:=v[u].n+1;
       cond:=true
       end;
    end until cond;
end;
end;

{***************************************************************************}
procedure affichenb;
var i:integer;
    v:string;
begin
settextjustify (1,1);
settextstyle (1,0,5);
setcolor (0);
for i:=1 to 36 do begin
    if c[i].v=25 then v:='*' else str (c[i].v,v);
    outtextxy (c[i].x,c[i].y,v);
    end;
end;

{***************************************************************************}
procedure fin;
var fson:string;
begin
setfillstyle (3,11);
settextjustify (1,1);
settextstyle (4,0,6);
setcolor (4);
if scr>150 then outtextxy (320,440,'BRAVO ... '+sscr+' POINTS')
           else if scr<2 then outtextxy (320,440,'NUL ... '+sscr+'POINT')
                         else outtextxy (320,440,'BOFF ... '+sscr+' POINTS');
son (250,500);son (150,250);son (200,500);son (150,1000);delay (50);son(150,250);son(250,500);son(200,1000);
cleardevice;
setcolor (15);
setbkcolor (8);
bar (100,100,540,380);
outtextxy (320,240,'BYE ... A bient“t !');
att:=readkey;
restorecrtmode;
halt;
end;

{***************************************************************************}
procedure des;
var i,it:integer;
    d1,d2,st:string;
begin
SetFillStyle(1,4);
bar3d  (439,19,509,89,20,true);
d[1].x:=474;
d[1].y:=44;
bar3d  (539,19,609,89,20,true);
d[2].x:=574;
d[2].y:=44;
d[1].v:=random(6)+1;
d[2].v:=random(6)+1;
str(d[1].v,d1);
str(d[2].v,d2);
settextstyle (1,0,6);
settextjustify (1,1);
setcolor(1);
for i:= 1 to 2 do repeat begin
    it:=random(6)+1;
    str(it,st);
    if i=1 then bar3d  (439,19,509,89,20,true)
           else bar3d  (539,19,609,89,20,true);
    outtextxy (d[i].x,d[i].y,st);
    son(100,50);son(110,200);
    end until it=d[i].v;
if d[1].v=d[2].v then sd:=(d[1].v+d[2].v)*2
                 else sd:=d[1].v+d[2].v;
settextjustify (0,1);
settextstyle (3,0,2);
str (sd,ssd);
setfillstyle (1,7);
bar (555,90,640,120);
setcolor (1);
outtextxy (425,100,'Somme max : '+ssd);
end;

{***************************************************************************}
procedure efface(k:byte);
begin
setfillstyle (1,14);
croix(k);
bar (c[k].x-30,c[k].y-19,c[k].x+30,c[k].y+30);
end;

{***************************************************************************}
procedure effligne (h:byte);
var l,i:integer;
begin
setfillstyle (1,14);
for i:=1 to 6 do begin
    l:=(h-1)*6+i;
    croix(l);
    bar (c[l].x-30,c[l].y-19,c[l].x+30,c[l].y+30);
    c[l].a:=0;
    end;
end;

{***************************************************************************}
procedure effcol (v:byte);
var l,i:integer;
begin
setfillstyle (1,14);
for i:=1 to 6 do begin
    l:=v+(i-1)*6;
    croix(l);
    bar (c[l].x-30,c[l].y-19,c[l].x+30,c[l].y+30);
    c[l].a:=0;
    end;
end;

{***************************************************************************}
procedure analyse;
var i,u,j,l,c1,c2:integer;
    ne,nc,np,snpd:string;
begin
if t then begin
for j:=1 to 6 do begin
    u:=0;
    for i:=1 to 6 do u:=u+c[i+(j-1)*6].a;
    if (u=1) or (u=101) or (u=201) or (u=301) then begin
       effligne(j);
       end;
    end;
for j:=1 to 6 do begin
    u:=0;
    for i:=1 to 6 do u:=u+c[j+(i-1)*6].a;
    if (u=1) or (u=101) or (u=201) or (u=301) then begin
       effcol(j);
       end;
    end;
u:=0;
for j:=1 to 6 do u:=u+c[j+(j-1)*6].a;
if (u=1) or (u=101) or (u=201) or (u=301) then begin
   for i:=1 to 6 do begin
       l:=i+(i-1)*6;
       croix(l);
       bar (c[l].x-30,c[l].y-19,c[l].x+30,c[l].y+30);
       c[l].a:=0;
   end;
end;
u:=0;
for j:=1 to 6 do u:=u+c[7-j+(j-1)*6].a;
if (u=1) or (u=101) or (u=201) or (u=301) then begin
   for i:=1 to 6 do begin
       l:=7-i+(i-1)*6;
       croix(l);
       bar (c[l].x-30,c[l].y-19,c[l].x+30,c[l].y+30);
       c[l].a:=0;
   end;
end;
end;
u:=0;
i:=0;
for j:=1 to 36 do begin
u:=u+c[j].a;
    if c[j].a<>0 then i:=i+c[j].v;
    end;
if z=10 then begin
settextjustify (0,1);
settextstyle (3,0,2);
setcolor (1);
c1:=round(int(u/100));
str(c1,ne);
outtextxy (425,270,'Etoile(s) : '+ne);
c2:=u-c1*100+C1;
str(c2,nc);
outtextxy (425,300,'Case(s) : '+nc);
str (npd,snpd);
outtextxy (425,330,'D‚part : '+snpd);
str (i,np);
outtextxy (425,360,'Restant : '+np);
scr:=npd-i-10*comp;
str(scr,sscr);
outtextxy (425,390,'Score : '+sscr);
if u=0 then fin;
end;
end;

{***************************************************************************}
procedure question;
var cd,cu:char;
    i:integer;
    b:boolean;
    scomp:string;
begin
 t:=false;
 comp:=comp+1;
 str (comp,scomp);
 des;
 repeat begin
 outtextxy (425,240,'Lanc‚(s) : '+scomp);
 settextstyle (3,0,2);
 settextjustify (0,1);
 setcolor (1);
 setfillstyle (1,7);
 bar (425,115,640,145);
 outtextxy (425,130,'Reste : '+ssd);
 outtextxy (425,160,'Case : ');
       repeat begin
              repeat begin
                     bar (495,145,520,175);
                     bar (425,175,640,205);
                     setcolor (1);
                     repeat cd:=readkey until ((ord(cd)>47) and (ord(cd)<52)) or (cd='+') or (cd=#27);;
                     if cd=#27 then fin;
                     outtextxy(495,160,cd);
                     repeat cu:=readkey until ((ord(cd)>47) and (ord(cd)<58)) or (cu='+');
                     outtextxy(505,160,cu);
                     val (cd,id,i);val (cu,iu,i);
                     k:=10*id+iu;
                     end until ((k>=0) and (k<=36) and (c[k].a<>0) and (sd>=c[k].v))  or (cd='+');
              settextstyle (1,0,1);
              setcolor (4);
              outtextxy(425,190,'Corrige ou ENTREE');
              repeat att:=readkey until (att=#13) or (att=#8);
              if att=#13 then cond:=true else cond:=false;
              end until cond;
       bar (425,175,640,505);
       if (cd='+') or (cu='+') then
          else begin
          c[k].a:=0;
          sd:=sd-c[k].v;
          efface (k);
          str(sd,ssd);
          t:=true
          end;
    for z:=0 to 10 do analyse;
end until (k=0) or (sd=0);
end;

{****************************************************************************
**                        Programme principale                             **
****************************************************************************}
begin
clrscr;
grpilote:=detect;
initgraph (grpilote,grmode,'c:\tp\bgi');
cleardevice;
tab;
initval;
initcases;
affichenb;
npd:=0;
for z:=1 to 36 do npd:=npd+c[z].v;
z:=10;
comp:=0;
analyse;
repeat question until false;
att:=readkey;
end.