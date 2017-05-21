<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
   <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
	<meta charset="utf-8" />
    <script src="./js/echarts.js"></script>
 <script src="./js/macarons.js"></script>
   
</head>
<body>
    <div id="main" style="width:1300px; height:600px;">
   <script type="text/javascript" src="./js/jquery.js"></script>

    </div>
    <script>
        //初始化echarts实例
        var myChart = echarts.init(document.getElementById("main"), "macarons");
        var option = {
            backgroundColor: new echarts.graphic.RadialGradient(0.3, 0.3, 0.8, [{
                offset: 0,
                color: '#f7f8fa'
            }, {
                offset: 1,
                color: '#cdd0d5'
            }]),

            animationDuration: 3000,
            animationEasingUpdate: 'quinticInOut',

            tooltip: {
                show: true
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} : {b}'
            },
            toolbox: {
                show: true,
                feature: {
                    restore: { show: true },
                    magicType: { show: true, type: ['force', 'chord'] },
                    saveAsImage: { show: true }
                }
            },

            title: {
                text:"echarts入门实例"
            },
            
           
          
            series: [{
                itemStyle: {

                    
                    normal: {
                        label: {

                            position: 'top',

                            show: true,
                            textStyle: {
                                color: '#333'
                            }
                        },
                        nodeStyle: {
                            brushType: 'both',
                            borderColor: 'rgba(255,215,0,0.4)',
                            borderWidth: 1
                        },
                        linkStyle: {
                            normal: {
                                color: 'source',
                                curveness: 0,
                                type: "solid"
                            }
                        }
                    },
                   
                },
                     force:{
                    initLayout: 'circular',
                    repulsion:100,
                },

                     animation: false,
                name:"",
                type: 'graph',//关系图类型
                layout: 'force',//引力布局
                roam: true,//可以拖动
              //  legendHoverLink: true,//是否启用图例 hover(悬停) 时的联动高亮。
               // hoverAnimation: false,//是否开启鼠标悬停节点的显示动画
               // coordinateSystem: null,//坐标系可选
              //  xAxisIndex: 0, //x轴坐标 有多种坐标系轴坐标选项
              //  yAxisIndex: 0, //y轴坐标 
               // ribbonType: true,
                useWorker: false,
                minRadius: 15,
                maxRadius: 25,
                gravity: 1.1,
               
                scaling: 1.1,
                nodes: ${requestScope.node},
                links: ${requestScope.link}
            } ]            
        }
        myChart.setOption(option);
       //var ecConfig = require('echarts/config');
       ///合并数组去重复
       function mergeArray(arr1, arr2){ 
 for (var i = 0 ; i < arr1.length ; i ++ ){
   for(var j = 0 ; j < arr2.length ; j ++ ){
    if (arr1[i] === arr2[j]){
     arr1.splice(i,1); //利用splice函数删除元素，从第i个位置，截取长度为1的元素
    }
   }
 }
 for(var i = 0; i <arr2.length; i++){
  arr1.push(arr2[i]);
 }
 return arr1;
}
////比较数组去重复
  function subArray(arr1, arr2){ 
 for (var i = 0 ; i < arr1.length ; i ++ ){
   for(var j = 0 ; j < arr2.length ; j ++ ){
    if (arr1[i] === arr2[j]){
     arr1.splice(i,1); //利用splice函数删除元素，从第i个位置，截取长度为1的元素
    }
   }
 }
 return arr1;
}
      // var index=0;
        myChart.on('click',   function openOrFold(param) {
       
            var option = myChart.getOption();//获取已生成图形的option
            var nodesOption = option.series[0].nodes;//获得所有节点数组
            var linksOption = option.series[0].links;//获得所有连接的数组
            var data = param.data;//表示当前选择的某一节点
            var linksNodes = [];//中间变量
          var first=  nodesOption[0].id
          
            if (data.category == (0)) {
               
            }
            //添加点击事件
            if (typeof param.seriesIndex == 'undefined') {    
                return;    
            }  
            
            
			 // alert(param.data.flag)
            if (param.type == 'click'&&param.name!=first&&param.data.flag==true) { 
            	//alert(data.flag)
            	var jadata=[]; 
            	var jlink=[];  
				   var index=0;
           for(i=0;i<nodesOption.length;i++){
           if(nodesOption[i].id==data.id){
          // alert(nodesOption[i].id+"---"+data.id)
           index=i;
          // alert(index)
           }
           }
                $.ajax({ 
                    url:"getNextData", //服务器的地址 
                    data:"name="+param.name, //参数 
                 
                    dataType:"text", //返回数据类型 
                    type:"POST", //请求类型 
                    success:function(ja){ 
                    //param.data.flag=false
                        var result =JSON.parse(ja);//转化为json对象
                       // alert(nodesOption[index].flag)
                     nodesOption[index].flag=false
                       // 	alert(JSON.stringify(result))
                   //    if(index%2==0){
                  // nodesOption[i].flag = false
                       nodesOption= mergeArray(nodesOption,result)//数组合并
                     //  }else {
                     //  nodesOption= subArray(nodesOption,result)//删除重复
                     //  }
                      
                       
                        myChart.setOption(option);//重新绘制
                        
                    },
                    
                });	
							
                $.ajax({ 
                    url:"getNextLink", //服务器的地址 
                    data:"name="+param.name, //参数 
                    dataType:"text", //返回数据类型 
                
                    type:"POST", //请求类型 
                    success:function(jalink){ 
                   // param.data.flag=false
                        var result =JSON.parse(jalink);
                   //  alert(JSON.stringify(result[0]))
                //  if(index%2==0){
                	//linksOption[index].flag = false
                       linksOption= mergeArray(linksOption,result)//数组合并
                    //   }else {
                    //   linksOption= subArray(linksOption,result)//删除重复
                   //    }
                         myChart.setOption(option);//重新绘制
                    },
                    
                });	
             //index++;
            }    
            //判断是否选择到了连接线上
          /*  if (data != null && data != undefined) {
                
                if (data.flag) {
                    //遍历关系数组，最终获得所选节点的一层子节点
                    for ( var m in linksOption) {
                        //父节点为当前节点
                        if (linksOption[m].target == data.id) {
							
                            linksNodes.push(linksOption[m].source);//获得子节点数据
                        }
                    }
                    //遍历子节点数组，设置对应的option属性
                    if (linksNodes != null && linksNodes != undefined) {
                        for ( var p in linksNodes) {
                            nodesOption[linksNodes[p]].ignore = false;//设置展示该节点
                            nodesOption[linksNodes[p]].flag = true;
                        }
                    }
                    nodesOption[data.id].flag = false;//设置该节点的flag为false，下次点击折叠子孙节点
                    myChart.setOption(option);//重新绘制
                } else {

                    for ( var m in linksOption) {
                        
                        if (linksOption[m].target == data.id) {//父节点为当前节点
                            linksNodes.push(linksOption[m].source);//找到当前节点的第一层子节点
                        }
                        if (linksNodes != null && linksNodes != undefined) {
                            for ( var n in linksNodes) {
                                //第一层子节点作为父节点，找到所有子孙节点
                                if (linksOption[m].target == linksNodes[n]) {
                                    linksNodes.push(linksOption[m].source);
                                }
                            }
                        }
                    }
                    //遍历最终生成的连接关系数组
                    if (linksNodes != null && linksNodes != undefined) {
                        for ( var p in linksNodes) {
                            nodesOption[linksNodes[p]].ignore = true;//设置折叠该节点
                            nodesOption[linksNodes[p]].flag = true;
                            $(".message").hide();
                        }
                    }
                    nodesOption[data.id].flag = true;//设置该节点的flag为true，下次点击展开子节点
                    myChart.setOption(option);//重绘
                }
            }*/
        }
       
       ); 
       
    </script>


</body>
</html>
