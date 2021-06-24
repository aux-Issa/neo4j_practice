class UnivsController < ApplicationController
    def index
        @univs = Univ.all
    end   
end
