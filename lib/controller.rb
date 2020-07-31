class Controller
   attr_reader :user, :article

   def run
      Article.articles_filtered
      welcome
      areyou
   end
  
  def welcome
   puts ""
   puts "** Welcome!! **"
   puts ""      
   end

   def areyou
      yes_or_no = PROMPT.yes?("** Are you a new user? **")
      if yes_or_no
          puts "** Let's signup then! **"
          User.create_user
      else 
          User.login
      end
  end 

   def self.intro
   puts ""
   puts "Welcome to The New York Times:Top Stories for the arts section."
   puts ""
   intro_select = PROMPT.select("** What do you want to do today? **",%w(All_articles Your_saved_articles Exit))
       case intro_select
       when "All_articles"
           Controller.random_articles
       when "Your_saved_articles"
           
       when "Exit"
           puts"** Hope to see you soon! **"
         exit = exit(true)  
       end
   end

# Once user logs in, we want to present them with random titles from the New York Times Arts section Top Posts.

   def self.random_articles
      @category_list = Article.all.collect do |articles|
         articles.category.capitalize
      end.uniq
      #binding.pry
      Controller.select_articles  
   end

   def self.select_articles
      @selection = PROMPT.select("Please choose a category you are interested in.", @category_list)
      puts ""
      puts "Nice pick! You chose #{@selection.blue}. Here are all the articles from The New York Times for your chosen category."
      puts ""     
      Controller.contained_articles
   end

   def self.contained_articles
      @variable = []
      Article.all.each do |article|
         if article.category.capitalize == @selection
            @variable << article
         end
      end
      self.article_attributes
   end

   def self.article_attributes
   #@article_selections = 
   @variable.each do |article|
           puts "Title:".blue + " " + "#{article.title}"
           puts "Description:".blue + " " + "#{article.abstract}"
           puts "Author:".blue + " " + "#{article.author}"
           puts "URL:".blue + " " + "#{article.url}"
         puts " "
         end
        #awesome_print(@article_selections)
      # self.add_to_favorites
   end

   # def self.add_to_favorites
   #    PROMPT.select(" Please choose your favorite article. ", @article_selections)
   #    binding.pry
   # end


end
