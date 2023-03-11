import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-relacion',
  templateUrl: './relacion.component.html',
  styleUrls: ['./relacion.component.css']
})
export class RelacionComponent {
  relaciones: any;

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.http.get('/api/relaciones').subscribe(data => {
      this.relaciones = data;
    });
  }
}
