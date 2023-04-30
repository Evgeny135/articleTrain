uses
  GraphABC;
  
type  plan = record
  number:integer;
  train: record
    typeTrain: string[6];
    otpravka:string[11];
    prib:string[11];
    timeOtpr:string[5];
    timePrib:string[5];
    intermediate:string;
    classTrain:string[8];
    price:real;
    timeInter:string;
    timestoyanki:string;
    alternative:string;
  end;
end;
var arrTrain:array[0..100] of string;
var
  a:string;
  auth,dataTrain:text;
  loginb,passwordb,adminb,alertb:boolean;
  addTrainb:boolean;
  login,password:string;
  x,y,nmax:Integer;
  index:integer;
  changepassb:boolean;
  oldpasswordb:boolean;
  oldpassword:string;
  AuthWind,MainWind,numb:boolean;
  w,w2:integer;
  newpasswordb:boolean;
  newpassword:string;
  key1:Integer;
  y1,y2:integer;
  count:integer;
  addNum,addType,addOtpravka,addPrib,addTimeOtp,addTimePrib,addInter,addTimeInter,addSt,addClass,addPrice,addAlternative:string;
  addNumb,addTypeb,addOtpravkab,addPribb,addTimeOtpb,addTimePribb,addInterb,addTimeInterb,addStb,addClassb,addPriceb,addAlternativeb:boolean;
  minprice:real;
  mintrain:plan;
  i,j,inum,code:integer;
  num,deleteNum:string;
  editNum:string;
  editNumb:boolean;
  editTrainb:boolean;
  editNub:boolean;
  check,punktAb,punktBb,minpriceb,deleteNumb,deleteTrainb:boolean;
  punktA,punktB:string;
  editTrainNumb:boolean;
  containinter:boolean;
//  yes,no:boolean;
  trainArr: array [0..100] of plan;
  
  
  
procedure Authorizing;forward;  
procedure  MainWindow; forward;
procedure recordDataTrainLog; forward;
procedure dataTrainLog;forward;
procedure admin;forward;
procedure changePass;forward;


{Процедура нахождения самого дешевого билета из пунтка А в Б}
{Параметры - minpriceb - флаг активности окна}
{minprice - минимальная цена за билет}
{a-массив записи строки поезда}
procedure checkMin();
begin
  minpriceb:=true;
  minprice:=9999999;
//  var a: array[0..100] of string;
  mintrain:= trainArr[0];
  for var i:=0 to nmax do
    with trainArr[i] do
    begin
      var b:=train.intermediate.Split(' ');
      if (((train.otpravka.Equals(punktA)) and b.Contains(punktB))or((train.otpravka.Equals(punktA)) and train.prib.Equals(punktB))or (b.Contains(punktA) and (train.prib.Equals(punktB))) or ((b.Contains(punktA) and b.Contains(punktB))and (b.IndexOf(punktA)<b.IndexOf(punktB)))) then
        begin
          if trainArr[i].train.price<minprice then
            begin
          minprice:=trainArr[i].train.price;
          mintrain:=trainArr[i];
          rectangle(50,80,1550,400);
    rectangle(1500,90,1530,120);
    textout(700,90,'Самый дешевый билет');
    textout(52,130,' │Ном │  Тип  │ Пункт отп │ Пункт приб │ Время о  │ Время п │                      Промеж.станции                        │ Классы │  Цена  │');
    textout(52,150,'      │       │           │            │          │         │                                                            │        │         ');
    textout(70,150,mintrain.number);
    textout(120,150,mintrain.train.typeTrain);
    textout(210,150,mintrain.train.otpravka);
    textout(330,150,mintrain.train.prib);
    textout(470,150,mintrain.train.timeOtpr);
    textout(575,150,mintrain.train.timePrib);
    setfontsize(10);
    textout(675,150,mintrain.train.intermediate);
    setfontsize(14);
    textout(1300,150,mintrain.train.classTrain);
    textout(1430,150,mintrain.train.price);
    end;
        end
        end;
      

end; 
{Процедура открытия окна для изменения поезда}
{editNum-номер поезда, который хотим отредактировать}
{editTrainb-флаг активности окна}
procedure editTrainNumber;
begin
  editNum:=nil;
  editTrainNumb:=true;
  rectangle(80,100,600,300);
  textout(120,110,'Введите номер поезда который хотите изменить');
  rectangle(300,140,400,180);
  rectangle(200,200,300,240);
  textout(210,205,'Изменить');
  rectangle(320,200,420,240);
  textout(330,205,'Отмена');
end;

{Процедупа открытия окна редактирования поезда}
{editTrainb - флаг активности окна}
{i - переменная цикла, b-последовательность в результате разделения}
{все что начинается с add - переменные ввода в форму}
procedure editTrain;
begin
  editTrainb:=true;

//Ввод номера , после чего ищется в файле и отображается в форму
// в форме изменил и поезд удалился
rectangle(50,80,1550,700);
textout(700,90,'Редактирование поезда');
  textout(80,110,'Номер');
  rectangle(80,140,180,180);//addNum
  textout(200,110,'Тип');
  rectangle(200,140,500,180);//addType
  textout(525,110,'Пункт отправки');
  rectangle(520,140,820,180);//addOtpravka
  textout(845,110,'Пункт прибытия');
  rectangle(840,140,1140,180);//addPrib
  textout(1165,110,'Время отп');
  rectangle(1160,140,1260,180);//addTimOtp
  textout(1285,110,'Время приб');
  rectangle(1280,140,1380,180);//addTimePrib
  textout(80,190,'Промежуточные станции(через пробел)');
  rectangle(80,220,1520,260);//addInter
  textout(80,270,'Время прибытия на станцию в соответсвии с порядком станций(через пробел)');
  rectangle(80,300,1520,340);//addTimeInter
  textout(80,350,'Время стоянки в соответсвии с порядком станций(через пробел)');
  rectangle(80,380,1520,420);//addSt
  textout(80,430,'Классы вагонов (через пробел СВ-спальный вагон С-сидячий К-купе П-плацкарт)');
  rectangle(80,460,180,500);//addClass
  textout(900,430,'Цена'); //addPrice
  rectangle(900,460,1000,500);
  textout(80,510,'Альтернативный путь до конечной станции (через пробел)');
  rectangle(80,540,1520,580); //addAlternative
  rectangle(400,650,500,690);
  textout(410,655,'Добавить');
  rectangle(550,650,650,690);
  textout(560,655,'Закрыть');
  
  var i:=0;    
assign(dataTrain,'C:\Users\trish\Desktop\СРАДИК\2 семестр\Фотки с курсачом + курса\coursach\Project5\dataTrain.txt');
reset(dataTrain); 
while not( eof(dataTrain)) do
begin
  readln(dataTrain,a);
  arrTrain[i]:=a;
  var b:=a.Split('>');
  if b[0].Equals(editNum) then
  begin
    index:=i;
    addNum:=b[0];
  addType:=b[1];
  addOtpravka:=b[2];
  addPrib:=b[3];
  addTimeOtp:=b[4];
  addTimePrib:=b[5];
  addInter:=b[6];
  addTimeInter:=b[9];
  addSt:=b[10];
  addClass:=b[7];
  addPrice:=b[8];
  addAlternative:=b[11];
  end;
  i:=i+1;
end;
close(dataTrain);

   textout(90,145,addNum);
  textout(210,145,addType);
  textout(530,145,addOtpravka);
  textout(850,145,addPrib);
  textout(1170,145,addTimeOtp);
  textout(1290,145,addTimePrib);
  textout(90,225,addInter);
  textout(90,305,addTimeInter);
  textout(90,385,addSt);
  textout(90,465,addClass);
  textout(910,465,addPrice);
  textout(90,545,addAlternative);
  
 
end;

{Процедру подробной информации о поезде}
{inum-преобразованная num,num-номер поезда}
{j-параметр цикла}
procedure checkInfo();
begin
  var a:integer;
 val(num,inum,code);
 for var i:=0 to nmax-1 do
 begin
   with trainArr[i] do
   begin
     if inum=number then
     begin
       check:=true;
        rectangle(70,70,700,700);
       var b := train.intermediate.Split(' ');
       var c:=train.timeInter.Split(' ');
       var k:=train.timestoyanki.Split(' ');
       rectangle(650,90,680,125);
       textout(660,95,'X');
       textout(240,80,'Вр.отп');
       textout(300,80,'Станция');
       textout(420,80,'Вр.приб');
       textout(500,80,'Стоянка');
       textout(80,200,'Тип');
       textout(130,200,train.typeTrain);
       textout(240,100,train.timeOtpr);
       textout(80,400,'Классы вагонов');
       textout(250,400,train.classTrain);
       textout(300,100,train.otpravka);
       textout(80,450,'Цена');
       textout(130,450,train.price);
       textout(80,100,'№');
       textout(100,100,number);
       textout(80,500,'Альтернативные пути до конечной станции');
       textout(80,530,train.alternative);
       for var j:=0 to b.Length-1 do
       begin 
          textout(300,125+20*j,b[j]);
          textout(420,125+20*j,c[j]);
          textout(500,125+20*j,k[j]);
          if (j=b.Length-1) then
          begin
            textout(420,125+20*b.Length,train.timePrib);
            textout(300,125+20*b.Length,train.prib);
          end;
       end;    
       end;
   end;
 end;
  
  
end;


{Процедура записи в запись из файла}
{dataTrain-переменная текстового файла}
{i-параметр цикла}
{b-переменная последовтеьности полученной в результате разделения}
{nmax-макисмальное число поездов}
procedure recordDataTrainLog();
begin
//  count:=1;
  assign(dataTrain,'C:\Users\trish\Desktop\СРАДИК\2 семестр\Фотки с курсачом + курса\coursach\Project5\dataTrain.txt');
  reset(dataTrain); 
//  setpenwidth(2);
  i:=0;
  while not eof(dataTrain) do
  begin
    
    readln(dataTrain,a);
    var b:=a.Split(char('>'));
    with trainArr[i] do
    begin
      number:=b[0].ToInteger;
      with train do
      begin
        begin
          typeTrain:=b[1];
          otpravka:=b[2];
          prib:=b[3];
          timeOtpr:=b[4];
          timePrib:=b[5];
          intermediate:=b[6];
          classTrain:=b[7];
          price:=b[8].ToReal;
          timeInter:=b[9];
          timestoyanki:=b[10];
          alternative:=b[11];
          i+=1;
        end;
      end;
    end;
  end;
  close(dataTrain);
  nmax:=i;
end;


{Процедура вывода таблицы поездов}
procedure dataTrainLog();
begin
  recordDataTrainLog();
  var y:=0;
  setfontsize(14);
//  var str := '├Ном ┼       Пункт отправления      ┼        Пункт прибытия        ┼       Время отпр       ┼       Время приб       ┼                   Промеж.станции                  ┼     Классы     ┼    Цена    ┤';
  textout(50,50,'┌────┬───────┬───────────┬────────────┬──────────┬─────────┬──────────────────────────────────────────────────────────────────────┬────────┬────────┐'); 
  textout(50,70,'│Ном │  Тип  │ Пункт отп │ Пункт приб │ Время о  │ Время п │                              Промеж.станции                          │ Классы │  Цена  │');
  textout(50,90,'├────┼───────┼───────────┼────────────┼──────────┼─────────┼──────────────────────────────────────────────────────────────────────┼────────┼────────┤');
  for var j:=0 to nmax-1 do
    with trainArr[j] do
    begin
//    var str:='├' + number[3] + '│' + train.typeTrain + '│' + train.otpravka + '│' + train.prib + '│' + train.timeOtpr + '│' + train.timePrib + '│'+ train.intermediate + '│' +train.classTrain + '│'+ train.price+'┤' ;
    textout(50,110+y,'│    │       │           │            │          │         │                                                                      │        │        │');
    textout(60,110+y,number);
//    textout(70,110+y,number);
    textout(115,110+y,train.typeTrain);
    textout(200,110+y,train.otpravka);
    textout(325,110+y,train.prib);
    textout(470,110+y,train.timeOtpr);
    textout(575,110+y,train.timePrib);
    setfontsize(10);
    textout(670,110+y,train.intermediate);
    setfontsize(14);
    textout(1390,110+y,train.classTrain);
    textout(1510,110+y,train.price);
    
    y+=22;
//    textout();
  end;
end;

{Процедура смены пароля}
{confirm-флаг правильности старого пароля}
{a-строка из файла}
procedure changePasswordd;
begin
  var confirm:boolean;
  confirm:=false;
  assign(auth,'C:\Users\trish\Desktop\СРАДИК\2 семестр\Фотки с курсачом + курса\coursach\Project5\auth.txt');
  reset(auth);
  while not eof(auth) do
  begin
    readln(auth,a);
    if a=(oldpassword) then
      confirm:=true; 
  end;
  close(auth);
  if confirm then
  begin
    rewrite(auth);
    writeln(auth,newpassword);
    close(auth);
  end
  else 
    writeln('Неверный старый пароль');
end;


//Процесс авторизации
{Процедура авторизации}
{a-переменная строки файла}
procedure accessEntry();
begin
  assign(auth,'C:\Users\trish\Desktop\СРАДИК\2 семестр\Фотки с курсачом + курса\coursach\Project5\auth.txt');
  reset(auth);
  while not eof(auth) do
  begin
    readln(auth,a);
      
    if password=a  then
       begin
            admin;
            break;
            end
     else 
     begin
       authorizing;
       textout(1,1,'Введен неверный пароль');
          end;      
  end;
  close(auth);
end;


{Процедура удаления файла}
{deleteTrainb-флаг активности окна}
procedure deleteTrain;
begin
  deleteTrainb:=true;
  rectangle(80,100,600,300);
  textout(120,110,'Введите номер поезда который хотите удалить');
  rectangle(300,140,400,180);
  rectangle(200,200,300,240);
  textout(210,205,'Удалить');
  rectangle(320,200,420,240);
  textout(330,205,'Отмена');
end;

{Процедура отрисовки формы для добавления поезда}
{addTrainb-флаг активности окна}
procedure addTrain;
begin
  
  addTrainb:=true;
  rectangle(50,80,1550,700);
  textout(700,90,'Добавление поезда');
  textout(80,110,'Номер');
  rectangle(80,140,180,180);//addNum
  textout(200,110,'Тип');
  rectangle(200,140,500,180);//addType
  textout(525,110,'Пункт отправки');
  rectangle(520,140,820,180);//addOtpravka
  textout(845,110,'Пункт прибытия');
  rectangle(840,140,1140,180);//addPrib
  textout(1165,110,'Время отп');
  rectangle(1160,140,1260,180);//addTimOtp
  textout(1285,110,'Время приб');
  rectangle(1280,140,1380,180);//addTimePrib
  textout(80,190,'Промежуточные станции(через пробел)');
  rectangle(80,220,1520,260);//addInter
  textout(80,270,'Время прибытия на станцию в соответсвии с порядком станций(через пробел)');
  rectangle(80,300,1520,340);//addTimeInter
  textout(80,350,'Время стоянки в соответсвии с порядком станций(через пробел)');
  rectangle(80,380,1520,420);//addSt
  textout(80,430,'Классы вагонов (через пробел СВ-спальный вагон С-сидячий К-купе П-плацкарт)');
  rectangle(80,460,180,500);//addClass
  textout(900,430,'Цена'); //addPrice
  rectangle(900,460,1000,500);
  textout(80,510,'Альтернативный путь до конечной станции (через пробел)');
  rectangle(80,540,1520,580); //addAlternative
  rectangle(400,650,500,690);
  textout(410,655,'Добавить');
  rectangle(550,650,650,690);
  textout(560,655,'Закрыть');
    textout(90,145,addNum);
  textout(210,145,addType);
  textout(530,145,addOtpravka);
  textout(850,145,addPrib);
  textout(1170,145,addTimeOtp);
  textout(1290,145,addTimePrib);
  textout(90,225,addInter);
  textout(90,305,addTimeInter);
  textout(90,385,addSt);
  textout(90,465,addClass);
  textout(910,465,addPrice);
  textout(90,545,addAlternative);
  
  
  
end;

//Отображение ввода текста
{Процедура  ввода текста}
{key-ключ передаваемый по нажатию клавиши}
{x,y-координаты нажатия,numb,addNumb-и все т.п. переменные, которые вводятся}
{login-переменная строки которая редактируется}
procedure WriteText(Key:char;x,y:integer;var login:string);
begin
  if(integer(key)=8) then
  begin
    if (numb or addNumb or addTimeOtpb or addTimePribb or addClassb or addPriceb or deleteNumb or editNumb) then
      Rectangle(x,y,x+100,y+40)
    else 
      if punktAb or punktBb or addTypeb or addOtpravkab or addPribb  then
        Rectangle(x,y,x+300,y+40)
     else 
       if addInterb or addTimeInterb or addStb or addAlternativeb then
         Rectangle(x,y,x+1440,y+40)
    else
      Rectangle(x,y,x+360,y+50);
    Delete(login,login.Length,1);
    textout(x+10,y+10,login);
  end
  else
  begin
    login:=login+key;
    textout(x+10,y+10,login);
  end;
end;

{Процедура считывания ключа по нажатии на клавишу}
{oldpassword-старый пароль,newpassword-новый пароль}
{key-код нажатого символа/цифры}
procedure keypress(Key:char);
begin
  if oldpasswordb  then
    WriteText(Key,690,130,oldpassword);
  if passwordb then
    writetext(Key,690,250,password);
    if newpasswordb then
      writetext(Key,690,250,newpassword);
  if numb then
    writetext(Key,300,10,num);
  if punktAb then
    writetext(Key,680,10,punktA);
  if punktBb then
    writetext(Key,1000,10,punktB);
  if addNumb then
  begin
    if ((48..57).Contains(integer(key)) or (integer(key)=8))  then
    writetext(Key,80,140,addNum);
    end;
  if addTypeb then
  begin
    if ((1072..1103).Contains(integer(key)) or (1040..1071).Contains(integer(key)) or (integer(key)=8)) then
      writetext(Key,200,140,addType);
  end;
  if addOtpravkab then
    begin
    if ((1072..1103).Contains(integer(key)) or (1040..1071).Contains(integer(key)) or (integer(key)=8) or (integer(key)=32) or (integer(key)=45)) then
      writetext(Key,520,140,addOtpravka);//addOtpravka
        end;
   if addPribb then
   begin
     if ((1072..1103).Contains(integer(key)) or (1040..1071).Contains(integer(key)) or (integer(key)=8) or (integer(key)=32) or (integer(key)=45)) then
       writetext(Key,840,140,addPrib);
   end;
   if addTimeOtpb then
   begin
     if ((48..57).Contains(integer(key))or (integer(key)=8) or (integer(key)=58)) then
       begin
         writetext(Key,1160,140,addTimeOtp);
         var k:=addTimeOtp.Split(':');
          if ((addTimeOtp.Length>=5 ) and (not (k[0].ToInteger<24 )or ( k[1].ToInteger >59))or (addTimeOtp.Length<5)) then
            textout(1165,185,'Неккоректно')
          else
            textout(1160,185,'                          ');
       end;
       end;
       if addTimePribb then
   begin
     if ((48..57).Contains(integer(key))or (integer(key)=8) or (integer(key)=58)) then
       begin
         writetext(Key,1280,140,addTimePrib);
         var k:=addTimePrib.Split(':');
          if ((addTimePrib.Length>=5 ) and (not (k[0].ToInteger<24 )or ((k[1].ToInteger >59))) or (addTimePrib.Length<5)) then
            textout(1165,185,'Неккоректно')
          else
            textout(1165,185,'                          ');
       end;
     end;
     if addInterb then
       if ((1072..1103).Contains(integer(key)) or (1040..1071).Contains(integer(key)) or (integer(key)=8) or (integer(key)=32) or (integer(key)=45)) then
         begin
         writetext(Key,80,220,addInter);
         end;
    if addTimeInterb then 
      if ((48..57).Contains(integer(key))or (integer(key)=8) or (integer(key)=58) or (integer(key)=32)) then
        begin
        writetext(Key,80,300,addTimeInter);
        var a:=addTimeInter.Split(' ');
        var z:=addInter.Split(' ');
        if a.Length <> z.Length then
          textout(900,270,'Неверное количество времени')
        else
          textout(900,270,'                                                    ');
        end;
    if addStb then
      if ((48..57).Contains(integer(key))or (integer(key)=8) or (integer(key)=32)) then
        begin
        writetext(Key,80,380,addSt);
        var a:=addSt.Split(' ');
        var z:=addInter.Split(' ');
         if a.Length <> z.Length then
          textout(900,350,'Неверное количество времени')
        else
          textout(900,350,'                                                    ');
        end;
      if addClassb then
        if (1040..1071).Contains(integer(key)) or (integer(key)=8) or (integer(key)=32) then
          begin
          Writetext(Key,80,460,addClass);
          var k:=addClass.Split(' ');
          for var i:=0 to k.Length-1 do
            begin
            if ((not (k[i]=('СВ')) )and  (not (k[i]=('С') ))and (not( k[i]=('К'))) and( not (k[i]=('П')))) then
            textout(190,460,'Неккоректно')
          else
            textout(190,460,'                                    ')
          end;
        end;
        if addPriceb then
          if ((48..57).Contains(integer(key))or (integer(key)=8)) then
            writetext(Key,900,460,addPrice);
         if addAlternativeb then
           writetext(Key,80,540,addAlternative);
         if deleteNumb then
           if ((48..57).Contains(integer(key))or (integer(key)=8)) then
            writetext(Key,300,140,deleteNum);
         if editNumb then
           if ((48..57).Contains(integer(key))or (integer(key)=8)) then
             writetext(Key,300,140,editNum);
          end;
      
       
{Процедура отрисовки окна подтверждения}
procedure alert;
begin
  alertb:=true;
//  rectangle(320,200,420,240);
//  textout(330,205,'Отмена');
 rectangle(650,100,1170,300);
 textout(680,150,'Вы уверены что хотите удалить поезд');
 rectangle(710,200,810,240);
 textout(720,205,'Да');
 rectangle(830,200,930,240);
 textout(840,205,'Нет');

end;   
        
{Процедура удаления поезда из фаайла по его номеру}
{dataTrain- файловая переменная}
{b-последовательность полученная разделением строки по символу}
{deletNum-номер поезда который мы хотим удалить}        
procedure deleteTrainFile(deleteNum:string);
begin
  var arr:array[0..100] of string;
        var i:=0;
        assign(dataTrain,'C:\Users\trish\Desktop\СРАДИК\2 семестр\Фотки с курсачом + курса\coursach\Project5\dataTrain.txt');
        reset(dataTrain);
        while not eof(dataTrain) do
          begin
           readln(dataTrain,a);
           var b:=a.Split('>');
           if b[0]=deleteNum then
             continue
           else
             begin
                arr[i]:=a;
                i:=i+1;
              end;
              end;
              close(dataTrain);
              rewrite(dataTrain);
              for var j:=0 to i-1 do
              begin
                writeln(dataTrain,arr[j]);
              end;
              close(dataTrain);
              
end;   
 


//Нажатия на кнопки
{Запуск определенных процедур по координатам}
{x,y-коодинаты,m-какая кнопка мыши}
procedure ClickPlase(x,y,m:Integer);
begin
if (AuthWind = true) then
  begin
begin
  
   //Нажатие на поле пароля
  if ((x>690) and (x<1050) and (y>250) and (y<300)) then
  begin
    loginb:=false;
    passwordb:=true;
    OnKeyPress:=keypress;
  end
  else
    passwordb:=false;
  
  if ((x>690) and( y>520 )and (x<1020) and (y<570)) then
  begin
    changePass;
  end;
    
  //Нажатие на кнопку вход
  if ((x>690) and (x<840) and (y>350) and (y<400)) then
  begin
    Rectangle(690, 130,1050, 180);
    Rectangle(690, 250, 1050, 300);
    accessEntry;
    loginb:=false;
    passwordb:=false;
    login:=nil;
    password:=nil;
 end;
 if ((x>690) and (y>450) and (x<1020) and (y<500)) then
 begin
   password:=nil;
   MainWindow;
   end;
 //Нажатие на кнопку выход
  if ((x>870) and (x<1020) and (y>350) and (y<400)) then
    begin
    halt();
    end;
    
end;            
end;
if changePassb then
begin
 if  ((x>690) and (x<840) and (y>350) and (y<400)) then
   begin
   changePasswordd;
   changePassb:=false;
   oldpasswordb:=false;
     newpasswordb:=false;
   newpassword:=nil;
   oldpassword:=nil;
   authorizing;
   end;
  if ((x>870) and (x<1020) and (y>350) and (y<400)) then
    begin
    changePassb:=false;
    oldpasswordb:=false;
     newpasswordb:=false;
    newpassword:=nil;
   oldpassword:=nil;
    Authorizing;
    end;
   if ((x>690) and (x<1050) and (y>130) and (y<180)) then
    begin
     oldpasswordb:=true;
     newpasswordb:=false;
     OnKeypress:=keypress;
      end;
      if ((x>690) and (x<1050) and (y>250) and (y<300)) then
  begin
    oldpasswordb:=false;
    newpasswordb:=true;
    OnKeyPress:=keypress;
  end
  else
    newpasswordb:=false;
end;
if (MainWind = true) then
begin
  if ((x>10) and (x<40) and (y>10) and (y<40)) then
    begin
    Authorizing;
    mainwind:=false;
    adminb:=false;
    num:=nil;
    punktA:=nil;
    punktB:=nil;
    end;
  
  if ((x>300) and (x<400) and (y>10) and (y<50)) then
    numb:=true
  else
    numb:=false;
  if ((x>420) and (x<460) and (y>10) and (y<50)) then
    begin
    checkInfo();
    num:=nil;
  end;
  if (( x>650) and (y>90) and (x<680) and (y<125) and check=true) then
  begin
    check:=false;
        clearWindow;
        if adminb then
          admin
        else
          MainWindow;
        end;

   if ((x>680) and (x<980) and( y>10) and (y<50)) then
     punktAb:=true
   else
     punktAb:=false;
   if ((x>1000) and (x<1300) and (y>10) and (y<50)) then
     punktBb:=true
   else
     punktBb:=false;
   if ((x>1320) and (x<1360) and (y>10) and (y<50)) then
     begin
     checkMin;
     punktA:=nil;
     punktB:=nil;
     end;
   if minpriceb then
     if ((x>1500) and (y>90) and (x<1530) and (y<120)) then
       begin
       minpriceb:=false;
       clearWindow;
       if adminb then
          admin
        else
          MainWindow;
       end;
       end;
if adminb then
begin
  if ((x>10) and (y>60) and (x<40) and (y<90)) then
    addTrain;
  if ((x>320) and (y>200) and (x<420) and (y<240)) then
    admin;
  
  if addTrainb or editTrainb then
    begin
    
  if ((x>80) and (y>140) and (x<180) and (y<180)) then
      addNumb:=true
  else 
    addNumb:=false;
  if ((x>200) and (y>140) and (x<500) and (y<180)) then
    addTypeb:=true
  else
    addTypeb:=false;
  if  ((x>520) and (y>140) and (x<820) and (y<180)) then
      addOtpravkab:=true
    else
      addOtpravkab:=false;
    if ((x>840) and (y>140) and (x<1140) and (y<180)) then
      addPribb:=true
    else 
      addPribb:=false;
    if ((x>1160) and (y>140) and (x<1260) and (y<180)) then
      addTimeOtpb:=true
    else
      addTimeOtpb:=false;
     
    if ((x>1280) and (y>140) and (x<1380) and (y<180)) then
      addTimePribb:=true
      else
        addTimePribb:=false;
    if ((x>80) and( y>220) and (x<1520) and (y<260)) then
      addInterb:=true
    else
      addInterb:=false;
    if ((x>80) and (y>300) and (x<1520) and (y<340)) then
      addTimeInterb:=true
    else
      addTimeInterb:=false;
    
     if ((x>80) and (y>380) and (x<1520) and (y<420)) then
       addStb:=true
     else
       addStb:=false;
    if ((x>80) and (y>460) and( x<180 )and (y<500)) then
      addClassb:=true
    else
      addClassb:=false;
    if ((x>900) and (y>460) and (x<1000) and (y<500)) then
      addPriceb:=true
    else
      addPriceb:=false;
    if ((x>80) and (y>540) and( x<1520) and (y<580)) then
      addAlternativeb:=true
    else 
      addAlternativeb:=false;
    if ((x>400) and (y>650) and (x<500) and (y<690)) and addTrainb then
    begin
         var test:=addNum+'>'+addType+'>'+addOtpravka+'>'+addPrib+'>'+addTimeOtp+'>'+addTimePrib+'>'+addInter+'>'+addClass+'>'+addPrice+'>'+addTimeInter+'>'+addSt+'>'+addAlternative;
//      writeln(test);
//      assign(dataTrain,'C:\Users\trish\Desktop\coursach\Project5\dataTrain.txt');
      append(dataTrain);
      writeln(dataTrain,test);
      close(dataTrain);
      addTrainb:=false;
      addNum:=nil;
      addType:=nil;
      addOtpravka:=nil;
       addPrib:=nil;
       addTimeOtp:=nil;
       addTimePrib:=nil;
       addInter:=nil;
       addClass:=nil;
       addPrice:=nil;
       addTimeInter:=nil;
       addSt:=nil;
       addAlternative:=nil;
      admin;
      end;
      
      if ((x>400) and (y>650) and (x<500) and (y<690)) and editTrainb then
    begin
     
      var test:=addNum+'>'+addType+'>'+addOtpravka+'>'+addPrib+'>'+addTimeOtp+'>'+addTimePrib+'>'+addInter+'>'+addClass+'>'+addPrice+'>'+addTimeInter+'>'+addSt+'>'+addAlternative;
      arrTrain[index]:=test;
      rewrite(dataTrain);
      for var j:=0 to i-1 do
        writeln(dataTrain,arrTrain[j]); 
      close(dataTrain);
      editTrainb:=false;
      addNum:=nil;
      addType:=nil;
      addOtpravka:=nil;
       addPrib:=nil;
       addTimeOtp:=nil;
       addTimePrib:=nil;
       addInter:=nil;
       addClass:=nil;
       addPrice:=nil;
       addTimeInter:=nil;
       addSt:=nil;
       addAlternative:=nil;
      admin;
     end;
     if ((x>550) and (y>650) and (x<650) and (y<690))  then
       begin
       editTrainb:=false;
     addTrainb:=false;
      addNum:=nil;
      addType:=nil;
      addOtpravka:=nil;
       addPrib:=nil;
       addTimeOtp:=nil;
       addTimePrib:=nil;
       addInter:=nil;
       addClass:=nil;
       addPrice:=nil;
       addTimeInter:=nil;
       addSt:=nil;
       addAlternative:=nil;
       admin;
        
      end;
    end;
    end;
    if  ((x>10) and  (y>110) and (x<40) and (y<140)) then
       deleteTrain;
    
    
    if deleteTrainb then
    begin
      if ((x>300) and (y>140) and (x<400) and (y<180)) then
        deleteNumb:=true
      else 
        deleteNumb:=false;
      if ((x>200) and (y>200) and( x<300 )and (y<240)) then
      begin
        alert;
end;
                  if ((x>320) and (y>200 )and (x<420) and (y<240)) then
                  begin
                    deleteNum:=nil;
                    deleteTrainb:=false;
                    admin;
                    end;
end;
        
      if alertb then 
        begin  
        if ((x>710) and (y>200) and (x<810) and (y<240)) then
          begin
            deleteTrainFile(deleteNum);
            admin;
            deleteNum:=nil;
            deleteTrainb:=false;
        end;
        if  ((x>830) and (y>200) and (x<930) and (y<300)) then
          begin
            deleteNum:=nil;
            admin;
//            deleteTrain;
           end;
           end;
           
      if ((x>10) and (y>160) and (x<40) and (y<190)) then
        editTrainNumber;
        
        if editTrainNumb then
          begin
        if ((x>300) and (y>140) and (x<400) and (y<180)) then
          editNumb:=true
        else 
          editNumb:=false;
        if ((x>200) and (y>200) and (x<300) and (y<240)) then
          begin
          if editNum<>nil then
          begin
            editTrainNumb:=false;
            editTrain;
//            addNum:=nil;
//      addType:=nil;
//      addOtpravka:=nil;
//       addPrib:=nil;
//       addTimeOtp:=nil;
//       addTimePrib:=nil;
//       addInter:=nil;
//       addClass:=nil;
//       addPrice:=nil;
//       addTimeInter:=nil;
//       addSt:=nil;
//       addAlternative:=nil;
//          editTrainNumb:=false;
//            editNumb:=false;
          end;
          end;
        if ((x>320) and (y>200) and (x<420) and (y<240)) and editTrainb then
        begin
          editTrainb:=false;
      addNum:=nil;
      addType:=nil;
      addOtpravka:=nil;
       addPrib:=nil;
       addTimeOtp:=nil;
       addTimePrib:=nil;
       addInter:=nil;
       addClass:=nil;
       addPrice:=nil;
       addTimeInter:=nil;
       addSt:=nil;
       addAlternative:=nil;
          admin;
          editTrainNumb:=false;
          end;
          end;
         
         
       end;
     
{Процедура смены пароля}
{changePassb-флаг отрисоввки окна, и AuthWind аналогично}
procedure changePass;
begin
  changePassb:=true;
  AuthWind:=false;
  TextOut(800, 50, 'Смена пароля');
    TextOut(500, 142, 'Старый пароль:');
    TextOut(500, 255, 'Новый Пароль:');
    SetPenWidth(2);
    Rectangle(690, 130,1050, 180); //  Поле ввода старого пароля
    Rectangle(690, 250, 1050, 300); //  Поле ввода пароля  
    Rectangle(690, 350, 840, 400); // Кнопка Вход
    Rectangle(870, 350, 1020, 400); // Кнопка Выход
    Textout(730, 360, 'СМЕНА');
    Textout(900, 360, 'ОТМЕНА');
end;                   

{Процедура отрисовки главного окна}
procedure MainWindow;
begin
  AuthWind:=false;
  MainWind:=true;
  clearWindow;
  onMouseDown:=ClickPlase;
  setPenWidth(2);
  setfontsize(14);
  rectangle(10,10,40,40);
  textout(10,10,'<-');
//  rectangle(10,50,40,80);
  textout(50,3,'Введите номер поезда');
  textout(50,25,'чтобы посмотреть подробно');
  rectangle(300,10,400,50);
  rectangle(420,10,460,50);
  textout(425,15,'inf');
  textout(470,3,'Введите пункты ');
  textout(470,25,'чтобы было дешевле');
  rectangle(680,10,980,50);
  rectangle(1000,10,1300,50);
  rectangle(1320,10,1360,50);
  textout(1330,15,'₽');
//  rectangle(1450,10,1490,50);
  OnKeyPress:=keypress;

  
  dataTrainLog;
  
end;

{Процедура отрисовки функций администратора}
procedure admin;
begin
  
  MainWindow;
  onMouseDown:=ClickPlase;
  changepassb:=false;
  adminb:=true;
  rectangle(10,60,40,90);
  textout(20,65,'+');
  rectangle(10,110,40,140);
  textout(20,115,'-');
  rectangle(10,160,40,190);
  textout(15,165,'✎');
 
  
  
end; 

{Процедура авторизации}
procedure Authorizing;

  procedure AuthWindow;
  begin
    AuthWind:=true;
    MainWind:=false;
    ClearWindow;
    SetFontSize(18); 
    TextOut(800, 50, 'АВТОРИЗАЦИЯ');
    TextOut(590, 255, 'Пароль:');
    SetPenWidth(2);
    Rectangle(690, 250, 1050, 300); //  Поле ввода пароля  
    Rectangle(690, 350, 840, 400); // Кнопка Вход
    Rectangle(870, 350, 1020, 400); // Кнопка Выход
    Rectangle(690,450,1020,500);
    Rectangle(690,520,1020,570);
    textout(700,525,'СМЕНА ПАРОЛЯ');
    textout(700,455,'ВХОД ГОСТЕМ');
    Textout(730, 360, 'ВХОД');
    Textout(900, 360, 'ВЫХОД');
  end;
  
 
begin
  AuthWindow;
  OnMouseDown:=ClickPlase;
end;
 
begin
  setfontname('Consolas');
  SetWindowSize(1600, 950);
   WindowIsFixedSize;
  setfontsize(16);
  textout(470,10,'МИНИСТЕРСТВО НАУКИ И ВЫСШЕГО ОБРАЗОВАНИЯ РОССИЙСКОЙ ФЕДЕРАЦИИ');
  textout(400,30,'ФГБОУ ВО "Рязанский государственный радиотехнический университет имени В.Ф.Уткина"');
  textout(720,80,'Кафедра ВПМ');
  textout(700,150,'Курсовая работа');
  textout(710,180,'по дисциплине');
  textout(550,210,'Алгоритмические языки и программирование');
  textout(730,240,'по теме:');
  textout(600,270,'Информационные системы');
  textout(550,300,'Задание: 2.1 Расписание движения поездов');
  textout(1200,600,'Выполнил: ст.гр.145');
  textout(1200,630,'Тришин Е.А.');
  textout(1200,660,'Проверил:');
  textout(1200,690,'с.п.Москвитина О.А.');
  textout(750,900,'Рязань 2022');
  readln();
  clearWindow;
  textout(20,20,'Задание: Разработать программу создания и обработки таблицы расписания движения поездов через некоторую станцию');
  textout(20,50,'Столбцы таблицы должны содержать сведения о номере поезда,его типе, о пунктах отправления-прибытия, о времени отправления-прибытия,'); 
  textout(20,80,'промежуточных станциях, доступных классах вагонов,цене за билет.'); 
  textout(20,110,'В программе должна быть предусмотрена возможность выдачи информации о конечной и промежуточных станциях, времени прибытия и стоянки');
  textout(20,140,'о возможном альтернативном пути на конечную станцию, подборе самого дешёвого билета из пункта А в пункт Б.');
  textout(20,170,'Также необходимо предусмотреть возможность изменения таблицы расписания. Расписание должно содержать о не менее чем 30 рейсах.');
  readln();
  clearWindow;
  textout(20,20,'Для пользователя:');
  textout(20,50,'"₽"-после ввода в 2 поля пунктА и пунктБ,выдается самый дешевый билет из А в Б'); 
  textout(20,80,'"inf"-после ввода номера поезда , и нажатии на данную кнопку,выдается полная информация о поезде');
  textout(20,110,'"<-" - выход на окно авторизации');
  textout(20,140,'Для администратора:');
  textout(20,170,'"+"-добавление нового поезда');
  textout(20,200,'"-"-удаление поезда');
  textout(20,230,'"✎"-редактирование поезда');
  textout(20,250,'Примечание:');
  textout(20,280,'При редактировании/удалении в поля "Пункт прибытия,пункт отправки,промежуточные станции ,альтернативный путь" указывать только буквы ');
  textout(20,310,'русского алфавита,в поля "Номер,время отправки, время прибытия/на стоянку,время стоянки"-указывать цифры,а все что связано со временем ');
  textout(20,340,'указывать видом hh:mm');
  textout(20,370,'При добавлении поезда обязательно должны быть заполнены все поля');
  readln();
  setPenWidth(2);
  setfontsize(14);
//  dataTrainLog
  Authorizing;
end.