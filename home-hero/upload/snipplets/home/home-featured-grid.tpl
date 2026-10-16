{# /*============================================================================
  #Home featured grid
==============================================================================*/

#Properties

#Featured Slider

#}

{% set featured_products = featured_products | default(false) %}
{% set new_products = new_products | default(false) %}
{% set sale_products = sale_products | default(false) %}

{# Check if slider is used #}

{% set has_featured_products_and_slider = featured_products and settings.featured_products_format != 'grid' %}
{% set has_new_products_and_slider = new_products and settings.new_products_format != 'grid' %}
{% set has_sale_products_and_slider = sale_products and settings.sale_products_format != 'grid' %}
{% set use_slider = has_featured_products_and_slider or has_new_products_and_slider or has_sale_products_and_slider %}
{% set section_columns_grid_mobile = settings.grid_columns_mobile %}
{% set section_columns_grid_slider_mobile = section_columns_grid_mobile == '1' ? '1.15' : section_columns_grid_mobile == '2' ? '2.25' : '3.25' %}

{% if featured_products %}
    {% set sections_products = sections.primary.products %}
    {% set section_name = 'primary' %}
    {% set section_title = settings.featured_products_title %}
    {% set section_format = settings.featured_products_format %}
    {% set section_id = 'featured' %}
    {% set section_grid_desktop = settings.featured_products_desktop == 'default' ? 'true' : 'false' %}
    {% set section_grid_mobile = settings.featured_products_mobile == 'default' ? 'true' : 'false' %}
    {% set section_columns_desktop = settings.featured_products_desktop == 'default' ? settings.grid_columns_desktop : settings.featured_products_desktop %}
    {% set section_columns_mobile = settings.featured_products_mobile == 'default' ? settings.grid_columns_mobile : settings.featured_products_mobile %}
{% endif %}
{% if new_products %}
    {% set sections_products = sections.new.products %}
    {% set section_name = 'new' %}
    {% set section_title = settings.new_products_title %}
    {% set section_format = settings.new_products_format %}
    {% set section_id = 'new' %}
    {% set section_columns_desktop = settings.new_products_desktop %}
    {% set section_columns_mobile = settings.new_products_mobile %}
    {% set section_grid_desktop = settings.new_products_desktop == 'default' ? 'true' : 'false' %}
    {% set section_grid_mobile = settings.new_products_mobile == 'default' ? 'true' : 'false' %}
    {% set section_columns_desktop = settings.new_products_desktop == 'default' ? settings.grid_columns_desktop : settings.new_products_desktop %}
    {% set section_columns_mobile = settings.new_products_mobile == 'default' ? settings.grid_columns_mobile : settings.new_products_mobile %}
{% endif %}
{% if sale_products %}
    {% set sections_products = sections.sale.products %}
    {% set section_name = 'sale' %}
    {% set section_title = settings.sale_products_title %}
    {% set section_format = settings.sale_products_format %}
    {% set section_id = 'sale' %}
    {% set section_grid_desktop = settings.sale_products_desktop == 'default' ? 'true' : 'false' %}
    {% set section_grid_mobile = settings.sale_products_mobile == 'default' ? 'true' : 'false' %}
    {% set section_columns_desktop = settings.sale_products_desktop == 'default' ? settings.grid_columns_desktop : settings.sale_products_desktop %}
    {% set section_columns_mobile = settings.sale_products_mobile == 'default' ? settings.grid_columns_mobile : settings.sale_products_mobile %}
{% endif %}

{% set section_columns_slider_mobile = section_columns_mobile == '1' ? '1.15' : section_columns_mobile == '2' ? '2.25' : '3.25' %}

<div class="js-products-{{ section_id }}-container container-fluid">
    <div class="row">
        {% if featured_products or new_products or sale_products %}
            {# FGS: encabezado con el título a la izquierda y enlace "Ver todo" a la derecha (Más vendidos, Nuevo y Sale) #}
            {% set fgs_see_all = featured_products ? '/mas-vendidos/' : (new_products ? '/nuevo/' : '/sale/') %}
            <div class="fgs-sec-head col-12">
                <h2 class="js-products-{{ section_id }}-title section-title h5 mb-1" {% if not section_title %}style="display: none;"{% endif %}>
                    {{ section_title }}
                </h2>
                <a class="fgs-seeall" href="{{ fgs_see_all }}">Ver todo</a>
            </div>
        {% else %}
        <h2 class="js-products-{{ section_id }}-title section-title h5 mb-1 text-center col-12" {% if not section_title %}style="display: none;"{% endif %}>
            {{ section_title }}
        </h2>
        {% endif %}
        <div class="js-products-{{ section_id }}-col col-12 {% if use_slider %}p-0{% else %}pl-0{% endif %}">
            {% if use_slider %}
                <div class="js-swiper-{{ section_id }} swiper-container">
            {% endif %}
                    <div class="js-products-{{ section_id }}-grid js-products-home-grid  {% if use_slider %}swiper-wrapper{% else %}row{% endif %}" 
                    data-desktop-columns="{{ section_columns_desktop }}" 
                    data-mobile-columns="{{ section_columns_mobile }}" 
                    data-desktop-grid="{{ section_grid_desktop }}" 
                    data-desktop-grid-columns="{{ settings.grid_columns_desktop }}" 
                    data-mobile-grid="{{ section_grid_mobile }}" 
                    data-mobile-grid-columns="{{ settings.grid_columns_mobile }}" 
                    data-mobile-grid-slider-columns="{{ section_columns_grid_slider_mobile }}" 
                    data-mobile-slider-columns="{{ section_columns_slider_mobile }}" 
                    data-format="{{ section_format }}" 
                    data-section-id="{{ section_id }}">
                        {% for product in sections_products %}
                            {% if use_slider %}
                                {% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'section_name': section_name} %}
                            {% else %}
                                {% include 'snipplets/grid/item.tpl' %}
                            {% endif %}
                        {% endfor %}
                    </div>
            {% if use_slider %}
                </div>
            {% endif %}
        </div>
    </div>
</div>

{% if use_slider %}
    <div class="js-swiper-{{ section_id }}-prev swiper-button-prev d-none d-md-block svg-square svg-icon-text">
        <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
    </div>
    <div class="js-swiper-{{ section_id }}-next swiper-button-next d-none d-md-block svg-square svg-icon-text">
        <svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
    </div>
{% endif %}

{% if featured_products or new_products or sale_products %}
{% set fgs_store = featured_products ? 'home-products-featured' : (new_products ? 'home-products-new' : 'home-products-sale') %}
{% set fgs_badge = featured_products ? 'Más vendido' : (new_products ? 'Nuevo' : 'Sale') %}
{% set fgs_badge_bg = sale_products ? '#9c3a24' : '#1b1b1a' %}
<style>
/* FGS · Encabezado, "Ver todo" y etiqueta de cada sección ({{ fgs_badge }}). Cada sección lleva solo sus propios estilos. */
[data-store="{{ fgs_store }}"] .container-fluid{padding-left:3vw;padding-right:3vw}
/* Menos aire entre secciones: el tema deja ~100 px debajo de cada fila de productos */
[data-store="{{ fgs_store }}"]{margin-top:0 !important;margin-bottom:0 !important;padding-top:0 !important;padding-bottom:0 !important}
[data-store="{{ fgs_store }}"] .container-fluid{padding-top:clamp(22px,2.6vw,48px);padding-bottom:clamp(6px,.8vw,16px)}
[data-store="{{ fgs_store }}"] .row{margin-bottom:0 !important}
[data-store="{{ fgs_store }}"] .js-products-{{ section_id }}-grid > *{margin-bottom:clamp(6px,.8vw,16px) !important;padding-bottom:0 !important}
[data-store="{{ fgs_store }}"] .js-products-{{ section_id }}-grid > * > *{margin-bottom:0 !important}
[data-store="{{ fgs_store }}"] .fgs-sec-head{display:flex;align-items:baseline;justify-content:space-between;gap:16px;margin-bottom:clamp(14px,1.6vw,30px)}
[data-store="{{ fgs_store }}"] .fgs-sec-head .section-title{text-align:left;margin:0;font-size:clamp(24px,2.6vw,50px);line-height:1.05;font-weight:700}
[data-store="{{ fgs_store }}"] .fgs-seeall{flex:none;font-size:clamp(13px,1.05vw,20px);font-weight:600;text-decoration:underline;text-underline-offset:4px;color:inherit}
[data-store="{{ fgs_store }}"] .fgs-seeall:hover{opacity:.7}
[data-store="{{ fgs_store }}"] .js-products-{{ section_id }}-grid > *{position:relative}
[data-store="{{ fgs_store }}"] .js-products-{{ section_id }}-grid > *::before{content:"{{ fgs_badge }}";position:absolute;z-index:5;top:12px;left:12px;padding:5px 12px;border-radius:999px;background:{{ fgs_badge_bg }};color:#fff;font-size:12px;font-weight:700;line-height:1.2;letter-spacing:.01em;pointer-events:none}
[data-store="{{ fgs_store }}"] .js-products-{{ section_id }}-grid img{border-radius:14px}
@media (max-width:767px){
  [data-store="{{ fgs_store }}"] .container-fluid{padding-left:16px;padding-right:16px;padding-top:20px;padding-bottom:4px}
  [data-store="{{ fgs_store }}"] .js-products-{{ section_id }}-grid > *::before{top:8px;left:8px;padding:4px 9px;font-size:11px}
}
</style>
{% endif %}
