PJAX for Rails 3.1+
===================

Integrate Chris Wanstrath's [PJAX](https://github.com/defunkt/jquery-pjax) into Rails 3.1+ via the asset pipeline.

To activate, add this to your app/assets/javascripts/application.js (or whatever bundle you use):

    //=require jquery.pjax

All links that match `$('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])')` will then use PJAX. 

The PJAX container has to be marked with data-pjax-container attribute, so for example:

    <body>
      <div>
        <!-- This will not be touched on PJAX updates -->
        <%= Time.now %>
      </div>

      <div data-pjax-container>
        <!-- PJAX updates will go here -->
        <%= content_tag :h3, 'My site' %>
        <%= link_to 'About me', about_me_path %>
        <!-- The following link will not be pjax'd -->
        <%= link_to 'Google', 'http://google.com', 'data-skip-pjax' => true %>
      </div>
    </body>


FIXME: Currently the layout is hardcoded to "application". Need to delegate that to the specific layout of the controller.

Examples for redirect_to
-----------------------------

    class ProjectsController < ApplicationController
      before_filter :set_project, except: [ :index, :create ]

      def index
        @projects = current_user.projects
      end
  
      def show
      end
  
      def create
        @project = Project.create params[:project]
        redirect_to :show, @project
      end
  
      def update
        @project.update_attributes params[:project]
        redirect_to :show, @project
      end
  
      def destroy
        @project.destroy

        index # set the objects needed for rendering index
        redirect_to :index
      end
  
      private
        def set_project
          @project = current_user.projects.find params[:id].to_i
        end
    end
