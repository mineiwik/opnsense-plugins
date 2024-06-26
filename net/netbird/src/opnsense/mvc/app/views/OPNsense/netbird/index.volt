
<script>
    function refreshConStatus() {
                  $("#refreshAct_progress").addClass("fa fa-spinner fa-pulse");
                  ajaxCall(url="/api/netbird/service/constatus", sendData={},callback=function(data,status) {
                      $("#constatus").html(data.responseText);
                      $("#refreshAct_progress").removeClass("fa fa-spinner fa-pulse");
                });
    }

    $( document ).ready(function() {

        $("#refreshAct").click(function(){
            refreshConStatus();
        });

        $("#saveAct").click(function(){
        $("#saveAct_progress").addClass("fa fa-spinner fa-pulse");
            saveFormToEndpoint(url="/api/netbird/settings/set",formid='frm_GeneralSettings',callback_ok=function(){
                ajaxCall(url="/api/netbird/service/reload", sendData={},callback=function(data,status) {
                     updateServiceControlUI('netbird');
                     $("#saveAct_progress").removeClass("fa fa-spinner fa-pulse");
                });
            });
        });


        var data_get_map = {'frm_GeneralSettings':"/api/netbird/settings/get"};
        mapDataToFormUI(data_get_map).done(function(data){
            updateServiceControlUI('netbird');
            $('.selectpicker').selectpicker('refresh');
        });
    refreshConStatus();

    });
</script>

<div class="alert alert-info hidden" role="alert" id="responseMsg">

</div>

<div  class="col-md-12">
    {{ partial("layout_partials/base_form",['fields':generalForm,'id':'frm_GeneralSettings'])}}
</div>
<div>
    <h2>{{ lang._('Connection Status') }}</h2>
    <section id="constatus" class="col-xs-11">
    </section>
</div>


<div class="col-md-12">
    <button class="btn btn-primary"  id="saveAct" type="button"><b>{{ lang._('Save') }}</b><i id="saveAct_progress"></i></button>
    <button class="btn"  id="refreshAct" type="button"><b>{{ lang._('Refresh') }}</b><i id="refreshAct_progress"></i></button>
</div>
