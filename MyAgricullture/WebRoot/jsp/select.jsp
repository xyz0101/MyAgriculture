<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>搜索叙词</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css"> 
#search{ 
text-align: center; 
position:relative; 
} 
.autocomplete{ 
border: 1px solid #9ACCFB; 
background-color: white; 
text-align: left; 
} 
.autocomplete li{ 
list-style-type: none; 
} 
.clickable { 
cursor: default; 
} 
.highlight { 
background-color: #9ACCFB; 
} 
</style> 
  </head>
  
  <body>
     <script type="text/javascript" src="./js/jquery.js"></script>
  <script type="text/javascript"> 
function checknull(){
    if($.trim($("#search-text").val())==""){
   
                $("#span").html("关键词不能为空");
               return false;
    }else
   return true;
    }

//alert(${requestScope.value });
//alert("weqwe");
$(function(){ 
//取得div层 
var $search = $('#search'); 
//取得输入框JQuery对象 
var $searchInput = $search.find('#search-text'); 
//关闭浏览器提供给输入框的自动完成 
$searchInput.attr('autocomplete','off'); 
//创建自动完成的下拉列表，用于显示服务器返回的数据,插入在搜索按钮的后面，等显示的时候再调整位置 
var $autocomplete = $('<div class="autocomplete"></div>') 
.hide() 
.insertAfter('#submit'); 
//清空下拉列表的内容并且隐藏下拉列表区 
var clear = function(){ 
$autocomplete.empty().hide(); 
}; 
//注册事件，当输入框失去焦点的时候清空下拉列表并隐藏 
$searchInput.blur(function(){ 
setTimeout(clear,500); 
}); 
//下拉列表中高亮的项目的索引，当显示下拉列表项的时候，移动鼠标或者键盘的上下键就会移动高亮的项目，想百度搜索那样 
var selectedItem = null; 
//timeout的ID 
var timeoutid = null; 
//设置下拉项的高亮背景 
var setSelectedItem = function(item){ 
//更新索引变量 
selectedItem = item ; 
//按上下键是循环显示的，小于0就置成最大的值，大于最大值就置成0 
if(selectedItem < 0){ 
selectedItem = $autocomplete.find('li').length - 1; 
} 
else if(selectedItem > $autocomplete.find('li').length-1 ) { 
selectedItem = 0; 
} 
//首先移除其他列表项的高亮背景，然后再高亮当前索引的背景 
$autocomplete.find('li').removeClass('highlight') 
.eq(selectedItem).addClass('highlight'); 
}; 

var ajax_request = function(){ 
//ajax服务端通信

$.ajax({ 
url:"findname", //服务器的地址 
data:"name="+$searchInput.val(), //参数 
//dataType:"json", //返回数据类型 
type:"POST", //请求类型 
success:function(data){ 
//alert(data);	
	//var result = JSON.parse(data); 
	//alert(data.jsonArray);
	 var state_value = data.split(",");  //result是和action中定义的result变量的get方法对应的
	// alert(state_value); 
if(state_value.length) { 
//遍历data，添加到自动完成区 
$.each(state_value, function(index,term) { 
//创建li标签,添加到下拉列表中 
$('<li></li>').text(term).appendTo($autocomplete) 
.addClass('clickable') 
.hover(function(){ 
//下拉列表每一项的事件，鼠标移进去的操作 
$(this).siblings().removeClass('highlight'); 
$(this).addClass('highlight'); 
selectedItem = index; 
},function(){ 
//下拉列表每一项的事件，鼠标离开的操作 
$(this).removeClass('highlight'); 
//当鼠标离开时索引置-1，当作标记 
selectedItem = -1; 
}) 
.click(function(){ 

//鼠标单击下拉列表的这一项的话，就将这一项的值添加到输入框中
 if(selectedItem<=24)
$searchInput.val(term); 
//清空并隐藏下拉列表 
$autocomplete.empty().hide(); 
}); 
});//事件注册完毕 
//设置下拉列表的位置，然后显示下拉列表 
var ypos = $searchInput.position().top; 
var xpos = $searchInput.position().left; 
$autocomplete.css('width',$searchInput.css('width')); 
$autocomplete.css({'position':'relative','left':xpos + "px",'top':ypos +"px"}); 
setSelectedItem(0); 
//显示下拉列表 
$autocomplete.show(); 
} 
} 
}); 
}; 
//对输入框进行事件注册 
$searchInput 
.keyup(function(event) { 
//字母数字，退格，空格 
if(event.keyCode > 40 || event.keyCode == 8 || event.keyCode ==32) { 
//首先删除下拉列表中的信息 
$autocomplete.empty().hide(); 
clearTimeout(timeoutid); 
timeoutid = setTimeout(ajax_request,100); 
} 
else if(event.keyCode == 38){ 
//上 
//selectedItem = -1 代表鼠标离开 
if(selectedItem == -1){ 
setSelectedItem($autocomplete.find('li').length-1); 
} 
else { 
//索引减1 
setSelectedItem(selectedItem - 1); 
} 
event.preventDefault(); 
} 
else if(event.keyCode == 40) { 
//下 
//selectedItem = -1 代表鼠标离开 
if(selectedItem == -1){ 
setSelectedItem(0); 
} 
else { 
//索引加1 
setSelectedItem(selectedItem + 1); 
} 
event.preventDefault(); 
} 
}) 
.keypress(function(event){ 
//enter键 
if(event.keyCode == 13) { 
//列表为空或者鼠标离开导致当前没有索引值 
if($autocomplete.find('li').length == 0 || selectedItem == -1) { 
return; 
} 
$searchInput.val($autocomplete.find('li').eq(selectedItem).text()); 
$autocomplete.empty().hide(); 
event.preventDefault(); 
} 
}) 
.keydown(function(event){ 
//esc键 
if(event.keyCode == 27 ) { 
$autocomplete.empty().hide(); 
event.preventDefault(); 
} 
}); 
//注册窗口大小改变的事件，重新调整下拉列表的位置 
$(window).resize(function() { 
var ypos = $searchInput.position().top; 
var xpos = $searchInput.position().left; 
$autocomplete.css('width',$searchInput.css('width')); 
$autocomplete.css({'position':'relative','left':xpos + "px",'top':ypos +"px"}); 
}); 
}); 
</script> 
  
  
   <center>   
   <form action="select" method="post" onsubmit="return checknull();">
   <div id = "search">
  <span id = "span">请输入关键词</span> <input type="text"  id="search-text"  name ="name">
   <input type="submit" id="submit" value="搜索">   
   </div>
   </form>
   </center>
  </body>
</html>
