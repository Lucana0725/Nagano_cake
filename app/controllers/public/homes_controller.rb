class Public::HomesController < ApplicationController
  def top
    # トップページで表示する新着商品を、新着上位4件分だけ取ってくる
    @items = Item.order('created_at DESC').limit(4)
  end
  
  def about
    
  end
end
