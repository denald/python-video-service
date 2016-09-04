<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Bootstrap 101 Template</title>

    <!-- Bootstrap -->
   <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="static/custom.css">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    % for item in files:
        <div class='video_file'>
            %if item.endswith('.mp4'):
            <video controls>
                <source src="/play/{{item}}" type="video/mp4">
                Your browser does not support the video tag.
            </video>
            %end
            <div class="video_controls">
                <p><strong>{{item}}</strong></p>
                <form action="/download/{{item}}" method="get">
                        <input type="hidden" name="download" value="True" />
                        <input type="submit" class="btn btn-primary" value="Download" name="download" id="download_btn" />
                </form>

                <form action="/delete/{{item}}" method="get">
                        <input type="submit" class="btn btn-warning" value="Remove" name="delete" id="delete_btn" />
                </form>

                %if not item.endswith('.mp4'):
                <form action="/convert/{{item}}" method="get">
                        <button type="submit" class="btn btn-danger" name="convert" id="convert_btn"
                         data-toggle="popover"
                         title="Conversion" data-content="This video is convering now">Convert to MP4</button>
                </form>
                %end
            </div>
        </div>
        <hr>
    % end
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  <script src="static/app.js"></script>
  </body>
</html>
