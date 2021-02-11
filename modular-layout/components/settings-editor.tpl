<script>
  function initSettingsEditor(options = {}) {
    var entityData;

    if (options.entityData === 'siteData') {
      var entityData = new Edicy.CustomData({
        type: 'site'
      });;
    } else if (options.entityData === 'articleData') {
      var entityData = new Edicy.CustomData({
        type: 'article',
        id: '{{article.id}}'
      });
    } else {
      var entityData = new Edicy.CustomData({
        type: 'page',
        id: '{{page.id}}'
      });
    }

    var SettingsEditor = new Edicy.SettingsEditor(options.settingsBtn, {
      menuItems: options.menuItems,
      values: options.values || options.defaultValues,
      buttonTitleI18n: options.buttonTitleI18n,
      buttonActiveClass: 'active',
      containerClass: options.containerClass || 'editor_default',
      preview: function(data) {
        options.prevFunc && options.prevFunc(data);
      },
      commit: function(data) {
        entityData.set(options.dataKey, data, {
          success: function() {
            if (options.noReload !== true) {
              window.location.reload();
            }
          }
        });
      }
    });

    options.settingsBtn.removeAttribute('disabled');

    $('.edy-settings-editor').each(function() {
      if ($(this).find('.layout_settings-close').length <= 0) {
        $(this).prepend('<div class="layout_settings-close"></div>');
      }
    });

    $('.layout_settings-close').click(function() {
      $('body').trigger('click');
    });


    $('.js-settings-editor-btn').click(function() {
      if ($('.edy-settings-editor-inner-title').length >= 1) {
        $('.edy-settings-editor-inner-title').text($(this).find('.edy-cbtn-content .p14.bold').text())
      } else {
        $('.edy-settings-editor .edy-settings-editor-inner').prepend(
          '<h3 class="edy-settings-editor-inner-title" style="padding: 0 32px;margin-bottom: 0;">' + $(this).find('.edy-cbtn-content .p14.bold').text() + '</h3>'
        );
      }
    });
  }

  var debounce = function(func, wait, immediate) {
    var timeout;
    return function() {
      var context = this, args = arguments;
      var later = function() {
        timeout = null;
        if (!immediate) func.apply(context, args);
      };
      var callNow = immediate && !timeout;
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
      if (callNow) func.apply(context, args);
    };
  };

  window.addEventListener('DOMContentLoaded', function(event) {
    var shadowDom = document.querySelector(".edy-next-shadowdom").shadowRoot;
    var setSettingsBtn = setInterval(function() {
      if (shadowDom.querySelectorAll('div[class^="toolbar__"]').length) {
        var toolbarExpandBtn = shadowDom.querySelector('div[class^="toolbar-expand"]');
        var toolbar = shadowDom.querySelector('div[class^="toolbar__"]');
        var settingsBtn = document.querySelector(".js-layout_settings-btn");
        var toolbarItem = shadowDom.querySelector('div[class^="toolbar-content-item__"]');

        settingsBtn.className = toolbarItem.className + ' ' + settingsBtn.className;

        toolbar.insertBefore(settingsBtn, toolbarExpandBtn);

        shadowDom.querySelector(".js-layout_settings-btn").addEventListener(
          "click", function(e){
            document.querySelector('body').classList.toggle('layout_settings-visible');
            e.stopImmediatePropagation();
          }
        );

        var positionPopover = function() {
          var settingsPopover = $('.js-layout_settings-popover');
          var settingsPopoverArrow = $('.layout_settings-arrow');

          if ($( window ).width() > 768) {
            settingsPopover.css({right: window.innerWidth - settingsBtn.getBoundingClientRect().right - (settingsPopover.width() / 2)})
            settingsPopoverArrow.css({right: settingsPopover.width() / 2});
          } else {
            settingsPopover.css({right: 0});
            settingsPopoverArrow.css({right: 72});
          }
        }

        $(window).resize(debounce(function() {
          positionPopover();
        }, 25));

        positionPopover();
        clearInterval(setSettingsBtn);
      }
    }, 500);

    $('body').append($('.js-layout_settings-popover'));
  });
</script>
