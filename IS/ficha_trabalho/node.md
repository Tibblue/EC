# NODE.JS

## Package

`package.json` - Ficheiro de dependencias
* Inicializar o **package.json** - `$npm init -y`

Dentro do `package.json` temos:
* **scripts** - scripts para o npm
    * Exemplo
        ```
        "scripts":{
            "start": "npm server.js"
            "dev": "nodemon server.js"
        }
        ```
* **dependencies** - dependencias aka packages que precisamos

## NPM

* Run - `$npm run <script>`
* Install a package - `$npm install <package>`
    * Install all package dependencies - `$npm install`
    * Save nas dependencias - `$npm install --save <package>`
