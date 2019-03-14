# [Voltar ao CrashCourse](../crash.md)

# basicNodeJS
Esta pasta tambem foi gerada automaticamente, mas fiz algumas alterações.

Esta servidor tem:
* ***pugs*** para gerar páginas HTML e onde vão ver como usar as *views* em conjunto com o *css*
* algumas ***routes*** para ilustrar como devem arrumar as routas organizadamente
* ***javascripts*** simples. acreditem, voces não querem ver jQuery a vossa frente, e se poderem reduzir o uso de javascripts, menos coisas estranhas vão acontecer no website.
* ***app.js*** a importar vários *packages*. Há varias categorias de *packages*, e alguns tem de ser colocados no lugar correto do *app.js* para funcionarem (olá *middlewares*)

## O que tem este Server? :o

- [x] File Upload
- [ ] Autenticação
- [x] Ferramentas e ficheiros importantes
  - [x] app.js briefing
  - [x] Pug & CSS quick intro
  - [x] jQuery (& JavaScript) quick intro


### *File Upload*
Este server tem na sua *root* (aka path **"/"**) formularios para File Upload.

Um deles usa apenas **pedidos HTTP** escritos no HTML, e posterior tratamento na rota onde é recebido o pedido.
* [W3Schools Info](https://www.w3schools.com/html/html_forms.asp)

O outro usa **pedidos HTTP** atraves de *JavaScript* e *jQuery*
* [Info (não vale a pena sofrerem. a serio...)](https://medium.freecodecamp.org/here-is-the-most-popular-ways-to-make-an-http-request-in-javascript-954ce8c95aaa)

### *TODO Autenticação*

Someday brothers XDDD

## Ferramentas e ficheiros importantes

### *app.js briefing*
`app.js` é onde definimos as coisas mais importantes do servidor como *imports de packages* e como usa-los, *routes*, etc.

Vamos ver como definir as routes principais, como importas packages e como usa-las.

#### Routes no app.js
```js
// ROUTES
app.use('/',        require('./routes/index'));
app.use('/users',   require('./routes/users'));
app.use('/api/users', require('./routes/api/users'))
```
Neste excerto das routes do app.js, vemos 3 rotas definidas.

Para definir uma *route* usamos o `app.use(<server_path>,<file_path>)`.

O **server_path** é o path par aceder a esta route.
Por exemplo, a primeira route definida diz que o **server_path** é `'/'` (no browser escreveriamos `localhost:<port>/`). O `'/'` é a nossa ***root*** do servidor. É um lugar especial no coração do nosso servidor.

Depois temos o **file_path** é o path para o ficheiro no nosso filesystem que vai dizer ao servidor o que fazer quando alguem aceder a esta route. Por exemplo, a primeira route definida diz que o **file_path** é `require('./routes/index')`, onde`'./routes/index'` é o path a começar na root da pasta até ao ficheiro e o `require()` é apenas a maneira de dizer que precisamos desse ficheiro (não questionem porque XD)

#### Packages
```js
// IMPORTS
var express = require('express');
var cookieParser = require('cookie-parser');
// Definir o Express (aka parte crucial do servidor)
var app = express();
// Dizer ao Express (aka app) para usar o CookieParser
app.use(cookieParser());
```
Neste exemplo, temos primeiramente o *import* de packages, seguido do seu uso.

Para usar uma *package* temos de a importar usando o `require('<package_name>')` onde ***package_name*** é o nome da package (wow :o), normalmente igual ao nome que usaram para instalar o package com o npm. Depois de o importar, temos ainda de o associar a uma var, para o usarmos mais tarde.

Depois de importado podemos usalo.

Por exemplo, fazendo `var app = express()` usamos o package *express* para gerar uma app que vai servir como base para o nosso servidor. e depois fazermos `app.use(cookieParser())` para dizer à nossa app (aka servidor aka express) para usar o *cookieParser* que foi anteriormente importado.

NOTA: Podemos importar packages em qualquer ficheiro, não apenas no app.js (exemplo: ficheiros das routes)

### *Pug & CSS quick intro*
**CSS** (Cascading Style Sheets) são ficheiros que permitem alterar propriedades de elementos de uma página HTML e assim tornar uma página visualmente diferente. Para uma mesma página HTML, se alterassemos apenas o seu CSS esta pode ficar ***completamente diferente***. A nivel de CSS vamos usar o `w3.css` por ser o que sempre usei, ser simples e fazer coisas porreiras.

[w3.css Basics](https://www.w3schools.com/w3css/)

Para usar o CSS no Pug, colocamos o elementos seguido da class do CSS que lhe queremos atribuir, separado por .
``` pug
label.w3-text-indigo
```

**Pug** é uma linguagem alternativa a HTML, existem imensas, eu apenas aprendi esta e é good, recomendo XD

[Pug Website](https://pugjs.org/api/getting-started.html)

Pug, tal como python, batevos se não usarem indentação direito.
Um dos pontos fortes de Pug é não termos de fechar tags, contudo para isso o ficheiro tem de estar bem indentado. ***Remember That***

O que se escreveria em HTML como
``` html
<p>Paragrafo</p>
```
Em Pug fica
``` pug
p Paragrafo
```
Outra capacidade do Pug é fazer ***extends*** e ***include*** de outros pugs.
* O *extends* permite dizer que o ficheiro é uma parte de outro maior.
* O *include* permite incluir um ficheiro mais pequeno no meio de um maior.

Tem exemplos disto nos pugs.
* O index faz *extends* do layout, porque o layout tem o cabeçalho do Pug e o index tem o body.
* O index faz *include* do footer para usa-lo como parte inferior da página.

O ***block*** serve para definir zonas que podem ser definidas mais tarde. Por exemplo, o layout tem o block content, que é mais tarde definido no index. Há ainda mais capacidades do block, #busquem_na_documentação.

Ultimamente refiro que quando fazemos *render* do Pug no nosso server, podemos passar-lhe *variaveis*, e essas podem ser usadas no Pug. Por exemplo, no lista.pug, temos a linha `each file in lista` onde lista é uma var que nos é passada, com a lista de ficheiros.
Aproveito para chamar atenção da linha 9 no lista.pug onde temos `td= file.descricao`
Isto porque queria colocar no elemento *td* o valor da variavel `file.descricao`. Isso faz-se usando um *=* após o elemento e antes da variavel.

### *jQuery (& JavaScript) quick & notCancerous intro*
jQuery é cancro em qualquer quantidade, mas é praticamente obrigatorio para se fazerem animações na página entre outras coisas.
Contudo para esses casos ojQuery é ralativamente simples e pequeno. Um cancro aceitavel e toleravel.

Não tenciono usa-lo muito, mas como exemplo temos o seu uso está no [myUpload.js](public/javascripts/myUpload.js).
``` js
$("#hide").click(()=>{
    $("table").hide()
})
```
Onde o `$` é uma abreviação para o uso do jQuery, `#hide` permite ir buscar o elemento no HTML sujo **id** é **hide** (spoiler é o botão que diz hide) e `.click()` permite executar algo após o elemento ser clicado (quem diria :o).

Depois dentro de chavetas temos o código para o click. Neste caso `$("table")` usa o já dito, mas desta vez não tem #, portanto ele vai selecionar todos os elementos do *tipo* **table** (neste caso a tabela que mostra a lista dos ficheiros) e o `.hide()` torna o elemento invisivel.

No mesmo ficheiro ([myUpload.js](public/javascripts/myUpload.js)) linhas 16 a 23, temos um função em javascript, que serve para verificar que foi selecionado um ficheiro antes de submeter o formulário.

Existem mais coisas, mas é tudo doloroso tanto de entender como explicar. Quando for preciso perguntem XD espero que não seja preciso.
