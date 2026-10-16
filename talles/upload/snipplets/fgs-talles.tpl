{# FGS: muestra el rango de talles disponibles en cada tarjeta de producto #}
<style>
.fgs-talles{display:inline-block;margin-left:.6em;font-size:12px;letter-spacing:.02em;color:#6b6b69;white-space:nowrap;vertical-align:middle}
.fgs-talles-solo{display:block;margin:4px 0 0;font-size:12px}
</style>
<script>
(function () {
  var SOLO_DISPONIBLES = true;         // false = cuenta también talles agotados
  var MOSTRAR_SIN_COLORES = true;      // false = talles solo en productos con círculos
  var SIZE = /^(XXS|XS|S|M|L|XL|XXL|XXXL|\d{2}(\/\d{2})?)$/i;
  var ORDEN = ['XXS','XS','S','M','L','XL','XXL','XXXL'];
  function ord(t) { var i = ORDEN.indexOf(t.toUpperCase()); return i >= 0 ? i : 100 + parseFloat(t); }

  function talles(card) {
    var lista = [];
    var dv = card.matches('[data-variants]') ? card : card.querySelector('[data-variants]');
    if (dv) {
      try {
        JSON.parse(dv.getAttribute('data-variants')).forEach(function (v) {
          var hay = v.available !== false && (v.stock == null || v.stock > 0);
          [v.option0, v.option1, v.option2].forEach(function (o) {
            var t = String(o == null ? '' : o).trim();
            if (SIZE.test(t) && (hay || !SOLO_DISPONIBLES)) lista.push(t);
          });
        });
      } catch (e) {}
    }
    if (!lista.length) {
      card.querySelectorAll('option, label, button, a, span, li').forEach(function (el) {
        var t = el.textContent.trim();
        if (el.children.length || !SIZE.test(t)) return;
        var apagado = el.disabled || el.getAttribute('aria-disabled') === 'true' ||
          /disabled|unavailable|sold|nostock|no-stock/i.test(el.className) ||
          el.closest('[class*="disabled"],[class*="unavailable"]');
        if (!apagado || !SOLO_DISPONIBLES) lista.push(t);
      });
    }
    var vistos = {};
    return lista.filter(function (t) { return vistos[t] ? false : (vistos[t] = true); })
                .sort(function (a, b) { return ord(a) - ord(b); });
  }

  function procesar(card) {
    if (card.getAttribute('data-fgs')) return;
    var link = card.querySelector('.js-item-description > .item-link');
    if (!link) return;
    card.setAttribute('data-fgs', '1');
    var lista = talles(card);
    if (!lista.length) return;
    var texto = lista.length > 1 ? lista[0] + '–' + lista[lista.length - 1] : lista[0];

    var colores = link.querySelector('[class*="js-color-variant-available-"] .item-colors');
    if (colores && colores.querySelector('.item-colors-bullet')) {
      var s = document.createElement('span');
      s.className = 'fgs-talles'; s.textContent = texto;
      colores.appendChild(s);
    } else if (MOSTRAR_SIN_COLORES) {
      var d = document.createElement('div');
      d.className = 'fgs-talles fgs-talles-solo'; d.textContent = texto;
      d.style.marginLeft = '0';
      link.appendChild(d);
    }
  }

  function todo() { document.querySelectorAll('.js-item-product').forEach(procesar); }
  todo();
  var t;
  new MutationObserver(function () { clearTimeout(t); t = setTimeout(todo, 150); })
    .observe(document.body, { childList: true, subtree: true });
})();
</script>
