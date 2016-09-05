% for item in files:
        <div class='video_file'>
            %if item.endswith('.mp4'):
            <video controls>
                <source src="/play/{{item}}" type="video/mp4">
                Your browser does not support the video tag.
            </video>
            %end
            <div class="video_controls">
                <p><strong>{{item}}<strong></p>
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