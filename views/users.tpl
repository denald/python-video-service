%rebase layout title='Users'
%include('navbar.tpl')

<div class="container">
    <div id="add_user">
    <form class="form-horizontal" action="/user/add" method="post" name="add_user" autocomplete="off">
          <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">Username</label>
            <div class="col-sm-10">
              <input name="username" class="form-control" id="inputEmail3" placeholder="Username">
            </div>
          </div>
          <div class="form-group">
            <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
            <div class="col-sm-10">
              <input type="password" name="password" class="form-control" id="inputPassword3" placeholder="Password">
            </div>
          </div>
          <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
            <div class="col-sm-10">
              <input type="email" name="email" class="form-control" id="inputPassword3" placeholder="Email">
            </div>
          </div>
          <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
              <button type="submit" class="btn btn-default">Add</button>
            </div>
          </div>
    </form>
  </div>

    <table class="table table-hover">
        <thead>
            <tr>
                <th>#</th>
                <th>First Name</th>
                <th>Role</th>
                <th>Email</th>
                <th>Description</th>
                </tr>
        </thead>
        <tbody>
            % for index, user in enumerate(users, 1):
            <tr>
                <th scope="row">{{index}}</th>
                <td>{{user[0]}}</td>
                <td>{{user[1]}}</td>
                <td>{{user[2]}}</td>
                <td>{{user[3]}}</td>
            </tr>
            %end
        </tbody>
    </table>
</div>

