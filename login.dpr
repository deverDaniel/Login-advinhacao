program login;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, windows, System.Generics.Collections;

// função para limpar o console
procedure LimparConsole;
var
  hConsole: THandle;
  screenBufferInfo: CONSOLE_SCREEN_BUFFER_INFO;
  cellsWritten: DWORD;
  consoleSize: DWORD;
  topLeft: COORD;
begin
  hConsole := GetStdHandle(STD_OUTPUT_HANDLE);
  GetConsoleScreenBufferInfo(hConsole, screenBufferInfo);
  consoleSize := screenBufferInfo.dwSize.X * screenBufferInfo.dwSize.Y;
  topLeft.X := 0;
  topLeft.Y := 0;

  FillConsoleOutputCharacter(hConsole, ' ', consoleSize, topLeft, cellsWritten);
  FillConsoleOutputAttribute(hConsole, screenBufferInfo.wAttributes, consoleSize, topLeft, cellsWritten);
  SetConsoleCursorPosition(hConsole, topLeft);
end;

procedure termo;
var caracteres, lista: Tlist<String>;
    palavra_secreta, chute, exibir: String;
    i, tentativas: Integer;
begin
  randomize;
  LimparConsole;
  tentativas:= 6;
  exibir:= '_____';
  lista:= Tlist<String>.Create;
  caracteres:= Tlist<String>.Create;
  lista.Add('gamer');
  lista.Add('limao');
  lista.Add('china');
  lista.Add('curvo');
  lista.Add('vetor');
  palavra_secreta:= lista[random(5)];
  While(tentativas > 0) do begin
      repeat
      LimparConsole;
      WriteLn('escreva uma palavra de 5 caracteres');
      WriteLn(exibir);
      ReadLn(chute);
     until(Length(chute) = 5);
    
    for i := 1 to Length(palavra_secreta) do
     begin
      if chute[i] = palavra_secreta[i] then begin
        exibir[i]:= chute[i];
      end;
      if exibir = palavra_secreta then begin
        WriteLn('Acertou');
        sleep(1000);
        exit;
      end else begin

      end;




     end;
     tentativas:= tentativas - 1;
  end;
  WriteLn('Não foi dessa vez, a palavra era: ', palavra_secreta);
  Sleep(3000);


  lista.Free;
  caracteres.free;


end;


procedure advinha_num;   //jogo de advinhar número secreto
var num, tentativas, chute: Integer;
    acertou: boolean;
begin
  LimparConsole;
  Randomize;
  tentativas:= 4;
  num:= Random(20);
  acertou:= false;
  While (chute <> num) and (tentativas > 0) do begin
    WriteLn('Número total de tentativas: ', tentativas);
    WriteLn;
    WriteLn('escreva um número entre 0-20');
    ReadLn(chute);
    if (chute = num) then begin
      acertou:= True;
      break;
    end;
   tentativas:= tentativas - 1;
   if (tentativas > 0) then begin
     if (chute > num) then begin
      WriteLn('Número secreto é menor que ', chute);
     end else begin
       WriteLn('Número secreto é maior que ', chute);
     end;
   end;

    WriteLn;
  end;
  if (acertou) then begin
    WriteLn('Parabéns você acertou o número secreto');
  end else begin
    WriteLn('Não foi dessa vez, o número secreto era: ', num);

  end;
  sleep(5000);
end;


 //constantes com usuario e senha
const loginAdm: String = 'admin';
      senhaAdmin: String = '1234';

//verifica se o login está correto, retorna true se sim, false se não
function verifica_login(usuario, senha: String): boolean;
begin
  result:= (usuario = loginAdm) and (senha = senhaAdmin);

end;



//pede login e senha e chama o verificar senha
function fazer_login: boolean;
var usuario, senha: String;
    tentativas: Integer;
begin
  tentativas:= 3;
  repeat
    LimparConsole;
    WriteLn('Digite seu usuário');
    ReadLn(usuario);
    WriteLn('Digite sua senha');
    ReadLn(senha);
    if (verifica_login(usuario,senha)) then begin
      WriteLn('usuario logado com sucesso');
      result:= True;
      sleep(1500);
      exit;
    end else begin
      WriteLn('Usuario ou senha incorreto');
      tentativas:= tentativas-1;
    end;
    sleep(1500);
  until tentativas <= 0;
  WriteLn('Errou login 3 vezes, encerrando...');
  sleep(1500);
  result:= False;

end;

function opcao_menu: Boolean;
var opcao: String;
begin
  ReadLn(opcao);

  if (opcao = '1') then begin
      result:= fazer_login;
  end else if (opcao = '2') then begin
    advinha_num;
    Sleep(1500);
    result:= True;
  end else if (opcao = '3') then begin
    termo;
    Sleep(1500);
    result:= True;
  end else if (opcao = '9') then begin
    WriteLn('Saindo...');
    Sleep(1500);
    result:= False;
  end else begin
    WriteLn('Opção invalida');
    Sleep(1500);
    result:= True;
  end;
end;



procedure Menu;  //exibe o menu

begin
  LimparConsole;
  WriteLn('--------Menu---------');
  WriteLn('|                   |');
  WriteLn('| 1 - Login         |');
  WriteLn('| 2 - Advinha número|');
  WriteLn('| 3 - Termo         |');
  WriteLn('| 9 - sair          |');
  WriteLn('---------------------');
end;

procedure Menu_login;
begin
  LimparConsole;
  WriteLn('--------Menu---------');
  WriteLn('|                   |');
  WriteLn('| 1 - Login         |');
  WriteLn('| 9 - sair          |');
  WriteLn('---------------------');
end;


begin
  try
    menu;
    While(opcao_menu) do begin
      Menu;
    end;


  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
