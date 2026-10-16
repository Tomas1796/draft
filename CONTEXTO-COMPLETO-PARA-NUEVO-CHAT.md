# FGS — Contexto completo para continuar en un chat nuevo (Claude Code escritorio)

> **Cómo usar este archivo:** pegalo (o adjuntalo) al inicio de un chat nuevo y decile: *"Leé este archivo entero. Es el contexto de todo lo que venimos haciendo en la web de Feel Good Shoes. Continuá desde la sección 'Pendientes'."*
> Complementos: `fgs-home-paquete/README.md` (guía operativa), `FGS-home-documentacion.md` (documentación de la home) y el archivo original `fgs-contexto-reorganizacion-sitio.md` (estrategia de reorganización, puntos 1 a 10+; está en la carpeta del usuario, no necesariamente en el repo).
> Rama del repo: `claude/intelligent-cerf-r4p0cb` en `tomas1796/draft`. Última actualización: 16/10/2026.

---

## 0. Reglas de trato con el usuario (importante)

- Idioma: **español rioplatense, voseo**. Tono operativo, directo.
- **No cerrar las respuestas con una pregunta.**
- El usuario ("Tomi", consultor) **nunca hizo un sitio web y no sabe programar**: pedir pasos detallados, uno a uno, con qué botón tocar. Suele mandar capturas de pantalla; mirarlas con atención antes de contestar.
- Distinguir siempre: *"te estoy preguntando si podés"* ≠ *"hacelo"*. Si pregunta si se puede algo, responder primero eso; no ejecutar sin que lo pida.
- Antes de acciones difíciles de revertir o que toquen la tienda en vivo, avisar qué va a pasar y confirmar.
- Admitir errores propios con claridad (hubo varios, ver sección 7).

## 1. Quiénes y qué

- **Negocio:** Feel Good Shoes — `feelgoodshoes.com.ar` (calzado y ropa masculina, Argentina).
- **Dueño:** Lucas. **Consultor / quien me habla:** Tomi (tomas@neurodeep.co, agencia NeuroDeep).
- **Plataforma:** Tiendanube, plan **Impulso**, tema **Rio** (plantillas Twig `.tpl`).
- **Tráfico bajo**: el usuario aceptó que probar cambios en la tienda publicada no es riesgoso.
- Hay un conector **Tiendanube_FGS** (MCP) disponible, y conectores de Meta Ads, Gmail, Drive, Calendar, GitHub.
- Hay análisis previos en el repo: `analisis-3qs-2026-10-07.html`, `analisis-draft-edades-2026-10-07.html` (Meta Ads, no relacionados con la home).

## 2. Objetivo del proyecto

Reorganizar el sitio por **ocasión de uso** en lugar de solo por tipo de prenda, para subir el ticket promedio y el % de pedidos con más de un ítem (base: **35 %**). Idea: "¿Para qué te vestís?" → el cliente elige ocasión (trabajo, evento, finde, talles grandes) y se le muestra qué ponerse de pies a cabeza.

El usuario trajo un **mockup en HTML/JS** (borrador de home) y pidió que la tienda real se vea igual. Yo respondí que sí se puede en Tiendanube, pero **no con las opciones normales del editor**: hubo que editar archivos del tema por **FTP**.

## 3. Cronología de lo hecho

1. **Análisis de pedidos recientes** (API Tiendanube) para definir "Más vendidos" (punto 10 del documento de contexto). Las respuestas eran enormes → se guardaron en archivos y se analizaron con python/jq.
2. **Evaluación de factibilidad** del mockup en Tiendanube + paso a paso para el editor (Banners promocionales como tarjetas de ocasión, Categorías principales como círculos, Mensaje de bienvenida como título).
3. **Armado del borrador en el editor** (ver sección 5): título, 4 banners, 6 círculos, orden de bloques.
4. **Decisión de arquitectura** (propuesta del usuario, aprobada): terminar el borrador → **duplicar el diseño** ("New Home (Copia)") → **publicar el duplicado** → editar por FTP **solo en el duplicado**; el diseño original queda como respaldo.
5. **FileZilla 3.71.1** instalada vía Claude Code en la Mac del usuario; conexión FTP a Tiendanube, descarga de `home.tpl` y `home-section-switch.tpl`, etc.
6. **Hero nuevo** (`fgs-hero.tpl`) con CSS responsivo, vidrio translúcido en los círculos, velos de color y fondo con foto de sandalias.
7. **Iteraciones de diseño** por capturas del usuario (ver sección 7).
8. **Secciones Más vendidos / Nuevo / Sale** con encabezado a la izquierda, "Ver todo", etiqueta sobre las imágenes y menos espacio vertical.
9. **Categorías en la tienda** creadas por el conector (sección 5.4).
10. **Listas "Destacar"**: se analizó que no se pueden editar por API; se preparó el listado de productos para que Haas las cargue a mano.
11. **Paquete de respaldo** (`fgs-home-paquete/` + `.zip` + `FGS-home-documentacion.md`) y este archivo. El usuario guardó todo en una carpeta de su Mac: **"FGS Nueva Web"**.

## 4. Conceptos técnicos de Tiendanube / Rio que importan

- La home se arma con **secciones** ordenadas por `home_order_position_N`; las despacha `snipplets/home/home-section-switch.tpl` (la carpeta se escribe **`snipplets`**, sin una "i").
- Los ajustes del editor se definen en `config/settings.txt` (indentado con **tabs**). Campos de imagen: `'nombre.jpg' | has_custom_image`, se leen con `| static_url | settings_image_url('1080p')`. Items de galería: `image,title,description,link,button`. Links: `| setting_url`.
- **Diseño en borrador vs publicado:** editar el diseño publicado guarda y publica al instante. **FTP solo existe sobre el diseño publicado**. Abrir FTP **frena las actualizaciones automáticas** del tema.
- ⚠️ **"Cerrar FTP" BORRA el código personalizado. NUNCA tocarlo.** Para invalidar el acceso: **"Generar nueva contraseña"** (seguro). *(Yo me equivoqué una vez diciéndole que cerrara; el diálogo lo advertía; se corrigió.)*
- Sin verificar: si el código personalizado persiste cuando el diseño pasa a borrador. Mantener respaldo (paquete).
- **FileZilla:** Transferencia → Tipo de transferencia → **Binario** (el servidor rechaza ASCII con "503 ASCII not supported"). Aceptar el certificado TLS. Elegir "No guardar contraseñas". Para cerrar limpio: Servidor → Desconectar, Edición → Borrar datos privados, Cmd+Q.
- Link de "Editar código" en el admin = FTP (le dije al principio que era seguro mirar; no lo era del todo, quedó aclarado).
- **El conector Tiendanube puede:** listar/crear categorías, asignar categorías a productos, listar/buscar productos, pedidos, `update_product`, `update_visibility`.
  **No puede:** sacar productos de una categoría, renombrar/mover categorías, editar diseño/menú, ni editar las listas **Destacar** (Destacados / Novedades / Ofertas / Principal), que alimentan los bloques de la home y se cargan a mano en `/admin/themes/settings/product_order/`.
- Los bloques "Más vendidos / Nuevo / Sale" **leen listas Destacar, no categorías**. (Al principio el bloque mostraba productos de otra lista cargada por Haas y no mi categoría "Más vendidos"; se explicó.)

## 5. Estado actual de la tienda

### 5.1 Archivos modificados por FTP (solo estos 4; `home.tpl` NO se tocó)
Respaldados en `fgs-home-paquete/1-codigo-ftp/` (rutas del tema) y en `home-hero/upload/`.

| Archivo | Qué hace |
|---|---|
| `snipplets/home/fgs-hero.tpl` (NUEVO, ~9.9 KB) | Hero "¿Para qué te vestís?": título/subtítulo (`settings.welcome_message/welcome_text`), 4 tarjetas de ocasión (primeros 4 de `settings.banner_promotional`), círculos de categorías (incluye `home-categories.tpl` si `settings.slider_categories` no está vacío), fondo con `fgs_hero_bg.jpg` + `settings.fgs_hero_bg_style`. Incluye CSS y un `<script>` chico que fuerza la carga de imágenes lazy en ≥900 px. |
| `snipplets/home/home-section-switch.tpl` | Original con **UNA línea cambiada**: en `section_select == 'welcome'` incluye `fgs-hero.tpl` en vez de `home-welcome-message.tpl`. |
| `snipplets/home/home-featured-grid.tpl` | Para featured/new/sale: encabezado `.fgs-sec-head` (h2 a la izquierda + enlace "Ver todo" → `/mas-vendidos/`, `/nuevo/`, `/sale/`), etiqueta `::before` ("Más vendido"/"Nuevo"/"Sale"; fondo `#9c3a24` para Sale, `#1b1b1a` el resto), CSS acotado por `[data-store="home-products-featured|new|sale"]`, padding lateral 3vw, imágenes redondeadas, espaciado compactado. |
| `config/settings.txt` | Original + 13 líneas tras `welcome_text`: subtítulo "Fondo del bloque de ocasiones (opcional)", `image original = fgs_hero_bg.jpg (1920x900)`, `dropdown fgs_hero_bg_style` con valores `light` / `dark`. |

Parámetros de diseño del hero (desktop ≥900 px): grilla `minmax(0,.733fr) minmax(0,1fr)`; título `clamp(52px,6.3vw,136px)`; subtítulo `clamp(15px,1.5vw,30px)` con `max-width:18em`; tarjetas de alto `clamp(105px,min(12.85vw,24vh),280px)`; círculos `clamp(72px,6.2vw,128px)`; vidrio `rgba(255,255,255,.14)` + imagen a opacidad `.84` + `backdrop-filter`; velo oscuro `rgba(27,27,26,.52)` / claro `rgba(239,239,239,.72)`; borde de tarjeta `1px solid rgba(74,50,22,.28)` (oscuro: `rgba(255,255,255,.34)`) con `background-clip:padding-box`.

### 5.2 Configuración guardada en el editor (no está en archivos)
- **Mensaje de bienvenida:** título "¿Para qué te vestís?"; texto "Elegí la ocasión y te mostramos qué ponerte, de pies a cabeza."
- **Banners promocionales (4):** Para laburar ("Oficina, reuniones, home office"), Evento y casamiento ("Casamiento, bautismo, una cena"), Finde y salidas ("Calor, asado, salir"), Talles grandes ("Hasta XXXL, mismo calce").
- **Categorías principales (círculos):** Sastreros, Camisas, Zapatillas, Chombas, Remeras, Shorts (con íconos provisorios).
- **Fondo:** foto de sandalias sin texto, estilo `dark`.
- **CSS avanzado del editor:** `.home-category-name{display:block!important;white-space:normal!important;overflow:visible!important;text-overflow:clip!important;-webkit-line-clamp:unset!important;line-height:1.2}` (para que no se corten los nombres de los círculos).

### 5.3 Diseños
- **"New Home (Copia)"** = diseño publicado actual (con FTP/código personalizado).
- El diseño original quedó como respaldo sin tocar.

### 5.4 Categorías creadas (raíz, visibles)
| Categoría | ID | Productos | Link |
|---|---|---|---|
| Para laburar | 41583338 | 82 | `/para-laburar/` (asumido) |
| Evento y casamiento | 41583339 | 65 | `/evento-y-casamiento/` |
| Finde y salidas | 41583340 | 127 | `/finde-y-salidas/` |
| Talles grandes | 41583341 | 22 | `/talles-grandes/` |
| Más vendidos | 41583815 | 26 | `/mas-vendidos/` |
| Nuevo | 41590382 | 49 | `/nuevo/` |
| Sale | 41590383 | 115 | `/sale/` |

(Hubo una lectura de 60 en Sale antes de que terminara el segundo lote; el valor correcto es 115.)

### 5.5 Listas Destacar (para cargar a mano, ver `fgs-home-paquete/3-listas/listas-destacar.md`)
Destacados 26 productos (más vendidos), Novedades 28 (lanzamientos a precio lleno), Ofertas 24; Principal vacía. Las carga **Haas** (o el usuario) en `/admin/themes/settings/product_order/`.

## 6. Pendientes (todo del lado del usuario salvo indicación)

1. Subir los **6 íconos definitivos** (hechos con Gemini, ya en su carpeta como `Gemini_Generated…jpeg`) a *Categorías principales*; borrar círculos viejos/duplicados. Optimizar a ~400×400 px y <100 KB cada uno.
2. Subir las **fotos de ocasión de Lucas** a *Banners promocionales* (hoy hay imágenes provisorias).
3. Subir la **foto de fondo** definitiva (1920 px de ancho, <400 KB) a `fgs_hero_bg`.
4. **Cargar las listas Destacar** (Destacados 26 / Novedades 28 / Ofertas 24).
5. Cargar **stock real** de lanzamientos con "stock null" antes del **30/10**.
6. Revisar el **espacio vertical entre las secciones** de productos en la tienda en vivo; si sigue grande, inspeccionar el elemento con DevTools → pestaña *Computed*.
7. Revisar en **celular** (prioridad alta para el usuario: "importante que se vea bien en celular").
8. Después del **Cyber (desde el 9/11)**: evaluar "looks armados" (nivel 1).
9. Medir **conversión, ticket promedio y % de pedidos multi-ítem** (base 35 %).
10. Cuando termine todo: **"Generar nueva contraseña"** de FTP. **Jamás "Cerrar FTP".**
11. Mantener actualizado el paquete de respaldo (`fgs-home-paquete.zip`) tras cada cambio.

## 7. Problemas encontrados y cómo se resolvieron (para no repetirlos)

| Problema | Causa / solución |
|---|---|
| Respuesta de pedidos demasiado grande | Se guardó en archivos y se analizó con python/jq. |
| Bloque "Más vendidos" mostraba otros productos | Lee la lista Destacar (la de Haas), no la categoría. |
| FileZilla: transferencias fallidas "503 ASCII not supported" | Tipo de transferencia → Binario; limpiar cola y volver a descargar. |
| No dejaba arrastrar bloques en el editor | Se dieron alternativas (borrar y volver a agregar). |
| No se veía el hero tras subir | Caché: esperar unos minutos + Cmd+Shift+R. |
| Último círculo gris/atenuado | El swiper del tema atenúa slides "fuera de vista". Fix: `opacity:1 !important; visibility:visible !important` en `.swiper-slide`. (Antes se había supuesto lazy-load y se agregó el script de desvelado; es inofensivo.) |
| Borde de tarjeta distinto en "Finde y salidas" | Fondo de color de cada tarjeta se mezclaba con borde translúcido. Fix: `background-clip:padding-box` + `background-color` (se verificó midiendo píxeles). |
| Círculos cortados bajo el pliegue | Dimensionado vertical con `vh`. |
| Error mío: indiqué "Cerrar FTP" como último paso | Es destructivo; corregido a "Generar nueva contraseña". |
| Error mío: conté 60 en Sale | Lectura antes de que terminara el lote. |

## 8. Cómo probé (si hay que repetirlo)

- Plantillas Twig simuladas con **Jinja2** (traduciendo `? :` e `is not empty`) y capturas con **Chromium headless** (`/opt/pw-browsers/chromium`, `--window-size` y `--force-device-scale-factor 1.4` para imitar la pantalla del usuario ≈ 1430 px CSS).
- Técnicas CSS usadas: `vw`/`vh`/`clamp`, `backdrop-filter`, `background-clip:padding-box`, scoping por `data-store` de cada sección, overrides al swiper del tema.

## 9. Mapa de archivos del repo (`tomas1796/draft`, rama `claude/intelligent-cerf-r4p0cb`)

```
fgs-home-paquete/            ← paquete de respaldo (usar este como fuente)
  README.md                  guía operativa
  1-codigo-ftp/{config,snipplets}/…   los 4 archivos con rutas del tema
  2-imagenes/{iconos-categorias,fondo,fotos-ocasiones}/ + LEEME.txt
  3-listas/listas-destacar.md
fgs-home-paquete.zip         lo mismo comprimido
FGS-home-documentacion.md    documentación de la home
CONTEXTO-COMPLETO-PARA-NUEVO-CHAT.md   este archivo
home-hero/                   trabajo previo (fgs-hero.html, preview.html, iconos, upload/ con los 4 archivos)
ocasiones/                   imágenes provisorias de ocasión (PNG)
destacar/listas-destacar.md  listas para Destacar
analisis-*.html              análisis de Meta Ads (otro tema)
```

En la Mac del usuario: carpeta **"FGS Nueva Web"** con `fgs-home-paquete`, los 4 archivos sueltos (duplicados; se recomendó borrarlos y trabajar solo desde `fgs-home-paquete/1-codigo-ftp/`), la documentación y las imágenes de Gemini (6 íconos + panorámica de sandalias). Nombres sugeridos: `1-sastreros`, `2-camisas`, `3-zapatillas`, `4-chombas`, `5-remeras`, `6-bermudas`, `fondo-sandalias`.

## 10. Prompt sugerido para abrir el chat nuevo

> Leé `CONTEXTO-COMPLETO-PARA-NUEVO-CHAT.md` y `fgs-home-paquete/README.md`. Soy Tomi, consultor de Feel Good Shoes (Tiendanube, tema Rio). Ya tenemos la home por ocasiones publicada con código por FTP. Quiero continuar con los pendientes de la sección 6. Respondeme en español rioplatense, paso a paso, sin cerrar con preguntas, y no toques nada en la tienda sin avisarme antes. Hoy quiero: [lo que sigue].
