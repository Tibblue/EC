# CrashCourse
Onde tudo se torna realidade.

## [express-generated](express-generated/express-generated.md)
Esta pasta foi gerada com o comando `$express --view=pug express-generated`. (*express-generated* é o nome que dei a pasta)

Este comando gera um server básico, simples e pronto a usar.

Esta pasta pronta a usar segue um layout, que é aceite por todos e ajuda a criar um ambiente comum e civilizado para todos. Cada pasta tem um proposito e um tipo de documento a ser lá colocado. Passo a explicar então.

## [basicNodeJS](basicNodeJS/basicNodeJS.md)
Esta pasta tambem foi gerada automaticamente, mas fiz algumas alterações.

Esta servidor tem:
* ***pugs*** para gerar páginas HTML e onde vão ver como usar as *views* em conjunto com o *css*
* algumas ***routes*** para ilustrar como devem arrumar as routas organizadamente
* ***javascripts*** simples. acreditem, voces não querem ver jQuery a vossa frente, e se poderem reduzir o uso de javascripts, menos coisas estranhas vão acontecer no website.
* ***app.js*** a importar vários *packages*. Há varias categorias de *packages*, e alguns tem de ser colocados no lugar correto do *app.js* para funcionarem (olá *middlewares*)

### coisas novas (até para mim XD)

* env variables
  * [Artigo](https://www.twilio.com/blog/working-with-environment-variables-in-node-js-html)
  * [Documentação](https://nodejs.org/dist/latest-v8.x/docs/api/process.html#process_process_env)
* JWT - [npm documentation](https://www.npmjs.com/package/jsonwebtoken)
* module.exports
  * [Artigo](https://www.tutorialsteacher.com/nodejs/nodejs-module-exports)
  * [Artigo](https://www.sitepoint.com/understanding-module-exports-exports-node-js/)
  * [Documentação](https://nodejs.org/api/modules.html#modules_module_exports)