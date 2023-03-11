import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-tipo-movimiento',
  templateUrl: './tipo-movimiento.component.html',
  styleUrls: ['./tipo-movimiento.component.css']
})
export class TipoMovimientoComponent {
  tiposMovimientos: any;

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.http.get('/api/tipos-movimientos').subscribe(data => {
      this.tiposMovimientos = data;
    });
  }
}
