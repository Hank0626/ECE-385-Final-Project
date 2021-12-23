//-------------------------------------------------------------------------
//    collision.sv                                                       --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module collision
(
			input 	[9:0] x,
			input 	[9:0] y,
			input  	[6:0] width,
			input 	[6:0] height,
			output 	is_collide_up,
						is_collide_down,
						is_collide_left,
						is_collide_right,
						// Modify
						is_collide_left_end,
						is_collide_right_end
		);

		logic	[9:0] x_left_cen;
		logic [9:0] x_right_cen;
		logic	[9:0] y_top_cen;
		logic [9:0] y_bottom_cen;
		logic num = 0;
		assign x_left_cen = x - width / 2;
		assign x_right_cen = x + width / 2;
		
		assign y_top_cen = y - height / 2;
		assign y_bottom_cen = y + height / 2;


		logic [16:0] address1,
						 address2,
						 address3,
						 address4,
						 // Modify
						 address5,
						 address6;

		assign address1 = x / 4 + y_top_cen / 4 * 160;  //top
		assign address2 = x / 4 + y_bottom_cen / 4 * 160;  //bottom
		assign address3 = x_left_cen / 4 + y / 4 * 160;  //left
		assign address4 = x_right_cen / 4 + y / 4 * 160;  //right
		
		// Modify
		assign address5 = (x - 8) / 4 + (y_bottom_cen - 4) / 4 * 160;  // left_end
		assign address6 = (x + 8) / 4 + (y_bottom_cen - 4) / 4 * 160;  // right_end
		
		
		
		
		logic [23:0] col1,
						 col2,
						 col3,
						 col4,
						 // Modify
						 col5,
						 col6;
		
		
		
		map1_rom color1(.read_address(address1), .color_output(col1));
		map1_rom color2(.read_address(address2), .color_output(col2));
		map1_rom color3(.read_address(address3), .color_output(col3));
		map1_rom color4(.read_address(address4), .color_output(col4));	
		map1_rom color5(.read_address(address5), .color_output(col5));			
		map1_rom color6(.read_address(address6), .color_output(col6));	
		
		
		always_comb begin
			if (col1 == 24'h716734 || col1 == 24'h5f582b)
				is_collide_up = 1'b1;
			else
				is_collide_up = 1'b0;
				
			if (col2 == 24'h716734 || col2 == 24'h5f582b)
				is_collide_down = 1'b1;
			else
				is_collide_down = 1'b0;
			
			if (col3 == 24'h716734 || col3 == 24'h5f582b)
				is_collide_left = 1'b1;
			else
				is_collide_left = 1'b0;
			if (col4 == 24'h716734 || col4 == 24'h5f582b)
				is_collide_right = 1'b1;
			else
				is_collide_right = 1'b0;
			if (col5 == 24'h716734 || col5 == 24'h5f582b)
				is_collide_left_end = 1'b1;
			else
				is_collide_left_end = 1'b0;
			if (col6 == 24'h716734 || col6 == 24'h5f582b)
				is_collide_right_end = 1'b1;
			else
				is_collide_right_end = 1'b0;
			
	
		end
endmodule

module collision_board
(
			input 	[9:0] x,
			input 	[9:0] y,
			input  	[6:0] width,
			input 	[6:0] height,
			input    [9:0] board_x_pos,
			input    [9:0] board_y_pos,
			output 	is_collide_down_board
		);

		logic	[9:0] x_left_cen;
		logic [9:0] x_right_cen;
		logic	[9:0] y_top_cen;
		logic [9:0] y_bottom_cen;

		assign x_left_cen = x - width / 2;
		assign x_right_cen = x + width / 2;
		
		assign y_top_cen = y - height / 2;
		assign y_bottom_cen = y + height / 2;

		always_comb begin
		if (x >= board_x_pos - 34 && x <= board_x_pos + 34 && y_bottom_cen >= board_y_pos - 7 && y_bottom_cen <= board_y_pos - 5)
			is_collide_down_board = 1'b1;
		else
			is_collide_down_board = 1'b0;
		
		end
endmodule


