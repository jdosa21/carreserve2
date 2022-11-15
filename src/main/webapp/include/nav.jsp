<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<script>
		function loginCk(a,b,c,d,e) {
			var level = '<%=(String)session.getAttribute("MEMBER_LEVEL")%>';
			var id = '<%=String.valueOf(session.getAttribute("LOGIN_ID"))%>';
			if (level == a) {
				alert(c+" 회원아이디로 로그인해 주십시오");
				var aTag = document.createElement('a');
				aTag.setAttribute('id', 'head_content');
				aTag.setAttribute('class', 'nav-link active" aria-current="page');
				aTag.setAttribute('href', '/include/login.jsp');
				aTag.setAttribute('data-bs-toggle', 'modal');
				aTag.setAttribute('data-bs-target', '#exampleModal');
										document.charset = "UTF-8";
										document.body.appendChild(aTag);
										aTag.click();
			} else if (level && level != b) {
				alert(c+" 회원아이디로 로그인해 주십시오");
				var aTag = document.createElement('a');
				aTag.setAttribute('id', 'head_content');
				aTag.setAttribute('class', 'nav-link active" aria-current="page');
				aTag.setAttribute('href', '/include/login.jsp');
				aTag.setAttribute('data-bs-toggle', 'modal');
				aTag.setAttribute('data-bs-target', '#exampleModal');
										document.charset = "UTF-8";
										document.body.appendChild(aTag);
										aTag.click();
			} else {
				if(e=='1'){
					location.replace("http://localhost:8080/"+d);
				}else{
					location.replace("http://localhost:8080/"+d+"?"+e+"="+id);
				}	
			}
		}

		
	</script>
	<div class="container-fluid" id="nav_menu">
		<div class="row">
			<div id="dev_img" class="col-4" style="height: 60px;">
				<h1 style="line-height: 60px;">
					<a style="text-decoration: none; color: black" href="http://localhost:8080/main"><b
							style="font-size: 50px">dev.com</b></a>
				</h1>
			</div>
			<div class="col-8" style="border-radius: 28px 0px 0px 28px; background-color: #4aa8d8; height: 60px">
				<div class="container">
					<div class="row">
						<div id="nav_content" class="col-3">
							<a href="/recruitment"><b style="color: white; font-size: 20px">채용정보</b></a>
						</div>
						<div id="nav_content" class="col-3">
							<a href="http://localhost:8080/talent"><b style="color: white; font-size: 20px">인재정보</b></a>
						</div>
						<div id="nav_content" class="col-3">
							<c:choose>
								<c:when test="${MEMBER_LEVEL =='1'}">
									<a href="javascript:loginCk('0','1','기업','post/insertForm','compyId')"><b
											style="color: white; font-size: 20px">채용공고작성</b></a>
								</c:when>
								<c:otherwise>
									<a href="javascript:loginCk('1','0','일반','resumes/insertForm','mbrId')"><b
											style="color: white; font-size: 20px">이력서작성</b></a>
								</c:otherwise>
							</c:choose>
						</div>
						<div id="nav_content" class="col-3">
							<a href="javascript:loginCk('0','1','기업','companyMain','1')"><b style="color: white; font-size: 20px">기업회원</b></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>