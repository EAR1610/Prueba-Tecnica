import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { CuentaComponent } from './cuenta/cuenta.component';
import { MovimientoComponent } from './movimiento/movimiento.component';
import { TipoMovimientoComponent } from './tipo-movimiento/tipo-movimiento.component';
import { AsientoComponent } from './asiento/asiento.component';
import { RelacionComponent } from './relacion/relacion.component';

@NgModule({
  declarations: [
    AppComponent,
    CuentaComponent,
    MovimientoComponent,
    TipoMovimientoComponent,
    AsientoComponent,
    RelacionComponent,
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
