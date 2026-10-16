# FGS · Rediseño de la home (Tiendanube) — documentación

Última actualización: 16/10/2026 · Cliente: Feel Good Shoes (feelgoodshoes.com.ar) · Tema: Rio (Tiendanube, plan Impulso)

Este paquete reúne todo lo que se modificó en la home para poder **repetirlo, auditarlo o volver atrás** sin depender de nadie.

## 1. Qué hace el cambio
La home pasa de un grid de productos mezclados a una estructura **por ocasión**:

1. Carrusel de imágenes (banner de Lucas / promo).
2. **Hero "¿Para qué te vestís?"**: título a la izquierda, 4 tarjetas de ocasión (Para laburar, Evento y casamiento, Finde y salidas, Talles grandes) a la derecha y, debajo, los círculos de tipo de prenda (Categorías principales). Fondo con foto editable.
3. Más vendidos · Nuevo · Sale, cada una con título a la izquierda, enlace "Ver todo" y etiqueta.

## 2. Archivos del tema modificados por FTP (son **solo 4**)
Carpeta `1-codigo-ftp/` (respeta las rutas del tema).

| Archivo | Ruta en el FTP | Qué se hizo |
|---|---|---|
| `fgs-hero.tpl` | `/snipplets/home/` | **Archivo nuevo.** El hero completo (HTML, CSS y un script chico para cargar los íconos en compu). |
| `home-section-switch.tpl` | `/snipplets/home/` | **1 línea cambiada.** Dentro del bloque `welcome`, ahora incluye `fgs-hero.tpl` en vez de `home-welcome-message.tpl`. |
| `home-featured-grid.tpl` | `/snipplets/home/` | Encabezado con "Ver todo" a la derecha, etiqueta en cada producto y menos espacio vertical, solo en Más vendidos, Nuevo y Sale. |
| `settings.txt` | `/config/` | **13 líneas agregadas** dentro de "Mensaje de bienvenida": campos *Imagen de fondo* y *Estilo del fondo*. |

No se tocó `home.tpl` ni ningún otro archivo.

### Cómo subirlos (FileZilla)
1. En Tiendanube: diseño **publicado** → ⋮ → *Editar código* → *Abrir FTP* (da host, usuario y clave).
2. FileZilla → **Transferencia → Tipo de transferencia → Binario** (con Automático falla: el servidor rechaza el modo texto).
3. Orden: primero `fgs-hero.tpl`, después `settings.txt`, después `home-featured-grid.tpl`, al final `home-section-switch.tpl` (este último es el que activa el hero). Siempre **Sobrescribir**.
4. Esperar 2 o 3 minutos (caché) y recargar con Cmd+Shift+R en incógnito.
5. **Antes de subir, bajar una copia de seguridad de todas las carpetas del FTP** (la original está en `Documentos/respaldo-fgs`).

## 3. Cómo funciona (para entenderlo en 1 minuto)
- `home.tpl` recorre las secciones en el orden que se arma en el editor y delega cada una en `home-section-switch.tpl`.
- La sección *Mensaje de bienvenida* (`welcome`) ahora dibuja `fgs-hero.tpl`. **El lugar del hero en la home lo controla ese bloque en el editor.**
- El hero lee del editor:
  - Título y subtítulo → *Mensaje de bienvenida* (`welcome_message`, `welcome_text`).
  - 4 tarjetas → los **primeros 4** banners de *Banners promocionales* (foto, título, subtítulo, link). Sin foto, la tarjeta es de color liso.
  - Círculos → *Categorías principales* (`slider_categories`). El texto de cada círculo es el **nombre de la categoría** a la que enlaza.
  - Fondo → campo nuevo `fgs_hero_bg.jpg` y `fgs_hero_bg_style` (`light`/`dark`).
- Las tres secciones de productos se alimentan de las listas de **Destacar** (ver punto 6), no de categorías.

## 4. Configuración guardada en el editor (no está en los archivos)
Si se rehace el diseño en otro lado, esto hay que volver a cargarlo a mano.

| Dónde | Valor |
|---|---|
| Mensaje de bienvenida → Título | `¿Para qué te vestís?` |
| Mensaje de bienvenida → Descripción | `Elegí la ocasión y te mostramos qué ponerte, de pies a cabeza.` |
| Mensaje de bienvenida → Imagen de fondo | foto de sandalias sin texto (`2-imagenes/fondo/`) |
| Mensaje de bienvenida → Estilo del fondo | Oscuro |
| Banners promocionales (en este orden) | 1 Para laburar · "Oficina, reuniones, home office" → `/para-laburar/` · 2 Evento y casamiento · "Casamiento, bautismo, una cena" → `/evento-y-casamiento/` · 3 Finde y salidas · "Calor, asado, salir" → `/finde-y-salidas/` · 4 Talles grandes · "Hasta XXXL, mismo calce" → `/talles-grandes/` |
| Categorías principales (círculos) | Sastreros, Camisas, Zapatillas, Chombas, Remeras, Shorts; imagen = ícono 3D (`2-imagenes/iconos-categorias/`); link a la categoría correspondiente |
| Productos destacados → Título | `Más vendidos` |
| Productos nuevos → Título | `Nuevo` (se ve como "Nuevos" si no se cambia) |
| Edición avanzada de CSS | ver bloque abajo |

Orden de bloques de la Página de inicio (arrastrando en el editor): Carrusel de imágenes → **Mensaje de bienvenida** (= el hero) → Productos destacados → Productos nuevos → Video. Apagar con el ojito *Banners promocionales* y *Categorías principales* para que no se repitan abajo (el hero sigue leyendo sus datos aunque estén apagados). *Verificar este orden en el editor antes de dar el trabajo por cerrado.*

CSS pegado en *Edición avanzada de CSS* (evita que se corten los nombres de los círculos):
```css
.home-category-name {
  display: block !important;
  white-space: normal !important;
  overflow: visible !important;
  text-overflow: clip !important;
  -webkit-line-clamp: unset !important;
  line-height: 1.2;
}
```

## 5. Datos de toda la tienda (no dependen del diseño)
Categorías creadas (todas en la raíz y **visibles**):

| Categoría | ID | Productos | Link |
|---|---|---|---|
| Para laburar | 41583338 | 82 | `/para-laburar/` |
| Evento y casamiento | 41583339 | 65 | `/evento-y-casamiento/` |
| Finde y salidas | 41583340 | 127 | `/finde-y-salidas/` |
| Talles grandes | 41583341 | 22 | `/talles-grandes/` |
| Más vendidos | 41583815 | 26 | `/mas-vendidos/` |
| Nuevo | 41590382 | 49 | `/nuevo/` |
| Sale | 41590383 | 115 | `/sale/` |

Criterios: *Más vendidos* = pedidos pagos 17/09–15/10/2026 con curva de talles; *Nuevo* = lanzamientos a precio lleno (id ≥ 360.000.000) con ≥3 talles con stock; *Sale* = precio promocional y stock en ≥2 talles; *Talles grandes* = productos con XXL/XXXL en stock.

## 6. Listas de "Destacar" (lo que muestran los bloques de la home)
Se cargan **a mano** en el administrador (Destacar / `/admin/themes/settings/product_order/`). No se pueden cargar por API. Listas sugeridas con nombres, precios y talles en `3-listas/listas-destacar.md`. Estado al 16/10: Destacados 40 (debería tener 26), Novedades 28 (con productos en oferta por error), Ofertas 2, Principal 0.

## 7. Volver atrás
- **Volver al diseño anterior:** publicar el borrador original. El diseño con el hero queda como borrador **con todo adentro** (código y editor).
- **Quitar solo el hero:** subir de nuevo el `home-section-switch.tpl` original (`respaldo-fgs/snipplets/home/`). El hero deja de usarse.
- **Si el editor da error o no carga:** subir de nuevo el `settings.txt` original (`respaldo-fgs/config/`).

## 8. ⚠️ Advertencias
1. **NO tocar "Cerrar FTP"** en el panel del diseño: Tiendanube avisa que **se pierde el código personalizado**. Para invalidar el acceso usar **"Generar nueva contraseña"**.
2. Abrir el FTP saca al diseño de las actualizaciones automáticas de Tiendanube.
3. Todo lo que se guarda en el editor del diseño actual se **publica al instante**.
4. Renombrar categorías puede cambiar sus links (`/nuevo/`, `/sale/`…). Si se renombran, actualizar `home-featured-grid.tpl`.
5. El enlace del hero a `/para-laburar/` se asumió con el mismo formato que los otros tres (estos sí verificados).
6. Cyber FGS 30/10–8/11 (50 % off): no hacer cambios grandes esos días; el bloque/categoría *Sale* pierde sentido.

## 9. Ajustes finos (valores en `fgs-hero.tpl`)
| Qué | Valor actual | Dónde |
|---|---|---|
| Velo oscuro del fondo | `rgba(27,27,26,.52)` | `.fgs-hero--dark::before` |
| Velo claro del fondo | `rgba(239,239,239,.72)` | `.fgs-hero--bg::before` |
| Transparencia de los círculos | ícono 84 %, vidrio 14 % | `.home-category-image` |
| Alto de tarjetas (compu) | el menor entre 12,85 vw y 24 vh | `.fgs-occ` |
| Tamaño del título (compu) | 6,3 vw (52–136 px) | `.fgs-hero__title` |
| Círculos (compu) | 6,2 vw (72–128 px) | `.home-category-image` |

## 10. Prompts para los íconos 3D (Gemini)
Pedir primero este prompt base y luego, en el mismo chat, cada prenda:

> Ilustración de producto en 3D, estilo render minimalista de estudio: la prenda sola, vista frontal, centrada, con apariencia de tela suave y volumen redondeado, iluminación suave de estudio con una sombra de contacto sutil debajo, colores sobrios y mate, acabado limpio y moderno como un ícono de aplicación premium. Fondo liso color crema #ECE5D6, sin degradados ni texturas. Composición cuadrada 1:1, el objeto ocupa el 60 % del cuadro y queda centrado con amplio margen alrededor. Sin texto, sin logos, sin personas, sin maniquí.

Prendas: sastrero azul marino #1F2A44 · camisa de botones manga corta blanco hueso · zapatilla urbana blanca (3/4) · chomba marrón #4A3226 · remera lisa arena #CDB894 · bermuda verde oliva #5B5E3C. Luego: *"Mantené exactamente el mismo estilo, iluminación, fondo y proporciones que esta imagen de referencia."* Reducir a ~400×400 px.

## 11. Pendientes (al 16/10/2026)
- [ ] Cargar los 6 íconos 3D definitivos en Categorías principales y borrar los círculos viejos azules / duplicados.
- [ ] Cargar las fotos de Lucas en las 4 ocasiones.
- [ ] Corregir las listas de Destacar (ver punto 6).
- [ ] Cargar stock real en los lanzamientos con "stock sin límite" (Bari, Moss, Milano, Musculosa Soft, Lined, Button, Cotton Ceramic, Aura, Fragua) **antes del 30/10**.
- [ ] Revisar el espacio vertical entre secciones en la tienda real (si sigue grande, inspeccionar el hueco bajo una tarjeta de producto).
- [ ] Después del Cyber: looks armados (nivel 1: sección editorial con 3 prendas) y unificar colores en productos nuevos.
- [ ] Medir conversión, ticket promedio y % de órdenes con más de una prenda (base 35 %).

## 12. Contenido del paquete
```
fgs-home-paquete/
├─ README.md                 ← este archivo
├─ 1-codigo-ftp/
│  ├─ config/settings.txt
│  └─ snipplets/home/{fgs-hero.tpl, home-section-switch.tpl, home-featured-grid.tpl}
├─ 2-imagenes/               ← íconos, fondo y fotos (provisorios hasta reemplazarlos)
└─ 3-listas/listas-destacar.md
```
