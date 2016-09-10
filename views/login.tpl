%rebase layout title = "Login"
<div class="site-wrapper">
  <div id="parent">
    <form class="form-horizontal login_form" data-toggle="validator" role="form" action="login" method="post" name="login" autocomplete="off">
          <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">Username</label>
            <div class="col-sm-10">
              <input name="username" class="form-control" id="inputEmail3" placeholder="Email" required
              data-error="Field is required">
              <div class="help-block with-errors"></div>
            </div>
          </div>
          <div class="form-group">
            <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
            <div class="col-sm-10">
              <input type="password" name="password" data-minlength="4" class="form-control" id="inputPassword3" placeholder="Password" required
              data-error="Field is required. Minimum 4 symbols length">
             <div class="help-block with-errors"></div>
            </div>
          </div>
          <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
              <button type="submit" class="btn btn-default">Sign in</button>
            </div>
          </div>
    </form>
  </div>
</div>







