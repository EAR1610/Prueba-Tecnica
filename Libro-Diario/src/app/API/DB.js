const express = require('express');
const app = express();

const cuentas = [
  { Codigo_Cuenta: 1, nombre: 'Cuenta 1' },
  { Codigo_Cuenta: 2, nombre: 'Cuenta 2' },
  { Codigo_Cuenta: 3, nombre: 'Cuenta 3' }
];

const movimientos = [
  { 
    Codigo_Movimiento: 1, 
    fecha: '2022-01-01', 
    factura: 'FAC-001', 
    descripcion: 'Descripción del movimiento 1', 
    comentario: 'Comentario del movimiento 1', 
    subtotal: 100.00, 
    total: 118.00, 
    Codigo_Cuenta: 1, 
    Codigo_Tipo_Movimiento: 1 
  },
  { 
    Codigo_Movimiento: 2, 
    fecha: '2022-01-02', 
    factura: 'FAC-002', 
    descripcion: 'Descripción del movimiento 2', 
    comentario: 'Comentario del movimiento 2', 
    subtotal: 200.00, 
    total: 236.00, 
    Codigo_Cuenta: 2, 
    Codigo_Tipo_Movimiento: 2 
  },
  { 
    Codigo_Movimiento: 3, 
    fecha: '2022-01-03', 
    factura: 'FAC-003', 
    descripcion: 'Descripción del movimiento 3', 
    comentario: 'Comentario del movimiento 3', 
    subtotal: 300.00, 
    total: 354.00, 
    Codigo_Cuenta: 3, 
    Codigo_Tipo_Movimiento: 3 
  }
];

const tiposMovimientos = [
  {
    Codigo_Tipo_Movimiento: 1,
    nombre : 'Debe',
    tipo : 'Egreso'
  }
]

const relaciones = [
  {
    Codigo_Cuenta : 1,
    Codigo_Tipo_Movimiento : 1,
  }
]

const asientos = [
  {
    Codigo_Asiento: 1,
    Codigo_Movimiento : 1,
    asiento : 69,
  }
]

app.get('/api/movimientos', (req, res) =>{
  res.json(movimientos);
})

app.get('/api/cuenta', (req, res) => {
  res.json(cuentas);
});

app.get('/api/tipo-movimientos', (req, res) => {
  res.json(tiposMovimientos);
});

app.get('/api/relaciones', (req, res) => {
  res.json(relaciones);
});

app.get('/api/asientos', (req, res) => {
  res.json(asientos);
});

app.listen(3000, () => {
  console.log('API corriendo en el puerto 3000');
});
