PJAX for Rails 3.1+
===================

Integrate Chris Wanstrath's PJAX into Rails 3.1+ via the asset pipeline.

To activate, add this to your app/assets/javascripts/application.js (or whatever bundle you use):

    //=require pjax

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

Examples for redirect_pjax_to
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
        redirect_pjax_to :show, @project
      end
  
      def update
        @project.update_attributes params[:project]
        redirect_pjax_to :show, @project
      end
  
      def destroy
        @project.destroy

        index # set the objects needed for rendering index
        redirect_pjax_to :index
      end
  
      private
        def set_project
          @project = current_user.projects.find params[:id].to_i
        end
    end

PJAX OPTIONS (Fast and dirty solution)
------------
in application.js:

  window.pjax_options = { timeout: 5000 }
  
     container - The selector of the container to load the reponse body into, or
                 the container itself.
clickedElement - The element that was clicked to start the pjax call.
          push - Whether to pushState the URL. Defaults to true (of course).
       replace - Whether to replaceState the URL. Defaults to false.
       timeout - pjax sets this low, <1s. Set this higher if using a custom
                 error handler. It's in ms, so something like `timeout: 2000`
         error - By default this callback reloads the target page once `timeout`
                 ms elapses.