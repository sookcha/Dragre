class DragreController < ApplicationController
  def index
    
    foldername = params[:foldername]
    uploaded_io = params[:file]
    fl = params[:fl]
    
    @mb = 1024.0 * 1024.0
    if foldername == nil
      dir = 'public/files/*'
      puts(dir)
      @dirs = Dir.glob(dir).select {|f| File.directory? f}
      @files = Dir.glob(dir).select {|f| File.file? (f)} 
    else
      dir = 'public/files/'+foldername+'/*'
      puts(dir)
      @dirs = Dir.glob(dir).select {|f| File.directory? f}
      @files = Dir.glob(dir).select {|f| File.file? (f)} 
    end
  end
end