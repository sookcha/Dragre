class DragreController < ApplicationController
  def index
    foldername = params[:foldername]
    uploaded_io = params[:file]
    if (uploaded_io != nil)
    File.open(Rails.root.join('public', 'files', uploaded_io.original_filename), 'wb') do |file|
       file.write(uploaded_io.read)
     end
   end
    @mb = 1024.0 * 1024.0
    if foldername == nil
      dir = 'public/files/*'
      @dirs = Dir.glob(dir).select {|f| File.directory? f}
      @files = Dir.glob(dir).select {|f| File.file? (f)} 
    else
      dir = 'public/files/' + foldername + '/*'
      @dirs = Dir.glob(dir).select {|f| File.directory? f}
      @files = Dir.glob(dir).select {|f| File.file? (f)} 
    end
  end
end