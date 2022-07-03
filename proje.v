module proje(clk,start,bin0,bin1,registeredbin,bf1,bf2,bf3,bf4,isitstart,b,clk25,o_hsync,o_vsync,color);

input clk;
input start;
input bin0;
input bin1;
output reg [17:0]bf1 =18'b111111111111111111;
output reg [17:0]bf2 =18'b111111111111111111;
output reg [17:0]bf3 =18'b111111111111111111;
output reg [17:0]bf4 =18'b111111111111111111;
reg [4:0]ind1 = 0;
reg [4:0]ind2 = 0;
reg [4:0]ind3 = 0;
reg [4:0]ind4 = 0;
output reg [7:0] color;
output reg clk25=0;
output o_hsync;
output o_vsync;
reg [9:0] counter_x = 0;  // horizontal counter
reg [9:0] counter_y = 0;  // vertical counter
reg [20:0] cnt = 0;
reg [7:0]empty[0:2703];
reg [7:0]r0[0:2499];
initial begin
	$readmemh("empty.list", empty);
	$readmemh("r0.list", r0);
	end
	

reg [10:0] drop;
reg [3:0] dummy;
output reg b = 1;
reg a ;
initial a = 0 ;
reg inside1=0;
reg inside2=0;
reg inside3=0;
reg inside4=0;
reg [4:0] i =0 ;


output reg [1:0] isitstart;
initial isitstart = 0;

reg [1:0] fourcyc;
initial fourcyc = 0 ;


output reg [3:0] registeredbin;


always @ (posedge clk) begin
	clk25 = ~clk25;

for (i =0 ; i<6 ; i = i+3) begin // o bit 4 değilse doludur kaç dolu var onu buluyo
		if (bf1[3*i+2] != 1) begin
			inside1 <= inside1 + 1;
		end
		if (bf2[3*i+2] != 1) begin
			inside2 <= inside2 + 1;
		end
		if (bf3[3*i+2] != 1) begin
			inside3 <= inside3 + 1;
		end
		if (bf4[3*i+2] != 1) begin
			inside4 <= inside4 + 1;
		end	
	end

	if (start == 0 && isitstart <3) begin
	isitstart <= isitstart +1 ;
	end
	
	if (isitstart == 3) begin
	b<=0;
		case ({bin1,bin0,cnt}) 
		
		3'b111 : begin
		cnt <= 0 ;
		end
		
		3'b100 : begin
		dummy[fourcyc] = 0 ;
		cnt <= 1 ;
		fourcyc <= fourcyc +1;
		if(fourcyc == 3) begin
			registeredbin[3] = dummy[0];
			registeredbin[2] = dummy[1];
			registeredbin[1] = dummy[2];
			registeredbin[0] = dummy[3];
			isitstart <= 0 ;
		end 
		end
		
		3'b010 :  begin
		dummy[fourcyc] = 1 ;
		cnt <= 1 ;
		fourcyc <= fourcyc +1;
		if(fourcyc == 3) begin
			registeredbin[3] = dummy[0];
			registeredbin[2] = dummy[1];
			registeredbin[1] = dummy[2];
			registeredbin[0] = dummy[3];	
			isitstart <= 0;
		end 
		
		
		
		end
		
		default : a <= 1;
		endcase		
		
end

	if (isitstart == 0) b<=1;

end
always @( posedge(b)) begin


	case(registeredbin[3:2]) 

		00: begin
				if(bf1[15]==0) drop <= drop+1;
				bf1[17:3]= bf1[14:0];
				bf1[2:0]= {1'b0,registeredbin[1:0]};
				
//loss hesaplama
			end
		
		01: begin
			if(bf2[15]==0) drop <= drop+1;	
				bf2[17:3]= bf1[14:0];
				bf2[2:0]= {1'b0,registeredbin[1:0]};
//loss hesaplama
			end
		
		10: begin
		if(bf3[15]==0) drop <= drop+1;
				bf3[17:3]= bf1[14:0];
				bf3[2:0]= {1'b0,registeredbin[1:0]};
//loss hesaplama
			end
		
		11: begin
		if(bf4[15]==0) drop <= drop+1;
				bf4[17:3]= bf1[14:0];
				bf4[2:0]= {1'b0,registeredbin[1:0]};
//loss hesaplama
			end
		
endcase

end

always @(posedge clk25)  // horizontal counter
		begin 
			if (counter_x < 799)
				counter_x <= counter_x + 1;  // horizontal counter (including off-screen horizontal 160 pixels) total of 800 pixels 
			else
				counter_x <= 0;              
		end  // always 
	
	always @ (posedge clk25)  // vertical counter
		begin 
			if (counter_x == 799)  // only counts up 1 count after horizontal finishes 800 counts
				begin
					if (counter_y < 525)  // vertical counter (including off-screen vertical 45 pixels) total of 525 pixels
						counter_y <= counter_y + 1;
					else
						counter_y <= 0;              
				end  // if (counter_x...
		end  // always

assign o_hsync = (counter_x >= 0 && counter_x < 96) ? 1:0;  // hsync high for 96 counts                                                 
assign o_vsync = (counter_y >= 0 && counter_y < 2) ? 1:0;   // vsync high for 2 counts
	always @ (posedge clk)
		begin
			if(counter_x>=154&& counter_x<206&& counter_y>=40&& counter_y<92&&bf1[2:0]==7) begin //B1/6
			color <= empty[(counter_x-154)* 52+(counter_y-40)];
			end else if(counter_x>=155&& counter_x<205&& counter_y>=41&& counter_y<91&&bf1[2:0]==0) begin //B1/6
			color <= r0[(counter_x-155)* 50+(counter_y-41)];
		
			end else if(counter_x>=154&& counter_x<206&& counter_y>=92&& counter_y<144) begin
			color <= empty[(counter_x-154)* 52+(counter_y-92)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=144&& counter_y<196) begin
			color <= empty[(counter_x-154)* 52+(counter_y-144)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=196&& counter_y<248) begin
			color <= empty[(counter_x-154)* 52+(counter_y-196)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=248&& counter_y<300) begin
			color <= empty[(counter_x-154)* 52+(counter_y-248)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=300&& counter_y<352) begin //B1/1
			color <= empty[(counter_x-154)* 52+(counter_y-300)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=40&& counter_y<92) begin //B2/6
			color <= empty[(counter_x-216)* 52+(counter_y-40)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=92&& counter_y<144) begin 
			color <= empty[(counter_x-216)* 52+(counter_y-92)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=144&& counter_y<196) begin
			color <= empty[(counter_x-216)* 52+(counter_y-144)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=196&& counter_y<248) begin
			color <= empty[(counter_x-216)* 52+(counter_y-196)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=248&& counter_y<300) begin
			color <= empty[(counter_x-216)* 52+(counter_y-248)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=300&& counter_y<352) begin //B2/1
			color <= empty[(counter_x-216)* 52+(counter_y-300)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=40&& counter_y<92) begin //B3/6
			color <= empty[(counter_x-278)* 52+(counter_y-40)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=92&& counter_y<144) begin 
			color <= empty[(counter_x-278)* 52+(counter_y-92)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=144&& counter_y<196) begin
			color <= empty[(counter_x-278)* 52+(counter_y-144)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=196&& counter_y<248) begin
			color <= empty[(counter_x-278)* 52+(counter_y-196)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=248&& counter_y<300) begin
			color <= empty[(counter_x-278)* 52+(counter_y-248)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=300&& counter_y<352) begin //B3/1
			color <= empty[(counter_x-278)* 52+(counter_y-300)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=40&& counter_y<92) begin //B4/6
			color <= empty[(counter_x-340)* 52+(counter_y-40)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=92&& counter_y<144) begin 
			color <= empty[(counter_x-340)* 52+(counter_y-92)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=144&& counter_y<196) begin
			color <= empty[(counter_x-340)* 52+(counter_y-144)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=196&& counter_y<248) begin
			color <= empty[(counter_x-340)* 52+(counter_y-196)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=248&& counter_y<300) begin
			color <= empty[(counter_x-340)* 52+(counter_y-248)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=300&& counter_y<352) begin //B4/1
			color <= empty[(counter_x-340)* 52+(counter_y-300)];
			
			

		end else begin
			color <=0;
			end
	
	
		end
	
endmodule