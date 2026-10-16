{% if section_select == 'slider' %}

	{#  **** Home slider ****  #}

	{% set head_transparent_section = (has_main_slider or has_mobile_slider) and settings.head_transparent %}

	<section class="section-slider-home" data-store="home-slider" {% if head_transparent_section %}data-header-type="transparent-on-section"{% endif %}>

		{{ component('nubesdk-slot', { type: 'before_section_slider' }) }}

		{% if show_help or (show_component_help and not (has_main_slider or has_mobile_slider)) %}
			{% snipplet 'defaults/home/slider_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-slider.tpl' %}
			{% if has_mobile_slider %}
				{% include 'snipplets/home/home-slider.tpl' with {mobile: true} %}
			{% endif %}
		{% endif %}

		{{ component('nubesdk-slot', { type: 'after_section_slider' }) }}

	</section>

{% elseif section_select == 'main_categories' %}

	{#  **** Main categories ****  #}
	{% if show_help or (show_component_help and not has_main_categories) %}
		{% snipplet 'defaults/home/main_categories_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-categories.tpl' %}
	{% endif %}

{% elseif section_select == 'products' %}

	{#  **** Featured products ****  #}
	{% if show_help or (show_component_help and not has_products) %}
		{% include 'snipplets/defaults/home/featured_products_help.tpl' with { products_title: 'Destacados' | translate, section_id: 'featured' }  %}
	{% else %}
		{% include 'snipplets/home/home-featured-products.tpl' with {'has_featured': true} %}
	{% endif %}

{% elseif section_select == 'informatives' %}

	{#  **** Informative banners ****  #}
	{% if show_help or (show_component_help and not has_informative_banners) %}
		{% snipplet 'defaults/home/informative_banners_help.tpl' %}
	{% else %}
		{% include 'snipplets/banner-services/banner-services.tpl' %}
	{% endif %}

{% elseif section_select == 'categories' %}

	{#  **** Categories banners ****  #}
	{{ component('nubesdk-slot', { type: 'before_section_banner_categories' }) }}

	<section class="section-banners-home position-relative" data-store="home-banner-categories">
		{% if show_help or (show_component_help and not has_banners) %}
			{% snipplet 'defaults/home/category_banners_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-banners.tpl' with {'has_banner': true} %}
		{% endif %}
	</section>

	{{ component('nubesdk-slot', { type: 'after_section_banner_categories' }) }}

{% elseif section_select == 'new' %}

	{#  **** New products ****  #}
	{% if show_help or (show_component_help and not has_products) %}
		{% include 'snipplets/defaults/home/featured_products_help.tpl' with { products_title: 'Novedades'| translate, section_id: 'new' }  %}
	{% else %}
		{% include 'snipplets/home/home-featured-products.tpl' with {'has_new': true} %}
	{% endif %}

{% elseif section_select == 'video' %}

	{#  **** Video embed ****  #}

	 <section class="section-video-home" data-store="home-video">
		{% if show_help or (show_component_help and not has_video) %}
			{% snipplet 'defaults/home/video_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-video.tpl' %}
		{% endif %}
	</section>
	
{% elseif section_select == 'sale' %}

	{#  **** Sale products ****  #}
	{% if show_help or (show_component_help and not has_products) %}
		{% include 'snipplets/defaults/home/featured_products_help.tpl' with { products_title: 'Ofertas' | translate,  section_id: 'sale' }  %}
	{% else %}
		{% include 'snipplets/home/home-featured-products.tpl' with {'has_sale': true} %}
	{% endif %}

{% elseif section_select == 'main_product' %}

	{#  **** Main product ****  #}
	{% if show_help or (show_component_help and not has_products) %}
		{% snipplet 'defaults/home/main_product_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-main-product.tpl' %}
	{% endif %}

{% elseif section_select == 'newsletter' %}

	{#  **** Newsletter ****  #}
	{% include 'snipplets/home/home-newsletter.tpl' %}

{% elseif section_select == 'instafeed' %}

	{#  **** Instafeed ****  #}
	{% if show_help or (show_component_help and not has_instafeed) %}
		{% snipplet 'defaults/home/instafeed_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-instafeed.tpl' %}
	{% endif %}

{% elseif section_select == 'promotional' %}

	{#  **** Promotional banners ****  #}
	{{ component('nubesdk-slot', { type: 'before_section_banner_promotional' }) }}

	<section class="section-banners-home position-relative" data-store="home-banner-promotional">
		{% if show_help or (show_component_help and not has_promotional_banners) %}
			{% snipplet 'defaults/home/promotional_banners_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-banners.tpl' with {'has_banner_promotional': true} %}
		{% endif %}
	</section>

	{{ component('nubesdk-slot', { type: 'after_section_banner_promotional' }) }}

{% elseif section_select == 'news_banners' %}

	{#  **** News banners ****  #}
	{{ component('nubesdk-slot', { type: 'before_section_banner_news' }) }}

	<section class="section-banners-home position-relative" data-store="home-banner-news">
		{% if show_help or (show_component_help and not has_news_banners) %}
			{% snipplet 'defaults/home/news_banners_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-banners.tpl' with {'has_banner_news': true} %}
		{% endif %}
	</section>

	{{ component('nubesdk-slot', { type: 'after_section_banner_news' }) }}

{% elseif section_select == 'modules' %}

	{#  **** Modules ****  #}
	<section class="section-modules-home position-relative" data-store="home-image-text-module">
		{% if show_help or (show_component_help and not has_image_and_text_module) %}
			{% include 'snipplets/defaults/home/image_text_modules_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-banners.tpl' with {'has_module': true} %}
		{% endif %}
	</section>

{% elseif section_select == 'welcome' %}

	{#  **** Welcome message ****  #}
	{% if show_help or (show_component_help and not has_welcome_message) %}
		{% include 'snipplets/defaults/home/welcome_message_help.tpl' with { section: 'welcome', title: 'Mensaje de bienvenida' | translate, data_store: 'home-welcome-message' } %}
	{% else %}
		{% include 'snipplets/home/fgs-hero.tpl' %}
	{% endif %}

{% elseif section_select == 'institutional' %}

	{#  **** Institutional message ****  #}
	{% if show_help or (show_component_help and not has_institutional_message) %}
		{% include 'snipplets/defaults/home/welcome_message_help.tpl' with { section: 'institutional', title: 'Mensaje institucional' | translate, data_store: 'home-institutional-message' } %}
	{% else %}
		{% include 'snipplets/home/home-welcome-message.tpl' with {institutional: true} %}
	{% endif %}

{% elseif section_select == 'testimonials' %}

	{#  **** Testimonials slider ****  #}
	<section class="section-testimonials-home position-relative" data-store="home-testimonials">

		{{ component('nubesdk-slot', { type: 'before_section_testimonials' }) }}

		{% if show_help or (show_component_help and not has_testimonials) %}
			{% snipplet 'defaults/home/testimonials_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-testimonials.tpl' %}
		{% endif %}

		{{ component('nubesdk-slot', { type: 'after_section_testimonials' }) }}

	</section>

{% elseif section_select == 'brands' %}

	{#  **** Brands ****  #}
	<section class="section-brands-home" data-store="home-brands">
		{% if show_help or (show_component_help and not has_brands) %}
			{% snipplet 'defaults/home/brands_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-brands.tpl' %}
		{% endif %}
	</section>

{% endif %}
