const express = require('express');
const path = require('path');
const app = express();
const port = 3000;

// Configurar middleware para archivos estáticos
app.use(express.static('public'));

// Ruta principal que sirve index.html
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(port, () => {
    console.log(`Servidor corriendo en http://localhost:${port}`);
}); 