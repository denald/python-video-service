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

    %include('content.tpl')

    %include('modal.tpl')