{% if editmode %}
  <!DOCTYPE html>
  <html class="editmode" lang="{{ page.language_code }}">
    <head prefix="og: http://ogp.me/ns#">
      <style>
        .content {
          font-size: 16px;
          font-family: sans-serif;
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

        #home-button, 
        .user-list, 
        .search-user,
        .add-user {
          padding: 16px;
        }
      </style>

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

      {% if editor_locale == 'et' %}
        {% assign str_add_email = "Soovid lisada e-posti aadressi? " %}
        {% assign str_add = "Lisa" %}
        {% assign str_search_email = "Soovid otsida kasutajat? " %}
        {% assign str_insert_email = "Sisesta e-posti aadress" %}
        {% assign str_home = "Mine tagasi esilehele" %}
        {% assign language = 'et' %}
        {% assign str_title = "Parooliga kaitstud lehtede kasutajate kustutamine üle API" %}
      {% else %}
        {% assign str_add_email = "Add an e-mail address: " %}
        {% assign str_add = "Add" %}
        {% assign str_search_email = "Search for an e-mail: " %}
        {% assign str_insert_email = "Insert an e-mail" %}
        {% assign str_home = "Go back to front page" %}
        {% assign language = 'en' %}
        {% assign str_title = "Deleting users of password-protected pages over API" %}
      {% endif %}

    </head>

    <title>{{str_title}}</title>

    <body class="content">

      <a href="/" id="home-button">{{ str_home | escape_once }}</a>

      <div class="container">

          <div class="add-user">
            <label for="email">{{ str_add_email | escape_once }}</label>
            <input 
              type="email" 
              id="email-to-add" 
              name="email" 
              placeholder="email@email.com" 
              required
            >

            <input type="submit" value="{{ str_add | escape_once }}" id="add-user"><br>
          </div>


          <div class="search-user">
            <label for="search">{{ str_search_email | escape_once }}</label>
            <input id="search" type="text" placeholder="{{ str_insert_email | escape_once }}" />
          </div>

          <div class="user-list"></div>

      </div>

      <script>
        const translationStrings = {
          'et': {
            emailAddress: 'E-posti aadress',
            deleteUser: 'Kustuta kasutaja',
            deleteButton: 'Kustuta',
            confirmText: 'Oled sa kindel, et soovid seda kasutajat kustutada?',
            userDeleted: 'Kasutaja kustutatud!',
            userAdded: 'Kasutaja lisatud!',
            userNotInserted: "E-posti aadressi ei ole sisestatud!",
            notCorrectOrAlreadyExists: "E-posti aadress pole korrektne või on juba lisatud!",
            somethingWentWrong: "Midagi läks valesti, proovi uuesti!"
          },
          'en': {
            emailAddress: 'E-mail address',
            deleteUser: 'Delete user',
            deleteButton: 'Delete',
            confirmText: 'Are you sure you want to delete this account?',
            userDeleted: 'User deleted!',
            userAdded: 'User added!',
            userNotInserted: "E-mail address is not inserted",
            notCorrectOrAlreadyExists: "The entered e-mail address is not valid or already exists!",
            somethingWentWrong: "Something went wrong, try again!"
          }
        }

        const tr = key => (translationStrings['{{ language | escape_once }}'] || translationStrings['en'])[key];

        const translatedDeleteButton = tr('deleteButton');

        const searchTable = (e) => {
          const target = e.target || e.srcElement;
          const value = target.value.toLowerCase();
          $('#user-table tr').each(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
          });
        }

        const addUser = () => {
          const emailAddressToAdd = $('#email-to-add')[0].value;
          const regexp = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i;

          if (emailAddressToAdd === '') {
            alert(tr('userNotInserted'));
          } else if (emailAddressToAdd.match(regexp)) {
            $.ajax({
                type: 'POST',
                contentType: 'application/json',
                url: '/admin/api/site_users',
                dataType: 'json',
                data: JSON.stringify({email: emailAddressToAdd}),
              })
              .then(function () {
                alert(tr('userAdded'))
                getUsers().then(buildTable);
              })
              .catch(function (xhr) {
                if (typeof xhr.responseJSON.errors.email !== 'undefined') {
                  alert(tr('notCorrectOrAlreadyExists'));
                }
              });
          } else {
            alert(tr('notCorrectOrAlreadyExists'));
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
                      </thead>
                        <tbody id='user-table'>`;

          users.forEach((user) => {
            list_html += `<tr>
                            <td>${user.email}</td>
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

        const deleteUser = (e) => {
          const target = e.target || e.srcElement;
          const entry = target.closest('tr');
          const id = $(target)[0].attributes['data-id'].value;

          if (confirm(tr('confirmText'))) {
            $.ajax({
              type: 'DELETE',
              contentType: 'application/json',
              url: `/admin/api/site_users/${id}`,
              dataType: 'json'
            }).then(function () {
              entry.remove();
              alert(tr('userDeleted'))
            }).catch(function () {
              alert(tr('somethingWentWrong'));
            });
          }
        }

        const init = () => $(document).ready(() => {
          getUsers().then(buildTable);
          $('#search').on('keyup', searchTable);
          $(document).on('click', '.delete', deleteUser);
          $(document).on('click', '#add-user', addUser);
        });

        init();
      </script>
    </body>

  </html>
{% else %}
  <!DOCTYPE html>
  <head>
    <title>Redirect</title>
    <meta http-equiv="refresh" content="0; url=/" />
  </head>
{% endif %}
