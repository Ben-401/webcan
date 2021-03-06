<%inherit file="layout.mako"/>
<div class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    My Devices
                    <form class="form-inline mr-auto" id="new-device">
                        <input class="form-control col-md-2 mr-sm-2" name="dev_name" placeholder="New Device"/>
                        <input class="form-control col-md-2 mr-sm-2" name="dev_make" placeholder="Make"/>
                        <input class="form-control col-md-2 mr-sm-2" name="dev_model" placeholder="Model"/>
                        <input class="form-control col-md-2 mr-sm-2" name="dev_type" placeholder="Type"/>
                        <button type="button" id="submit" class="btn btn-primary">Add</button>
                    </form>
                </div>
                <%
                    fields = ['name', 'secret', 'make', 'model', 'type']
                %>
                <table class="table">
                    <thead>
                    <tr>
                        % for f in fields:
                            <th>${f.title()}</th>
                        % endfor
                    </tr>
                    </thead>
                    <tbody>
                        %for i in devices:

                            <tr>
                                <td><a href="/dev/${i[fields[0]]}">${i[fields[0]]}</a></td>
                                <td>
                                    <div class="input-group">
                                        <!-- Target -->
                                        <%
                                            i[fields[0]] = i[fields[0]].replace(' ','-')
                                        %>
                                        <input class='form-control' id="key-${i[fields[0]]}" value="${i[fields[1]]}">

                                        <!-- Trigger -->
                                        <span class="input-group-btn">
                                            <button class="btn btn-sm btn-primary btn-clipboard"
                                                    data-clipboard-target="#key-${i[fields[0]]}">
                                                <i class="fa fa-clipboard fa-1" aria-hidden="true"></i>
                                            </button>
                                        </span>
                                    </div>
                                </td>

                                %for f in fields[2:]:
                                    <td>
                                        %if f in i:
                                        ${i[f]}
                                        %endif
                                    </td>
                                %endfor
                            </tr>
                        %endfor
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="//cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.7.1/clipboard.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('input').on('change', function () {

        });
        $('#submit').click(function () {
            $.post('/dev_add', $('#new-device').serialize())
                    .done(function (data, status, jqxhr) {
                        console.log(data);
                    }).fail(function (jqxhr, status, err) {
                console.log(jqxhr, status, err);
            })
        });
        var clipboard = new Clipboard('.btn-clipboard');
        $('.btn-clipboard').tooltip({
            trigger: 'click',
            placement: 'top'
        });

        function setTooltip(message, btn) {
            btn.tooltip('hide')
                    .attr('data-original-title', message)
                    .tooltip('show');
        }

        function hideTooltip() {
            setTimeout(function () {
                $('.btn-clipboard').tooltip('hide');
            }, 1000);
        }

        clipboard.on('success', function (e) {
            setTooltip('Copied!', $(e.trigger));
            hideTooltip();
        });

        clipboard.on('error', function (e) {
            setTooltip('Failed!', $(e.trigger));
            hideTooltip();
        });


    });
</script>