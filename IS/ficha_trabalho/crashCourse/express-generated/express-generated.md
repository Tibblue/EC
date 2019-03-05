# [Voltar ao CrashCourse](../crash.md)

# express-generated
Esta pasta foi gerada com o comando `$express --view pug express-generated`. (*express-generated* é o nome que dei a pasta)

Este comando gera um server básico, simples e pronto a usar.

Esta pasta pronta a usar segue um layout, que é aceite por todos e ajuda a criar um ambiente comum e civilizado para todos. Cada pasta tem um proposito e um tipo de documento a ser lá colocado. Passo a explicar então.

## Layout da pasta:
* **bin** - O ficheiro *www* é o ficheiro que inicia o servidor (não é o *app.js* sry).

    Para rookies a unica coisa que vos interessa é a linha 15.
    ``` js
    var port = normalizePort(process.env.PORT || '3000');
    ```
    O **3000** é o numero da port onde o servidor está a correr localmente.

    Caso queiram podem alterar, contudo ***recomendo*** a não alterarem nem tocarem no ficheiro nem pasta.

* **public** - Esta pasta é algo interessante.

    Primeiramente esta pasta é publica. Por public quero dizer que qualquer ficheiro que esteja nesta pasta é de acesso publico a qualquer pessoa que saiba o path ate ao ficheiro (apenas precisam de saber isto, mais detalhes serao ditos na hora apropriada).

    Segundamente esta pasta tem 3 importantes subpastas:
    * images - onde vao colocar todas as imagens a usar
    * javascripts - estes ficheiros permitem a execuçao de varias coisas, por exemplo, animaçoes complexas no website. Coisas complexas nascem aqui. ***CUIDADO***
    * stylesheets - aqui são colocadas ficheiros css responsaveis por alterar o look da pagina a apresentar. Vamos usar o ***w3.css*** por ser simples e prático, e ter fantastica documentação.

* **routes** - Aqui definem-se routes aka rotas.

    Rotas são a maneira de saber-mos para onde o user quer ir no nosso website. Num site esta zona está depois do ultimo /

    Por exemplo `https://www.overleaf.com/project`:
    * `https://www.overleaf.com/` é o site, em testing é o nosso **localhost:3000/**
    * `/project` é a rota, que no overleaf nos leva para a página com os nossos projetos (experimentem ;P )

    Usando vários ficheiros de routes conseguimos evitar caos, e organizar melhor o servidor.

* **views** - Nesta pasta colocam-se todas as views do servidor. Por views refiro-me a documentos que desenham as páginas visiveis ao utilizador. Podem ser escritas em HTML, ou outras linguagens equivalentes.

    No nosso caso, vamos usar o ***pug*** (antigamente *jade*). Esta linguagem é simples quando entenderem os basicos, e a documentaçao na net é boa.

* **app.js** - Apesar de já ter esclarecido que o ficheiro *www* é que inicia o servidor, o *app.js* é que contem o conteudo de maior importancia.

* **package.json** - Este ficheiro com já dito antes contem informação para o *npm*, como os *scripts* e package *dependencies*. Recomendo cuidado se lhe mexerem manualmente.

# Executar o servidor
Primeiramente, não esquecer `$npm install` para instalar todas as dependencias. (Caso falhe á primeira tentem outra vez até dar.)

Depois para executar basta correr `$npm run start`.

Iniciado o servidor basta abrirem o browser no [localhost:3000](http://localhost:3000)

E voalá u have yourselfs a server ;)