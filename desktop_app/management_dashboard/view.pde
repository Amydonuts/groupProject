// Presentation logic
  ListBox l;
  Chart overview;
  DropdownList open_orders, processing_orders, in_transit_orders, delivered_orders ;
  int is_expanded = 0;
  
  
void updateDashboard(){
  view = new Dashboard_view();
 for (String status: Status.LIST){
   view.build_metric("total " + status, (float) data.getOrdersByStatus(status).length);
   view.build_list(status + "list", data.getOrdersByStatus(status));
   view.build_Chart(status + "chart", 1,2,3,4);
  } 
}
  
public class Dashboard_view {
  
  int is_expanded = 0;
  int vert_margin_spacing = 70;
  int horiz_margin_spacing = 70;
  int metric_x_size = 100;
  int metric_spacing = 0;
  int metric_y_size = 20;
  int list_spacing = 0;
  int list_x_size = 100;
  int list_y_size = 100;
  int chart_spacing = 0;
  int chart_size = 140;
 
  
  void build_Chart(String chart_name, int val, int val1, int val2, int val3)  {
    //Chart chart = cp5.addChart(chart_name);
    Chart chart = cp5.addChart(chart_name)
               .setPosition(horiz_margin_spacing + chart_spacing, 5*vert_margin_spacing)
               .setSize(chart_size,chart_size)
               .setRange(0, 10)
               .setView(5);
    chart.getColor().setBackground(color(255, 100));
    chart.addDataSet(chart_name);
    chart.setColors(chart_name, color(255), color(0, 255, 0));
    chart.updateData(chart_name, val, val1, val2, val3);
    
    chart_spacing = chart_spacing + chart_size + (chart_size / 5);
  }
  
  void build_metric(String name, Float value)  {
    cp5.addNumberbox(name)
    .setValue(value)
    .setPosition(horiz_margin_spacing, vert_margin_spacing + metric_spacing)
    .setSize(metric_x_size,metric_y_size);
    metric_spacing = metric_spacing + (2*metric_y_size);
  }
  
  void build_list(String list_name, JSONObject[] orders)  {
    ScrollableList list = cp5.addScrollableList(list_name)
          .setPosition((3*horiz_margin_spacing) + list_spacing, vert_margin_spacing)
          .setSize(list_x_size,list_y_size);
    list.setBackgroundColor(color(190));
    list.setItemHeight(20);
    list.setBarHeight(40);
    list.setColorBackground(color(60));
    list.setColorActive(color(255, 128));
    list_spacing = list_spacing + list_x_size + 10;
    list.clear();
    for (JSONObject order: orders){
      int i = 0;
      
      if(order != null){   
        list.addItem(order.getString("order_id"),i);
        i = i+1;
      }   
    }
  }
  
  void build_expanded_order(String orderid)  {
    
    if(is_expanded == 1){
    cp5.get("Expanded order").remove();
    is_expanded = 0;
  } 
    
    ListBox order = cp5.addListBox("Expanded order")
         .setPosition((3*horiz_margin_spacing), 3*vert_margin_spacing)
         .setSize(550, 320)
         .setItemHeight(15)
         .setBarHeight(15)
         .setColorBackground(color(255, 128))
         .setColorActive(color(0))
         .setColorForeground(color(255, 100,0)); 
         
    order.addItem(data.getOrderByID(orderid).getString("order_id"),0);
    order.addItem(data.getOrderByID(orderid).getString("order_status"),1);
    order.addItem(data.getOrderByID(orderid).getString("order_items"),2);
    order.addItem(data.getOrderByID(orderid).getString("order_total"),3);
    order.addItem(data.getOrderByID(orderid).getString("order_placed"),4);
    is_expanded = 1;
  } 
}
