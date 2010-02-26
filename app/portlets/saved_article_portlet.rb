class SavedArticlePortlet < Portlet
  
  def render
    #Check whether the user is logged in or not.
    if logged_in?
      # Your Code Goes Here
      limit=20
      unless params[:show].blank?
        @saved_article=SaveArticle.find(:all, :conditions=>"user_id=#{current_user.id}")
      else
        @saved_article=SaveArticle.find(:all, :conditions=>"user_id=#{current_user.id}", :limit=>limit)  
      end
      
      unless @saved_article.blank?
        #If number of saved articles are odd in number then add odd one in left list
        if(@saved_article.length%2==0)
          @saved_article_left=@saved_article.first(@saved_article.length/2)
        else
          @saved_article_left=@saved_article.first(@saved_article.length/2 +1)
        end
        
        @saved_article_right=@saved_article.last(@saved_article.length/2)
      end
    end
  end
  
end