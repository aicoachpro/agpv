const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
  res.send('AGPV Provisionsrechner — dev server läuft');
});

app.listen(port, () => {
  console.log(`Server läuft auf http://localhost:${port}`);
});
