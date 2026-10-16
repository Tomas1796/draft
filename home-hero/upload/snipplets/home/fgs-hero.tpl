{# FGS · Hero de ocasiones. Reemplaza la presentación del bloque "Mensaje de bienvenida". #}
<section class="fgs-hero">
  <div class="fgs-hero__txt">
    <h2 class="fgs-hero__title">{{ settings.welcome_message | default("¿Para qué te vestís?") }}</h2>
    <p class="fgs-hero__sub">{{ settings.welcome_text | default("Elegí la ocasión y te mostramos qué ponerte, de pies a cabeza.") }}</p>
  </div>
  <div class="fgs-hero__grid">
    <a class="fgs-occ fgs-occ--laburar" href="/para-laburar/"><span>Para laburar</span><small>Oficina, reuniones, home office</small></a>
    <a class="fgs-occ fgs-occ--evento" href="/evento-y-casamiento/"><span>Evento y casamiento</span><small>Casamiento, bautismo, una cena</small></a>
    <a class="fgs-occ fgs-occ--finde" href="/finde-y-salidas/"><span>Finde y salidas</span><small>Fresco, cómodo y con onda</small></a>
    <a class="fgs-occ fgs-occ--grandes" href="/talles-grandes/"><span>Talles grandes</span><small>Hasta XXXL, mismo calce</small></a>
  </div>
</section>
<style>
.fgs-hero{display:grid;grid-template-columns:1fr;gap:20px;padding:28px 16px 24px;max-width:1400px;margin:0 auto;color:#4a3216}
.fgs-hero__title{max-width:12ch;font-size:36px;line-height:1;font-weight:800;letter-spacing:-.01em;margin:0 0 10px;color:#4a3216}
.fgs-hero__sub{margin:0;font-size:16px;line-height:1.4;max-width:30ch;color:#6b5a45}
.fgs-hero__grid{display:grid;grid-template-columns:minmax(0,1fr) minmax(0,1fr);gap:10px}
.fgs-occ{position:relative;overflow:hidden;display:flex;flex-direction:column;justify-content:flex-end;min-height:130px;padding:16px;border-radius:16px;color:#fff;text-decoration:none;transition:transform .15s ease}
.fgs-occ:hover{transform:translateY(-3px)}
.fgs-occ span{font-size:19px;line-height:1.05;font-weight:800}
.fgs-occ small{margin-top:4px;font-size:12.5px;line-height:1.25;opacity:.88}
.fgs-occ::after{content:"";position:absolute;right:-20px;top:-20px;width:84px;height:84px;border-radius:50%;border:1.5px solid currentColor;opacity:.25}
.fgs-occ--laburar{background:#1f2a44}
.fgs-occ--evento{background:#4a3226}
.fgs-occ--finde{background:#cdb894;color:#1d1a14}
.fgs-occ--grandes{background:#5b5e3c}
@media (max-width:359px){
  .fgs-hero__title{font-size:30px}
  .fgs-occ{padding:12px;min-height:116px}
  .fgs-occ span{font-size:16px}
  .fgs-occ small{font-size:11.5px}
}
@media (min-width:900px){
  .fgs-hero{grid-template-columns:minmax(0,1fr) minmax(0,1.5fr);gap:48px;align-items:center;padding:56px 40px 40px}
  .fgs-hero__title{font-size:60px}
  .fgs-hero__sub{font-size:18px}
  .fgs-hero__grid{gap:14px}
  .fgs-occ{min-height:210px;padding:22px}
  .fgs-occ span{font-size:26px}
  .fgs-occ small{font-size:14px}
}
</style>
