% 3D Run length Encoding
clc; 
clearvars -except data

[ column_number, row_number, frame_number ] = size (data); % obtain the size of the data

frame_depth = 2; 
vector_final = [];
vector_final_2D = [];
vector_final_3D = [];
length_bitstream_total = 0;
total_2D_bitstream = [];
total_3D_bitstream = [];

% loop for depth 
for iter_depth = 1 : 2 : frame_number-1 % : frame_number        
   
    v_1 = scan_form( data( :, :, iter_depth ), 'spiral' );   % first frame depth
    v_2 = scan_form( data( :, :, iter_depth+1 ), 'spiral' ); % second frame depth 

    [ ~, vector_row_number ] = size( v_1 );
    vector_depth_3D = [];
    
    vector_2D_1 = RLE_length ( v_1 );   
    vector_2D_2 = RLE_length ( v_2 );
    vector_final_2D = cat ( 2, vector_final_2D, [ vector_2D_1 vector_2D_2 ] );
    
    [ vector_final_2D_row, vector_final_2D_column ] = size ( vector_final_2D );
    
    for iter_vector_2D = 1: vector_final_2D_column
        
        bitstream_2D = dec2bin( vector_final_2D ( iter_vector_2D ) );
        total_2D_bitstream = cat( 2, total_2D_bitstream, bitstream_2D );
    
    end
    
     
    for iter_vector = 1 : vector_row_number

        if( v_1( iter_vector ) == v_2( iter_vector ) )

           vector_depth_3D =  cat (2, vector_depth_3D, v_1( iter_vector ));

        else % add special number that is not used in tha raw data '2' 

            vector_buffer = [ 2 v_1(iter_vector) v_2(iter_vector)];
            vector_depth_3D = cat (2, vector_depth_3D, vector_buffer);

        end

    end
    
    % concantinate a specail character to decode the bitstream
    % vector_depth = cat ( 2, vector_depth, 3 );
    vector_final = cat ( 2, vector_final, vector_depth_3D);
    vector_final_frames = RLE_length ( vector_final );
    vector_final_3D = cat ( 2, vector_final_3D, vector_final_frames ) ;
   
    [ vector_final_3D_row, vector_final_3D_column ] = size ( vector_final_3D );
    
    for iter_vector_3D = 1: vector_final_3D_column
        
        bitstream_3D = dec2bin( vector_final_3D ( iter_vector_3D ) );
        total_3D_bitstream = cat( 2, total_3D_bitstream, bitstream_3D );
        
    end
    
end  
    



