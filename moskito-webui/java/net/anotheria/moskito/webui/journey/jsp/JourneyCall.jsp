<%@ page language="java" contentType="text/html;charset=UTF-8" session="true"
%><%@ taglib uri="http://www.anotheria.net/ano-tags" prefix="ano" 
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/html">
<jsp:include page="../../shared/jsp/Header.jsp" flush="false"/>
<section id="main">
    <div class="content">
        <div class="box">
            <div class="box-title">
                <i class="fa fa-caret-right"></i>
                <h3 class="pull-left">
                    <a href="mskShowJourneys">Journeys</a> :: <a href="mskShowJourney?pJourneyName=${journeyName}">${journeyName}</a>  :: ${tracedCall.name}
                </h3>
                <div class="box-right-nav">
                    <a href="" class="tooltip-bottom" title="Help"><i class="fa fa-info-circle"></i></a>
                </div>
            </div>

            <p class="paddner">
                <span><ano:write name="tracedCall" property="created"/>&nbsp;&nbsp;<ano:write name="tracedCall" property="date"/> &nbsp;&nbsp;</span>
            </p>
            <div class="box-content">

                <table class="table table-striped table-tree tree">
                    <thead>
                    <tr>
                        <th><button class="btn btn-primary tree-expand">Expand</button></th>
                        <th>Call</th>
                        <th>Gross duration</th>
                        <th>Net duration</th>
                        <th>Aborted</th>
                    </tr>
                    </thead>
                    <tbody>
                    <ano:iterate name="tracedCall" property="elements" type="net.anotheria.moskito.webui.journey.api.TracedCallStepAO" id="traceStep">
                        <%--
                            <ano:equal name="traceStep" property="aborted" value="true"><tr class="stat_error" id="node-<ano:write name="traceStep" property="id"/>"></ano:equal>
                         <ano:notEqual name="traceStep" property="aborted" value="true"><tr class="< %= ((index & 1) == 0 )? "even" : "odd" % >" id="node-<ano:write name="id"/>"></ano:notEqual>
                     --%>
                        <tr data-level="${traceStep.level}">
                            <td><div><i class="minus">–</i><i class="plus">+</i><i class="vline"></i>${traceStep.niceId}</div></td>
                            <td class="popover-bottom" data-content="<ano:write name="traceStep"/>">${traceStep.call}</td>
                                <%--<td onmouseover="Tip('<ano:write name="traceStep" property="fullCall" filter="true"/>', WIDTH, 500)" onmouseout="UnTip()"><% for (int i=1; i<traceStep.getLayer(); i++){ %><%= EMPTY %><%}%><ano:equal name="traceStep" property="root" value="false"><%=IMG%></ano:equal><ano:write name="traceStep" property="call" filter="true"/></td>--%>
                            <td>${traceStep.duration}</td>
                            <td>${traceStep.timespent}</td>
                            <td><ano:equal name="traceStep" property="aborted" value="true">X</ano:equal></td>
                        </tr>
                    </ano:iterate>
                    </tbody>
                </table>
            </div>
        </div>

        --- ${dupStepBeansSize} ---

        <%-- duplicates --%>
        <ano:present name="dupStepBeansSize">
        <div class="box">
            <div class="box-title">
                <a class="accordion-toggle tooltip-bottom" title="Close/Open" data-toggle="collapse" href="#collapseduplicates"><i class="fa fa-caret-right"></i></a>
                <h3 class="pull-left">
                    Duplicates
                </h3>
                <div class="box-right-nav">
                    <a href="" class="tooltip-bottom" title="Help"><i class="fa fa-info-circle"></i></a>
                </div>
            </div>
            <div id="collapseduplicates" class="box-content accordion-body collapse in">
                <table class="table table-striped tablesorter">
                    <thead>
                    <tr>
                        <th>Duplicate (<ano:write name="dupStepBeansSize"/>)<i class="fa fa-caret-down"></i></th>
                        <%-- <th><button class="deselect_all_journey_positions">Reset</button></th> --%>
                        <th>Calls<i class="fa fa-caret-down"></i></th>
                        <th>Positions<i class="fa fa-caret-down"></i></th>
                        <th>Time / Duration<i class="fa fa-caret-down"></i></th>
                    </tr>
                    </thead>
                    <tbody>
                    <ano:iterate name="dupStepBeans" type="net.anotheria.moskito.webui.journey.api.TracedCallDuplicateStepsAO" id="dupStep" indexId="index">
                        <tr>
                            <td>${dupStep.call}</td>
                            <%--<td><input type="checkbox" class="select_current_row_positions_checkbox" value=""/></td>--%>
                            <td>${dupStep.numberOfCalls}</td>
                            <td>
                                <ano:iterate name="dupStep" property="positions" type="java.lang.String" id="position"><a href="#${position}">${position}</a> </ano:iterate>
                            </td>
                            <td>${dupStep.timespent} / ${dupStep.duration}</td>
                        </tr>
                    </ano:iterate>
                    </tbody>
                </table>
            </div>
        </div>
        </ano:present>


    </div>
<jsp:include page="../../shared/jsp/Footer.jsp" flush="false"/>
</section>
<!-- autoexpand tree -->
<script>
    $(document).ready(function() {
        $('.table').on('click','.tree-expand', function() {
            $("table.tree tr.collapsed").removeClass('collapsed').addClass('expanded');
            $("table.tree tr[style='display: none;']").css('display','table-row');
            $('.tree-expand').addClass('tree-collapse').removeClass('tree-expand').html('Collapse');
        });

        $('.table').on('click','.tree-collapse', function() {
            $("table.tree tr.expanded").removeClass('expanded').addClass('collapsed');
            $("table.tree tr[style='display: table-row;']").css('display','none');
            $('.tree-collapse').addClass('tree-expand').removeClass('tree-collapse').html('Expand');
        });
    });
</script>
</body>
</html>
