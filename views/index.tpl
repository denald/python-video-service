%rebase layout title='Index'

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
            <li><a href="/manage">Manage</a></li>
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

    <div class="container">
    <div class="row">
        <div class="upload_controls">
             <div id="upload_form" class="col-md-10 pull-right">
                  <form action="/upload" method="post" enctype="multipart/form-data">
                         <div id="upload_file_controls" class="col-md-8">
                             <input type="file" name="data" class="filestyle" data-icon="false">
                         </div>
                         <div id='upload_submit' class="col-md-4">
                             <button type="submit" class="btn btn-default">Upload</button>
                         </div>
                  </form>
              </div>
        </div>
    </div>
        % for item in files:
        <div class='video_file'>
            %if item.endswith('.mp4'):
            <video controls>
                <source src="/play/{{item}}" type="video/mp4">
                Your browser does not support the video tag.
            </video>
            %end
            <div class="video_controls">
                <p>
                    <strong>{{item}}</strong>
                </p>
                <form action="/download/{{item}}" method="get">
                        <input type="hidden" name="download" value="True" />
                        <button type="submit" class="btn btn-primary" id="download_btn">Download</button>
                </form>

                %if admin:
                <button class="btn btn-warning" data-href="/delete/{{item}}"
                                                data-toggle="modal" data-target="#confirm-delete">
                    Delete
                </button>
                %end

                %if not item.endswith('.mp4'):
                <form action="/convert/{{item}}" method="get">
                        <button type="submit" class="btn btn-danger" name="convert" id="convert_btn"
                         data-toggle="popover"
                         title="Conversion" data-content="This video is convering now">Convert to MP4</button>
                </form>
                %end
            </div>
        </div>
    % end
    </div>
</div>


<!-- Delete modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Confirm Delete</h4>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-danger btn-ok">Delete</a>
                </div>
            </div>
        </div>
</div>

