<%@page import="java.util.List" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <html lang="ko"
            class=" js flexbox canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths fonts_loaded"
            xmlns="http://www.w3.org/1999/xhtml">

        <head>
            <title>범일정보 홈페이지</title>
            <link rel="stylesheet" href="/resources/css/resume.css">
            <%@ include file="/include/lib.jsp" %>
                <script>
                    let pop = 0;
                    let selectDay = 0;
                    let selectStrDayOne = 0;
                    let selectEndDayOne = 0;
                    let strDay;
                    let endDay;
                    $(document).ready(function () {
                        document.getElementById('layerPopWrap').style.display = "none";
                        document.getElementById('layerPopWrap1').style.display = "none";
                        document.getElementById('layerPopWrap2').style.display = "none";
                    });
                    $(document).on("click", function (e) {

                        if ($(e.target).parents('.layerPopWrap').length < 1 && pop == 0) {
                            document.getElementById('layerPopWrap').style.display = "none";
                            document.getElementById('layerPopWrap1').style.display = "none";
                            document.getElementById('layerPopWrap2').style.display = "none";
                        }
                        pop = 0;
                    });
                    function dateEnd() {
                        let str = 0;
                        let end = 0;
                        let rsDate = document.getElementById('rsDateTxt').innerText.replace(/\s*/g, "", "")
                        let reDate = document.getElementById('reDateTxt').innerText.replace(/\s*/g, "", "")
                        let rsTime = document.getElementById('rsTimeTxt').innerText.replace(/\s*/g, "", "")
                        let reTime = document.getElementById('reTimeTxt').innerText.replace(/\s*/g, "", "")

                        str = (rsDate.split('.')[0] * 1 * 12 * 30 * 24 * 60) + (rsDate.split('.')[1] * 1 * 30 * 24 * 60) + (rsDate.split('.')[2] * 1 * 24 * 60)
                            + (rsTime.split(':')[0] * 1 * 60) + (rsTime.split(':')[1] * 1);
                        end = (reDate.split('.')[0] * 1 * 12 * 30 * 24 * 60) + (reDate.split('.')[1] * 1 * 30 * 24 * 60) + (reDate.split('.')[2] * 1 * 24 * 60)
                            + (reTime.split(':')[0] * 1 * 60) + (reTime.split(':')[1] * 1);

                        if (str > end) {
                            alert('반납시간은 대여시간보다 이전일 수 없습니다');
                            return false;
                        }
                        document.getElementById('layerPopWrap').style.display = "none";
                        document.getElementById('rsDate').innerText = rsDate;
                        document.getElementById('reDate').innerText = reDate;
                        document.getElementById('rsTime').innerText = rsTime;
                        document.getElementById('reTime').innerText = reTime;
                    }
                    function carEnd() {
                        document.getElementById('layerPopWrap2').style.display = "none";
                        let car = $('input[name="tgl"]:checked').val();
                        if (car == null) {
                            document.getElementById('rentCar').innerText = "대여차량";
                        } else {
                            document.getElementById('rentCar').innerText = car
                        }

                    }
                    function openPop() {
                        document.getElementById('layerPopWrap').style.display = "block";
                        document.getElementById('layerPopWrap1').style.display = "none";
                        document.getElementById('layerPopWrap2').style.display = "none";
                        chooseOne('rsTimeDiv');
                        pop = 1;
                    }

                    function openPopRe() {
                        document.getElementById('layerPopWrap').style.display = "block";
                        document.getElementById('layerPopWrap1').style.display = "none";
                        document.getElementById('layerPopWrap2').style.display = "none";
                        chooseOneRe('reTimeDiv');
                        pop = 1;
                    }
                    function openPop1() {
                        document.getElementById('layerPopWrap1').style.display = "block";
                        document.getElementById('layerPopWrap').style.display = "none";
                        document.getElementById('layerPopWrap2').style.display = "none";
                        pop = 1;
                    }
                    function openPop2() {
                        document.getElementById('layerPopWrap2').style.display = "block";
                        document.getElementById('layerPopWrap1').style.display = "none";
                        document.getElementById('layerPopWrap').style.display = "none";
                        pop = 1;
                    }
                    function openInsert() {
                        chooseOne('a', 'awq4')
                        document.getElementById('qq').style.display = "block";
                        pop = 1;
                    }
                    let selectId = "";
                    function selectOne(id) {
                        $('.sri_select ,resume_select, open').attr('class', 'sri_select resume_select ');
                        if (selectId != id) {
                            $('#' + id).attr('class', 'sri_select resume_select open');
                            selectId = id;
                        } else {
                            selectId = "";
                        }
                    };
                    function selectRadio(tId, bId) {
                        const btn = document.getElementById(bId);
                        let tm = '분';
                        let idT = 'workingStrTime';
                        let idM = 'workingStrMn';
                        $('.sri_select ,resume_select, open').attr('class', 'sri_select resume_select ');
                        selectId = "";
                        if (bId == 'g1' || bId == 'i1') {
                            tm = '시'
                        }
                        if (bId == 'i1' || bId == 'j1') {
                            idT = 'workingEndTime';
                            idM = 'workingEndMn';
                        }

                        let workingStrTime = $('input[name="' + idT + '"]:checked').val();
                        let workingStrMn = $('input[name="' + idM + '"]:checked').val();

                        document.getElementById(tId).innerText = workingStrTime + ':' + workingStrMn;


                        btn.innerText = event.target.value + tm;
                    };
                    function chooseOne(id) {

                        $('.selectArea, returnBox , open').attr('class', 'selectArea returnBox');
                        $('.sri_select ,resume_select, open').attr('class', 'sri_select resume_select ');
                        $('#' + id).attr('class', 'selectArea  open');
                    };
                    function chooseOneRe(id) {

                        $('.selectArea, open').attr('class', 'selectArea ');
                        $('.sri_select ,resume_select, open').attr('class', 'sri_select resume_select ');
                        $('#' + id).attr('class', 'selectArea returnBox open');
                    };
                    function selectDays(mm, yy, day) {
                        let dayOne = (yy * 12 * 30 * 24 * 60) + (mm * 30 * 24 * 60) + (day * 24 * 60);
                        const dayCls = event.target.parentElement.classList;


                        let dayCl = String(dayCls).split(' ');
                        let cls = '';
                        if (selectDay == 0) {
                            cls = 'startDay';
                        } else if (selectStrDayOne > dayOne && selectDay == 1) {
                            $('.startDay').attr('class', '');
                            selectStrDayOne = 0;
                            selectEndDayOne = 0;
                            cls = 'startDay';
                            selectDay = 0;
                        } else if (selectDay == 1) {
                            cls = 'endDay';
                        } else if (selectDay > 1) {
                            cls = 'startDay';
                            $('.startDay').removeClass('startDay');
                            $('.endDay').removeClass('endDay');
                            selectStrDayOne = 0;
                            selectEndDayOne = 0;
                            selectDay = 0;
                        }


                        if (dayCl[dayCl.length - 1] == 'startDay' || dayCl[dayCl.length - 1] == 'endDay') {
                            selectDay = selectDay * 0;
                            $('.startDay').removeClass('startDay');
                            $('.endDay').removeClass('endDay');
                            selectStrDayOne = 0;
                            selectEndDayOne = 0;
                        } else {
                            if (selectDay == 0) {
                                selectStrDayOne = dayOne;
                            } else {
                                selectEndDayOne = dayOne;
                            }

                            dayCls.add(cls);
                            selectDay = selectDay + 1;
                        }

                        if (selectDay == 1) {
                            document.getElementById('rsDateTxt').innerText = String(yy) + '.' + String(mm + 1) + '.' + String(day);
                            document.getElementById('reDateTxt').innerText = String(yy) + '.' + String(mm + 1) + '.' + String(day);
                        } else if (selectDay == 2) {
                            document.getElementById('reDateTxt').innerText = String(yy) + '.' + String(mm + 1) + '.' + String(day);
                        }


                    }
                    function chooseOne(cls, id) {
                        $('.' + cls + ', check_on').attr('class', 'sri_check sri_radio ' + cls);
                        $('#' + id).attr('class', 'sri_check sri_radio ' + cls + ' check_on');
                        document.getElementById('qq').style.display = "none";

                    };
                    function insertOk() {

                        $('#school_type_high1').val($('#aaaaaa').val());
                        document.getElementById('insert').click();
                    }
                </script>

                <style>
                    .contentWrap .cont {
                        width: 500px;
                        height: 572px;
                    }

                    .icon_sel_arrow {
                        display: block;
                        height: 24px;
                        width: 24px;
                        background: url('/resources/images/icon_arrow_24x24.png') no-repeat;
                        background-size: 24px;
                    }

                    .logo {
                        display: inline-block;
                        width: 172px;
                        height: 50px;
                        background: url(/resources/images/logo.png) no-repeat 0 center/90%;
                        transition: background-image 500ms;
                        margin: 0 0 0 11px
                    }

                    .mVbg {
                        background: url(/resources/images/bg_main_visual.png) no-repeat center/cover;
                        width: 143%;
                        min-width: 2500px;
                        height: 283%;
                        min-height: 2500px;
                        position: absolute;
                        top: 100%;
                        left: 50%;
                        transform: translate(-50%, -50%) rotate(0deg);
                        animation: mVbgRotate 360s infinite linear;
                    }

                    .dw-ul {
                        scroll-behavior: smooth;
                    }

                    #aa {
                        border: 1px;
                        overflow: scroll;
                        -ms-overflow-style: none;
                        /* IE and Edge */
                        scrollbar-width: none;
                        /* Firefox */
                    }

                    #aa::-webkit-scrollbar {
                        display: none
                            /* Chrome , Safari , Opera */
                    }


                    .intro_item_wrap {
                        padding: 50px;
                        background-color: #f7f7f7;
                    }
                </style>

        </head>

        <body>
            <div id="skip">
                <a href="#main" id="skipToContent">본문 바로가기</a>
            </div>

            <%@ include file="/include/header.jsp" %>


                <script type="text/javascript">
                    $(window).scroll(function () {
                        var scroll = $(window).scrollTop();
                        if (scroll >= 60) {
                            $("#header").addClass('subLayout').addClass('dark');
                        } else {
                            $("#header").removeClass();
                        }
                    });

                </script>

                <div id="main" class="main">
                    <h2 class="blind">본문</h2>
                    <div id="wrap">
                        <!-- 메인비주얼 -->

                        <section id="page1" style="transition: none 0s ease 0s; top: 0px;">

                            <div class="mVbg">
                            </div>
                            <div>
                                <div class="wrap">
                                    <div>
                                        <div id="content" style="margin-top: 180px;">
                                            <div id="container" style="width: 100%; ">
                                                <div class="skrMainRenew" style="margin-right:3%;">
                                                    <div class="contentWrap" style="width: 100%;">
                                                        <div class="cont" style="width: 100%;">
                                                            <div class="mainCotnWrap jejuOn" id="tabOn">
                                                                <div class="mainTab" style="margin-bottom: 20px;">
                                                                    <div class="tabWrap tabJeju">
                                                                        <div style="width: 100%; display: flex;">
                                                                            <div style="width: 33%;">
                                                                                <div class="btnWrap"
                                                                                    style="width: 150px; height: 50%; margin-top: 4%; margin-left: 4%;">
                                                                                    <a class="btnConfirm"
                                                                                        href="../">예약하기</a>
                                                                                </div>
                                                                            </div>
                                                                            <div style="width: 33%;">
                                                                                <span
                                                                                    style="margin-top: 5%;justify-content: center; font-size: 25px;">
                                                                                    운행일지 작성
                                                                                </span>
                                                                            </div>
                                                                            <div style="width: 33%;">
                                                                                <a href="../rs/myFindAll.do?id=1">
                                                                                    <div class="btnWrap"
                                                                                        style="width: 200px; height: 50%; margin-top: 4%; margin-right: 4%; float: right;">
                                                                                        <button type="submit"
                                                                                            class="btnRes"
                                                                                            style="border: none;">나의
                                                                                            예약정보</button>
                                                                                    </div>
                                                                                </a>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                                <div class="mainCotn" id="popupDiv">
                                                                    <section id="aa" style="margin-top: 50px;">
                                                                        <div id="sri_section">
                                                                            <div id="sri_wrap">
                                                                                <div id="content">
                                                                                    <div id="resume"
                                                                                        class="wrapper_narrow packed_resume_write">
                                                                                        <form id="resume_form"
                                                                                            name="resume_form"
                                                                                            method="post"
                                                                                            action="../log/insert.do?id=1"
                                                                                            target=""
                                                                                            enctype="multipart/form-data"
                                                                                            onkeydown="return event.key != 'Enter';">
                                                                                            <input type="hidden"
                                                                                                value="${id}"
                                                                                                name="rsId">




                                                                                            <div id="school"
                                                                                                class="resume_section">
                                                                                                <div class="area_title"
                                                                                                    style="background-color: #ffffff;">
                                                                                                    <h3 class="title">
                                                                                                        운행목적</h3>
                                                                                                    <p class="txt_noti">
                                                                                                        을 선택하세요</p>

                                                                                                </div>
                                                                                                <div class="resume_write resume_edu"
                                                                                                    style="background-color: #ffffff;">
                                                                                                    <div
                                                                                                        class="select_title">
                                                                                                        <div
                                                                                                            class="resume_radio focus">
                                                                                                            <label
                                                                                                                class="sri_check sri_radio a check_on"
                                                                                                                for="school_type_primary"
                                                                                                                id="awq1">
                                                                                                                <input
                                                                                                                    name="rsPurpose"
                                                                                                                    class="inp_check"
                                                                                                                    id="school_type_primary"
                                                                                                                    type="radio"
                                                                                                                    value="출장"
                                                                                                                    checked>
                                                                                                                <span
                                                                                                                    class="txt_check"
                                                                                                                    onclick="chooseOne('a','awq1')">출장</span>
                                                                                                            </label>
                                                                                                            <label
                                                                                                                class="sri_check sri_radio a"
                                                                                                                for="school_type_middle"
                                                                                                                id="awq2">
                                                                                                                <input
                                                                                                                    name="rsPurpose"
                                                                                                                    class="inp_check"
                                                                                                                    id="school_type_middle"
                                                                                                                    type="radio"
                                                                                                                    value="교육">
                                                                                                                <span
                                                                                                                    class="txt_check"
                                                                                                                    onclick="chooseOne('a','awq2')">교육</span>
                                                                                                            </label>
                                                                                                            <label
                                                                                                                class="sri_check sri_radio a"
                                                                                                                for="school_type_high"
                                                                                                                id="awq3">
                                                                                                                <input
                                                                                                                    name="rsPurpose"
                                                                                                                    class="inp_check"
                                                                                                                    id="school_type_high"
                                                                                                                    type="radio"
                                                                                                                    value="행사">
                                                                                                                <span
                                                                                                                    class="txt_check"
                                                                                                                    onclick="chooseOne('a','awq3')">행사</span>
                                                                                                            </label>
                                                                                                            <label
                                                                                                                class="sri_check sri_radio a"
                                                                                                                for="school_type_high1"
                                                                                                                id="awq4">
                                                                                                                <input
                                                                                                                    name="rsPurpose"
                                                                                                                    class="inp_check"
                                                                                                                    id="school_type_high1"
                                                                                                                    type="radio"
                                                                                                                    value="">
                                                                                                                <span
                                                                                                                    class="txt_check"
                                                                                                                    onclick="openInsert()">기타</span>
                                                                                                            </label>
                                                                                                            <div id="qq"
                                                                                                                style="display: none;">
                                                                                                                <br><br><br><br>
                                                                                                                <div
                                                                                                                    class="area_title">
                                                                                                                    <h4
                                                                                                                        class="title">
                                                                                                                        기타
                                                                                                                        운행목적
                                                                                                                        입력
                                                                                                                    </h4>
                                                                                                                </div>
                                                                                                                <input
                                                                                                                    type="text"
                                                                                                                    id="aaaaaa"
                                                                                                                    class="input_type1"
                                                                                                                    value=""
                                                                                                                    style="width: 100%;">
                                                                                                            </div>
                                                                                                        </div>

                                                                                                    </div>
                                                                                                </div>


                                                                                                <div id="education"
                                                                                                    class="resume_write resume_edu"
                                                                                                    style="height: 70px; z-index: 9999999;">

                                                                                                    <div class="tpl_row fixedTop resume_add"
                                                                                                        data-tpl_id="tpl_highschool"
                                                                                                        id="tpl_row_1658907845266">


                                                                                                        <div
                                                                                                            class="area_title">
                                                                                                            <h4
                                                                                                                class="title">
                                                                                                                정보 입력
                                                                                                            </h4>
                                                                                                        </div>

                                                                                                        <div class="resume_row"
                                                                                                            style="height: 70px;">
                                                                                                            <div
                                                                                                                class="input_title">
                                                                                                                기존 주행거리
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="resume_input">
                                                                                                                <label
                                                                                                                    class="bar_title"
                                                                                                                    for="school_nm_1658907845266">
                                                                                                                    <span
                                                                                                                        class="valid_hidden">
                                                                                                                    </span>
                                                                                                                </label>
                                                                                                                <input
                                                                                                                    type="number"
                                                                                                                    id="school_nm_1658907845266"
                                                                                                                    value="${list.distance}"
                                                                                                                    class="box_input"
                                                                                                                    maxlength="100"
                                                                                                                    data-api_type="auto"
                                                                                                                    data-api_id="school_high"
                                                                                                                    data-min_len="2"
                                                                                                                    autocomplete="off"
                                                                                                                    readonly>
                                                                                                            </div>
                                                                                                        </div>

                                                                                                        <div class="resume_row"
                                                                                                            style="height: 70px;">
                                                                                                            <div
                                                                                                                class="input_title">
                                                                                                                주행거리
                                                                                                                <span
                                                                                                                    class="point">필수</span>
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="resume_input">
                                                                                                                <label
                                                                                                                    class="bar_title"
                                                                                                                    for="school_nm_1658907845266">
                                                                                                                    <span
                                                                                                                        class="valid_hidden">
                                                                                                                    </span>
                                                                                                                </label>
                                                                                                                <input
                                                                                                                    type="number"
                                                                                                                    id="school_nm_1658907845266"
                                                                                                                    name="drvDistance"
                                                                                                                    value=""
                                                                                                                    class="box_input"
                                                                                                                    maxlength="100"
                                                                                                                    data-api_type="auto"
                                                                                                                    data-api_id="school_high"
                                                                                                                    data-min_len="2"
                                                                                                                    autocomplete="off"
                                                                                                                    required>
                                                                                                            </div>
                                                                                                        </div>

                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>


<br>
<br>
<br>

                                                                                            <div id="attach_port_files"
                                                                                                class="resume_section"
                                                                                                data-order_item="attach_port_files"
                                                                                                data-except="y"
                                                                                                style="display: block; margin-top: 10%; background-color:#ffffff">
                                                                                                <div class="area_title">
                                                                                                    <h3 class="title"
                                                                                                        style="margin-top: 3%;">
                                                                                                        비고
                                                                                                    </h3>
                                                                                                </div>

                                                                                                <div
                                                                                                    class="resume_write">
                                                                                                    <div class="resume_row"
                                                                                                        data-tpl_id="tpl_attach_files">
                                                                                                        <p
                                                                                                            class="noti_portfolio">
                                                                                                            비고를 입력하세요
                                                                                                        </p>

                                                                                                    </div>
                                                                                                    <div class="intro_item_wrap"
                                                                                                        style="margin-top: -100px; margin-bottom:-70px;">
                                                                                                        <div
                                                                                                            class="write_area">
                                                                                                            <div
                                                                                                                class="inner_wrap">
                                                                                                                <div
                                                                                                                    class="tpl_row intro_item on">
                                                                                                                    <div
                                                                                                                        class="item_title">
                                                                                                                        <div
                                                                                                                            class="input_wrap">
                                                                                                                            <label
                                                                                                                                for="intro_title_165"
                                                                                                                                class="txt"
                                                                                                                                style="display: block;"></label>
                                                                                                                            <input
                                                                                                                                type="text"
                                                                                                                                id="intro_title_165"
                                                                                                                                name="note"
                                                                                                                                class="input_type1"
                                                                                                                                value="">
                                                                                                                            <p
                                                                                                                                class="txt_error">
                                                                                                                            </p>
                                                                                                                        </div>
                                                                                                                        <div
                                                                                                                            class="area_change_btn">
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                </div>
                                                                                            </div>


                                                                                            <div class="control"
                                                                                                style="margin-top: 5%;">

                                                                                                <button id="in"
                                                                                                    type="button"
                                                                                                    class="btnSizeM colorBlueReverse btn_action ga_event"
                                                                                                    data-action="copy"
                                                                                                    style="float: right; width: 100%; height: 100px;"
                                                                                                    onclick="insertOk()">작성하기</button>
                                                                                            </div>
                                                                                            <br>
                                                                                            <br>
                                                                                            <button id="insert"
                                                                                                type="submit"
                                                                                                style="display: none;"></button>
                                                                                        </form>
                                                                                    </div>

                                                                                </div>

                                                                            </div>

                                                                        </div>
                                                                    </section>

                                                                </div>


                                                                <!--// 예약컨텐츠 -->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>

        </body>

        </html>