Tham khảo: https://medium.com/geekculture/node-js-environment-variables-setting-node-app-for-multiple-environments-51351b51c7cd

### Install dotenv from npm

```
npm i dotenv --save
```

### File `.env.production` and `.env.development`

2 file này sẽ chứa Env Variables

```
# .env.production
NODE_ENV=development
HOST=localhost
PORT=3000
ROOT=''

# .env.development
NODE_ENV=production
HOST=127.0.0.1
ROOT=/node01
PORT=3000
```

### File `config.js`

`dotenv` sẽ đọc từ 2 file `.env` lưu vào biến vào `process.env`

```js
const dotenv = require('dotenv');
const path = require('path');

let profilePath = path.resolve(__dirname, `.env.${process.env.NODE_ENV}`);
dotenv.config({
    path: profilePath
});

console.log('ENV_PROFILE = ' + profilePath);

module.exports = {
    NODE_ENV: process.env.NODE_ENV || 'failed_dev',
    HOST: process.env.HOST || 'localhost',
    PORT: process.env.PORT || 3000,
    ROOT: process.env.ROOT || ''
}
```

### File `package.json`, set npm run commands 

```json
{
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "dev": "NODE_ENV=development node index.js",
    "prod": "NODE_ENV=production node index.js"
  },
  "dependencies": {
    "dotenv": "^16.0.3",
    "express": "^4.18.2"
  }
}
```

### Using

// index.js

```js
const config =  require('./config.js');
const express =  require('express');
const app =  express();
let root = config.ROOT;

console.log(`NODE_ENV=${config.NODE_ENV}`);

app.get(`${root}/test`, (req, res) => {
    res.send('Hello World !! ' + root);
});

app.listen(config.PORT, config.HOST, () => {
    console.log(`APP LISTENING ON http://${config.HOST}:${config.PORT}`);
    console.log(config.ROOT);
})
```



To run dev mode

```
npm run dev
```



To run on production

```
npm run prod
```

