%rebase layout title='Index'

        <div class="page-header col-md-12">
        <%
            username = user.username
            role = user.role
        %>
        <div id="user_info " class="col-md-3 pull-left">
            <span>
                <strong>username:</strong> {{username}}
            </span>
            <span>
                <strong>role:</strong> {{role}}
            </span>
        </div>
        <div class="header_controls col-md-7 pull-right">
            <div id="upload_form" class="col-md-10">
                <form action="/upload" method="post" enctype="multipart/form-data">
                    <div class="">
                        <div id="upload_file_controls" class="col-md-10">
                            <input type="file" name="data" class="filestyle" data-icon="false">
                        </div>
                        <div id='upload_submit' class="col-md-2">
                            <button type="submit" class="btn btn-default">Upload</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="logout pull-right col-md-1">
                <a class="btn btn-default" role="button" href="/logout">Logout</a>
            </div>
        </div>

    %if defined('message') and message:
        <div class="message">{{message}}</div>
    %else:

    %include('content.tpl')

    %include('modal.tpl')

