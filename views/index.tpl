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
        <div class='logout'>
            <a class="btn btn-default" role="button" href="/logout">Logout</a>
        </div>
    </div>

    %if defined('message') and message:
        <div class="message">{{message}}</div>
    %else:

    <div id="upload_form">
        <form action="/upload" method="post" enctype="multipart/form-data">
            <input type="file" name="data" />
            <button type="submit">Upload</button>
        </form>
    </div>

    %include('content.tpl')

    %include('modal.tpl')

