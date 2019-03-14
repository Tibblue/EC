# NODE.JS

## Package

`package.json` - Ficheiro de dependencias
* Inicializar o **package.json** caso necessario (pravavelmente não será)
    ``` bash
    $npm init -y
    ```
Dentro do `package.json` temos:
* **scripts** - scripts para o npm
    * Exemplo
        ``` json
        "scripts":{
            "start": "npm server.js",
            "dev": "nodemon server.js"
        }
        ```
* **dependencies** - dependencias aka packages que precisamos
    * Exemplo
        ``` json
        "dependencies": {
            "cookie-parser": "~1.4.3",
            "debug": "~2.6.9",
            "express": "~4.16.0",
            "http-errors": "~1.6.2",
            "morgan": "~1.9.0",
            "pug": "2.0.0-beta11"
        }
        ```

## NPM

* Run - `$npm run <script>`
* Install a package - `$npm install <package>`
    * ***IMP*** - Install all package dependencies - `$npm install`
    * ***IMP*** - Save nas dependencias - `$npm install --save <package>`
