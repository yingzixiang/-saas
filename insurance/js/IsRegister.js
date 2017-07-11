var openid, memberId;
coded = localStorage.getItem("code");
code = window.location.href.split(/code=/)[1].split(/&/)[0];
localStorage.setItem("code", code);
if(coded == code) {
	$(".modalReg").hide();
} else {
	$.ajax({
		type: "get",
		url: "http://xb.guegg.com/code/getCode?code="+code,
		async: true,
		success: function(obj) {
			openid = obj.openid;
			localStorage.setItem("openid", openid);
			if(obj.result == 1) {
				$(".modalReg").hide();
				memberId = obj.memberId;
				localStorage.setItem("memberId", memberId);
				//window.location.reload();
			} else if(obj.result == 0){
				$(".modalReg").show();
				validation();
			}
		},
		error: function(){
			$(".modalReg").hide();
		}
	});
}
//弹出验证信息
function validation() {
	$(".yanzhenma").click(function(e) {
		e.preventDefault();
		var memberMobile = $(".contentPhone input").val();
		if(/^1[3|4|5|7|8]\d{9}$/.test(memberMobile)) {
			$.ajax({
				url: "http://xb.guegg.com/running/member/register",
				type: "post",
				data: {
					memberMobile: memberMobile,
					openid: openid
				},
				async: true,
				success: function(obj) {
					if(obj.result==1){
						memberId = obj.memberId;
						localStorage.setItem("memberId", memberId);
						$.toast("验证成功");
						$(".modalReg").hide();
						$(".weui_toast").fadeOut("slow");
						window.location.reload();
					}else{
						alert("注册失败！");
					}
				},
				error: function() {
					alert("手机验证出错");

				}
			});
		} else {
			alert("手机号码错误");
			$(".yanzhenma").html("");
			$(".yanzhenma").html("重发");
		}
	});
}