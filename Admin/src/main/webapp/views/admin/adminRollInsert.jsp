<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 등록</title>
<link href="${contextPath }/resources/master.css" rel="stylesheet"
	type="text/css" />
<link href="${contextPath }/resources/member/css/memberInsert.css"
	rel="stylesheet" type="text/css" />
<link
	href="${contextPath }/resources/member/passwordValidate/css/passwordValidate.css"
	rel="stylesheet" type="text/css" />
<script src="${contextPath }/resources/member/js/insertMember.js"></script>
<!-- Daum 주소 API -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="${contextPath }/resources/member/passwordValidate/js/PasswordValidate.js"></script>
<script type="text/javascript">
	/**
	 *  중복체크 ajax 관련 로직입니다.
	 */

	function checkIdDuplicate() {
		const memId = document.querySelector('input[name="memId"]').value;
		const errorSpan = document.getElementById('id-error');

		// 아이디를 입력하지 않은 경우
		if (!memId) {
			errorSpan.textContent = '아이디를 입력해주세요.';
			return;
		}

		const xhr = new XMLHttpRequest();
		xhr.open('POST', '${contextPath}/adminCheckIdDuplicate.go', true);
		xhr.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded');

		xhr.onload = function() {
			if (xhr.status === 200) {
				const response = JSON.parse(xhr.responseText);

				if (response.isDuplicate) {
					errorSpan.textContent = '이미 사용 중인 아이디입니다.';
					errorSpan.style.color = 'red';
				} else {
					errorSpan.textContent = '사용 가능한 아이디입니다.';
					errorSpan.style.color = 'green';
				}
			} else {
				errorSpan.textContent = '서버 오류가 발생했습니다. 다시 시도해주세요.';
			}
		};

		xhr.onerror = function() {
			errorSpan.textContent = '네트워크 오류가 발생했습니다. 다시 시도해주세요.';
		};

		xhr.send('memId=' + encodeURIComponent(memId));
	}
	document.addEventListener('DOMContentLoaded', function() {
		const memIdInput = document.querySelector('input[name="memId"]');

		if (memIdInput) {
			memIdInput.addEventListener('blur', checkIdDuplicate);
		} else {
			console.error('Could not find input element with name "memId"');
		}
	});
</script>
</head>
<body>
	<div align="center">
		<h3>어드민 역활 등록</h3>
		<form action="${ contextPath }/adminRollInsert.do" method="post" onsubmit="return validatePasswords()">
			<table class="insertTableForm">
				<tr>
					<th>역활코드</th>
					<td><input type="text" name="rollCode" required></td>
				</tr>
				<tr>
					<th>역활 이름</th>
					<td><input type="text" name="adminName" required></td>
				</tr>
				<tr>
					<td class="table_bottom button memberInsertBtn" colspan="2">
						<input class="btn" type="submit" value="역활 등록"> 
						<input class="btn" type="reset" value="초기화">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
