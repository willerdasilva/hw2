class Movie < ActiveRecord::Base
    # The controller method needs to set up this variable. And since the possible  
    #values of movie ratings are really the responsibility of the Movie model, 
    #it's best if the controller sets this variable by consulting the Model. 
    #Hence, you should create a class method of Movie that returns an appropriate value for this collection.
    
    #First make a collection, and make a getter for it.
    
    @@ratingsVar = ['G','PG','PG-13','R', 'NC-17']
    
    def self.ratingsVar
        @@ratingsVar
    end
    #@ratings = ['G','PG','PG-13','R']
    #def self.all_ratings
    #    a = Array.new
    #    self.select("rating").uniq.each {|x| a.push(x.rating)}
    #    a.sort.uniq
    #end
end
