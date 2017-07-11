<!--%
	/* *
	 *功能：支付宝手机网站支付接口调试入口页面
	 *版本：3.3
	 *日期：2012-08-17
	 *说明：
	 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
	 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%-->
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<title>活动报名</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
		<link href="css/index.css" type="text/css" rel="stylesheet" />
		<script src="js/jquery-2.2.4.js" type="text/javascript" charset="utf-8"></script>
	</head>

	<body>
		<div id="div0">
			<div id="divp">
			<p class="img1"><img class="id1" src="img/p5.png" /></p>
			<p class="img2"><img class="id1" src="img/p16.png" /></p>
			</div>
			<div id="div1">
				<p id="p1">魔都最污的跑步活动</p>
				<p id="p2">2016年08月10号开始</p>
				<p id="p3">杭州鑫苑国际影城正门集合</p>
				<p id="p4">小巴跑团承办</p>
				<div class="div">
					<p id="p5">99</p>
					<p id="p6">2016年08月08日</p>
				</div>
				<div class="div">
					<p id="p7">你负责跑,其余的交给我们,小巴跑团再次出发......</p>
				</div>
			</div>
			<div id="divul">
			<ul class="Price">
				<li>
					<div id="text"><span class="font1">￥</span><span class="font1">50.00</span></div>
				</li>
				<li><button type="button" id="more" onclick="more()" class="btn1">详情</button></li>
				<li><button type="button" id="book" onclick="book()" class="btn1">预定</button></li>
			</ul>
			</div>
		</div>
		<div id="imgMore">
			<img id="det" src="img/p8.png" />
			<img id="cancel" src="img/p9.png" onclick="can()" />
		</div>
		<form id="div2" name=alipayment action=alipayapi.jsp method=post target="_blank">
			<div id="div3">
				<p id="t1"><span>亲爱的,</span><span>小小巴</span></p>
				<p id="t2"><b>请填写一下信息，以便正常参加各类户外活动</b></p>
				<input id="inp1" type="text" />
				<input id="inp2" type="text"/>
				<input id="inp3" type="text"/>
				<input id="inpp1" name="WIDout_trade_no" style="display:none" />
				<input id="inpp2" name="WIDsubject" style="display:none" />
				<input id="inpp3" name="WIDtotal_fee" style="display:none" />
				<input id="inpp4" name="WIDshow_url" style="display:none" />
			</div>
			<img id="create" src="img/p11.png" />
			<img id="ok" src="img/p10.png" onclick="make_sure()" />
			<img id="cha" src="img/p9.png" onclick="call_off()" />
			<div class="modal" id="modal2">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="GroupErr">
							<p>个人信息填写完成</p>
							<p>
								<button type="submit"><a onclick="pay_it()" target="_blank">去付款</a></button>
								<a onclick="dis_play()">继续填写</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</form>
		<div class="modal" id="modal1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="GroupErr">
						<p id="title">真实姓名填写有误</p>
						<p>
							<a onclick="dis_play()">去修改</a>
							<a onclick="call_off()">狠心离去</a>
						</p>
					</div>
				</div>
			</div>
		</div>
		
	</body>
	<script type="text/javascript">
		function more() {
			document.getElementById("more").style.background = "linear-gradient(to bottom, #d84252 0%, #e4683c 100%)";
			document.getElementById("imgMore").style.display = "block";
			document.getElementById("book").disabled=true;
		}
		function can() {
			document.getElementById("imgMore").style.display = "none";
			document.getElementById("more").style.background = "linear-gradient(to bottom, #fe885e 0%, #f77067 100%)";
		    document.getElementById("book").disabled=false;
		}

		function book() {
			document.getElementById("book").style.background = "linear-gradient(to bottom, #d84252 0%, #e4683c 100%)";
			document.getElementById("div2").style.display = "block";
			document.getElementById("more").disabled=true;
		}
		function make_sure() {
			var inp1 = document.getElementById("inp1").value;
			var inp2 = document.getElementById("inp2").value;
			var inp3 = document.getElementById("inp3").value;
			if(!/^[\u4e00-\u9fa5]{2,}$/.test(inp1)) {　
				document.getElementById("modal1").style.display = "block";
			} else if(!(/^\d{18}$/.test(inp2) || /^\d{17}x$/.test(inp2))) {
				document.getElementById("title").innerHTML = "身份证填写有误";
				document.getElementById("modal1").style.display = "block";
			} else if(!/^\d{11}$/.test(inp3)) {
				document.getElementById("title").innerHTML = "联系电话填写有误";
				document.getElementById("modal1").style.display = "block";
			} else {
				document.getElementById("modal2").style.display = "block";
			}
			document.getElementById("more").disabled=false;
			
		}

		function call_off() {
			document.getElementById("modal1").style.display = "none";
			document.getElementById("div2").style.display = "none";
			document.getElementById("book").style.background = "linear-gradient(to bottom, #fe885e 0%, #f77067 100%)";
			document.getElementById("more").disabled=false;
		}
		function pay_it() {
			/*alert("付款");
			var name=$("#inp1").val();
			var Idcard=$("#inp2").val();
			var iPcard=$("#inp3").val();
			console.log(name);
			$.ajax({
				url:"alipayapi.jsp",
				data:{
					WIDout_trade_no:"2016829105121907",
					WIDsubject:"",
					WIDtotal_fee:"100",
					WIDshow_url:''
				},
				type:"post",
				dataType:"html",
				success:function(obj){
					console.log(obj);
				},
				error:function(){
					
				}
			})*/
			var vNow = new Date();
			var sNow = "";
			sNow += String(vNow.getFullYear());
			sNow += String(vNow.getMonth() + 1);
			sNow += String(vNow.getDate());
			sNow += String(vNow.getHours());
			sNow += String(vNow.getMinutes());
			sNow += String(vNow.getSeconds());
			sNow += String(vNow.getMilliseconds());
			$("#inpp1").val("");
			$("#inpp2").val("");
			$("#inpp3").val("");
			$("#inpp1").val(sNow);
			$("#inpp2").val("");
			$("#inpp3").val($("#text span:eq(1)").html());
		}
		pay_it();
		function dis_play() {
			document.getElementById("modal1").style.display = "none";
			document.getElementById("modal2").style.display = "none";
		}
	</script>
	<script>
		/*$.ajax({
			url:"http://192.168.0.206:8080/activity/myActivityDetails",
			type:"post",
			data:{
				activityId:1
			},
			success:function(obj){
				console.log(obj);
				if(obj.result==1){
					$("#p1").html("");
					$("#p2").html("");
					$("#p3").html("");
					$("#p4").html("");
					$("#p1").html(obj.aicivity.activityName);
					$("#p2").html(obj.aicivity.startTime);
					$("#p3").html(obj.aicivity.activityActaddress);
					$("#p4").html(obj.aicivity.);
				}else{
					
				}
			}
		})*/
		
		 
	</script>
</html>