<%@page import="java.util.List" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                    <html lang="ko"
                        class=" js flexbox canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths fonts_loaded"
                        xmlns="http://www.w3.org/1999/xhtml">

                    <head>
                        <title>범일정보 홈페이지</title>
                        <link rel="stylesheet" href="/resources/css/resume.css">
                        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
                        <link rel="stylesheet"
                            href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
                        <%@ include file="/include/lib.jsp" %>
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

                                #sub_title.type02>.sub_visual {
                                    height: 250px;
                                }

                                #sub_title.type02>.sub_visual {
                                    height: 380px;
                                    background: linear-gradient(to bottom, #13172d 30%, #25425b);
                                }

                                #sub_title>.sub_visual {
                                    overflow: hidden;
                                    position: relative;
                                    width: 100%;
                                    height: 560px;
                                    background: url(../img/contents/bg_subvisual.png) no-repeat center/cover;
                                }

                                #sub_title>.sub_visual .sub_visualIn {
                                    position: relative;
                                    z-index: 1;
                                    max-width: 1370px;
                                    height: 100%;
                                    margin: 0 auto;
                                    padding: 0 30px;
                                    box-sizing: border-box;
                                }

                                #sub_title>.sub_visual .cont {
                                    position: relative;
                                    top: 50%;
                                    transform: translateY(-50%);
                                    color: #fff;
                                    font-size: 18px;
                                    font-weight: bold;
                                    font-weight: normal;
                                    line-height: 1;
                                }

                                .sub_visualIn .ico_diagram {
                                    transform: scale(0.6);
                                    right: -45px;
                                }

                                .sub_visualIn .ico_diagram {
                                    position: absolute;
                                    top: -45%;
                                    right: 0;
                                }

                                .sub_visualIn .ico_diagram>div {
                                    position: relative;
                                    width: 257px;
                                    height: 159px;
                                }

                                .sub_visualIn .ico_diagram .oval {
                                    position: absolute;
                                    width: 22px;
                                    height: 22px;
                                    border: 5px solid;
                                    border-radius: 100%;
                                    box-sizing: border-box;
                                    box-shadow: 0 0 20px 0px #829eba, inset 0 0 20px 0px #3b5d78;
                                }

                                .sub_visualIn .ico_diagram .oval:nth-of-type(1) {
                                    top: 84px;
                                    border-color: #8fafbe;
                                }

                                .sub_visualIn .ico_diagram .oval:nth-of-type(2) {
                                    top: 55px;
                                    left: 112px;
                                    border-color: #96a7c2;
                                }

                                .sub_visualIn .ico_diagram .oval:nth-of-type(3) {
                                    bottom: 0;
                                    right: 36px;
                                    border-color: #9ca3ca;
                                }

                                .sub_visualIn .ico_diagram .oval:nth-of-type(4) {
                                    right: 0;
                                    border-color: #9d9bc6;
                                }

                                .sub_visualIn .ico_diagram .line:nth-of-type(6) {
                                    top: 33px;
                                    left: 66px;
                                    height: 95px;
                                    border-color: #94aac1;
                                    transform: rotate(75deg);
                                }

                                .sub_visualIn .ico_diagram .line {
                                    position: absolute;
                                    width: 2px;
                                    height: 100px;
                                    border: 1px dashed;
                                    box-sizing: border-box;
                                }

                                .sub_visualIn .ico_diagram .line:nth-of-type(7) {
                                    top: 58px;
                                    left: 165px;
                                    height: 100px;
                                    border-color: #9cacca;
                                    transform: rotate(135deg);
                                }


                                .sub_visualIn .ico_diagram .line:nth-of-type(8) {
                                    bottom: 20px;
                                    right: 28px;
                                    height: 121px;
                                    border-color: #9c9bc6;
                                    transform: rotate(15deg);
                                }

                                #sub_title>.sub_visual .cont>h3 {
                                    font-size: 7.9vw;
                                }

                                #sub_title.type02>.sub_visual h3 {
                                    text-align: center;
                                }

                                #sub_title>.sub_visual .cont>h3 {
                                    font-size: 58px;
                                    font-weight: 800;
                                }

                                #sub_cont {
                                    padding-top: 55px;
                                }

                                #sub_cont {
                                    padding-top: 80px;
                                }

                                #sub_cont {
                                    padding-top: 70px;
                                }

                                #sub_cont .sSolWrap {
                                    max-width: 1568px;
                                    margin: 0 auto;
                                    padding: 10px 30px;
                                    box-sizing: border-box;
                                }

                                .who,
                                #sub_cont .sSolWrap .sSol_contWrap .sSol_box .sSol_cont .sSol_ex,
                                #sub_cont .sSolWrap .sSol_contWrap .sSol_box .sSol_cont .sSol_char .sSol_charRow,
                                #sub_cont .sSolWrap .sSol_contWrap .sSol_box,
                                #sub_cont .sSolWrap .sSol_contWrap,
                                #sub_cont .sSolWrap .sSol_top .sSol_topBox,
                                #sub_cont .sSolWrap,
                                #sub_cont .s7Wrap .s7_row,
                                #sub_cont .s7Wrap,
                                #sub_cont .s2_cWrap,
                                #sub_cont .blueBox .s2_contWrap,
                                #sub_cont .blueBox .s6_contWrap,
                                #sub_cont .blueBox,
                                #sub_cont .sBusiness_wrap .sBusiness_box,
                                #sub_cont .sBusiness_wrap,
                                #sub_cont .s1_circleWrap .s1_cWrap,
                                #sub_cont .wp1180,
                                #sub_cont .wp1150,
                                #sub_cont .wp1410 {
                                    width: 100%;
                                    height: auto;
                                    overflow: hidden;
                                }

                                #sub_title>.sub_navi {
                                    width: 100%;
                                    height: 65px;
                                    background-color: #3754d1;
                                    color: #fff;
                                }

                                #sub_title>.sub_navi.sub_navi_sol ul {
                                    width: 65%;
                                    margin: 0 auto;
                                }

                                #sub_title>.sub_navi.sub_navi_sol li {
                                    width: 25%;
                                    margin-left: -1px;
                                }

                                #sub_title>.sub_navi li {
                                    float: left;
                                    width: 14.2857142857%;
                                    margin-left: -1px;
                                    text-align: center;
                                }

                                #sub_title>.sub_navi li>a {
                                    font-size: 16px;
                                }

                                #sub_title>.sub_navi li>a {
                                    display: inline-block;
                                    height: 100%;
                                    color: #fff;
                                    font-size: 18px;
                                    font-weight: normal;
                                    line-height: 65px;
                                    white-space: nowrap;
                                }

                                #sub_cont .sSolWrap .sSol_top .sSol_topTle {
                                    font-size: 32px;
                                }

                                #sub_cont .sSolWrap .sSol_top .sSol_topTle {
                                    font-size: 44.5px;
                                    font-weight: normal;
                                    text-align: center;
                                }

                                #sub_cont .sSolWrap .sSol_top .sSol_topBox {
                                    border: 1px solid #ddd;
                                    padding: 65px 10px;
                                    box-sizing: border-box;
                                    text-align: center;
                                    margin: 60px 0;
                                }

                                .aaa th {
                                    text-align: center;
                                }

                                .aaa td {
                                    text-align: center;
                                }

                                .a1 div {
                                    width: 50%;
                                    box-shadow: 2px 2px 2px 2px gray;
                                    padding: 1%, 1%, 1%, 1%;
                                }
                            </style>
                            <script>
                                let pop = 0;
                                let t = 0;
                                let t1 = 0;
                                let t2 = 1;

                                function openPop() {

                                    if (t == 1) {

                                        document.getElementById('carIn').style.display = "none";
                                        pop = 0;
                                        t = 0;
                                    } else {
                                        pop = 1;
                                        t = 1;
                                        t2 = 0;
                                        t1 = 0;
                                        document.getElementById('carIn').style.display = "block";
                                        document.getElementById('carUp').style.display = "none";
                                        document.getElementById('carList').style.display = "none";
                                    }
                                }
                                function openPop1() {

                                    if (t1 == 1) {

                                        document.getElementById('carUp').style.display = "none";
                                        pop = 0;
                                        t1 = 0;
                                    } else {
                                        pop = 1;
                                        t1 = 1;
                                        t = 0;
                                        t2 = 0;
                                        document.getElementById('carUp').style.display = "block";
                                        document.getElementById('carIn').style.display = "none";
                                        document.getElementById('carList').style.display = "none";
                                    }
                                }

                                function openPop2() {

                                    if (t2 == 1) {

                                        document.getElementById('carList').style.display = "none";
                                        pop = 0;
                                        t2 = 0;
                                    } else {
                                        pop = 1;
                                        t2 = 1;
                                        t = 0;
                                        t1 = 0;
                                        document.getElementById('carList').style.display = "block";
                                        document.getElementById('carIn').style.display = "none";
                                        document.getElementById('carUp').style.display = "none";
                                    }
                                }
                                function updateSet(id) {
                                    openPop1();
                                    document.getElementById('carIdUp').value = document.getElementById('carId_' + id).innerText.replace(/\s*/g, "", "")
                                    document.getElementById('carTypeUp').value = document.getElementById('carType_' + id).innerText.replace(/\s*/g, "", "")
                                    document.getElementById('carNumUp').value = document.getElementById('carNum_' + id).innerText.replace(/\s*/g, "", "")
                                    document.getElementById('distanceUp').value = document.getElementById('distance_' + id).innerText.replace(/\s*/g, "", "")
                                    document.getElementById('drivingAtUp').value = document.getElementById('drivingAt_' + id).innerText.replace(/\s*/g, "", "").replace('주행정지', '').replace('주행실행', '')


                                }
                            </script>
                    </head>

                    <body>
                        <div id="skip"><a href="#main">본문 바로가기</a></div>

                        <!-- HEADER -->
                        <header id="header" class="">
                            <h1 class="logo" id="mainlogo"><a href="http://www.bumil.co.kr/"><span
                                        class="blind">범일정보</span></a>
                            </h1>

                            <div class="quick_menu">
                                <h2 class="blind">퀵 메뉴 영역</h2>
                                <ul class="area">
                                    <li class="brochure"><a href="./bumil_introduction_v03.pdf" target="_blank"
                                            title="범일정보 회사소개서 새창">Company brochure</a></li>
                                    <li><a href="https://blog.naver.com/bumil_information" target="_blank"
                                            title="블로그가기 새창">Blog</a>
                                    </li>
                                    <li><a href="https://www.facebook.com/bumilinformation/" target="_blank"
                                            title="페이스북가기 새창">Facebook</a>
                                    </li>
                                    <li><a href="../" target="_blank" title="페이스북가기 새창">예약하기</a>
                                    </li>
                                </ul>
                            </div>
                        </header>
                        <!-- //HEADER -->


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

                        <div id="sub_main">
                            <div id="sub_title" class="type02">
                                <div class="sub_visual">
                                    <div class="sub_visualIn">
                                        <div class="cont">
                                            <h3>관리자 페이지</h3>
                                            <div class="ico_diagram">
                                                <div>
                                                    <div class="oval"></div>
                                                    <div class="oval"></div>
                                                    <div class="oval"></div>
                                                    <div class="oval"></div>

                                                    <div class="dash_line"></div>

                                                    <div class="line">
                                                        <div class="current"></div>
                                                    </div>
                                                    <div class="line">
                                                        <div class="current"></div>
                                                    </div>
                                                    <div class="line">
                                                        <div class="current"></div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="sub_navi sub_navi_sol">
                                    <ul>
                                        <li><a href="../mng">차량 관리</a></li>
                                        <li><a href="../mng/rs">예약 관리</a></li>
                                        <li><a href="../mng/logs">운행일지 관리</a></li>
                                        <li><a href="../mng/chart">통계</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div id="sub_cont">
                                <div class="sSolWrap">
                                    <div class="sSol_top">
                                        <p class="sSol_topTle"> 예약 통계</p>
                                        <div class="sSol_topBox">

                                            <div style="width: 100%; display: flex; margin-bottom: 5%;">
                                                <div style="width: 47%; 
                                                box-shadow: 2px 2px 2px 2px gray;
                                                margin-left: 1.5%;">
                                                    <p class="sSol_topTle"
                                                        style="font-size: 20px;float: left; margin-left: 10%; margin-top: 3%; margin-bottom: 3%;">
                                                        예약자 순위</p>
                                                    <canvas id="myChart"></canvas>
                                                </div>
                                                <div style="width: 47%; 
                                                box-shadow: 2px 2px 2px 2px gray;
                                                margin-left: 3%;">
                                                    <p class="sSol_topTle"
                                                        style="font-size: 20px;float: left; margin-left: 10%; margin-top: 3%; margin-bottom: 3%;">
                                                        예약현황</p>
                                                    <canvas id="myChart1"></canvas>
                                                </div>
                                            </div>
                                            <div style="width: 100%; display: flex; margin-bottom: 5%;">
                                                <div style="width: 47%; 
                                                box-shadow: 2px 2px 2px 2px gray;
                                                margin-left: 1.5%;">
                                                    <p class="sSol_topTle"
                                                        style="font-size: 20px;float: left; margin-left: 10%; margin-top: 3%; margin-bottom: 3%;">
                                                        운행목적</p>
                                                    <canvas id="myChart2"></canvas>
                                                </div>
                                                <div style="width: 47%; 
                                                box-shadow: 2px 2px 2px 2px gray;
                                                margin-left: 3%;">
                                                    <p class="sSol_topTle"
                                                        style="font-size: 20px;float: left; margin-left: 10%; margin-top: 3%; margin-bottom: 3%;">
                                                        반납사유 순위</p>
                                                    <canvas id="myChart3"></canvas>
                                                </div>
                                            </div>
                                            <script type="text/javascript">
                                                function getChart(id, type, label, labels, data) {
                                                    var context = document
                                                        .getElementById(id)
                                                        .getContext('2d');
                                                    var myChart = new Chart(context, {
                                                        type: type, // 차트의 형태
                                                        data: { // 차트에 들어갈 데이터
                                                            labels: labels
                                                            //x 축
                                                            ,
                                                            datasets: [
                                                                { //데이터
                                                                    label: label, //차트 제목
                                                                    fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                                                                    data: data //x축 label에 대응되는 데이터 값
                                                                    ,
                                                                    backgroundColor: [
                                                                        //색상
                                                                        'rgba(255, 99, 132, 0.2)',
                                                                        'rgba(54, 162, 235, 0.2)',
                                                                        'rgba(255, 206, 86, 0.2)',
                                                                        'rgba(75, 192, 192, 0.2)',
                                                                        'rgba(153, 102, 255, 0.2)',
                                                                        'rgba(255, 159, 64, 0.2)'
                                                                    ],
                                                                    borderColor: [
                                                                        //경계선 색상
                                                                        'rgba(255, 99, 132, 1)',
                                                                        'rgba(54, 162, 235, 1)',
                                                                        'rgba(255, 206, 86, 1)',
                                                                        'rgba(75, 192, 192, 1)',
                                                                        'rgba(153, 102, 255, 1)',
                                                                        'rgba(255, 159, 64, 1)'
                                                                    ],
                                                                    borderWidth: 1 //경계선 굵기
                                                                }/* ,
                                                            {
                                                                label: 'test2',
                                                                fill: false,
                                                                data: [
                                                                    8, 34, 12, 24
                                                                ],
                                                                backgroundColor: 'rgb(157, 109, 12)',
                                                                borderColor: 'rgb(157, 109, 12)'
                                                            } */
                                                            ]
                                                        },
                                                        options: {
                                                            scales: {
                                                                yAxes: [
                                                                    {
                                                                        ticks: {
                                                                            beginAtZero: true
                                                                        }
                                                                    }
                                                                ]
                                                            }
                                                        }
                                                    });

                                                }
                                                let days = "${days}";
                                                let dayCnt = "${dayCnt}";
                                                let labels = new Array;
                                                let data = new Array;
                                                for (let i = 0; i < 6; i++) {
                                                    labels[i] = String(days).replace("[", "").replace("]", "").split(", ")[i].split(" ")[0];
                                                    data[i] = String(dayCnt).replace("[", "").replace("]", "").split(", ")[i].split(" ")[0];
                                                }
                                                getChart('myChart1', 'line', '예약건', labels, data);



                                                labels = ['김성철', '전현철', '권우영', '손현준', '이진일', '이진일1', '이진일2'];
                                                data1 = [25, 0, 0, 0, 0, 0, 0];
                                                getChart('myChart', 'bar', '예약자', labels, data1);




                                                let data2 = new Array;
                                                let rsPurposeCnt = "${rsPurposeCnt}";
                                                for (let i = 0; i < 4; i++) {
                                                    data2[i] = String(rsPurposeCnt).replace("[", "").replace("]", "").split(", ")[i];

                                                }
                                                labels = ['기타', '출장', '행사', '교육'];
                                                getChart('myChart2', 'doughnut', '차량 취소', labels, data2);



                                                let data3 = new Array;
                                                let rsAt = "${rsAt}";
                                                for (let i = 0; i < 4; i++) {
                                                    data3[i] = String(rsAt).replace("[", "").replace("]", "").split(", ")[i];

                                                }
                                                labels = ['반납완료', '취소', '사고', '강제취소'];
                                                getChart('myChart3', 'pie', '차량 취소', labels, data3);
                                            </script>




                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </body>

                    </html>