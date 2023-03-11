import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-asiento',
  templateUrl: './asiento.component.html',
  styleUrls: ['./asiento.component.css']
})
export class AsientoComponent {
  asientos: any;

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.http.get('/api/asiento').subscribe(data => {
      this.asientos = data;
    });
  }
}
