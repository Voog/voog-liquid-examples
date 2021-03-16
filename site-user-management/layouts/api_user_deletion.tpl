{% if editmode %}
  <!DOCTYPE html>
  <html class="editmode" lang="{{ page.language_code }}">
    <head prefix="og: http://ogp.me/ns#">
      <style>
        .content {
          font-size: 16px;
          font-family: sans-serif;
        }

        a {
          color: #443df6;
        }

        h1 {
          margin: 0;
          padding: 16px 0 0 16px;
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

        .text-center {
          text-align: center;
        }

        #home-button, 
        .user-list, 
        .search-user,
        .add-user {
          padding: 16px;
        }

        .user-pagination {
          padding-left: 16px;
        }

        .user-pagination button:not(:first-child) {
          margin-left: 8px;
        }
      </style>

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

      {% if editor_locale == 'et' %}
        {% assign str_add_email = "Lisa e-posti aadress: " %}
        {% assign str_add = "Lisa" %}
        {% assign str_search_email = "Otsi kasutajat sel lehel: " %}
        {% assign str_insert_email = "Sisesta e-posti aadress" %}
        {% assign str_home = " ← Mine tagasi esilehele" %}
        {% assign language = 'et' %}
        {% assign str_title = "Parooliga kaitstud lehtede kasutajate haldamine" %}
      {% else %}
        {% assign str_add_email = "Add an e-mail address: " %}
        {% assign str_add = "Add" %}
        {% assign str_search_email = "Search for an e-mail on this page: " %}
        {% assign str_insert_email = "Insert an e-mail" %}
        {% assign str_home = " ← Go back to front page" %}
        {% assign language = 'en' %}
        {% assign str_title = "Manage users of password-protected pages" %}
      {% endif %}

      <title>{{str_title}}</title>

    </head>

    <body class="content">

      <a href="/" id="home-button">{{ str_home | escape_once }}</a>

      <h1>{{ str_title }}</h1>

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

          <div class="user-pagination"></div>
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
            somethingWentWrong: "Midagi läks valesti, proovi uuesti!",
            userActivated: "Aktiveeritud",
            str_page: "Leht"
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
            somethingWentWrong: "Something went wrong, try again!",
            userActivated: "Activated",
            str_page: "Page"
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
                getUsers(1).then((obj) => { buildTable(obj.users);});
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

        const getUsers = (pageNumber) => new Promise((resolve, reject) => {
          $.ajax({
              type: 'GET',
              contentType: 'application/json',
              url: `/admin/api/site_users?s=site_user.email&per_page=250&page=${pageNumber}`,
              dataType: 'json',
            })
            .then((users, status, xhr) => {
              const nPages = parseInt(xhr.getResponseHeader('X-Total-Pages'));
              const obj = {users: users, pages: nPages}
              buildTable(users);
              resolve(obj);
            })
            .catch(xhr => {
              alert(tr('somethingWentWrong'));
              reject();
            });
        });

        const buildTable = users => {
          let list_html = `<table id='user-table-table'>
                      <thead>
                        <tr>
                          <th>${tr('emailAddress')}</th>
                          <th>${tr('deleteUser')}</th>
                          <th>${tr('userActivated')}</th>
                        </tr>
                      </thead>
                        <tbody id='user-table'>`;

          users.forEach((user) => {
            list_html += `<tr>
                            <td>${user.email}</td>
                            <td class='text-center'>
                              <button class='delete' data-id='${user.id}'>
                                ${translatedDeleteButton}
                              </button>
                            </td>
                            <td class='text-center'>
                              ${user.status === 'active' ? '\u2713' : '\u2717'}
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

          getUsers(1).then((obj) => {
            const num = obj.pages;
            let container = $('<div />')
            for (let i = 1; i <= num; i++) {
              container.append(`<button class='pagination-button' onclick="getUsers(${i})">${tr('str_page')} ${i}</button>`);
            }
            $('.user-pagination').html(container);
          });
          
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
