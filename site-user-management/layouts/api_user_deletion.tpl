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
      </style>

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

      {% if editor_locale == 'et' %}
        {% assign str_add_email = "Lisa e-posti aadress: " %}
        {% assign str_add = "Lisa" %}
        {% assign str_search_email = "Otsi kasutajat sel lehel: " %}
        {% assign str_home = " ← Mine tagasi esilehele" %}
        {% assign str_title = "Parooliga kaitstud lehtede kasutajate haldamine" %}
        {% assign str_email_address = "E-posti aadress" %}
        {% assign str_delete_button = "Kustuta" %}
        {% assign str_user_activated = "Aktiveeritud" %}
      {% else %}
        {% assign str_add_email = "Add an e-mail address: " %}
        {% assign str_add = "Add" %}
        {% assign str_search_email = "Search for an e-mail on this page: " %}
        {% assign str_home = " ← Go back to front page" %}
        {% assign str_title = "Manage users of password-protected pages" %}
        {% assign str_email_address = "E-mail address" %}
        {% assign str_delete_button = "Delete" %}
        {% assign str_user_activated = "Activated" %}
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
            <input id="search" type="text" placeholder="email@email.com" />
          </div>

          <div class="user-list">
            <table id='user-table'>
              <thead>
                <tr>
                  <th>{{str_email_address | escape_once}}</th>
                  <th>{{str_delete_button | escape_once}}</th>
                  <th>{{str_user_activated | escape_once}}</th>
                </tr>
              </thead>
              <tbody id='user-table-body'>
              </tbody>
            </table>
          </div>

      </div>

      <script>
        const translationStrings = {
          'et': {
            deleteUser: 'Kustuta kasutaja',
            confirmText: 'Oled sa kindel, et soovid seda kasutajat kustutada?',
            userDeleted: 'Kasutaja kustutatud!',
            userAdded: 'Kasutaja lisatud!',
            userNotInserted: "E-posti aadressi ei ole sisestatud!",
            notCorrectOrAlreadyExists: "E-posti aadress pole korrektne või on juba lisatud!",
            somethingWentWrong: "Midagi läks valesti, proovi uuesti!",
            deleteButton: "Kustuta"
          },
          'en': {
            deleteUser: 'Delete user',
            confirmText: 'Are you sure you want to delete this account?',
            userDeleted: 'User deleted!',
            userAdded: 'User added!',
            userNotInserted: "E-mail address is not inserted",
            notCorrectOrAlreadyExists: "The entered e-mail address is not valid or already exists!",
            somethingWentWrong: "Something went wrong, try again!",
            deleteButton: "Delete"
          }
        }

        const tr = key => (translationStrings['{{ editor_locale }}'] || translationStrings['en'])[key];
        const translatedDeleteButton = tr('deleteButton');

        const searchTable = (e) => {
          const target = e.target || e.srcElement;
          const value = target.value.toLowerCase();

          $('#user-table-body tr').each(function () {
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
                getAllUsers();
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

        const getAllUsers = () => {
          let promises = [];

          getUsersPage().then((usersPage) => {
            const nPages = usersPage.nPages;

            for (let i = 2; i <= nPages; i++) {
              promises.push(getUsersPage(i));
            }
            
            addToTable(usersPage.users, {init: true});

            Promise.all(promises).then((results) => {
              results.forEach((usersPage, idx) => addToTable(usersPage.users));
            });
          })
        }
        
        const getUsersPage = (pageNumber = 1) => new Promise((resolve, reject) => {
          $.ajax({
              type: 'GET',
              contentType: 'application/json',
              url: `/admin/api/site_users?s=site_user.email&per_page=250&page=${pageNumber}`,
              dataType: 'json',
            })
            .then((users, status, xhr) => {
              const nPages = parseInt(xhr.getResponseHeader('X-Total-Pages'));

              resolve({users, nPages});          
            })
            .catch(xhr => {
              alert(tr('somethingWentWrong'));
              reject();
            });
        });

        const addToTable = (users, {init = false} = {}) => {

          if (init) {
            $('#user-table-body').empty();
          }

          users.forEach((user) => {
            $('#user-table-body').append(`<tr>
                            <td>${user.email}</td>
                            <td class='text-center'>
                              <button class='delete' data-id='${user.id}'>
                                ${translatedDeleteButton}
                              </button>
                            </td>
                            <td class='text-center'>
                              ${user.status === 'active' ? '\u2713' : '\u2717'}
                            </td>
                          </tr>`);
          });
        }

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
          getAllUsers();
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
