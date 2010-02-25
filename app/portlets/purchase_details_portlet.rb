class PurchaseDetailsPortlet < Portlet
    
  def render
    limit=10
    unless params[:show].blank?
      @order_detail=Product.find( :all, 
          :joins  =>  " as p INNER JOIN variants v ON v.product_id=p.id
                       INNER JOIN line_items li ON li.variant_id=v.id
                       INNER JOIN orders as o ON o.id = li.order_id", 
          :select =>  "p.name as product_name, o.id as order_id, o.total as order_total, o.created_at"
           )
    else
      @order_detail=Product.find( :all, 
          :joins  =>  " as p INNER JOIN variants v ON v.product_id=p.id
                       INNER JOIN line_items li ON li.variant_id=v.id
                       INNER JOIN orders as o ON o.id = li.order_id", 
          :select =>  "p.name as product_name, o.id as order_id, o.total as order_total, o.created_at",
           :limit=>limit)
    end
   
 end
    
end