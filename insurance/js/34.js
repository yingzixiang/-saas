	$(".titleChange a:eq(0)").addClass("hover");
	$(".titleChange a").click(function(){
		$(this).addClass("hover").siblings("a").removeClass("hover");
		switch($(this).index()){
			case 1:$("#Event").hide().siblings("#AboutRun").show();break;
			case 0:$("#Event").show().siblings("#AboutRun").hide();
		}
	});	
	$(".btn").attr("href","01.html?code="+localStorage.getItem("code"));
//创建的跑团
var memberId=localStorage.getItem("memberId");
$.ajax({
	url:'http://xb.guegg.com/group/myGroupList',
	type:'get',
	data:{
		memberId:memberId,
		type:1
	},
	success:function(obj){
		console.log(obj);
			if(obj.result==0){
				$("#MyPaotuanNo").show();			
			}else{
				$("#MyPaotuanNo").hide();
				$("#MyPaotuanList").show();
				$("#MyPaotuanList").html("");
				for(var i=0,MyPaotuanList="";i<obj.groupList.length;i++){
					MyPaotuanList+="<li><div class='myrungrouplist'>"
						+"<p><img src='"+
						obj.groupList[i].groupLogo
						+"'/></p><div><p>"+
						obj.groupList[i].groupGroupname
						+"</p><p>所在地：<span>"+
						obj.groupList[i].groupCity
					+"</span>   &nbsp;&nbsp;成员：<span>"+
					obj.groupNum[i]
					+"</span></p></div><button alt='"+obj.groupList[i].groupId+"'>管理跑团</button></div></li>";
					//$($(".myrungrouplist>button")[i]).attr("onclick","javascript:window.location.href='42.html?groupId="+obj.groupList[i].groupId+"')";
				}
				$("#MyPaotuanList").html(MyPaotuanList);
				$(".myrungrouplist button").click(function(){
					var i=$(this).index();
					window.location.href="42.html?groupId="+$(this).attr("alt");
				});
			}
		}
});
//加入的跑团
$.ajax({
	//url:"http://192.168.0.206:8080/group/myGroupList?memberId=10002&type=1",
	url:'http://xb.guegg.com/group/myGroupList',
	type:'get',
	data:{
		memberId:memberId,
		type:0
	},
	success:function(obj){
		console.log(obj);
		$("#search").hide();
		if(obj.result==1){
			$("#tuijian").html("");
			details(obj.groupList[0].groupId);
			/*for(var i=0,MyPaotuanList="";i<obj.groupList.length;i++){
				MyPaotuanList+="<li><img src='img/run33/36_04.png'/><div class='myrungrouplist'>"
					+"<p><img src='"+
					obj.groupList[i].groupLogo
					+"'/></p><div><p>"+
					obj.groupList[i].groupGroupname
					+"</p><p>所在地：<span>"+
					obj.groupList[i].groupCity
				+"</span>   &nbsp;&nbsp;成员：<span>"+
				obj.groupNum[i]
				+"</span></p></div><a class='xiangq' onclick='xiangqing("+obj.groupList[i].groupId+")'></a></div></li>";
				localStorage.setItem("groupId",obj.groupList[i].groupId);
			}
			$("#tuijian").html(MyPaotuanList);*/
		}else if(obj.result==0){
			$("#search").show();
			for(var i=0,MyPaotuanList="";i<obj.groupList.length;i++){
				MyPaotuanList+="<li><div class='myrungrouplist'>"
					+"<p><img src='"+
					obj.groupList[i].groupLogo
					+"'/></p><div><p>"+
					obj.groupList[i].groupGroupname
					+"</p><p>所在地：<span>"+
					obj.groupList[i].groupCity
				+"</span>   &nbsp;&nbsp;成员：<span>"+
				obj.groupNum[i]
				+"</span></p></div><button alt='"+obj.groupList[i].groupId+"'></button></div></li>";
			}
			console.log(MyPaotuanList);
			$("#tuijian").html(MyPaotuanList).show();
			$("#tuijian button").click(function(){
					var i=$(this).index();
					window.location.href="40.html?groupId="+$(this).attr("alt");
			});
		}
	}
});
function details(groupId){
	$("#details").show();
	$.ajax({
			type:"get",
			url:"http://xb.guegg.com/group/groupDetail",
			data:{
				groupId:groupId
				//groupId:2
			},
			async:true,
			success:function(obj){
				console.log(obj);
				if(obj.result==1){
					$("#details h1").html(obj.myGroup.groupGroupname);
					$('.logo img').attr("src","");
					$('.logo img').attr("src",obj.myGroup.groupLogo);
					$("#details ul li:eq(1)").html("<img src='img/images/039_07.png'/>"+obj.myGroup.groupApplicantsname);
					$("#details ul li:eq(2)").html("<img src='img/images/039_09.png'/>"+obj.myGroup.groupCity);
					$("#details ul li:eq(3)").html("<img style='margin: 14px 20px 14px 0px;' src='img/images/039_12.png'/>"+obj.myGroup.groupIntroduce);
					$("#details ul li:eq(4)").html("<img src='img/images/039_14.png'/>"+obj.groupNum+"人");
				}else if(obj.result==0){
					alert("暂无此跑团信息！");
				}
			},
			error:function(){
				$.toast("网路错误","cancel");
			}
		});
}	
	