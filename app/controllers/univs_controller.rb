class UnivsController < ApplicationController
    def index
        @univs = Univ.all
        @faculties = Faculty.all
    end   
end
