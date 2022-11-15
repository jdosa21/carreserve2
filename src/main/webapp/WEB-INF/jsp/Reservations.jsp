<%@page import="java.util.List" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <html lang="ko"
            class=" js flexbox canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths fonts_loaded"
            xmlns="http://www.w3.org/1999/xhtml">

        <head>
            <title>범일정보 홈페이지</title>

            <%@ include file="/include/lib.jsp" %>

                <script src="https://code.jquery.com/jquery-3.6.0.js"
                    integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>


                <script>
                    function insertCk() {
                        let carId = $("#carId").val();
                        let rsDateIn = $("#rsDateIn").val();
                        let reDateIn = $("#reDateIn").val();
                        let destination = $("#destination").val();

                        if (carId == "" || carId == null) {

                            alert("차량을 선택해 주십시오.");

                        } else if (rsDateIn == "" || rsDateIn == null) {

                            alert("대여시간을 선택해 주십시오.");

                        } else if (reDateIn == "" || reDateIn == null) {

                            alert("반납시간을 선택해 주십시오.");

                        } else if (destination == "" || destination == null) {

                            alert("목적지를 입력해 주십시오.");

                        } else {
                            document.getElementById('insert').click();
                        }
                    };

                    $(document).ready(function () {

                        document.getElementById('layerPopWrap').style.display = "none";
                        document.getElementById('layerPopWrap1').style.display = "none";
                        document.getElementById('layerPopWrap2').style.display = "none";


                    });
                    let pop = 0;
                    let selectDay = 0;
                    let selectStrDayOne = 0;
                    let selectEndDayOne = 0;
                    let strDay;
                    let endDay;
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

                        str = Number(rsDate.split('-')[0] * 1 * 12 * 30 * 24 * 60) + Number(rsDate.split('-')[1] * 1 * 30 * 24 * 60) + Number(rsDate.split('-')[2] * 1 * 24 * 60)
                            + Number(rsTime.split(':')[0] * 1 * 60) + (rsTime.split(':')[1] * 1);
                        end = Number(reDate.split('-')[0] * 1 * 12 * 30 * 24 * 60) + Number(reDate.split('-')[1] * 1 * 30 * 24 * 60) + Number(reDate.split('-')[2] * 1 * 24 * 60)
                            + Number(reTime.split(':')[0] * 1 * 60) + (reTime.split(':')[1] * 1);

                        if (str > end || str == end) {
                            alert('반납시간은 대여시간보다 이전이거나 같을 수 없습니다');
                            return false;
                        }
                        let time1 = new Date();
                        let time2 = new Date(rsDate + " " + rsTime);
                        if (time2 < time1) {
                            alert('대여시간은 현재시간보다 이전일 수 없습니다');
                            return false;
                        }
                        document.getElementById('layerPopWrap').style.display = "none";
                        document.getElementById('rsDate').innerText = rsDate;
                        document.getElementById('reDate').innerText = reDate;
                        document.getElementById('rsTime').innerText = rsTime;
                        document.getElementById('reTime').innerText = reTime;
                        $("#rsDateIn").val(rsDate + " " + rsTime);
                        $("#reDateIn").val(reDate + " " + reTime);

                        


                        $('#carId').val('');
                        document.getElementById('rentCar').innerText = "대여차량";
                    }
                    function carEnd() {
                        document.getElementById('layerPopWrap2').style.display = "none";
                        let car = $('input[name="tgl"]:checked').val();
                        if (car == null) {
                            document.getElementById('rentCar').innerText = "대여차량";
                        } else {
                            document.getElementById('rentCar').innerText = $('#t' + car).text();
                        }
                        $('#carId').val(car);
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
                        map.relayout();
                        searchPlaces();
                        pop = 1;
                    }
                    function openPop2() {
                        let rsDateIn = $("#rsDateIn").val();
                        let reDateIn = $("#reDateIn").val();
                        let destination = $("#destination").val();

                        if (rsDateIn == "" || rsDateIn == null) {

                            alert("대여시간을 선택해 주십시오.");
                            return false;

                        } else if (reDateIn == "" || reDateIn == null) {

                            alert("반납시간을 선택해 주십시오.");
                            return false;

                        } else if (destination == "" || destination == null) {

                            alert("목적지를 입력해 주십시오.");
                            return false;

                        }
                        let tagArea = document.getElementById('carListUl');
                        while (tagArea.hasChildNodes()) {
                            tagArea.removeChild(tagArea.firstChild);
                        }

                        let rsDateOne = $("#rsDateIn").val();
                        let reDateOne = $("#reDateIn").val();
                        let url = "../carCk.do?rsDate=" + rsDateOne + "&reDate=" + reDateOne;

                        $.getJSON(url, function (json) {

                            let res = json.res;

                            let carList = json.carList;

                            if (res == "1") {
                                alert("예약가능 차량이 없습니다!");
                                return false;
                            }
                            else if (res == "0") {
                                for (let i = 0; i < carList.length; i++) {
                                    createTeg(tagArea, carList[i].carId, carList[i].carType);
                                }
                            }

                        });



                        document.getElementById('layerPopWrap2').style.display = "block";
                        document.getElementById('layerPopWrap1').style.display = "none";
                        document.getElementById('layerPopWrap').style.display = "none";
                        pop = 1;
                    }

                    function setStrTime(tagArea, h) {

                        let a = 0;

                        let hRs;
                        let hRe;

                        if (h < 10) {
                            hRs = "0" + String(h);
                        } else {
                            hRs = h;
                        }
                        if ((h + 1) < 10) {
                            hRe = "0" + String(h + 1);
                        } else {
                            hRe = h + 1;
                        }
                        document.getElementById('g1').innerText = hRs + "시";

                        document.getElementById('rsTimeTxt').innerText = hRs + ":00";
                        document.getElementById('reTimeTxt').innerText = hRe + ":00";
                        document.getElementById('endTime'+(h+2)).checked = true;
                        for (i = h; i < 24; i++) {

                            let i1;
                            let id = "aa" + i;
                            if (i < 10) {
                                i1 = "0" + String(i);
                            } else {
                                i1 = i;
                            }

                            createTimeTeg(tagArea, i1, id, a);
                            a = a + 1;
                        };
                    };

                    function createTimeTeg(tagArea, i, id, a) {
                        let new_Lbtag;
                        let new_Litag;
                        let new_Intag;
                        new_Lbtag = document.createElement('label');

                        new_Lbtag.setAttribute('for', 's' + i);
                        new_Lbtag.setAttribute('id', 'bb' + i);
                        new_Lbtag.setAttribute('onclick', "selectRadio('rsTimeTxt','g1')");
                        tagArea.appendChild(new_Lbtag);

                        let LbArea = document.getElementById('bb' + i);

                        new_Litag = document.createElement('li');

                        new_Litag.setAttribute('class', 'link_opt');
                        new_Litag.setAttribute('id', id);
                        new_Litag.innerText = i + '시';
                        LbArea.appendChild(new_Litag);

                        new_Intag = document.createElement('input');

                        new_Intag.setAttribute('type', 'radio');
                        new_Intag.setAttribute('name', 'workingStrTime');
                        new_Intag.setAttribute('value', i);
                        new_Intag.setAttribute('id', 's' + i);
                        new_Intag.setAttribute('style', 'display: none;');

                        let LiArea = document.getElementById(id);

                        LiArea.appendChild(new_Intag);
                        if (a == 0) {
                            document.getElementById('s' + i).checked = true;
                        }


                    }

                    function createTeg(tagArea, id, type) {

                        let new_pTag;
                        let tagLi;
                        let tagLb;
                        new_pTag = document.createElement('li');

                        new_pTag.setAttribute('class', 'carType devCarType6');
                        new_pTag.setAttribute('id', 'li' + id);
                        tagArea.appendChild(new_pTag);





                        tagLi = document.getElementById('li' + id);
                        new_pTag = document.createElement('label');

                        new_pTag.setAttribute('class', 'formRdo');
                        new_pTag.setAttribute('id', 'lb' + id);
                        new_pTag.setAttribute('for', 't20' + id);

                        tagLi.appendChild(new_pTag);




                        tagLb = document.getElementById('lb' + id);
                        new_pTag = document.createElement('input');

                        new_pTag.setAttribute('type', 'radio');
                        new_pTag.setAttribute('name', 'tgl');
                        new_pTag.setAttribute('id', 't20' + id);
                        new_pTag.setAttribute('value', id);

                        tagLb.appendChild(new_pTag);




                        new_pTag = document.createElement('span');

                        new_pTag.setAttribute('class', 'rentName');
                        new_pTag.setAttribute('id', 't' + id);
                        new_pTag.innerHTML = type;

                        tagLb.appendChild(new_pTag);
                    }
                    function aa(a) {
                        $("#destination").val(a);
                        pop = 0;
                        document.getElementById('layerPopWrap1').style.display = "none";

                        let plc = document.getElementById('palce');
                        plc.innerText = a;

                    };
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
                            document.getElementById('rsDateTxt').innerText = String(yy) + '-' + String(mm + 1) + '-' + String(day);
                            document.getElementById('reDateTxt').innerText = String(yy) + '-' + String(mm + 1) + '-' + String(day);
                        } else if (selectDay == 2) {
                            document.getElementById('reDateTxt').innerText = String(yy) + '-' + String(mm + 1) + '-' + String(day);
                        }

                        let time1 = new Date();

                        let nowOne = (Number(time1.getFullYear()) * 12 * 30 * 24 * 60) + (Number(time1.getMonth()) * 30 * 24 * 60) + (Number(time1.getDate()) * 24 * 60);
                        let h;
                        let tagArea = document.getElementById('list_opt1');
                        if (selectStrDayOne == nowOne) {
                            h = Number(time1.getHours()) + 1;
                        } else {
                            h = 0;
                        }

                        while (tagArea.hasChildNodes()) {
                            tagArea.removeChild(tagArea.firstChild);
                        }

                        setStrTime(tagArea, h);


                    }
                </script>

                <style>
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
                                        <div id="content" style="margin-top: 180px; margin-left: 150px;">
                                            <div id="container">
                                                <div class="skrMainRenew">
                                                    <div class="contentWrap">
                                                        <div class="cont">
                                                            <div class="mainCotnWrap jejuOn" id="tabOn">
                                                                <div class="mainTab" style="margin-bottom: 20px;">
                                                                    <div class="tabWrap tabJeju">
                                                                        <div style="width: 100%; display: flex;">
                                                                            <div style="width: 70%;">
                                                                                <p
                                                                                    style="margin-top: 10px;  margin-left: 6%;">
                                                                                    차량 예약하기
                                                                                </p>

                                                                            </div>


                                                                            <div style="width: 30%; margin-right: 3%;">
                                                                                <div class="btnWrap"
                                                                                    style="width: 150px; height: 50%; margin-top: 18%;">
                                                                                    <a class="btnConfirm"
                                                                                        href="../rs/findAll.do">전체
                                                                                        예약정보</a>
                                                                                </div>
                                                                            </div>


                                                                        </div>

                                                                    </div>
                                                                </div>
                                                                <form id="resume_form" method="post"
                                                                    action="../rs/insert.do"
                                                                    enctype="multipart/form-data"
                                                                    onkeydown="return event.key != 'Enter';">

                                                                    <input type="hidden" id="carId" name="carId">
                                                                    <input type="hidden" id="userId" name="userId"
                                                                        value="1">
                                                                    <input type="hidden" id="rsDateIn" name="rsDate">
                                                                    <input type="hidden" id="reDateIn" name="reDate">
                                                                    <input type="hidden" id="destination"
                                                                        name="destination">
                                                                    <div class="mainCotn" id="popupDiv">
                                                                        <div class="rentSelect">
                                                                            <!-- 대여/반납일시 선택 -->
                                                                            <div class="selectCont periodWrap">
                                                                                <p class="selTit">언제 필요하세요?</p>
                                                                                <div class="rentSelectBox">
                                                                                    <div class="rentBox">
                                                                                        <p class="tit">대여일시</p>
                                                                                        <div class="selArea periodArea">
                                                                                            <p class="txt" id="rsDate">
                                                                                                0000-0-0</p>
                                                                                            <p class="txt" id="rsTime">
                                                                                                00:00</p>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="icon_sel_arrow"
                                                                                        style="margin-left: 105%; ">
                                                                                        <a href="#none"
                                                                                            class="goView open"
                                                                                            onclick="openPop()">
                                                                                            <span
                                                                                                class="blind">팝업열기</span>
                                                                                        </a>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="rentSelectBox">
                                                                                    <div class="rentBox">
                                                                                        <p class="tit">반납일시</p>
                                                                                        <div class="selArea periodArea">
                                                                                            <p class="txt" id="reDate">
                                                                                                0000-0-0</p>
                                                                                            <p class="txt" id="reTime">
                                                                                                00:00</p>
                                                                                        </div>
                                                                                    </div>
                                                                                    <i class="icon_sel_arrow"
                                                                                        style="margin-left: 105%;">
                                                                                        <a href="#none"
                                                                                            class="goView open"
                                                                                            onclick="openPopRe()">
                                                                                            <span
                                                                                                class="blind">팝업열기</span>
                                                                                        </a>
                                                                                    </i>
                                                                                </div>
                                                                                <!-- 대여기간 레이어팝업 -->
                                                                                <div class="layerPopWrap datePopup"
                                                                                    id="layerPopWrap">
                                                                                    <div class="layerPopContainer">
                                                                                        <!-- 레이어팝업 헤더 -->
                                                                                        <div class="layerPopTit">
                                                                                            <h3 class="popTit">대여기간 선택
                                                                                            </h3>
                                                                                            <a href="#none"
                                                                                                class="closed">
                                                                                                <span class="blind"
                                                                                                    id="timePopCloseBtn">팝업
                                                                                                    닫기</span>
                                                                                            </a>
                                                                                        </div>
                                                                                        <!--// 레이어팝업 헤더 -->

                                                                                        <!-- 레이어팝업 컨텐츠 -->
                                                                                        <div class="layerPopContent">
                                                                                            <div class="selPeriodWrap">
                                                                                                <!-- 달력영역 -->
                                                                                                <div
                                                                                                    class="calendarWrap">
                                                                                                    <div class="container"
                                                                                                        id="cal1">
                                                                                                        <div
                                                                                                            class="my-calendar clearfix">
                                                                                                            <div class="clicked-date"
                                                                                                                style="display: none;">
                                                                                                                <div
                                                                                                                    class="cal-day">
                                                                                                                </div>
                                                                                                                <div
                                                                                                                    class="cal-date">
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="calendar-box">
                                                                                                                <div class="ctr-box clearfix"
                                                                                                                    style="margin-bottom: -10%;">
                                                                                                                    <button
                                                                                                                        type="button"
                                                                                                                        title="prev"
                                                                                                                        class="btn-cal prev">
                                                                                                                    </button>

                                                                                                                    <span
                                                                                                                        class="cal-month"
                                                                                                                        style="margin-left: 23%;"></span>
                                                                                                                    <span
                                                                                                                        class="cal-year"></span>
                                                                                                                    <button
                                                                                                                        type="button"
                                                                                                                        title="next"
                                                                                                                        class="btn-cal next">
                                                                                                                    </button>
                                                                                                                </div>
                                                                                                                <table
                                                                                                                    class="cal-table ui-datepicker-calendar">
                                                                                                                    <thead>
                                                                                                                        <tr>
                                                                                                                            <th scope="col"
                                                                                                                                class="ui-datepicker-week-end">
                                                                                                                                <span
                                                                                                                                    title="일">일</span>
                                                                                                                            </th>
                                                                                                                            <th
                                                                                                                                scope="col">
                                                                                                                                <span
                                                                                                                                    title="월">월</span>
                                                                                                                            </th>
                                                                                                                            <th
                                                                                                                                scope="col">
                                                                                                                                <span
                                                                                                                                    title="화">화</span>
                                                                                                                            </th>
                                                                                                                            <th
                                                                                                                                scope="col">
                                                                                                                                <span
                                                                                                                                    title="수">수</span>
                                                                                                                            </th>
                                                                                                                            <th
                                                                                                                                scope="col">
                                                                                                                                <span
                                                                                                                                    title="목">목</span>
                                                                                                                            </th>
                                                                                                                            <th
                                                                                                                                scope="col">
                                                                                                                                <span
                                                                                                                                    title="금">금</span>
                                                                                                                            </th>
                                                                                                                            <th scope="col"
                                                                                                                                class="ui-datepicker-week-end1">
                                                                                                                                <span
                                                                                                                                    title="토">토</span>
                                                                                                                            </th>
                                                                                                                        </tr>
                                                                                                                    </thead>
                                                                                                                    <tbody
                                                                                                                        class="cal-body">

                                                                                                                    </tbody>
                                                                                                                </table>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <!-- // .my-calendar -->
                                                                                                    </div>
                                                                                                </div>
                                                                                                <script>
                                                                                                    let sOre = "";
                                                                                                    let dId = "";
                                                                                                    let lv = ""
                                                                                                    let tM = "";
                                                                                                    let tY = "";
                                                                                                    function setDay() {

                                                                                                        let tx = document.getElementById(dId);
                                                                                                        let tD = event.target.textContent;

                                                                                                        let lv1 = document.getElementById(lv);

                                                                                                        lv1.innerText = "";

                                                                                                        if (tD.length == 1) {
                                                                                                            tD = '0' + tD;
                                                                                                        }
                                                                                                        tx.value = tY + '.' + tM + '.' + tD;
                                                                                                        $("#cal1").hide();
                                                                                                        cnt2 = 0;

                                                                                                    }
                                                                                                    function setCal() { }
                                                                                                    // ================================
                                                                                                    // START YOUR APP HERE
                                                                                                    // ================================
                                                                                                    const init = {
                                                                                                        monList: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
                                                                                                        dayList: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
                                                                                                        today: new Date(),
                                                                                                        monForChange: new Date().getMonth(),
                                                                                                        activeDate: new Date(),
                                                                                                        getFirstDay: (yy, mm) => new Date(yy, mm, 1),
                                                                                                        getLastDay: (yy, mm) => new Date(yy, mm + 1, 0),
                                                                                                        nextMonth: function () {
                                                                                                            let d = new Date();
                                                                                                            d.setDate(1);
                                                                                                            d.setMonth(++this.monForChange);
                                                                                                            this.activeDate = d;
                                                                                                            return d;
                                                                                                        },
                                                                                                        prevMonth: function () {
                                                                                                            let d = new Date();
                                                                                                            d.setDate(1);
                                                                                                            d.setMonth(--this.monForChange);
                                                                                                            this.activeDate = d;
                                                                                                            return d;
                                                                                                        },
                                                                                                        addZero: (num) => (num < 10) ? '0' + num : num,
                                                                                                        activeDTag: null,
                                                                                                        getIndex: function (node) {
                                                                                                            let index = 0;
                                                                                                            while (node = node.previousElementSibling) {
                                                                                                                index++;
                                                                                                            }
                                                                                                            return index;
                                                                                                        }
                                                                                                    };

                                                                                                    const $calBody = document.querySelector('.cal-body');
                                                                                                    const $btnNext = document.querySelector('.btn-cal.next');
                                                                                                    const $btnPrev = document.querySelector('.btn-cal.prev');

                                                                                                    /**
                                                                                                     * @param {number} date
                                                                                                     * @param {number} dayIn
                                                                                                    */
                                                                                                    function loadDate(date, dayIn) {
                                                                                                        document.querySelector('.cal-date').textContent = date;
                                                                                                        document.querySelector('.cal-day').textContent = init.dayList[dayIn];
                                                                                                    }

                                                                                                    /**
                                                                                                     * @param {date} fullDate
                                                                                                     */
                                                                                                    function loadYYMM(fullDate) {
                                                                                                        let yy = fullDate.getFullYear();
                                                                                                        let mm = fullDate.getMonth();
                                                                                                        let firstDay = init.getFirstDay(yy, mm);
                                                                                                        let lastDay = init.getLastDay(yy, mm);
                                                                                                        let markToday;  // for marking today date

                                                                                                        if (mm === init.today.getMonth() && yy === init.today.getFullYear()) {
                                                                                                            markToday = init.today.getDate();

                                                                                                        }
                                                                                                        tM = init.monList[mm];
                                                                                                        tY = yy;
                                                                                                        document.querySelector('.cal-month').textContent = init.monList[mm];
                                                                                                        document.querySelector('.cal-year').textContent = yy;
                                                                                                        let qwedfg = ''
                                                                                                        let trtd = '';
                                                                                                        let day = 1;
                                                                                                        let startCount;
                                                                                                        let countDay = 0;
                                                                                                        for (let i = 0; i < 6; i++) {
                                                                                                            trtd += '<tr>';
                                                                                                            for (let j = 0; j < 7; j++) {

                                                                                                                let fullDate = yy + '.' + init.addZero(mm + 1) + '.' + init.addZero(countDay + 1);
                                                                                                                if (i === 0 && !startCount && j === firstDay.getDay()) {
                                                                                                                    startCount = 1;
                                                                                                                }
                                                                                                                if (!startCount) {
                                                                                                                    trtd += '<td class=" ui-datepicker-week-end ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;'
                                                                                                                } else if (init.today.getDate() + ((init.today.getMonth() * 32) + (init.today.getFullYear() * 365)) <= (countDay + 1) + ((mm) * 32) + (yy * 365)) {
                                                                                                                    trtd += '<td class="  ';
                                                                                                                    if (j == 0) {
                                                                                                                        trtd += 'ui-datepicker-week-end';
                                                                                                                    }
                                                                                                                    if (j == 6) {
                                                                                                                        trtd += 'ui-datepicker-week-end1';
                                                                                                                    }
                                                                                                                    if (selectStrDayOne == ((yy * 12 * 30 * 24 * 60) + (mm * 30 * 24 * 60) + ((countDay + 1) * 24 * 60))) {
                                                                                                                        trtd += ' startDay';
                                                                                                                    } else if (selectEndDayOne == ((yy * 12 * 30 * 24 * 60) + (mm * 30 * 24 * 60) + ((countDay + 1) * 24 * 60))) {
                                                                                                                        trtd += ' endDay';
                                                                                                                    }
                                                                                                                    trtd += '"><a class="ui-state-default ui-state-highlight" href="#" onclick="selectDays(' + mm + ',' + yy + ',' + (Number(countDay) + 1) + ')">'
                                                                                                                } else {
                                                                                                                    trtd += `<td class=" ui-datepicker-unselectable ui-state-disabled "> <span class="ui-state-default">`;
                                                                                                                }

                                                                                                                trtd += (startCount) ? ++countDay : '';
                                                                                                                if (init.today.getDate() + ((init.today.getMonth() * 32) + (init.today.getFullYear() * 365)) <= (countDay + 1) + ((mm) * 32) + (yy * 365)) {
                                                                                                                    trtd += '</a>';
                                                                                                                } else {
                                                                                                                    trtd += '</span>';
                                                                                                                }

                                                                                                                if (countDay === lastDay.getDate()) {
                                                                                                                    startCount = 0;
                                                                                                                }
                                                                                                                trtd += '</td>';
                                                                                                            }
                                                                                                            trtd += '</tr>';
                                                                                                        }
                                                                                                        $calBody.innerHTML = trtd;
                                                                                                    }

                                                                                                    /**
                                                                                                     * @param {string} val
                                                                                                     */
                                                                                                    function createNewList(val) {
                                                                                                        let id = new Date().getTime() + '';
                                                                                                        let yy = init.activeDate.getFullYear();
                                                                                                        let mm = init.activeDate.getMonth() + 1;
                                                                                                        let dd = init.activeDate.getDate();
                                                                                                        const $target = $calBody.querySelector(`.day[data-date="${dd}"]`);

                                                                                                        let date = yy + '.' + init.addZero(mm) + '.' + init.addZero(dd);

                                                                                                        let eventData = {};
                                                                                                        eventData['date'] = date;
                                                                                                        eventData['memo'] = val;
                                                                                                        eventData['complete'] = false;
                                                                                                        eventData['id'] = id;
                                                                                                        init.event.push(eventData);
                                                                                                        $todoList.appendChild(createLi(id, val, date));
                                                                                                    }

                                                                                                    loadYYMM(init.today);
                                                                                                    loadDate(init.today.getDate(), init.today.getDay());

                                                                                                    $btnNext.addEventListener('click', () => loadYYMM(init.nextMonth()));
                                                                                                    $btnPrev.addEventListener('click', () => loadYYMM(init.prevMonth()));

                                                                                                    $calBody.addEventListener('click', (e) => {
                                                                                                        if (e.target.classList.contains('day')) {
                                                                                                            if (init.activeDTag) {
                                                                                                                init.activeDTag.classList.remove('day-active');
                                                                                                            }
                                                                                                            let day = Number(e.target.textContent);
                                                                                                            loadDate(day, e.target.cellIndex);
                                                                                                            e.target.classList.add('day-active');
                                                                                                            init.activeDTag = e.target;
                                                                                                            init.activeDate.setDate(day);
                                                                                                            reloadTodo();
                                                                                                        }
                                                                                                    });
                                                                                                </script>
                                                                                                <!--// 달력영역 -->

                                                                                                <!-- 시간선택영역 -->
                                                                                                <div
                                                                                                    class="selTimeWrap">
                                                                                                    <!-- 대여일시 -->
                                                                                                    <div class="selectArea open"
                                                                                                        id="rsTimeDiv">
                                                                                                        <div
                                                                                                            class="rentSelectBox">
                                                                                                            <div
                                                                                                                class="rentBox">
                                                                                                                <p
                                                                                                                    class="tit">
                                                                                                                    대여일시
                                                                                                                </p>
                                                                                                                <div
                                                                                                                    class="selArea periodArea">
                                                                                                                    <p class="txt"
                                                                                                                        id="rsDateTxt">
                                                                                                                        0000-0-0
                                                                                                                    </p>
                                                                                                                    <p class="txt"
                                                                                                                        id="rsTimeTxt">
                                                                                                                        00:00
                                                                                                                    </p>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <a href="#none"
                                                                                                                class="goView btnOpen"
                                                                                                                id="rsTimeAbtn"
                                                                                                                onclick="chooseOne('rsTimeDiv')">
                                                                                                                <span
                                                                                                                    class="blind">시간선택</span>
                                                                                                            </a>
                                                                                                        </div>

                                                                                                        <!-- 대여시간 선택 -->
                                                                                                        <div class="selectTimeWrap"
                                                                                                            id="rsSelectTimeWrap"
                                                                                                            style="display: block;">

                                                                                                            <div
                                                                                                                style="margin-left: 8px;">


                                                                                                                <div
                                                                                                                    class="resume_row">

                                                                                                                    <div class="sri_select resume_select"
                                                                                                                        id="g">
                                                                                                                        <button
                                                                                                                            type="button"
                                                                                                                            class="ico_arr selected"
                                                                                                                            onclick="selectOne('g')"
                                                                                                                            id="g1">00시</button>
                                                                                                                        <ul class="list_opt"
                                                                                                                            id="list_opt1">

                                                                                                                        </ul>
                                                                                                                    </div>
                                                                                                                    <div class="sri_select resume_select"
                                                                                                                        id="h">
                                                                                                                        <button
                                                                                                                            type="button"
                                                                                                                            class="ico_arr selected"
                                                                                                                            onclick="selectOne('h')"
                                                                                                                            id="h1">00분</button>
                                                                                                                        <ul
                                                                                                                            class="list_opt">
                                                                                                                            <label
                                                                                                                                for="startTime_0">
                                                                                                                                <li class="link_opt"
                                                                                                                                    onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                    00분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="00"
                                                                                                                                        id="startTime_0"
                                                                                                                                        style="display: none;"
                                                                                                                                        checked>
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_1"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    01분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="01"
                                                                                                                                        id="startTime_1"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_2"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    02분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="02"
                                                                                                                                        id="startTime_2"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_3"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    03분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="03"
                                                                                                                                        id="startTime_3"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_4"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    04분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="04"
                                                                                                                                        id="startTime_4"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_5"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    05분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="05"
                                                                                                                                        id="startTime_5"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_6"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    06분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="06"
                                                                                                                                        id="startTime_6"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_7"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    07분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="07"
                                                                                                                                        id="startTime_7"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_8"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    08분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="08"
                                                                                                                                        id="startTime_8"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_9"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    09분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="09"
                                                                                                                                        id="startTime_9"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_10"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    10분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="10"
                                                                                                                                        id="startTime_10"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_11"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    11분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="11"
                                                                                                                                        id="startTime_11"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_12"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    12분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="12"
                                                                                                                                        id="startTime_12"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_13"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    13분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="13"
                                                                                                                                        id="startTime_13"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_14"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    14분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="14"
                                                                                                                                        id="startTime_14"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_15"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    15분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="15"
                                                                                                                                        id="startTime_15"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_16"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    16분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="16"
                                                                                                                                        id="startTime_16"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_17"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    17분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="17"
                                                                                                                                        id="startTime_17"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_18"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    18분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="18"
                                                                                                                                        id="startTime_18"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_19"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    19분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="19"
                                                                                                                                        id="startTime_19"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_20"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    20분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="20"
                                                                                                                                        id="startTime_20"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_21"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    21분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="21"
                                                                                                                                        id="startTime_21"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_22"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    22분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="22"
                                                                                                                                        id="startTime_22"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_23"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    23분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="23"
                                                                                                                                        id="startTime_23"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_24"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    24분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="24"
                                                                                                                                        id="startTime_24"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_25"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    25분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="25"
                                                                                                                                        id="startTime_25"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_26"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    26분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="26"
                                                                                                                                        id="startTime_26"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_27"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    27분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="27"
                                                                                                                                        id="startTime_27"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_28"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    28분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="28"
                                                                                                                                        id="startTime_28"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_29"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    29분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="29"
                                                                                                                                        id="startTime_29"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_30"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    30분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="30"
                                                                                                                                        id="startTime_30"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_31"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    31분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="31"
                                                                                                                                        id="startTime_31"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_32"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    32분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="32"
                                                                                                                                        id="startTime_32"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_33"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    33분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="33"
                                                                                                                                        id="startTime_33"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_34"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    34분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="34"
                                                                                                                                        id="startTime_34"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_35"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    35분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="35"
                                                                                                                                        id="startTime_35"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_36"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    36분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="36"
                                                                                                                                        id="startTime_36"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_37"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    37분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="37"
                                                                                                                                        id="startTime_37"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_38"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    38분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="38"
                                                                                                                                        id="startTime_38"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_39"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    39분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="39"
                                                                                                                                        id="startTime_39"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_40"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    40분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="40"
                                                                                                                                        id="startTime_40"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_41"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    41분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="41"
                                                                                                                                        id="startTime_41"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_42"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    42분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="42"
                                                                                                                                        id="startTime_42"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_43"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    43분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="43"
                                                                                                                                        id="startTime_43"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_44"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    44분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="44"
                                                                                                                                        id="startTime_44"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_45"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    45분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="45"
                                                                                                                                        id="startTime_45"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_46"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    46분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="46"
                                                                                                                                        id="startTime_46"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_47"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    47분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="47"
                                                                                                                                        id="startTime_47"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_48"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    48분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="48"
                                                                                                                                        id="startTime_48"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_49"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    49분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="49"
                                                                                                                                        id="startTime_49"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_50"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    50분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="50"
                                                                                                                                        id="startTime_50"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_51"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    51분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="51"
                                                                                                                                        id="startTime_51"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_52"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    52분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="52"
                                                                                                                                        id="startTime_52"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_53"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    53분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="53"
                                                                                                                                        id="startTime_53"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_54"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    54분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="54"
                                                                                                                                        id="startTime_54"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_55"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    55분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="55"
                                                                                                                                        id="startTime_55"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_56"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    56분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="56"
                                                                                                                                        id="startTime_56"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_57"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    57분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="57"
                                                                                                                                        id="startTime_57"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_58"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    58분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="58"
                                                                                                                                        id="startTime_58"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="startTime_59"
                                                                                                                                onclick="selectRadio('rsTimeTxt','h1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    59분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingStrMn"
                                                                                                                                        value="59"
                                                                                                                                        id="startTime_59"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                        </ul>
                                                                                                                    </div>
                                                                                                                </div>

                                                                                                            </div>

                                                                                                        </div>
                                                                                                        <!--// 대여시간 선택 -->
                                                                                                    </div>
                                                                                                    <!--// 대여일시 -->

                                                                                                    <!-- 반납일시 -->
                                                                                                    <div class="selectArea returnBox"
                                                                                                        id="reTimeDiv">
                                                                                                        <div
                                                                                                            class="rentSelectBox">
                                                                                                            <div
                                                                                                                class="rentBox">
                                                                                                                <p
                                                                                                                    class="tit">
                                                                                                                    반납일시
                                                                                                                </p>
                                                                                                                <div
                                                                                                                    class="selArea periodArea">
                                                                                                                    <p class="txt"
                                                                                                                        id="reDateTxt">
                                                                                                                        0000-0-0
                                                                                                                    </p>
                                                                                                                    <p class="txt"
                                                                                                                        id="reTimeTxt">
                                                                                                                        00:00
                                                                                                                    </p>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <a href="#none"
                                                                                                                class="goView btnOpen"
                                                                                                                id="reTimeAbtn"
                                                                                                                onclick="chooseOneRe('reTimeDiv')">
                                                                                                                <span
                                                                                                                    class="blind">시간선택</span>
                                                                                                            </a>
                                                                                                        </div>

                                                                                                        <!-- 반납시각 선택 -->
                                                                                                        <div class="selectTimeWrap"
                                                                                                            id="reSelectTimeWrap"
                                                                                                            style="display: block;">
                                                                                                            <div
                                                                                                                style="margin-left: 8px;">

                                                                                                                <div
                                                                                                                    class="resume_row">
                                                                                                                    <div class="sri_select resume_select"
                                                                                                                        id="i">
                                                                                                                        <button
                                                                                                                            type="button"
                                                                                                                            class="ico_arr selected"
                                                                                                                            onclick="selectOne('i')"
                                                                                                                            id="i1">00시</button>
                                                                                                                        <ul
                                                                                                                            class="list_opt">
                                                                                                                            <label
                                                                                                                                for="endTime1"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    00시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="00"
                                                                                                                                        id="endTime1"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime2"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    01시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="01"
                                                                                                                                        id="endTime2"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime3"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    02시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="02"
                                                                                                                                        id="endTime3"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime4"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    03시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="03"
                                                                                                                                        id="endTime4"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime5"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    04시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="04"
                                                                                                                                        id="endTime5"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime6"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    05시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="05"
                                                                                                                                        id="endTime6"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime7"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    06시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="06"
                                                                                                                                        id="endTime7"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime8"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    07시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="07"
                                                                                                                                        id="endTime8"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime9"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    08시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="08"
                                                                                                                                        id="endTime9"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime10"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    09시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="09"
                                                                                                                                        id="endTime10"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime11"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    10시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="10"
                                                                                                                                        id="endTime11"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime12"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    11시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="11"
                                                                                                                                        id="endTime12"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime13"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    12시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="12"
                                                                                                                                        id="endTime13"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime14"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    13시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="13"
                                                                                                                                        id="endTime14"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime15"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    14시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="14"
                                                                                                                                        id="endTime15"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime16"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    15시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="15"
                                                                                                                                        id="endTime16"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime17"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    16시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="16"
                                                                                                                                        id="endTime17"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime18"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    17시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="17"
                                                                                                                                        id="endTime18"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime19"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    18시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="18"
                                                                                                                                        id="endTime19"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime20"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    19시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="19"
                                                                                                                                        id="endTime20"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime21"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    20시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="20"
                                                                                                                                        id="endTime21"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime22"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    21시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="21"
                                                                                                                                        id="endTime22"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime23"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    22시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="22"
                                                                                                                                        id="endTime23"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime24"
                                                                                                                                onclick="selectRadio('reTimeTxt','i1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    23시<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndTime"
                                                                                                                                        value="23"
                                                                                                                                        id="endTime24"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                        </ul>
                                                                                                                    </div>
                                                                                                                    <div class="sri_select resume_select"
                                                                                                                        id="j">
                                                                                                                        <button
                                                                                                                            type="button"
                                                                                                                            class="ico_arr selected"
                                                                                                                            onclick="selectOne('j')"
                                                                                                                            id="j1">00분</button>
                                                                                                                        <ul
                                                                                                                            class="list_opt">
                                                                                                                            <label
                                                                                                                                for="endTime_0"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    00분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="00"
                                                                                                                                        id="endTime_0"
                                                                                                                                        style="display: none;"
                                                                                                                                        checked>
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_1"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    01분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="01"
                                                                                                                                        id="endTime_1"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_2"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    02분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="02"
                                                                                                                                        id="endTime_2"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_3"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    03분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="03"
                                                                                                                                        id="endTime_3"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_4"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    04분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="04"
                                                                                                                                        id="endTime_4"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_5"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    05분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="05"
                                                                                                                                        id="endTime_5"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_6"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    06분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="06"
                                                                                                                                        id="endTime_6"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_7"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    07분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="07"
                                                                                                                                        id="endTime_7"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_8"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    08분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="08"
                                                                                                                                        id="endTime_8"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_9"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    09분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="09"
                                                                                                                                        id="endTime_9"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_10"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    10분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="10"
                                                                                                                                        id="endTime_10"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_11"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    11분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="11"
                                                                                                                                        id="endTime_11"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_12"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    12분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="12"
                                                                                                                                        id="endTime_12"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_13"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    13분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="13"
                                                                                                                                        id="endTime_13"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_14"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    14분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="14"
                                                                                                                                        id="endTime_14"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_15"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    15분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="15"
                                                                                                                                        id="endTime_15"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_16"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    16분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="16"
                                                                                                                                        id="endTime_16"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_17"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    17분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="17"
                                                                                                                                        id="endTime_17"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_18"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    18분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="18"
                                                                                                                                        id="endTime_18"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_19"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    19분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="19"
                                                                                                                                        id="endTime_19"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_20"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    20분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="20"
                                                                                                                                        id="endTime_20"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_21"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    21분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="21"
                                                                                                                                        id="endTime_21"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_22"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    22분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="22"
                                                                                                                                        id="endTime_22"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_23"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    23분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="23"
                                                                                                                                        id="endTime_23"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_24"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    24분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="24"
                                                                                                                                        id="endTime_24"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_25"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    25분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="25"
                                                                                                                                        id="endTime_25"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_26"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    26분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="26"
                                                                                                                                        id="endTime_26"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_27"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    27분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="27"
                                                                                                                                        id="endTime_27"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_28"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    28분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="28"
                                                                                                                                        id="endTime_28"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_29"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    29분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="29"
                                                                                                                                        id="endTime_29"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_30"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    30분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="30"
                                                                                                                                        id="endTime_30"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_31"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    31분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="31"
                                                                                                                                        id="endTime_31"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_32"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    32분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="32"
                                                                                                                                        id="endTime_32"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_33"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    33분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="33"
                                                                                                                                        id="endTime_33"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_34"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    34분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="34"
                                                                                                                                        id="endTime_34"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_35"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    35분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="35"
                                                                                                                                        id="endTime_35"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_36"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    36분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="36"
                                                                                                                                        id="endTime_36"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_37"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    37분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="37"
                                                                                                                                        id="endTime_37"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_38"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    38분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="38"
                                                                                                                                        id="endTime_38"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_39"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    39분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="39"
                                                                                                                                        id="endTime_39"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_40"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    40분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="40"
                                                                                                                                        id="endTime_40"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_41"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    41분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="41"
                                                                                                                                        id="endTime_41"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_42"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    42분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="42"
                                                                                                                                        id="endTime_42"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_43"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    43분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="43"
                                                                                                                                        id="endTime_43"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_44"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    44분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="44"
                                                                                                                                        id="endTime_44"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_45"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    45분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="45"
                                                                                                                                        id="endTime_45"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_46"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    46분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="46"
                                                                                                                                        id="endTime_46"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_47"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    47분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="47"
                                                                                                                                        id="endTime_47"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_48"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    48분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="48"
                                                                                                                                        id="endTime_48"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_49"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    49분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="49"
                                                                                                                                        id="endTime_49"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_50"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    50분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="50"
                                                                                                                                        id="endTime_50"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_51"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    51분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="51"
                                                                                                                                        id="endTime_51"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_52"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    52분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="52"
                                                                                                                                        id="endTime_52"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_53"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    53분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="53"
                                                                                                                                        id="endTime_53"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_54"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    54분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="54"
                                                                                                                                        id="endTime_54"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_55"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    55분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="55"
                                                                                                                                        id="endTime_55"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_56"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    56분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="56"
                                                                                                                                        id="endTime_56"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_57"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    57분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="57"
                                                                                                                                        id="endTime_57"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_58"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    58분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="58"
                                                                                                                                        id="endTime_58"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                            <label
                                                                                                                                for="endTime_59"
                                                                                                                                onclick="selectRadio('reTimeTxt','j1')">
                                                                                                                                <li
                                                                                                                                    class="link_opt">
                                                                                                                                    59분<input
                                                                                                                                        type="radio"
                                                                                                                                        name="workingEndMn"
                                                                                                                                        value="59"
                                                                                                                                        id="endTime_59"
                                                                                                                                        style="display: none;">
                                                                                                                                </li>
                                                                                                                            </label>
                                                                                                                        </ul>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <!--// 반납시각 선택 -->
                                                                                                    </div>
                                                                                                    <!--// 반납일시 -->
                                                                                                </div>
                                                                                                <!--// 시간선택영역 -->
                                                                                            </div>
                                                                                        </div>
                                                                                        <!--// 레이어팝업 컨텐츠 -->

                                                                                        <!-- 팝업 하단 -->
                                                                                        <div class="layerPopBtm">
                                                                                            <div class="btnWrap">
                                                                                                <a class="btnRes"
                                                                                                    href="#none"
                                                                                                    onclick="dateEnd();">확인</a>
                                                                                            </div>
                                                                                            <div class="notiWrap">
                                                                                                <!-- <p class="notiTxt">날짜를 선택하시면 다시 선택하실 수 있습니다.</p> -->
                                                                                            </div>
                                                                                        </div>
                                                                                        <!--// 팝업 하단 -->
                                                                                    </div>
                                                                                </div>
                                                                                <!--// 대여기간 레이어팝업 -->
                                                                                <!-- 대여기간 레이어팝업 -->
                                                                                <div class="layerPopWrap datePopup"
                                                                                    id="layerPopWrap1">
                                                                                    <div class="layerPopContainer">
                                                                                        <div id="map_wrap">
                                                                                            <div class="map_wrap">
                                                                                                <div id="map"
                                                                                                    style="width:100%;height:100%;position:relative;overflow:hidden;">
                                                                                                </div>

                                                                                                <div id="menu_wrap"
                                                                                                    class="bg_white">
                                                                                                    <div class="option">
                                                                                                        <div>
                                                                                                            키워드 : <input
                                                                                                                type="text"
                                                                                                                value="대구광역시 수성구 대흥동 855-3"
                                                                                                                id="keyword"
                                                                                                                size="15"
                                                                                                                onkeydown="if(event.keyCode==13) searchPlaces();">
                                                                                                            <a
                                                                                                                href="javascript:searchPlaces();"><button
                                                                                                                    type="button">검색하기</button></a>

                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <hr>
                                                                                                    <ul id="placesList">
                                                                                                    </ul>
                                                                                                    <div
                                                                                                        id="pagination">
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                            <script
                                                                                                type="text/javascript"
                                                                                                src="//dapi.kakao.com/v2/maps/sdk.js?appkey=53af1cb49c0d226b951e6667c15dc27c&libraries=services"></script>
                                                                                            <script>

                                                                                                // 마커를 담을 배열입니다
                                                                                                var markers = [];

                                                                                                var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                                                                                                    mapOption = {
                                                                                                        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                                                                                                        level: 3 // 지도의 확대 레벨
                                                                                                    };
                                                                                                // 지도를 생성합니다    
                                                                                                var map = new kakao.maps.Map(mapContainer, mapOption);
                                                                                                map.relayout();


                                                                                                // 장소 검색 객체를 생성합니다
                                                                                                var ps = new kakao.maps.services.Places();

                                                                                                // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
                                                                                                var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

                                                                                                // 키워드로 장소를 검색합니다
                                                                                                searchPlaces();

                                                                                                // 키워드 검색을 요청하는 함수입니다
                                                                                                function searchPlaces() {

                                                                                                    var keyword = document.getElementById('keyword').value;

                                                                                                    if (!keyword.replace(/^\s+|\s+$/g, '')) {
                                                                                                        alert('키워드를 입력해주세요!');
                                                                                                        return false;
                                                                                                    }

                                                                                                    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
                                                                                                    ps.keywordSearch(keyword, placesSearchCB);
                                                                                                }

                                                                                                // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
                                                                                                function placesSearchCB(data, status, pagination) {
                                                                                                    if (status === kakao.maps.services.Status.OK) {

                                                                                                        // 정상적으로 검색이 완료됐으면
                                                                                                        // 검색 목록과 마커를 표출합니다
                                                                                                        displayPlaces(data);

                                                                                                        // 페이지 번호를 표출합니다
                                                                                                        displayPagination(pagination);

                                                                                                    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

                                                                                                        alert('검색 결과가 존재하지 않습니다.');
                                                                                                        return;

                                                                                                    } else if (status === kakao.maps.services.Status.ERROR) {

                                                                                                        alert('검색 결과 중 오류가 발생했습니다.');
                                                                                                        return;

                                                                                                    }
                                                                                                }

                                                                                                // 검색 결과 목록과 마커를 표출하는 함수입니다
                                                                                                function displayPlaces(places) {

                                                                                                    var listEl = document.getElementById('placesList'),
                                                                                                        menuEl = document.getElementById('menu_wrap'),
                                                                                                        fragment = document.createDocumentFragment(),
                                                                                                        bounds = new kakao.maps.LatLngBounds(),
                                                                                                        listStr = '';

                                                                                                    // 검색 결과 목록에 추가된 항목들을 제거합니다
                                                                                                    removeAllChildNods(listEl);

                                                                                                    // 지도에 표시되고 있는 마커를 제거합니다
                                                                                                    removeMarker();

                                                                                                    for (var i = 0; i < places.length; i++) {

                                                                                                        // 마커를 생성하고 지도에 표시합니다
                                                                                                        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                                                                                                            marker = addMarker(placePosition, i),
                                                                                                            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

                                                                                                        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                                                                                                        // LatLngBounds 객체에 좌표를 추가합니다
                                                                                                        bounds.extend(placePosition);

                                                                                                        // 마커와 검색결과 항목에 mouseover 했을때
                                                                                                        // 해당 장소에 인포윈도우에 장소명을 표시합니다
                                                                                                        // mouseout 했을 때는 인포윈도우를 닫습니다
                                                                                                        (function (marker, title) {
                                                                                                            kakao.maps.event.addListener(marker, 'mouseover', function () {
                                                                                                                displayInfowindow(marker, title);
                                                                                                            });

                                                                                                            kakao.maps.event.addListener(marker, 'mouseout', function () {
                                                                                                                infowindow.close();
                                                                                                            });

                                                                                                            itemEl.onmouseover = function () {
                                                                                                                displayInfowindow(marker, title);
                                                                                                            };

                                                                                                            itemEl.onmouseout = function () {
                                                                                                                infowindow.close();
                                                                                                            };
                                                                                                        })(marker, places[i].place_name);

                                                                                                        fragment.appendChild(itemEl);
                                                                                                    }

                                                                                                    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
                                                                                                    listEl.appendChild(fragment);
                                                                                                    menuEl.scrollTop = 0;

                                                                                                    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
                                                                                                    map.setBounds(bounds);
                                                                                                }

                                                                                                // 검색결과 항목을 Element로 반환하는 함수입니다
                                                                                                function getListItem(index, places) {

                                                                                                    var el = document.createElement('li')
                                                                                                    el.setAttribute('onclick', "aa('" + places.address_name + "')"),
                                                                                                        itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                                                                                                        '<div class="info">' +
                                                                                                        '   <h5>' + places.place_name + '</h5>';

                                                                                                    if (places.road_address_name) {
                                                                                                        itemStr += '    <span>' + places.road_address_name + '</span>' +
                                                                                                            '   <span class="jibun gray">' + places.address_name + '</span>';
                                                                                                    } else {
                                                                                                        itemStr += '    <span>' + places.address_name + '</span>';
                                                                                                    }

                                                                                                    itemStr += '  <span class="tel">' + places.phone + '</span>' +
                                                                                                        '</div>';

                                                                                                    el.innerHTML = itemStr;
                                                                                                    el.className = 'item';
                                                                                                    return el;
                                                                                                }

                                                                                                // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
                                                                                                function addMarker(position, idx, title) {
                                                                                                    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                                                                                                        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                                                                                                        imgOptions = {
                                                                                                            spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                                                                                                            spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                                                                                                            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                                                                                                        },
                                                                                                        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                                                                                                        marker = new kakao.maps.Marker({
                                                                                                            position: position, // 마커의 위치
                                                                                                            image: markerImage
                                                                                                        });

                                                                                                    marker.setMap(map); // 지도 위에 마커를 표출합니다
                                                                                                    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

                                                                                                    return marker;
                                                                                                }

                                                                                                // 지도 위에 표시되고 있는 마커를 모두 제거합니다
                                                                                                function removeMarker() {
                                                                                                    for (var i = 0; i < markers.length; i++) {
                                                                                                        markers[i].setMap(null);
                                                                                                    }
                                                                                                    markers = [];
                                                                                                }

                                                                                                // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
                                                                                                function displayPagination(pagination) {
                                                                                                    var paginationEl = document.getElementById('pagination'),
                                                                                                        fragment = document.createDocumentFragment(),
                                                                                                        i;

                                                                                                    // 기존에 추가된 페이지번호를 삭제합니다
                                                                                                    while (paginationEl.hasChildNodes()) {
                                                                                                        paginationEl.removeChild(paginationEl.lastChild);
                                                                                                    }

                                                                                                    for (i = 1; i <= pagination.last; i++) {
                                                                                                        var el = document.createElement('a');
                                                                                                        el.href = "#";
                                                                                                        el.innerHTML = i;

                                                                                                        if (i === pagination.current) {
                                                                                                            el.className = 'on';
                                                                                                        } else {
                                                                                                            el.onclick = (function (i) {
                                                                                                                return function () {
                                                                                                                    pagination.gotoPage(i);
                                                                                                                }
                                                                                                            })(i);
                                                                                                        }

                                                                                                        fragment.appendChild(el);
                                                                                                    }
                                                                                                    paginationEl.appendChild(fragment);
                                                                                                }

                                                                                                // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
                                                                                                // 인포윈도우에 장소명을 표시합니다
                                                                                                function displayInfowindow(marker, title) {
                                                                                                    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

                                                                                                    infowindow.setContent(content);
                                                                                                    infowindow.open(map, marker);
                                                                                                }

                                                                                                // 검색결과 목록의 자식 Element를 제거하는 함수입니다
                                                                                                function removeAllChildNods(el) {
                                                                                                    while (el.hasChildNodes()) {
                                                                                                        el.removeChild(el.lastChild);
                                                                                                    }
                                                                                                }

                                                                                            </script>
                                                                                        </div>

                                                                                    </div>
                                                                                </div>
                                                                                <!--// 대여기간 레이어팝업 -->
                                                                            </div>
                                                                            <div class="selectCont storeWrap btmInert"
                                                                                id="contDiv">

                                                                                <p class="selTit">목적지를 입력하세요</p>
                                                                                <div class="rentSelectBox"
                                                                                    onclick="openPop1()">
                                                                                    <div class="rentBox">
                                                                                        <p class="tit" id="palce">
                                                                                            목적지를 입력하세요
                                                                                        </p>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- 지점선택 레이어팝업 -->
                                                                                <!--// 지점선택 레이어팝업 -->
                                                                            </div>
                                                                            <!--// 지점 선택 -->

                                                                            <!-- 차량 선택 -->
                                                                            <div class="selectCont carWrap">
                                                                                <p class="selTit">어떤 차량을 원하세요?</p>
                                                                                <div class="rentSelectBox"
                                                                                    onclick="openPop2()"
                                                                                    style="width: 100%;">
                                                                                    <div class="rentBox"
                                                                                        style="width: 100%;">
                                                                                        <p class="tit" id="rentCar"
                                                                                            style="width: 100%;">대여차량
                                                                                        </p>
                                                                                    </div>

                                                                                </div>
                                                                                <div class="layerPopWrap"
                                                                                    id="layerPopWrap2"
                                                                                    style="display: block; ">
                                                                                    <div class="layerPopContainer">
                                                                                        <!-- 레이어팝업 헤더 -->
                                                                                        <div class="layerPopTit">
                                                                                            <h3 class="popTit"
                                                                                                style="text-align: center;">
                                                                                                대여차량 선택</h3>
                                                                                            <a href="#none"
                                                                                                class="closed"
                                                                                                id="carPopCloseBtn">
                                                                                                <span class="blind">팝업
                                                                                                    닫기</span>
                                                                                            </a>
                                                                                        </div>
                                                                                        <!--// 레이어팝업 헤더 -->

                                                                                        <!-- 레이어팝업 컨텐츠 -->
                                                                                        <div class="layerPopContent">
                                                                                            <div class="selectWrap">
                                                                                                <!-- 차종선택 -->

                                                                                                <!--// 차종선택 -->

                                                                                                <!-- 차량선택 -->
                                                                                                <div
                                                                                                    class="selectDepth2">
                                                                                                    <div
                                                                                                        class="scrollWrap mCustomScrollbar _mCS_3">
                                                                                                        <div id="mCSB_3"
                                                                                                            class="mCustomScrollBox mCS-dark mCSB_vertical mCSB_inside"
                                                                                                            tabindex="0"
                                                                                                            style="max-height: none;">
                                                                                                            <div id="mCSB_3_container"
                                                                                                                class="mCSB_container"
                                                                                                                style="position: relative; top: 0px; left: 0px;"
                                                                                                                dir="ltr">
                                                                                                                <ul
                                                                                                                    id="carListUl">



                                                                                                                </ul>
                                                                                                            </div>
                                                                                                            <div id="mCSB_3_scrollbar_vertical"
                                                                                                                class="mCSB_scrollTools mCSB_3_scrollbar mCS-dark mCSB_scrollTools_vertical"
                                                                                                                style="display: block;">
                                                                                                                <div
                                                                                                                    class="mCSB_draggerContainer">
                                                                                                                    <div id="mCSB_3_dragger_vertical"
                                                                                                                        class="mCSB_dragger"
                                                                                                                        style="position: absolute; min-height: 30px; top: 0px; display: block; height: 25px; max-height: 253px;">
                                                                                                                        <div class="mCSB_dragger_bar"
                                                                                                                            style="line-height: 30px;">
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div
                                                                                                                        class="mCSB_draggerRail">
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <!--// 차량선택 -->
                                                                                            </div>
                                                                                        </div>
                                                                                        <!--// 레이어팝업 컨텐츠 -->

                                                                                        <div class="layerPopBtm">
                                                                                            <div class="btnWrap">
                                                                                                <a class="btnRes"
                                                                                                    href="#none"
                                                                                                    onclick="carEnd()">확인</a>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <!--// 차량선택 레이어팝업 -->
                                                                            </div>
                                                                            <!--// 차량 선택 -->
                                                                        </div>

                                                                        <!-- 버튼 -->
                                                                        <div class="btnWrap">
                                                                            <a class="btnConfirm"
                                                                                href="../rs/myFindAll.do?id=1">예약확인</a>
                                                                            <button style="display: none;" type="submit"
                                                                                id="insert"></button>
                                                                            <button type="button" class="btnRes"
                                                                                style="border: none;"
                                                                                onclick="insertCk()">예약
                                                                                하기</button>
                                                                        </div>
                                                                        <!--// 버튼 -->

                                                                    </div>
                                                                </form>
                                                                <!--// 예약컨텐츠 -->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="mVisual">
                                            <img src="/resources/images/bg_visual02.png" alt="다이어그램 도형">
                                            <div class="diagram">
                                                <p class="d_cont d1"><b>I</b>nfra</p>
                                                <div class="d_line">
                                                    <div class="current"></div>
                                                </div>
                                                <p class="d_cont d2"><b>C</b>loud</p>
                                                <div class="d_line">
                                                    <div class="current"></div>
                                                </div>
                                                <p class="d_cont d3"><b>SW</b> development</p>
                                                <div class="d_line">
                                                    <div class="current"></div>
                                                </div>
                                                <p class="d_cont d4"><b>D</b>ell Technologies</p>
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