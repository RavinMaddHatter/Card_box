include <write.scad>
readyToPrint=true;
/* Personalization-Box*/
//Choose a mana symbol
symbole="phyrexian";//[black, blue, green, red, white,artifact,phyrexian,plainswalker,snow,tap,untap]
// a scale of 1 is ~25mm design volume
symboleScale=1.75;
lid_text="Lid_text";
//Height of text in mm
lid_text_height=6;
// this defines how far above the bottom of the box the text starts


card_thickness=.6;
card_width=70;
card_height=100;
single_wall_thickness=1.5;
number_of_cards=100;
extra_t_for_cards=3;
seal_gap=.1;
break_line=.750;//by ratio
overlap_distance=15;//mm

bevel_type=1;//1=none,2=round 3=miter
bevel_amount=1;

dice_box=false;
dice_box_height=20;


//common values
card_vol_w=card_width;
card_vol_l=number_of_cards*card_thickness+extra_t_for_cards;
card_vol_h=card_height;


module main_box(){
	difference(){
		if(bevel_type==1){
			translate([-(card_vol_w+single_wall_thickness*4)/2,-(card_vol_l+single_wall_thickness*4)/2,-single_wall_thickness*2])cube([card_vol_w+single_wall_thickness*4+seal_gap,seal_gap+card_vol_l+single_wall_thickness*4,break_line*card_vol_h+single_wall_thickness*2]);
			translate([-(card_vol_w+single_wall_thickness*2)/2,-(card_vol_l+single_wall_thickness*2)/2,-single_wall_thickness*2])cube([card_vol_w+single_wall_thickness*2,card_vol_l+single_wall_thickness*2,break_line*card_vol_h+single_wall_thickness*2+overlap_distance]);
		}
	translate([0,0,card_vol_h/2])cube([card_vol_w,card_vol_l,card_vol_h],center=true);
	face();
	rotate([0,0,180])face();	
	if(dice_box){
		difference(){
			translate([-(card_vol_w+single_wall_thickness*6)/2,-(card_vol_l+single_wall_thickness*6)/2,-single_wall_thickness*3])cube([card_vol_w+single_wall_thickness*6,card_vol_l+single_wall_thickness*6,overlap_distance+single_wall_thickness*3]);
		translate([-(card_vol_w+single_wall_thickness*2)/2,-(card_vol_l+single_wall_thickness*2)/2,-single_wall_thickness*3])cube([card_vol_w+single_wall_thickness*2,card_vol_l+single_wall_thickness*2,overlap_distance+single_wall_thickness*3]);
		}
		
	}
	}
}
module lid(){
	difference(){
		if(bevel_type==1){
			translate([-(card_vol_w+single_wall_thickness*4)/2,-(card_vol_l+single_wall_thickness*4)/2,break_line*card_vol_h])cube([card_vol_w+single_wall_thickness*4+seal_gap,seal_gap+card_vol_l+single_wall_thickness*4,(1-break_line)*card_vol_h+single_wall_thickness*2]);
		}
		translate([-seal_gap-(card_vol_w+single_wall_thickness*2)/2,-seal_gap-(card_vol_l+single_wall_thickness*2)/2,break_line*card_vol_h])cube([-seal_gap*2+card_vol_w+single_wall_thickness*2,-seal_gap*2+card_vol_l+single_wall_thickness*2,overlap_distance]);
		translate([0,0,card_vol_h/2])cube([card_vol_w,card_vol_l,card_vol_h],center=true);
	translate([0,0,card_vol_h+single_wall_thickness*2])write(lid_text,t=2*single_wall_thickness,h=lid_text_height,center=true, font="Magic.dxf");
translate([0,card_vol_l/2+single_wall_thickness*2,card_vol_h+single_wall_thickness*2-(1-break_line)*card_vol_h/2])rotate([90,0,180])write(lid_text,t=2*single_wall_thickness,h=lid_text_height,center=true, font="Magic.dxf");
	rotate([0,0,180])translate([0,card_vol_l/2+single_wall_thickness*2,card_vol_h+single_wall_thickness*2-(1-break_line)*card_vol_h/2])rotate([90,0,180])write(lid_text,t=2*single_wall_thickness,h=lid_text_height,center=true, font="Magic.dxf");
	}
}
module dice_box_part(){
difference(){
		if(bevel_type==1){
			translate([-(card_vol_w+single_wall_thickness*4)/2,-(card_vol_l+single_wall_thickness*4)/2,-single_wall_thickness*4-dice_box_height])cube([card_vol_w+single_wall_thickness*4+seal_gap,seal_gap+card_vol_l+single_wall_thickness*4,overlap_distance+dice_box_height+single_wall_thickness*4]);
		}
		translate([-(card_vol_w+single_wall_thickness*2)/2,-(card_vol_l+single_wall_thickness*2)/2,-single_wall_thickness*2])cube([-seal_gap*2+card_vol_w+single_wall_thickness*2,-seal_gap*2+card_vol_l+single_wall_thickness*2,overlap_distance+2*single_wall_thickness*2]);
		translate([-(card_vol_w)/2,-(card_vol_l)/2,-single_wall_thickness*2-dice_box_height])cube([card_vol_w,card_vol_l,dice_box_height+overlap_distance+single_wall_thickness*2]);
	}
}

module face(){
translate([0,card_vol_l/2+single_wall_thickness*2,break_line*card_vol_h/2])
rotate([90,0,0])linear_extrude(height=single_wall_thickness*2,convexity=10,center=true)
scale([symboleScale,symboleScale,1])
import(file = "Symbols.dxf",layer=symbole);
}

if(!readyToPrint){

	main_box();
	lid();
	if(dice_box){
		dice_box_part();
	}
}
if(readyToPrint){
	main_box();
	rotate([180,0,0])translate([0,(card_vol_l+single_wall_thickness*4)+5,-card_vol_h])lid();
	if(dice_box){
		translate([0,(card_vol_l+single_wall_thickness*4)+5,dice_box_height+single_wall_thickness*2])dice_box_part();
	}
}
