module proje(clk,start,bin0,bin1,registeredbin,bf1,bf2,bf3,bf4,isitstart,b,clk25,o_hsync,o_vsync,color,inside1,inside2,inside3,inside4,readout);

input clk;
input start;
input bin0;
input bin1;
output reg [17:0]bf1 =18'b111111111111111111;
output reg [17:0]bf2 =18'b111111111111111111;
output reg [17:0]bf3 =18'b111111111111111111;
output reg [17:0]bf4 =18'b111111111111111111;
output reg [7:0] color;
output reg clk25=0;
output o_hsync;
output o_vsync;
reg [9:0] counter_x = 0;  // horizontal counter
reg [9:0] counter_y = 0;  // vertical counter
reg [7:0]empty[0:2703];
reg [7:0]r0[0:2499];
reg [7:0]r1[0:2499];
reg [7:0]r2[0:2499];
reg [7:0]r3[0:2499];
reg [7:0]g0[0:2499];
reg [7:0]g1[0:2499];
reg [7:0]g2[0:2499];
reg [7:0]g3[0:2499];
reg [7:0]b0[0:2499];
reg [7:0]b1[0:2499];
reg [7:0]b2[0:2499];
reg [7:0]b3[0:2499];
reg [7:0]y0[0:2499];
reg [7:0]y1[0:2499];
reg [7:0]y2[0:2499];
reg [7:0]y3[0:2499];
reg [7:0]zero[0:63];
reg [7:0]one[0:63];
reg [7:0]two[0:63];
reg [7:0]three[0:63];
reg [7:0]four[0:63];
reg [7:0]five[0:63];
reg [7:0]six[0:63];
reg [7:0]seven[0:63];
reg [7:0]eight[0:63];
reg [7:0]nine[0:63];
reg [7:0]transmitted[0:9999];
reg [7:0]received[0:9999];
reg [7:0]dropped[0:9999];
reg [7:0]read[0:1499];
reg [6:0]drop1;
reg [6:0]drop2;
reg [6:0]drop3;
reg [6:0]drop4;
reg [6:0]dropt;
reg [1:0] h=0;

reg [3:0]drop11;
reg [3:0]drop21;
reg [3:0]drop31;
reg [3:0]drop41;
reg [3:0]drop12;
reg [3:0]drop22;
reg [3:0]drop32;
reg [3:0]drop42;
reg [3:0]dropt1;
reg [3:0]dropt2;
output reg [1:0]readout =0;
reg [28:0] r=0;
reg cnt;
initial cnt = 0;
initial begin
	$readmemh("empty.list", empty);
	$readmemh("r0.list", r0);
	$readmemh("r1.list", r1);
	$readmemh("r2.list", r2);
	$readmemh("r3.list", r3);
	$readmemh("g0.list", g0);
	$readmemh("g1.list", g1);
	$readmemh("g2.list", g2);
	$readmemh("g3.list", g3);
	$readmemh("y0.list", y0);
	$readmemh("y1.list", y1);
	$readmemh("y2.list", y2);
	$readmemh("y3.list", y3);
	$readmemh("b0.list", b0);
	$readmemh("b1.list", b1);
	$readmemh("b2.list", b2);
	$readmemh("b3.list", b3);
	$readmemh("zero.list", zero);
	$readmemh("one.list", one);
	$readmemh("two.list", two);
	$readmemh("three.list", three);
	$readmemh("four.list", four);
	$readmemh("five.list", five);
	$readmemh("six.list", six);
	$readmemh("seven.list", seven);
	$readmemh("eight.list", eight);
	$readmemh("nine.list", nine);
	$readmemh("transmitted.list", transmitted);	
	$readmemh("received.list", received);	
	$readmemh("dropped.list", dropped);		
	end
	

reg [10:0] drop;
reg [3:0] dummy;
output reg b = 1;
reg a ;
initial a = 0 ;
output reg [3:0]inside1=0;
output reg [3:0]inside2=0;
output reg [3:0]inside3=0;
output reg [3:0]inside4=0;
reg [3:0] inside1a;
reg [3:0] inside2a;
reg [3:0] inside3a;
reg [4:0] i =0 ;
reg e =1;
reg k;
output reg [1:0] isitstart;
initial isitstart = 0;

reg [1:0] fourcyc;
initial fourcyc = 0 ;


output reg [3:0] registeredbin;


always @ (posedge clk) begin
if (r < 750000000)  r <= r+1;
if (r==749999999)   r<=0;
	clk25 = ~clk25;
k<=1;
inside1=0;
inside2=0;
inside3=0;
inside4=0;

for (i =0 ; i<6 ; i = i+1) begin // o bit 4 değilse doludur kaç dolu var onu buluyo
		if (bf1[3*i+2] != 1) begin
			inside1 = inside1 + 1;
		end
		if (bf2[3*i+2] != 1) begin
			inside2 = inside2 + 1;
		end
		if (bf3[3*i+2] != 1) begin
			inside3 = inside3 + 1;
		end
		if (bf4[3*i+2] != 1) begin
			inside4 = inside4 + 1;
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
			registeredbin[3] <= dummy[0];
			registeredbin[2] <= dummy[1];
			registeredbin[1] <= dummy[2];
			registeredbin[0] <= dummy[3];
			isitstart <= 0 ;
			k<=0;
		end 
		end
		
		3'b010 :  begin
		dummy[fourcyc] = 1 ;
		cnt <= 1 ;
		fourcyc <= fourcyc +1;
		if(fourcyc == 3) begin
			registeredbin[3] <= dummy[0];
			registeredbin[2] <= dummy[1];
			registeredbin[1] <= dummy[2];
			registeredbin[0] <= dummy[3];	
			isitstart <= 0;
			k<=0;
		end 
		
		
		
		end
		
		default : a <= 1;
		endcase		
		
end

	//if (isitstart == 0) b<=1;
// read 3 second



	


if(r!=749999999&&k==0)begin
	case(registeredbin[3:2]) 

		2'b00: begin
				if(bf1[17]==0) drop1 = drop1+1;
				bf1[17:3]= bf1[14:0];
				bf1[2:0]= {1'b0,registeredbin[1:0]};
				
//loss hesaplama
			end
		
		2'b01: begin
			if(bf2[17]==0) drop2 = drop2+1;	
				bf2[17:3]= bf2[14:0];
				bf2[2:0]= {1'b0,registeredbin[1:0]};
//loss hesaplama
			end
		
		2'b10: begin
		if(bf3[17]==0) drop3 = drop3+1;
				bf3[17:3]= bf3[14:0];
				bf3[2:0]= {1'b0,registeredbin[1:0]};
//loss hesaplama
			end
		
		2'b11: begin
			if(bf4[17]==0) drop4 = drop4+1;
				bf4[17:3]= bf4[14:0];
				bf4[2:0]= {1'b0,registeredbin[1:0]};
//loss hesaplama
			end

endcase

drop11 <= drop1%10;
drop12 <= drop1/10;
drop21 <= drop2%10;
drop22 <= drop2/10;
drop31 <= drop3%10;
drop32 <= drop3/10;
drop41 <= drop4%10;
drop42 <= drop4/10;
dropt<=drop1+drop2+drop3+drop4;
dropt1<=dropt%10;
dropt2<=dropt/10;

end

if ( r == 749999999) begin
	
	if ( inside4 >= 3) begin
	
	readout <= ({bf4[(3*inside4-2)],bf4[(3*inside4-3)]});
	bf4[3*inside4-1] <= 1;
	bf4[3*inside4-2] <= 1;
	bf4[3*inside4-3] <= 1;
	e<=0;
	h<=11;
	end else if ( inside4 < 3 && inside3>=4) begin
	
	readout <= ({bf3[(3*inside3-2)],bf3[(3*inside3-3)]});
	bf3[3*inside3-1] <= 1;
	bf3[3*inside3-2] <= 1;
	bf3[3*inside3-3] <= 1;
	e<=0;
	h<=10;
	end else if ( inside4 < 3 && inside3 < 4 && inside2>=5) begin
	
	readout <= ({bf2[(3*inside2-2)],bf2[(3*inside2-3)]});
	bf2[3*inside2-1] <= 1;
	bf2[3*inside2-2] <= 1;
	bf2[3*inside2-3] <= 1;
	e<=0;
	h<=01;
	end else if (inside4 < 3 && inside3 < 4 && inside2<5 && inside1>=5) begin
	
	readout <= ({bf1[(3*inside1-2)],bf1[(3*inside1-3)]});
	bf1[3*inside1-1] <= 1;
	bf1[3*inside1-2] <= 1;
	bf1[3*inside1-3] <= 1;
	e<=0;
	h<=00;
	end else if (inside4 < 3 && inside3 < 4 && inside2<5 && inside1<5 && inside1>0) begin
	readout <= ({bf1[(3*inside1-2)],bf1[(3*inside1-3)]});
	bf1[3*inside1-1] <= 1;
	bf1[3*inside1-2] <= 1;
	bf1[3*inside1-3] <= 1;
	e<=0;
	h<=00;
	end else if (inside4 < 3 && inside3 < 4 && inside2<5 && inside1<5 && inside1==0 &&inside2>0) begin
	
	readout <= ({bf2[(3*inside2-2)],bf2[(3*inside2-3)]});
	bf2[3*inside2-1] <= 1;
	bf2[3*inside2-2] <= 1;
	bf2[3*inside2-3] <= 1;
	e<=0;
	h<=01;
	end else if (inside4 < 3 && inside3 < 4 && inside2<5 && inside1<5 && inside1==0 &&inside2==0 && inside3>0) begin
	
	readout <= ({bf3[(3*inside3-2)],bf3[(3*inside3-3)]});
	bf3[3*inside3-1] <= 1;
	bf3[3*inside3-2] <= 1;
	bf3[3*inside3-3] <= 1;
	e<=0;
	h<=10;
	end else if (inside4 < 3 && inside3 < 4 && inside2<5 && inside1<5 && inside1==0 &&inside2==0 && inside3==0 && inside4 >0) begin
	
	readout <= ({bf4[(3*inside4-2)],bf4[(3*inside4-3)]});
	bf4[3*inside4-1] <= 1;
	bf4[3*inside4-2] <= 1;
	bf4[3*inside4-3] <= 1;
	e<=0;
	h<=11;
	end else if(inside1==0 &&inside2==0 && inside3==0 && inside4 ==0) begin
	
	e<=1;
	end

	

end
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
			if(counter_x>=154&& counter_x<206&& counter_y>=40&& counter_y<92&&bf1[17:15]==7) begin //B1/6
			color <= empty[(counter_x-154)* 52+(counter_y-40)];			
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=92&& counter_y<144&&bf1[14:12]==7) begin
			color <= empty[(counter_x-154)* 52+(counter_y-92)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=144&& counter_y<196&&bf1[11:9]==7) begin
			color <= empty[(counter_x-154)* 52+(counter_y-144)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=196&& counter_y<248&&bf1[8:6]==7) begin
			color <= empty[(counter_x-154)* 52+(counter_y-196)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=248&& counter_y<300&&bf1[5:3]==7) begin
			color <= empty[(counter_x-154)* 52+(counter_y-248)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=300&& counter_y<352&&bf1[2:0]==7) begin //B1/1
			color <= empty[(counter_x-154)* 52+(counter_y-300)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=40&& counter_y<92&&bf2[17:15]==7) begin //B2/6
			color <= empty[(counter_x-216)* 52+(counter_y-40)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=92&& counter_y<144&&bf2[14:12]==7) begin 
			color <= empty[(counter_x-216)* 52+(counter_y-92)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=144&& counter_y<196&&bf2[11:9]==7) begin
			color <= empty[(counter_x-216)* 52+(counter_y-144)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=196&& counter_y<248&&bf2[8:6]==7) begin
			color <= empty[(counter_x-216)* 52+(counter_y-196)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=248&& counter_y<300&&bf2[5:3]==7) begin
			color <= empty[(counter_x-216)* 52+(counter_y-248)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=300&& counter_y<352&&bf2[2:0]==7) begin //B2/1
			color <= empty[(counter_x-216)* 52+(counter_y-300)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=40&& counter_y<92&&bf3[17:15]==7) begin //B3/6
			color <= empty[(counter_x-278)* 52+(counter_y-40)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=92&& counter_y<144&&bf3[14:12]==7) begin 
			color <= empty[(counter_x-278)* 52+(counter_y-92)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=144&& counter_y<196&&bf3[11:9]==7) begin
			color <= empty[(counter_x-278)* 52+(counter_y-144)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=196&& counter_y<248&&bf3[8:6]==7) begin
			color <= empty[(counter_x-278)* 52+(counter_y-196)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=248&& counter_y<300&&bf3[5:3]==7) begin
			color <= empty[(counter_x-278)* 52+(counter_y-248)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=300&& counter_y<352&&bf3[2:0]==7) begin //B3/1
			color <= empty[(counter_x-278)* 52+(counter_y-300)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=40&& counter_y<92&&bf4[17:15]==7) begin //B4/6
			color <= empty[(counter_x-340)* 52+(counter_y-40)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=92&& counter_y<144&&bf4[14:12]==7) begin 
			color <= empty[(counter_x-340)* 52+(counter_y-92)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=144&& counter_y<196&&bf4[11:9]==7) begin
			color <= empty[(counter_x-340)* 52+(counter_y-144)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=196&& counter_y<248&&bf4[8:6]==7) begin
			color <= empty[(counter_x-340)* 52+(counter_y-196)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=248&& counter_y<300&&bf4[5:3]==7) begin
			color <= empty[(counter_x-340)* 52+(counter_y-248)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=300&& counter_y<352&&bf4[2:0]==7) begin //B4/1
			color <= empty[(counter_x-340)* 52+(counter_y-300)];
			///// 0
			end else if(counter_x>=154&& counter_x<206&& counter_y>=40&& counter_y<92&&bf1[17:15]==0) begin //B1/6
			color <= r0[(counter_x-154)* 50+(counter_y-40)];			
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=92&& counter_y<144&&bf1[14:12]==0) begin
			color <= r0[(counter_x-154)* 50+(counter_y-92)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=144&& counter_y<196&&bf1[11:9]==0) begin
			color <= r0[(counter_x-154)* 50+(counter_y-144)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=196&& counter_y<248&&bf1[8:6]==0) begin
			color <= r0[(counter_x-154)* 50+(counter_y-196)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=248&& counter_y<300&&bf1[5:3]==0) begin
			color <= r0[(counter_x-154)* 50+(counter_y-248)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=300&& counter_y<352&&bf1[2:0]==0) begin //B1/1
			color <= r0[(counter_x-154)* 50+(counter_y-300)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=40&& counter_y<92&&bf2[17:15]==0) begin //B2/6
			color <= g0[(counter_x-216)* 50+(counter_y-40)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=92&& counter_y<144&&bf2[14:12]==0) begin 
			color <= g0[(counter_x-216)* 50+(counter_y-92)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=144&& counter_y<196&&bf2[11:9]==0) begin
			color <= g0[(counter_x-216)* 50+(counter_y-144)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=196&& counter_y<248&&bf2[8:6]==0) begin
			color <= g0[(counter_x-216)* 50+(counter_y-196)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=248&& counter_y<300&&bf2[5:3]==0) begin
			color <= g0[(counter_x-216)* 50+(counter_y-248)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=300&& counter_y<352&&bf2[2:0]==0) begin //B2/1
			color <= g0[(counter_x-216)* 50+(counter_y-300)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=40&& counter_y<92&&bf3[17:15]==0) begin //B3/6
			color <= b0[(counter_x-278)* 50+(counter_y-40)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=92&& counter_y<144&&bf3[14:12]==0) begin 
			color <= b0[(counter_x-278)* 50+(counter_y-92)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=144&& counter_y<196&&bf3[11:9]==0) begin
			color <= b0[(counter_x-278)* 50+(counter_y-144)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=196&& counter_y<248&&bf3[8:6]==0) begin
			color <= b0[(counter_x-278)* 50+(counter_y-196)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=248&& counter_y<300&&bf3[5:3]==0) begin
			color <= b0[(counter_x-278)* 50+(counter_y-248)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=300&& counter_y<352&&bf3[2:0]==0) begin //B3/1
			color <= b0[(counter_x-278)* 50+(counter_y-300)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=40&& counter_y<92&&bf4[17:15]==0) begin //B4/6
			color <= y0[(counter_x-340)* 50+(counter_y-40)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=92&& counter_y<144&&bf4[14:12]==0) begin 
			color <= y0[(counter_x-340)* 50+(counter_y-92)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=144&& counter_y<196&&bf4[11:9]==0) begin
			color <= y0[(counter_x-340)* 50+(counter_y-144)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=196&& counter_y<248&&bf4[8:6]==0) begin
			color <= y0[(counter_x-340)* 50+(counter_y-196)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=248&& counter_y<300&&bf4[5:3]==0) begin
			color <= y0[(counter_x-340)* 50+(counter_y-248)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=300&& counter_y<352&&bf4[2:0]==0) begin //B4/1
			color <= y0[(counter_x-340)* 50+(counter_y-300)];
			
			///// 1
			end else if(counter_x>=154&& counter_x<206&& counter_y>=40&& counter_y<92&&bf1[17:15]==1) begin //B1/6
			color <= r1[(counter_x-154)* 50+(counter_y-40)];			
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=92&& counter_y<144&&bf1[14:12]==1) begin
			color <= r1[(counter_x-154)* 50+(counter_y-92)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=144&& counter_y<196&&bf1[11:9]==1) begin
			color <= r1[(counter_x-154)* 50+(counter_y-144)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=196&& counter_y<248&&bf1[8:6]==1) begin
			color <= r1[(counter_x-154)* 50+(counter_y-196)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=248&& counter_y<300&&bf1[5:3]==1) begin
			color <= r1[(counter_x-154)* 50+(counter_y-248)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=300&& counter_y<352&&bf1[2:0]==1) begin //B1/1
			color <= r1[(counter_x-154)* 50+(counter_y-300)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=40&& counter_y<92&&bf2[17:15]==1) begin //B2/6
			color <= g1[(counter_x-216)* 50+(counter_y-40)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=92&& counter_y<144&&bf2[14:12]==1) begin 
			color <= g1[(counter_x-216)* 50+(counter_y-92)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=144&& counter_y<196&&bf2[11:9]==1) begin
			color <= g1[(counter_x-216)* 50+(counter_y-144)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=196&& counter_y<248&&bf2[8:6]==1) begin
			color <= g1[(counter_x-216)* 50+(counter_y-196)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=248&& counter_y<300&&bf2[5:3]==1) begin
			color <= g1[(counter_x-216)* 50+(counter_y-248)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=300&& counter_y<352&&bf2[2:0]==1) begin //B2/1
			color <= g1[(counter_x-216)* 50+(counter_y-300)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=40&& counter_y<92&&bf3[17:15]==1) begin //B3/6
			color <= b1[(counter_x-278)* 50+(counter_y-40)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=92&& counter_y<144&&bf3[14:12]==1) begin 
			color <= b1[(counter_x-278)* 50+(counter_y-92)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=144&& counter_y<196&&bf3[11:9]==1) begin
			color <= b1[(counter_x-278)* 50+(counter_y-144)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=196&& counter_y<248&&bf3[8:6]==1) begin
			color <= b1[(counter_x-278)* 50+(counter_y-196)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=248&& counter_y<300&&bf3[5:3]==1) begin
			color <= b1[(counter_x-278)* 50+(counter_y-248)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=300&& counter_y<352&&bf3[2:0]==1) begin //B3/1
			color <= b1[(counter_x-278)* 50+(counter_y-300)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=40&& counter_y<92&&bf4[17:15]==1) begin //B4/6
			color <= y1[(counter_x-340)* 50+(counter_y-40)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=92&& counter_y<144&&bf4[14:12]==1) begin 
			color <= y1[(counter_x-340)* 50+(counter_y-92)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=144&& counter_y<196&&bf4[11:9]==1) begin
			color <= y1[(counter_x-340)* 50+(counter_y-144)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=196&& counter_y<248&&bf4[8:6]==1) begin
			color <= y1[(counter_x-340)* 50+(counter_y-196)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=248&& counter_y<300&&bf4[5:3]==1) begin
			color <= y1[(counter_x-340)* 50+(counter_y-248)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=300&& counter_y<352&&bf4[2:0]==1) begin //B4/1
			color <= y1[(counter_x-340)* 50+(counter_y-300)];

			///// 2
			end else if(counter_x>=154&& counter_x<206&& counter_y>=40&& counter_y<92&&bf1[17:15]==2) begin //B1/6
			color <= r2[(counter_x-154)* 50+(counter_y-40)];			
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=92&& counter_y<144&&bf1[14:12]==2) begin
			color <= r2[(counter_x-154)* 50+(counter_y-92)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=144&& counter_y<196&&bf1[11:9]==2) begin
			color <= r2[(counter_x-154)* 50+(counter_y-144)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=196&& counter_y<248&&bf1[8:6]==2) begin
			color <= r2[(counter_x-154)* 50+(counter_y-196)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=248&& counter_y<300&&bf1[5:3]==2) begin
			color <= r2[(counter_x-154)* 50+(counter_y-248)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=300&& counter_y<352&&bf1[2:0]==2) begin //B1/1
			color <= r2[(counter_x-154)* 50+(counter_y-300)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=40&& counter_y<92&&bf2[17:15]==2) begin //B2/6
			color <= g2[(counter_x-216)* 50+(counter_y-40)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=92&& counter_y<144&&bf2[14:12]==2) begin 
			color <= g2[(counter_x-216)* 50+(counter_y-92)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=144&& counter_y<196&&bf2[11:9]==2) begin
			color <= g2[(counter_x-216)* 50+(counter_y-144)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=196&& counter_y<248&&bf2[8:6]==2) begin
			color <= g2[(counter_x-216)* 50+(counter_y-196)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=248&& counter_y<300&&bf2[5:3]==2) begin
			color <= g2[(counter_x-216)* 50+(counter_y-248)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=300&& counter_y<352&&bf2[2:0]==2) begin //B2/1
			color <= g2[(counter_x-216)* 50+(counter_y-300)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=40&& counter_y<92&&bf3[17:15]==2) begin //B3/6
			color <= b2[(counter_x-278)* 50+(counter_y-40)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=92&& counter_y<144&&bf3[14:12]==2) begin 
			color <= b2[(counter_x-278)* 50+(counter_y-92)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=144&& counter_y<196&&bf3[11:9]==2) begin
			color <= b2[(counter_x-278)* 50+(counter_y-144)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=196&& counter_y<248&&bf3[8:6]==2) begin
			color <= b2[(counter_x-278)* 50+(counter_y-196)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=248&& counter_y<300&&bf3[5:3]==2) begin
			color <= b2[(counter_x-278)* 50+(counter_y-248)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=300&& counter_y<352&&bf3[2:0]==2) begin //B3/1
			color <= b2[(counter_x-278)* 50+(counter_y-300)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=40&& counter_y<92&&bf4[17:15]==2) begin //B4/6
			color <= y2[(counter_x-340)* 50+(counter_y-40)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=92&& counter_y<144&&bf4[14:12]==2) begin 
			color <= y2[(counter_x-340)* 50+(counter_y-92)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=144&& counter_y<196&&bf4[11:9]==2) begin
			color <= y2[(counter_x-340)* 50+(counter_y-144)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=196&& counter_y<248&&bf4[8:6]==2) begin
			color <= y2[(counter_x-340)* 50+(counter_y-196)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=248&& counter_y<300&&bf4[5:3]==2) begin
			color <= y2[(counter_x-340)* 50+(counter_y-248)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=300&& counter_y<352&&bf4[2:0]==2) begin //B4/1
			color <= y2[(counter_x-340)* 50+(counter_y-300)];			

						///// 3
			end else if(counter_x>=154&& counter_x<206&& counter_y>=40&& counter_y<92&&bf1[17:15]==3) begin //B1/6
			color <= r3[(counter_x-154)* 50+(counter_y-40)];			
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=92&& counter_y<144&&bf1[14:12]==3) begin
			color <= r3[(counter_x-154)* 50+(counter_y-92)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=144&& counter_y<196&&bf1[11:9]==3) begin
			color <= r3[(counter_x-154)* 50+(counter_y-144)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=196&& counter_y<248&&bf1[8:6]==3) begin
			color <= r3[(counter_x-154)* 50+(counter_y-196)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=248&& counter_y<300&&bf1[5:3]==3) begin
			color <= r3[(counter_x-154)* 50+(counter_y-248)];
			
			end else if(counter_x>=154&& counter_x<206&& counter_y>=300&& counter_y<352&&bf1[2:0]==3) begin //B1/1
			color <= r3[(counter_x-154)* 50+(counter_y-300)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=40&& counter_y<92&&bf2[17:15]==3) begin //B2/6
			color <= g3[(counter_x-216)* 50+(counter_y-40)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=92&& counter_y<144&&bf2[14:12]==3) begin 
			color <= g3[(counter_x-216)* 50+(counter_y-92)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=144&& counter_y<196&&bf2[11:9]==3) begin
			color <= g3[(counter_x-216)* 50+(counter_y-144)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=196&& counter_y<248&&bf2[8:6]==3) begin
			color <= g3[(counter_x-216)* 50+(counter_y-196)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=248&& counter_y<300&&bf2[5:3]==3) begin
			color <= g3[(counter_x-216)* 50+(counter_y-248)];
			
			end else if(counter_x>=216&& counter_x<268&& counter_y>=300&& counter_y<352&&bf2[2:0]==3) begin //B2/1
			color <= g3[(counter_x-216)* 50+(counter_y-300)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=40&& counter_y<92&&bf3[17:15]==3) begin //B3/6
			color <= b3[(counter_x-278)* 50+(counter_y-40)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=92&& counter_y<144&&bf3[14:12]==3) begin 
			color <= b3[(counter_x-278)* 50+(counter_y-92)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=144&& counter_y<196&&bf3[11:9]==3) begin
			color <= b3[(counter_x-278)* 50+(counter_y-144)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=196&& counter_y<248&&bf3[8:6]==3) begin
			color <= b3[(counter_x-278)* 50+(counter_y-196)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=248&& counter_y<300&&bf3[5:3]==3) begin
			color <= b3[(counter_x-278)* 50+(counter_y-248)];
			
			end else if(counter_x>=278&& counter_x<330&& counter_y>=300&& counter_y<352&&bf3[2:0]==3) begin //B3/1
			color <= b3[(counter_x-278)* 50+(counter_y-300)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=40&& counter_y<92&&bf4[17:15]==3) begin //B4/6
			color <= y3[(counter_x-340)* 50+(counter_y-40)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=92&& counter_y<144&&bf4[14:12]==3) begin 
			color <= y3[(counter_x-340)* 50+(counter_y-92)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=144&& counter_y<196&&bf4[11:9]==3) begin
			color <= y3[(counter_x-340)* 50+(counter_y-144)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=196&& counter_y<248&&bf4[8:6]==3) begin
			color <= y3[(counter_x-340)* 50+(counter_y-196)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=248&& counter_y<300&&bf4[5:3]==3) begin
			color <= y3[(counter_x-340)* 50+(counter_y-248)];
			
			end else if(counter_x>=340&& counter_x<392&& counter_y>=300&& counter_y<352&&bf4[2:0]==3) begin //B4/1
			color <= y3[(counter_x-340)* 50+(counter_y-300)];	
		
			//stats templete
			
			end else if(counter_x>=400&& counter_x<600&& counter_y>=60&& counter_y<110) begin  //transmitted
			color <= transmitted[(counter_x-400)* 50+(counter_y-60)];
			
			end else if(counter_x>=400&& counter_x<600&& counter_y>=170&& counter_y<220) begin  //received
			color <= received[(counter_x-400)* 50+(counter_y-170)];
			
			end else if(counter_x>=400&& counter_x<600&& counter_y>=280&& counter_y<330) begin  //dropped
			color <= dropped[(counter_x-400)* 50+(counter_y-280)];
			
			end else if(counter_x>=440&& counter_x<448&& counter_y>=332&& counter_y<340&&drop11==0) begin  //dropped
			color <= zero[(counter_x-440)* 8+(counter_y-332)];
			end else if(counter_x>=440&& counter_x<448&& counter_y>=332&& counter_y<340&&drop11==1) begin  //dropped
			color <= one[(counter_x-440)* 8+(counter_y-332)];
			end else if(counter_x>=440&& counter_x<448&& counter_y>=332&& counter_y<340&&drop11==2) begin  //dropped
			color <= two[(counter_x-440)* 8+(counter_y-332)];
			end else if(counter_x>=440&& counter_x<448&& counter_y>=332&& counter_y<340&&drop11==3) begin  //dropped
			color <= three[(counter_x-440)* 8+(counter_y-332)];
			end else if(counter_x>=440&& counter_x<448&& counter_y>=332&& counter_y<340&&drop11==4) begin  //dropped
			color <= four[(counter_x-440)* 8+(counter_y-332)];
			end else if(counter_x>=440&& counter_x<448&& counter_y>=332&& counter_y<340&&drop11==5) begin  //dropped
			color <= five[(counter_x-440)* 8+(counter_y-332)];
			end else if(counter_x>=440&& counter_x<448&& counter_y>=332&& counter_y<340&&drop11==6) begin  //dropped
			color <= six[(counter_x-440)* 8+(counter_y-332)];
			end else if(counter_x>=440&& counter_x<448&& counter_y>=332&& counter_y<340&&drop11==7) begin  //dropped
			color <= seven[(counter_x-440)* 8+(counter_y-332)];
			end else if(counter_x>=440&& counter_x<448&& counter_y>=332&& counter_y<340&&drop11==8) begin  //dropped
			color <= eight[(counter_x-440)* 8+(counter_y-332)];
			end else if(counter_x>=440&& counter_x<448&& counter_y>=332&& counter_y<340&&drop11==9) begin  //dropped
			color <= nine[(counter_x-440)* 8+(counter_y-332)];
			
			end else if(counter_x>=420&& counter_x<428&& counter_y>=332&& counter_y<340&&drop12==0) begin  //dropped
			color <= zero[(counter_x-420)* 8+(counter_y-332)];
			end else if(counter_x>=420&& counter_x<428&& counter_y>=332&& counter_y<340&&drop12==1) begin  //dropped
			color <= one[(counter_x-420)* 8+(counter_y-332)];
			end else if(counter_x>=420&& counter_x<428&& counter_y>=332&& counter_y<340&&drop12==2) begin  //dropped
			color <= two[(counter_x-420)* 8+(counter_y-332)];
			end else if(counter_x>=420&& counter_x<428&& counter_y>=332&& counter_y<340&&drop12==3) begin  //dropped
			color <= three[(counter_x-420)* 8+(counter_y-332)];
			end else if(counter_x>=420&& counter_x<428&& counter_y>=332&& counter_y<340&&drop12==4) begin  //dropped
			color <= four[(counter_x-420)* 8+(counter_y-332)];
			end else if(counter_x>=420&& counter_x<428&& counter_y>=332&& counter_y<340&&drop12==5) begin  //dropped
			color <= five[(counter_x-420)* 8+(counter_y-332)];
			end else if(counter_x>=420&& counter_x<428&& counter_y>=332&& counter_y<340&&drop12==6) begin  //dropped
			color <= six[(counter_x-420)* 8+(counter_y-332)];
			end else if(counter_x>=420&& counter_x<428&& counter_y>=332&& counter_y<340&&drop12==7) begin  //dropped
			color <= seven[(counter_x-420)* 8+(counter_y-332)];
			end else if(counter_x>=420&& counter_x<428&& counter_y>=332&& counter_y<340&&drop12==8) begin  //dropped
			color <= eight[(counter_x-420)* 8+(counter_y-332)];
			end else if(counter_x>=420&& counter_x<428&& counter_y>=332&& counter_y<340&&drop12==9) begin  //dropped
			color <= nine[(counter_x-420)* 8+(counter_y-332)];
			//readout
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==0&&h==0&&e==0) begin  
			color <= r0[(counter_x-420)* 50+(counter_y-400)];
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==0&&h==1&&e==0) begin  
			color <= g0[(counter_x-420)* 50+(counter_y-400)];
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==0&&h==2&&e==0) begin  
			color <= b0[(counter_x-420)* 50+(counter_y-400)];
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==0&&h==3&&e==0) begin  
			color <= y0[(counter_x-420)* 50+(counter_y-400)];
			
			
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==1&&h==0&&e==0) begin  
			color <= r1[(counter_x-420)* 50+(counter_y-400)];
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==1&&h==1&&e==0) begin  
			color <= g1[(counter_x-420)* 50+(counter_y-400)];
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==1&&h==2&e==0) begin  
			color <= b1[(counter_x-420)* 50+(counter_y-400)];
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==1&&h==3&&e==0) begin  
			color <= y1[(counter_x-420)* 50+(counter_y-400)];
			
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==2&&h==0&&e==0) begin  
			color <= r2[(counter_x-420)* 50+(counter_y-400)];
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==2&&h==1&&e==0) begin  
			color <= g2[(counter_x-420)* 50+(counter_y-400)];
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==2&&h==2&&e==0) begin  
			color <= b2[(counter_x-420)* 50+(counter_y-400)];
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==2&&h==3&&e==0) begin  
			color <= y2[(counter_x-420)* 50+(counter_y-400)];
			
			
			
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==3&&h==0&&e==0) begin  
			color <= r3[(counter_x-420)* 50+(counter_y-400)];
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==3&&h==1&&e==0) begin  
			color <= g3[(counter_x-420)* 50+(counter_y-400)];
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==3&&h==2&e==0) begin  
			color <= b3[(counter_x-420)* 50+(counter_y-400)];
			end else if(counter_x>=420&& counter_x<470&& counter_y>=400&& counter_y<450&&readout==3&&h==3&&e==0) begin  
			color <= y3[(counter_x-420)* 50+(counter_y-400)];
			
			end else if(counter_x>=420&& counter_x<472&& counter_y>=400&& counter_y<452&&e==1) begin  
			color <= empty[(counter_x-420)* 52+(counter_y-400)];
			
			end else begin
			color <=0;
			end
			
			
	
		end
	
endmodule