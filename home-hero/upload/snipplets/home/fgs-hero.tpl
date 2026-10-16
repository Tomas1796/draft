{# FGS · Hero de ocasiones. Reemplaza la presentación del bloque "Mensaje de bienvenida".
   Título y subtítulo: bloque "Mensaje de bienvenida" del editor.
   Tarjetas: primeros 4 banners del bloque "Banners promocionales" del editor (foto, título, subtítulo y link).
   Círculos de tipo de prenda: bloque "Categorías principales" del editor (se incluye debajo de las tarjetas).
   Fondo del bloque (opcional): campo "Imagen de fondo" dentro de "Mensaje de bienvenida" en el editor; estilo claro u oscuro.
   Si un banner no tiene foto o no hay banners cargados, se muestra la tarjeta de color liso. #}
{% set fgs_slides = settings.banner_promotional %}
{% set fgs_fallback = [
    {'title': 'Para laburar', 'description': 'Oficina, reuniones, home office', 'link': '/para-laburar/'},
    {'title': 'Evento y casamiento', 'description': 'Casamiento, bautismo, una cena', 'link': '/evento-y-casamiento/'},
    {'title': 'Finde y salidas', 'description': 'Fresco, cómodo y con onda', 'link': '/finde-y-salidas/'},
    {'title': 'Talles grandes', 'description': 'Hasta XXXL, mismo calce', 'link': '/talles-grandes/'}
] %}
{% set fgs_has_bg = 'fgs_hero_bg.jpg' | has_custom_image %}
{% set fgs_dark = settings.fgs_hero_bg_style == 'dark' %}
<section class="fgs-hero{% if fgs_has_bg %} fgs-hero--bg{% if fgs_dark %} fgs-hero--dark{% endif %}{% endif %}" data-store="home-welcome-message"{% if fgs_has_bg %} style="background-image:url('{{ 'fgs_hero_bg.jpg' | static_url | settings_image_url('1080p') }}')"{% endif %}>
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
.fgs-occ{border:1px solid rgba(74,50,22,.22);box-shadow:0 8px 22px rgba(30,20,10,.16)}
.fgs-hero--dark .fgs-occ{border-color:rgba(255,255,255,.3);box-shadow:0 10px 26px rgba(0,0,0,.28)}
.fgs-hero__cats .home-category-image{box-sizing:border-box;border-radius:50%;overflow:hidden;border:1.5px solid rgba(74,50,22,.3);box-shadow:0 5px 14px rgba(30,20,10,.14)}
.fgs-hero--dark .fgs-hero__cats .home-category-image{border-color:rgba(255,255,255,.5);box-shadow:0 6px 16px rgba(0,0,0,.3)}
.fgs-hero__cats .home-category-image{background:rgba(255,255,255,.14);-webkit-backdrop-filter:blur(10px) saturate(1.2);backdrop-filter:blur(10px) saturate(1.2)}
.fgs-hero__cats .home-category-image img{opacity:.84 !important}
.fgs-hero--dark .fgs-hero__cats .home-category-name{text-shadow:0 1px 8px rgba(0,0,0,.55)}
.fgs-occ--c1{background:#1f2a44}
.fgs-occ--c2{background:#4a3226}
.fgs-occ--c3{background:#cdb894;color:#1d1a14}
.fgs-occ--c4{background:#5b5e3c}
.fgs-occ__img{position:absolute;inset:0;width:100%;height:100%;object-fit:cover;z-index:0}
.fgs-occ--img{color:#fff}
.fgs-occ--img::after{display:none}
.fgs-occ--img::before{content:"";position:absolute;inset:0;z-index:1;background:linear-gradient(to top,rgba(74,50,22,.88) 0%,rgba(74,50,22,.35) 45%,rgba(74,50,22,0) 75%)}
.fgs-hero--bg{position:relative;isolation:isolate;max-width:none;background-size:cover;background-position:center}
.fgs-hero--bg::before{content:"";position:absolute;inset:0;z-index:-1;background:rgba(239,239,239,.72)}
.fgs-hero--dark::before{background:rgba(27,27,26,.52)}
.fgs-hero--dark .fgs-hero__title{color:#f1efea}
.fgs-hero--dark .fgs-hero__sub{color:#cfcac2}
.fgs-hero--dark .home-category-name{color:#f1efea !important}
@media (max-width:359px){
  .fgs-hero__title{font-size:30px}
  .fgs-occ{padding:12px;min-height:116px}
  .fgs-occ span{font-size:16px}
  .fgs-occ small{font-size:11.5px}
}
@media (min-width:900px){
  .fgs-hero{grid-template-columns:minmax(0,.733fr) minmax(0,1fr);column-gap:0;row-gap:3.2vw;align-items:center;max-width:none;padding:clamp(24px,2.4vw,56px) 3vw clamp(28px,2.8vw,60px)}
  .fgs-hero__txt{padding-right:4vw}
  .fgs-hero__title{max-width:none;font-size:clamp(52px,6.3vw,136px);line-height:.98;margin:0 0 clamp(16px,1.6vw,34px)}
  .fgs-hero__sub{font-size:clamp(15px,1.5vw,30px);line-height:1.5;max-width:18em}
  .fgs-hero__grid{gap:clamp(10px,1.1vw,24px)}
  .fgs-occ{aspect-ratio:2.07/1;min-height:0;padding:clamp(12px,1.15vw,26px);border-radius:clamp(14px,1.2vw,26px)}
  .fgs-occ span{font-size:clamp(14px,1.45vw,31px);line-height:1.1;font-weight:700;letter-spacing:.01em}
  .fgs-occ small{font-size:clamp(11px,.8vw,17px);line-height:1.25;margin-top:.3em}
  .fgs-occ::after{width:clamp(70px,6.3vw,130px);height:clamp(70px,6.3vw,130px);right:-1.6vw;top:-1.6vw}
  /* círculos de Categorías principales: fila centrada, sin carrusel */
  .fgs-hero__cats .swiper-container{overflow:visible !important}
  .fgs-hero__cats .swiper-wrapper{display:flex !important;flex-wrap:wrap;justify-content:center;align-items:flex-start;transform:none !important;width:100% !important;gap:clamp(18px,2.6vw,56px)}
  .fgs-hero__cats .swiper-slide{width:auto !important;flex:0 0 auto;margin:0 !important;text-align:center;opacity:1 !important;visibility:visible !important}
  .fgs-hero__cats .swiper-slide-duplicate,.fgs-hero__cats .swiper-button-prev,.fgs-hero__cats .swiper-button-next{display:none !important}
  .fgs-hero__cats .home-category-image{width:clamp(72px,6.2vw,128px) !important;height:clamp(72px,6.2vw,128px) !important;margin:0 auto;border-radius:50%;overflow:hidden}
  .fgs-hero__cats .home-category-image img{width:100% !important;height:100% !important;object-fit:cover}
  .fgs-hero__cats .home-category-name{font-size:clamp(12px,1vw,20px) !important;margin-top:clamp(8px,.8vw,16px) !important;text-align:center;max-width:clamp(90px,9vw,170px)}
}
</style>
<script>
(function () {
  /* Compu: los círculos de Categorías principales se muestran en fila fija, así que forzamos la carga de sus imágenes
     (el carrusel del tema solo carga las que cree visibles). */
  function unveil() {
    var root = document.querySelector('.fgs-hero__cats');
    if (!root) { return; }
    var imgs = root.querySelectorAll('img');
    for (var i = 0; i < imgs.length; i++) {
      var img = imgs[i];
      var ds = img.getAttribute('data-src');
      var dss = img.getAttribute('data-srcset');
      if (dss) { img.setAttribute('sizes', '170px'); img.setAttribute('srcset', dss); }
      if (ds) { img.setAttribute('src', ds); }
      img.classList.remove('lazyload', 'swiper-lazy');
      img.classList.add('lazyloaded');
      img.style.opacity = '1';
    }
    var ph = root.querySelectorAll('.placeholder-fade, .swiper-lazy-preloader');
    for (var j = 0; j < ph.length; j++) { ph[j].style.display = 'none'; }
  }
  if (window.matchMedia && window.matchMedia('(min-width: 900px)').matches) {
    if (document.readyState === 'loading') { document.addEventListener('DOMContentLoaded', unveil); } else { unveil(); }
    window.addEventListener('load', function () { setTimeout(unveil, 300); });
  }
})();
</script>
