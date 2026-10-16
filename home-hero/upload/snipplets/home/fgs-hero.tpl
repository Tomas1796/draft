{# FGS · Hero de ocasiones. Reemplaza la presentación del bloque "Mensaje de bienvenida".
   Título y subtítulo: bloque "Mensaje de bienvenida" del editor.
   Tarjetas: primeros 4 banners del bloque "Banners promocionales" del editor (foto, título, subtítulo y link).
   Círculos de tipo de prenda: bloque "Categorías principales" del editor (se incluye debajo de las tarjetas).
   Si un banner no tiene foto o no hay banners cargados, se muestra la tarjeta de color liso. #}
{% set fgs_slides = settings.banner_promotional %}
{% set fgs_fallback = [
    {'title': 'Para laburar', 'description': 'Oficina, reuniones, home office', 'link': '/para-laburar/'},
    {'title': 'Evento y casamiento', 'description': 'Casamiento, bautismo, una cena', 'link': '/evento-y-casamiento/'},
    {'title': 'Finde y salidas', 'description': 'Fresco, cómodo y con onda', 'link': '/finde-y-salidas/'},
    {'title': 'Talles grandes', 'description': 'Hasta XXXL, mismo calce', 'link': '/talles-grandes/'}
] %}
<section class="fgs-hero" data-store="home-welcome-message">
  <div class="fgs-hero__txt">
    <h2 class="fgs-hero__title">{{ settings.welcome_message | default("¿Para qué te vestís?") }}</h2>
    <p class="fgs-hero__sub">{{ settings.welcome_text | default("Elegí la ocasión y te mostramos qué ponerte, de pies a cabeza.") }}</p>
  </div>
  <div class="fgs-hero__grid">
    {% if fgs_slides and fgs_slides is not empty %}
      {% for slide in fgs_slides %}
        {% if loop.index <= 4 %}
          <a class="fgs-occ fgs-occ--c{{ loop.index }}{% if slide.image %} fgs-occ--img{% endif %}" href="{{ slide.link ? (slide.link | setting_url) : '#' }}">
            {% if slide.image %}
              <img class="fgs-occ__img" loading="lazy" alt="{{ slide.title }}"
                   src="{{ slide.image | static_url | settings_image_url('large') }}"
                   srcset="{{ slide.image | static_url | settings_image_url('large') }} 480w, {{ slide.image | static_url | settings_image_url('huge') }} 640w, {{ slide.image | static_url | settings_image_url('original') }} 1024w"
                   sizes="(min-width: 900px) 40vw, 50vw">
            {% endif %}
            <span>{{ slide.title }}</span>
            {% if slide.description %}<small>{{ slide.description }}</small>{% endif %}
          </a>
        {% endif %}
      {% endfor %}
    {% else %}
      {% for slide in fgs_fallback %}
        <a class="fgs-occ fgs-occ--c{{ loop.index }}" href="{{ slide.link }}">
          <span>{{ slide.title }}</span>
          <small>{{ slide.description }}</small>
        </a>
      {% endfor %}
    {% endif %}
  </div>
  {% if settings.slider_categories and settings.slider_categories is not empty %}
    <div class="fgs-hero__cats">
      {% include 'snipplets/home/home-categories.tpl' %}
    </div>
  {% endif %}
</section>
<style>
.fgs-hero{display:grid;grid-template-columns:1fr;gap:20px;padding:28px 16px 24px;max-width:1400px;margin:0 auto;color:#4a3216}
.fgs-hero__title{max-width:12ch;text-wrap:balance;font-size:36px;line-height:1;font-weight:800;letter-spacing:-.01em;margin:0 0 16px;color:#4a3216}
.fgs-hero__sub{margin:0;font-size:16px;line-height:1.4;max-width:30ch;color:#6b5a45}
.fgs-hero__cats{grid-column:1/-1;min-width:0}
.fgs-hero__grid{display:grid;grid-template-columns:minmax(0,1fr) minmax(0,1fr);gap:10px}
.fgs-occ{box-sizing:border-box;position:relative;overflow:hidden;display:flex;flex-direction:column;justify-content:flex-end;min-height:130px;padding:16px;border-radius:16px;color:#fff;text-decoration:none;transition:transform .15s ease}
.fgs-occ:hover{transform:translateY(-3px)}
.fgs-hero a.fgs-occ,.fgs-hero a.fgs-occ:hover,.fgs-hero a.fgs-occ:focus{color:#fff}
.fgs-hero a.fgs-occ--c3:not(.fgs-occ--img),.fgs-hero a.fgs-occ--c3:not(.fgs-occ--img):hover,.fgs-hero a.fgs-occ--c3:not(.fgs-occ--img):focus{color:#1d1a14}
.fgs-occ span,.fgs-occ small{color:inherit}
.fgs-occ span,.fgs-occ small{position:relative;z-index:2}
.fgs-occ span{font-size:19px;line-height:1.05;font-weight:800}
.fgs-occ small{margin-top:4px;font-size:12.5px;line-height:1.25;opacity:.88}
.fgs-occ::after{content:"";position:absolute;right:-20px;top:-20px;width:84px;height:84px;border-radius:50%;border:1.5px solid currentColor;opacity:.25}
.fgs-occ--c1{background:#1f2a44}
.fgs-occ--c2{background:#4a3226}
.fgs-occ--c3{background:#cdb894;color:#1d1a14}
.fgs-occ--c4{background:#5b5e3c}
.fgs-occ__img{position:absolute;inset:0;width:100%;height:100%;object-fit:cover;z-index:0}
.fgs-occ--img{color:#fff}
.fgs-occ--img::after{display:none}
.fgs-occ--img::before{content:"";position:absolute;inset:0;z-index:1;background:linear-gradient(to top,rgba(74,50,22,.88) 0%,rgba(74,50,22,.35) 45%,rgba(74,50,22,0) 75%)}
@media (max-width:359px){
  .fgs-hero__title{font-size:30px}
  .fgs-occ{padding:12px;min-height:116px}
  .fgs-occ span{font-size:16px}
  .fgs-occ small{font-size:11.5px}
}
@media (min-width:900px){
  .fgs-hero{grid-template-columns:minmax(0,.733fr) minmax(0,1fr);column-gap:0;row-gap:3.8vw;align-items:center;max-width:none;padding:clamp(24px,2.4vw,56px) 3vw clamp(28px,2.8vw,60px)}
  .fgs-hero__txt{padding-right:4vw}
  .fgs-hero__title{max-width:none;font-size:clamp(44px,5vw,108px);line-height:.98;margin:0 0 clamp(14px,1.4vw,30px)}
  .fgs-hero__sub{font-size:clamp(16px,1.6vw,32px);line-height:1.5;max-width:34ch}
  .fgs-hero__grid{gap:clamp(10px,1.1vw,24px)}
  .fgs-occ{aspect-ratio:2.07/1;min-height:0;padding:clamp(16px,1.75vw,36px);border-radius:clamp(14px,1.2vw,26px)}
  .fgs-occ span{font-size:clamp(20px,2.1vw,44px);line-height:1.02}
  .fgs-occ small{font-size:clamp(12px,1.1vw,23px);margin-top:.35em}
  .fgs-occ::after{width:clamp(70px,6.3vw,130px);height:clamp(70px,6.3vw,130px);right:-1.6vw;top:-1.6vw}
  /* círculos de Categorías principales: tamaño de la maqueta */
  .fgs-hero__cats .swiper-wrapper{justify-content:center}
  .fgs-hero__cats .swiper-slide,.fgs-hero__cats .home-category-name{text-align:center}
  .fgs-hero__cats .swiper-slide{margin-right:clamp(26px,3.2vw,66px) !important}
  .fgs-hero__cats .swiper-slide:last-child{margin-right:0 !important}
  .fgs-hero__cats .home-category-image{width:clamp(88px,8.3vw,172px) !important;height:clamp(88px,8.3vw,172px) !important;margin:0 auto;border-radius:50%;overflow:hidden}
  .fgs-hero__cats .home-category-image img{width:100% !important;height:100% !important;object-fit:cover}
  .fgs-hero__cats .home-category-name{font-size:clamp(13px,1.2vw,24px) !important;margin-top:clamp(10px,1vw,20px) !important}
}
</style>
