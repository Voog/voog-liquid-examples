{% if editmode %}
  <!DOCTYPE html>
  {% include "template-variables" %}
  <html class="{% if editmode %}editmode{% else %}public{% endif %}" lang="{{ page.language_code }}">

  <head prefix="og: http://ogp.me/ns#">
    {% include "html-head" %}
    <style>
      .container .content {
        font-size: 16px;
      }

      td,
      th {
        border: 1px solid #dddddd;
        padding: 8px;
        text-align: left;
      }

      table {
        table-layout: fixed;
        border-collapse: collapse;
      }

      .user-list {
        padding-top: 16px;
      }

      .search-user {
        padding-top: 32px;
      }
    </style>

    {% if editmode or site.has_many_languages? %}
    {% assign lang-enabled = "lang-enabled" %}
    {% endif %}

    {% if flags_state %}
    {% assign flags="flags-enabled" %}
    {% else %}
    {% assign flags="flags-disabled" %}
    {% endif %}

    {% if editor_locale == 'et' %}
    {% assign str_add_email = "Soovid lisada e-posti aadressi? " %}
    {% assign str_add = "Lisa" %}
    {% assign str_search_email = "Soovid otsida kasutajat? " %}
    {% assign str_insert_email = "Sisesta e-posti aadress" %}
    {% else %}
    {% assign str_add_email = "Add an e-mail address: " %}
    {% assign str_add = "Add" %}
    {% assign str_search_email = "Search for an e-mail: " %}
    {% assign str_insert_email = "Insert an e-mail" %}
    {% endif %}

  </head>

  <body class="content-page {{ lang-enabled }} {{ flags }}">
    <div class="container">
      {% include "header" %}

      <section class="content-header content-formatted cfx"></section>

      <main class="content" role="main">

        <div class="add-user">
          <label for="email">{{ str_add_email }}</label>
          <input type="email" id="email-to-add" name="email" placeholder="email@email.com">

          <input type="submit" value="{{ str_add }}" id="add-user"><br>
        </div>


        <div class="search-user">
          <label for="search">{{ str_search_email }}</label>
          <input id="search" type="text" placeholder="{{ str_insert_email }}" />
        </div>

        <div class="user-list"></div>

      </main>
      {% include "footer" %}
    </div>

    {%- comment -%} Included component name can differ depending on template {%- endcomment -%}
    {% include "javascripts" %}

    <script>
      const translationStrings = {
        'et': {
          emailAddress: 'E-posti aadress',
          deleteUser: 'Kustuta kasutaja',
          deleteButton: 'Kustuta',
          confirmText: 'Oled sa kindel, et soovid seda kasutajat kustutada?',
          userDeleted: 'Kasutaja kustutatud!',
          userExists: 'Kasutaja on juba olemas!',
          userAdded: 'Kasutaja lisatud!',
          userNotInserted: "E-posti aadressi ei ole sisestatud!",
          notValidEmail: "Sisestatud e-posti aadress on ebasobiv!",
          somethingWentWrong: "Midagi läks valesti, proovi uuesti!"
        },
        'en': {
          emailAddress: 'E-mail address',
          deleteUser: 'Delete user',
          deleteButton: 'Delete',
          confirmText: 'Are you sure you want to delete this account?',
          userDeleted: 'User deleted!',
          userExists: 'User already exists!',
          userAdded: 'User added!',
          userNotInserted: "E-mail address is not inserted",
          notValidEmail: "The entered e-mail address is not valid!",
          somethingWentWrong: "Something went wrong, try again!"
        }
      }

      const language = document.getElementsByTagName('html')[0].getAttribute('lang');
      const tr = key => (translationStrings[language] || {})[key];

      const translatedDeleteButton = tr('deleteButton');

      const searchTable = (e) => {
        const target = (e.target) ? e.target : e.srcElement;
        const value = target.value.toLowerCase();
        $('#user-table tr').each(function () {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
      }

      const addUser = () => {
        const emailAddressToAdd = $('#email-to-add')[0].value;
        const regexp = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/;

        if (emailAddressToAdd.match(regexp)) {
          $.ajax({
              type: 'POST',
              contentType: 'application/json',
              url: '/admin/api/site_users',
              dataType: 'json',
              data: `{\"email\" : \"${emailAddressToAdd}\"}`,
            })
            .then(function () {
              alert(tr('userAdded'))
              getUsers().then(buildTable);
            })
            .catch(function (xhr) {
              if (xhr.responseJSON.errors.email[0] === "has already been taken") {
                alert(tr('userExists'));
              }
            });
        } else if (emailAddressToAdd === '') {
          alert(tr('userNotInserted'));
        } else {
          alert(tr('notValidEmail'));
        }
      }

      const getUsers = () => new Promise((resolve, reject) => {
        $.ajax({
            type: 'GET',
            contentType: 'application/json',
            url: '/admin/api/site_users',
            dataType: 'json'
          })
          .then(users => {
            users.forEach((user) => {
              [].push(user)
            });
            resolve(users);
          })
          .catch(xhr => {
            alert(tr('somethingWentWrong'));
            reject();
          })
      });

      const buildTable = users => {
        let list_html = `<table>
                    <thead>
                      <tr>
                        <th>${tr('emailAddress')}</th>
                        <th>${tr('deleteUser')}</th>
                      </tr>
                    </thead>`;

        users.forEach((user) => {
          list_html += `<tbody id='user-table'>
                    <tr>
                      <td>
                        ${user.email}
                      </td>
                      <td>
                        <button class='delete' data-id='${user.id}'>
                          ${translatedDeleteButton}
                        </button>
                      </td>
                    </tr>`;
        });

        list_html += '</tbody></table>';
        $('.user-list').html(list_html);
      };

      getUsers().then(buildTable);

      const deleteUser = (e) => {
        const target = (e.target) ? e.target : e.srcElement;
        const id = $(target)[0].attributes['data-id'].value;

        if (confirm(tr('confirmText'))) {
          $.ajax({
            type: 'DELETE',
            contentType: 'application/json',
            url: `/admin/api/site_users/${id}`,
            dataType: 'json'
          }).then(function () {
            getUsers().then(buildTable);
            alert(tr('userDeleted'))
          }).catch(function () {
            alert(tr('somethingWentWrong'));
          });
        }
      }

      const init = () => $(document).ready(() => {
        $('#search').on('keyup', searchTable);
        $(document).on('click', '.delete', deleteUser);
        $(document).on('click', '#add-user', addUser);
      });

      init();
    </script>
  </body>

  </html>
{% else %}
  <meta http-equiv="refresh" content="0; url=/" />
{% endif %}
