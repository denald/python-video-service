<div class="container-fluid">

  <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/index">Video service</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="/index">Home</a></li>
            %if admin:
            <li><a href="/users">Users</a></li>
            %end
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li class="user_info">
                <span>username: <strong>{{user.username}}</strong></span>
                <span>role: <strong>{{user.role}}</strong></span>
            </li>
            <li>
                <a href="/logout">Logout</a>
            </li>

          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    <!-- Nav finish-->