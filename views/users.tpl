%rebase layout title='Users'
%include('navbar.tpl')

<div class="container">
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