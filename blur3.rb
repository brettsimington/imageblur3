class Image
  attr_reader :image_blur
  
  def initialize(image_array)
    if image_array.empty?
      puts "need image"
    end
    @image_array = image_array
  end
  
  def output_image
    @image_array.each do |element|   
      element.each do |sub_element|
        print sub_element     
      end
      puts
    end
  end
    
# imageblur2
  def perf_image_trans
    
    @cells_with_ones = []
    @image_blur = @image_array

    @image_array.each_with_index do |row, row_index|
      sub_element_indices = @image_array[row_index].each_index.select{|i| row[i] == 1}
      unless sub_element_indices.empty?
        sub_element_indices.each do |index|
          @cells_with_ones << [row_index, index] 
        end
      end
    end

    @cells_with_ones.each do |coords|  
      case
 
      when coords[0] == 0 && coords[1] == 0
        @image_blur[0][1] = 1
        @image_blur[1][0] = 1

      when coords[0] == 0 && coords[1] == row_length-1
        @image_blur[0][row_length-2] = 1
        @image_blur[1][row_length-1] = 1
      
      when coords[0] == image_length-1 && coords[1] == 0
        @image_blur[image_length-2][0] = 1
        @image_blur[image_length-1][1] = 1
      
      when coords[0] == image_length-1 && coords[1] == row_length-1
        @image_blur[image_length-2][row_length-1] = 1
        @image_blur[image_length-1][row_length-2] = 1
      
      when coords[0] == 0  && coords[1]-1 >= 0 && coords[1]-1 < row_length-1
        @image_blur[0][coords[1]-1] = 1
        @image_blur[0][coords[1]+1] = 1
        @image_blur[1][coords[1]] = 1
        
      when coords[1] == row_length-1 && coords[0] > 0 && coords[0] < image_length-1

        @image_blur[coords[0]-1][coords[1]] = 1
        @image_blur[coords[0]][coords[1]-1] = 1
        @image_blur[coords[0]+1][coords[1]] = 1
        
      when coords[0] == image_length-1 && coords[1] > 0 && coords[1] < image_length-1

        @image_blur[coords[0]-1][coords[1]] = 1
        @image_blur[coords[0]][coords[1]-1] = 1
        @image_blur[coords[0]][coords[1]+1] = 1
          
      when coords[1] == 0 && coords[0] > 0 && coords[0] < image_length-1

        @image_blur[coords[0]-1][coords[1]] = 1
        @image_blur[coords[0]][coords[1]+1] = 1
        @image_blur[coords[0]+1][coords[1]] = 1
        
      else
        @image_blur[coords[0]-1][coords[1]] = 1
        @image_blur[coords[0]][coords[1]+1] = 1
        @image_blur[coords[0]+1][coords[1]] = 1
        @image_blur[coords[0]][coords[1]-1] = 1
      
      end
    end
  end



# iamge blur 3
  def blur(distance)
    @image_blur = @image_array
    distance.times do
      perf_image_trans
    end
  end 
  # iamge blur 3
  


  def image_length
    @image_array.length
  end

  def row_length
    @image_array[0].length
  end
end

image = Image.new([
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 0]
])

image2 = Image.new([
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 0]
])

image3 = Image.new([
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 1]
])


puts "original image 1"
image.output_image
image.blur(2)
puts
puts "manhattan image 1"
image = Image.new(image.image_blur)
image.output_image
puts

puts "original image 2"
image2.output_image
image2.blur(2)
puts
puts "manhattan image 2"
image2 = Image.new(image2.image_blur)
image2.output_image
puts

puts "original image 3"
image3.output_image
image3.blur(2)
puts
puts "manhattan image 3"
image3 = Image.new(image3.image_blur)
image3.output_image
puts