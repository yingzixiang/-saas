//表单验证输入为正整数
function inputNum(id){
	var inp = $(id);
    inp.blur(function(){
    var inpVal = inp.val();
    if(!isNaN(inpVal)&&inpVal>=0){ 
	}else{
        alert('请输入正整数');
        inp.val("");
      }
    })
}