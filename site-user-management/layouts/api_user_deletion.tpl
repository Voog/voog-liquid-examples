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
        text-align: center;
      }

      table {
        table-layout: fixed;
        border-collapse: collapse;
        width: 50%;
      }

      .userList {
        padding-top: 16px;
      }

      .searchForUser {
        padding-top: 32px;
      }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  </head>

  <body class="content-page{% if editmode or site.has_many_languages? %} lang-enabled{% endif %} {% if flags_state %}flags-enabled{% else %}flags-disabled{% endif %}">

    <div class="container">
      {% include "header" %}
      <section class="content-header content-formatted cfx" data-search-indexing-allowed="true"></section>
      <main class="content" role="main">
        
        <div class="addUser">
          <label for="email">
            {% if editor_locale == 'et'%}Soovid lisada e-posti aadressi?:{% else %}Add an e-mail address:{% endif %}
          </label>

          <input 
            type="email" 
            id="emailToBeAdded" 
            name="email" 
            placeholder="kasutaja@email.com"
          >

          <input 
            type="submit" 
            value="{% if page.language_code == 'et'%}Lisa{% else %}Add{% endif %}" 
            id="addUser"
          ><br>

        </div>

        <div class="searchForUser">
          <label for="search">
            {% if editor_locale == 'et'%}Soovid otsida kasutajat?:{% else %}Search for an e-mail:{% endif %}
          </label>
          <input 
            id="search" 
            type="text" 
            placeholder="{% if editor_locale == 'et' %}Sisesta e-posti aadress{% else %}Insert an e-mail{% endif %}"
          />
        </div>
        <div class="userList"></div>
      </main>
      {% include "footer" %}
    </div>


    <script>
      const language = document.getElementsByTagName('html')[0].getAttribute('lang');

      let emailTable = 'E-posti aadress'
      let addButton = 'Lisa'
      let deleteUser = 'Kustuta kasutaja'
      let deleteButton = 'Kustuta'
      let confirmText = 'Oled sa kindel, et soovid seda kasutajat kustutada?'
      let userDeleted = 'Kasutaja kustutatud!'
      let userExists = 'Kasutaja on juba olemas!'
      let userAdded = 'Kasutaja lisatud!'
      if (language == 'en') {
          emailTable = 'E-mail address'
          addButton = 'Add'
          deleteUser = 'Delete user'
          deleteButton = 'Delete'
          confirmText = 'Are you sure you want to delete this account?'
          userDeleted = 'User deleted!'
          userExists = 'User already exists!'
          userAdded = 'User added!'
      }

      /* Tabeli filtreerimine ja otsing */
      $(document).ready(function () {
        $("#search").on("keyup", function () {

          let value = $(this).val().toLowerCase();

          $("#userTable tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
          });
        });
      });

      /* Lisab kõik kasutajad pärast GET-requesti tabelisse */
      function getUsers() {
        $.ajax({
          type: 'GET',
          contentType: 'application/json',
          url: '/admin/api/site_users',
          dataType: 'json'
        }).then(function (users) {
          let list_html = "<table><thead><tr><th>" + emailTable + 
          "</th><th>" + deleteUser + 
          "</th></thead>";

          users.forEach((user) => {
            list_html += "<tbody id='userTable'><tr><td>" + user.email +
              "</td><td><button class='delete' data-id=" + user.id + 
              ">" + deleteButton + 
              "</button></td></tr>";
          });

          list_html += "</tbody></table>"
          $(".userList").html(list_html);
        });
      }
      getUsers();

      /* Kustutab kasutaja ja uuendab tabelit */
      $(document).on('click', '.delete', function (e) {

        let entry = $(this).parent().parent(); // Vali tabeli rida

        let id = $(this)[0].attributes['data-id'].value; // User ID delete nupust

        if (confirm(confirmText)) {
          $.ajax({
            type: 'DELETE',
            contentType: 'application/json',
            url: '/admin/api/site_users/' + id,
            dataType: 'json'
          }).then(function () {
            entry.remove();
            alert(userDeleted)
          });
        }
      });

      /* Lisab kasutaja ja uuendab tabelit */
      $(document).on('click', "#addUser", function (e) {

        let emailAddress = $("#emailToBeAdded")[0].value;

        $.ajax({
          type: 'POST',
          contentType: 'application/json',
          url: '/admin/api/site_users',
          dataType: 'json',
          data: "{\"email\" : \"" + emailAddress + "\"}",
          error: function (jqXHR) {
            if (jqXHR.status === 422) {
              alert(userExists)
            }
          }
        }).then(function () {
          alert(userAdded)
          getUsers();
        });
      })
    </script>
  </body>

  </html>
{% else %}
  <meta http-equiv="refresh" content="0; url=/" />
{% endif %}