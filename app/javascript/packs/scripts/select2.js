// import TomSelect from 'tom-select/dist/js/tom-select.popular'
// import Translations from './i18n/select.json'
//
// document.addEventListener("turbolinks:load", function() {
//     const i18n = Translations[document.querySelector('body').dataset.lang]
//
//     document.querySelectorAll('.js-multiple-select').forEach((element) => {
//         let opts = {
//             plugins: {
//                 'remove_button': {
//                     title: i18n['remove_button']
//                 },
//                 'no_backspace_delete': {},
//                 'restore_on_backspace': {}
//             },
//             valueField: 'id',
//             labelField: 'title',
//             searchField: 'title',
//             create: false,
//             load: function(query, callback) {
//                 const url = element.dataset.ajaxUrl + '.json?term=' + encodeURIComponent(query)
//
//                 fetch(url)
//                     .then(response => response.json())
//                     .then (json => {
//                         callback(json)
//                     }).catch(() => {
//                     callback()
//                 })
//             },
//             render: {
//                 no_results: function(_data, _escape){
//                     return '<div class="no-results">' + i18n['no_results'] + '</div>';
//                 }
//             }
//         }
//
//         new TomSelect(element, opts)
//     })
// })

import $ from 'jquery'
import 'select2/dist/js/select2'
import * as Select2Ru from 'select2/src/js/select2/i18n/ru'
import * as Select2En from 'select2/src/js/select2/i18n/en'

const select2_langs = {
    ru: Select2Ru,
    en: Select2En
}

$(document).on("turbolinks:before-cache", function() {
    $('.js-multiple-select').each(function () {
        $(this).select2('destroy');
    })
})


$(document).on("turbolinks:load", function() {
    $('.js-multiple-select').each(function () {
        const $this = $(this)

        let opts = {
            theme: 'bootstrap-5',
            width: $this.data("width") ? $this.data("width") : $this.hasClass("w-100") ? "100%" : "style",
            placeholder: $this.data("placeholder"),
            allowClear: Boolean($this.data("allow-clear")),
            language: select2_langs[$('body').data('lang')]
        }

        if($this.hasClass('js-ajax-select')) {
            const ajax_opts = {
                ajax: {
                    url: $this.data('ajax-url'),
                    data: function (params) {
                        return {
                            term: params.term
                        }
                    },
                    dataType: 'json',
                    delay: 1000,
                    processResults: function (data, params) {
                        const arr = $.map(data, function(value, index){
                            return {
                                id: value.id,
                                text: value.title
                            }
                        })
                        return {
                            results: arr
                        }
                    },
                    cache: true
                },
                minimumInputLength: 2
            }

            opts = Object.assign(opts, ajax_opts)
        }

        $this.select2(opts)
    })
})