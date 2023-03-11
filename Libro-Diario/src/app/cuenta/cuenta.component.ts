import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-cuenta',
  templateUrl: './cuenta.component.html',
  styleUrls: ['./cuenta.component.css']
})
export class CuentaComponent {
  cuentas: any;

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.http.get('/api/cuenta').subscribe(data => {
      this.cuentas = data;
    });
  }

}
