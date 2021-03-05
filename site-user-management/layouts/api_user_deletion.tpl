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

      tr {
        height: 100%;
      }

      td,
      th {
        border: 1px solid #dddddd;
        padding: 8px;
        text-align: center;
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

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


    <script>
      // Translations for the JS part
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

      let language = document.getElementsByTagName('html')[0].getAttribute('lang');
      let tr = key => (translationStrings[language] || {})[key];

      const translatedEmailAddress = tr('emailAddress');
      const translatedDeleteUser = tr('deleteUser');
      const translatedDeleteButton = tr('deleteButton');
      const translatedConfirmText = tr('confirmText');
      const translatedUserDeleted = tr('userDeleted');
      const translatedUserExists = tr('userExists');
      const translatedUserAdded = tr('userAdded');
      const translatedUserNotInserted = tr('userNotInserted');
      const translatedNotValidEmail = tr('notValidEmail');
      const translatedSomethingWentWrong = tr('somethingWentWrong');

      let allUsers = [];

      /* Filter the table during searching */
      $(document).ready(function () {
          $('#search').on('keyup', function () {

              const value = $(this).val().toLowerCase();

              $('#user-table tr').each(function () {
                  $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
              });
          });
      });

      /* Add all the users to the table based on a GET-request */
      function getUsers() {
          $.ajax({
              type: 'GET',
              contentType: 'application/json',
              url: '/admin/api/site_users',
              dataType: 'json'
          }).then(function (users) {

              // Make a table

              let list_html = `<table>
                    <thead>
                      <tr>
                        <th>${translatedEmailAddress}</th>
                        <th>${translatedDeleteUser}</th>
                      </tr>
                    </thead>`;

              // Add each user to the table

              users.forEach((user) => {
                  list_html += `<tbody id='user-table'>
                        <tr>
                          <td>${user.email}</td>
                          <td>
                            <button class='delete' data-id='${user.id}'>${translatedDeleteButton}</button>
                          </td>
                        </tr>`;
                  allUsers.push(user.email);
              })

              list_html += '</tbody></table>';
              $('.user-list').html(list_html);
          }).catch(function () {
              alert(translatedSomethingWentWrong);
          });;
      }

      getUsers();

      /* Delete the user and renew the table */
      $(document).on('click', '.delete', function (e) {

          let entry = $(this).parent().parent(); // Choose the row of the table

          let id = $(this)[0].attributes['data-id'].value; // Get the User ID from the delete button

          if (confirm(translatedConfirmText)) {
              $.ajax({
                  type: 'DELETE',
                  contentType: 'application/json',
                  url: '/admin/api/site_users/' + id,
                  dataType: 'json'
              }).then(function () {
                  entry.remove();
                  alert(translatedUserDeleted)
              }).catch(function () {
                  alert(translatedSomethingWentWrong);
              });
          }
      });

      /* Add an user and renew the table */
      $(document).on('click', "#add-user", function (e) {

          let emailAddressToAdd = $('#email-to-add')[0].value; // Get the email from the input
          const regexp = /^([\w\d._\-#])+@([\w\d._\-#]+[.][\w\d._\-#]+)+$/; // Validate e-mail address

          if (emailAddressToAdd === '') {
              alert(translatedUserNotInserted);
          } else if (emailAddressToAdd.match(regexp)) {
              $.ajax({
                  type: 'POST',
                  contentType: 'application/json',
                  url: '/admin/api/site_users',
                  dataType: 'json',
                  data: `{\"email\" : \"${emailAddressToAdd}\"}`,
              }).then(function () {
                  alert(translatedUserAdded)
                  getUsers();
              }).catch(function (jqXHR) {
                  if (jqXHR.status === 422) {
                      getUsers();
                      if (allUsers.includes(emailAddressToAdd)) {
                          alert(translatedUserExists);
                      }
                  } else {
                      alert(translatedSomethingWentWrong);
                  }
              });
          } else {
              alert(translatedNotValidEmail);
          }
      })
    </script>

    {% include "javascripts" %}

  </body>

  </html>
{% else %}
  <meta http-equiv="refresh" content="0; url=/" />
{% endif %}
