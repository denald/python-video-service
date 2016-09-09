%rebase layout title='Index'

    <div class="page-header">
        <%
            username = user.username
            role = user.role
        %>
        <div id="user_info">
            <span>
                <strong>username:</strong> {{username}}
            </span>
            <span>
                <strong>role:</strong> {{role}}
            </span>
        </div>
        <div class="header_controls">
            <div id="upload_form">
                <form action="/upload" method="post" enctype="multipart/form-data">
                    <div id="upload_file_controls">
                        <input type="file" name="data" class="filestyle" data-icon="false">
                        <button type="submit" class="btn btn-default">Upload</button>
                    </div>
                </form>
            </div>
            <div class='logout'>
               <a class="btn btn-default" role="button" href="/logout">Logout</a>
            </div>
        </div>
    </div>

    %if defined('message') and message:
        <div class="message">{{message}}</div>
    %else:

    %include('content.tpl')

    %include('modal.tpl')

