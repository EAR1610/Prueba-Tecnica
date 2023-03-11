import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-movimiento',
  templateUrl: './movimiento.component.html',
  styleUrls: ['./movimiento.component.css']
})
export class MovimientoComponent {
  movimientos: any;

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.http.get('/api/movimiento').subscribe(data => {
      this.movimientos = data;
    });
  }
}
