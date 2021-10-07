#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sun Sep 19 23:42:36 2021                
#                                                     
#######################################################

#@(#)CDS: Innovus v17.11-s080_1 (64bit) 08/04/2017 11:13 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 17.11-s080_1 NR170721-2155/17_11-UB (database version 2.30, 390.7.1) {superthreading v1.44}
#@(#)CDS: AAE 17.11-s034 (64bit) 08/04/2017 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 17.11-s053_1 () Aug  1 2017 23:31:41 ( )
#@(#)CDS: SYNTECH 17.11-s012_1 () Jul 21 2017 02:29:12 ( )
#@(#)CDS: CPE v17.11-s095
#@(#)CDS: IQRC/TQRC 16.1.1-s215 (64bit) Thu Jul  6 20:18:10 PDT 2017 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set defHierChar /
set delaycal_input_transition_delay 0.1ps
set fpIsMaxIoHeight 0
set init_gnd_net gnd
set init_mmmc_file Default.view
set init_oa_search_lib {}
set init_pwr_net vdd
set init_verilog DLX.v
set init_lef_file /software/dk/nangate45/lef/NangateOpenCellLibrary.lef
set defHierChar /
set delaycal_input_transition_delay 0.1ps
set fpIsMaxIoHeight 0
set init_gnd_net gnd
set init_mmmc_file Default.view
set init_oa_search_lib {}
set init_pwr_net vdd
set init_verilog DLX.v
set init_lef_file /software/dk/nangate45/lef/NangateOpenCellLibrary.lef
init_design
getIoFlowFlag
setIoFlowFlag 0
floorPlan -coreMarginsBy die -site FreePDK45_38x28_10R_NP_162NW_34O -r 1 0.6 5.0 5.0 5.0 5.0
uiSetTool select
getIoFlowFlag
fit
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {gnd vdd} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 0.8 bottom 0.8 left 0.8 right 0.8} -spacing {top 0.8 bottom 0.8 left 0.8 right 0.8} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -extend_corner {} -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length 0 -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring }
addStripe -nets {gnd vdd} -layer metal10 -direction vertical -width 0.8 -spacing 0.8 -set_to_set_distance 20 -start_from left -start_offset 15 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit metal10 -padcore_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid None -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { metal1(1) metal10(10) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { metal1(1) metal10(10) } -nets { gnd vdd } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { metal1(1) metal10(10) }
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}
setPlaceMode -fp false
placeDesign
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -use CLOCK -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Top -layer 1 -spreadType center -spacing 0.14 -pin CLK
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -spreadDirection clockwise -side Left -layer 1 -spreadType side -pin {{DRAM_ADDRESS[0]} {DRAM_ADDRESS[1]} {DRAM_ADDRESS[2]} {DRAM_ADDRESS[3]} {DRAM_ADDRESS[4]} {DRAM_ADDRESS[5]} {DRAM_ADDRESS[6]} {DRAM_ADDRESS[7]} {DRAM_ADDRESS[8]} {DRAM_ADDRESS[9]} {DRAM_ADDRESS[10]} {DRAM_ADDRESS[11]} {DRAM_ADDRESS[12]} {DRAM_ADDRESS[13]} {DRAM_ADDRESS[14]} {DRAM_ADDRESS[15]} {DRAM_ADDRESS[16]} {DRAM_ADDRESS[17]} {DRAM_ADDRESS[18]} {DRAM_ADDRESS[19]} {DRAM_ADDRESS[20]} {DRAM_ADDRESS[21]} {DRAM_ADDRESS[22]} {DRAM_ADDRESS[23]} {DRAM_ADDRESS[24]} {DRAM_ADDRESS[25]} {DRAM_ADDRESS[26]} {DRAM_ADDRESS[27]} {DRAM_ADDRESS[28]} {DRAM_ADDRESS[29]} {DRAM_ADDRESS[30]} {DRAM_ADDRESS[31]}}
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -spreadDirection clockwise -side Right -layer 1 -spreadType side -pin {{DRAM_DATA[0]} {DRAM_DATA[1]} {DRAM_DATA[2]} {DRAM_DATA[3]} {DRAM_DATA[4]} {DRAM_DATA[5]} {DRAM_DATA[6]} {DRAM_DATA[7]} {DRAM_DATA[8]} {DRAM_DATA[9]} {DRAM_DATA[10]} {DRAM_DATA[11]} {DRAM_DATA[12]} {DRAM_DATA[13]} {DRAM_DATA[14]} {DRAM_DATA[15]} {DRAM_DATA[16]} {DRAM_DATA[17]} {DRAM_DATA[18]} {DRAM_DATA[19]} {DRAM_DATA[20]} {DRAM_DATA[21]} {DRAM_DATA[22]} {DRAM_DATA[23]} {DRAM_DATA[24]} {DRAM_DATA[25]} {DRAM_DATA[26]} {DRAM_DATA[27]} {DRAM_DATA[28]} {DRAM_DATA[29]} {DRAM_DATA[30]} {DRAM_DATA[31]} {DRAM_DATA[32]} {DRAM_DATA[33]} {DRAM_DATA[34]} {DRAM_DATA[35]} {DRAM_DATA[36]} {DRAM_DATA[37]} {DRAM_DATA[38]} {DRAM_DATA[39]} {DRAM_DATA[40]} {DRAM_DATA[41]} {DRAM_DATA[42]} {DRAM_DATA[43]} {DRAM_DATA[44]} {DRAM_DATA[45]} {DRAM_DATA[46]} {DRAM_DATA[47]} {DRAM_DATA[48]} {DRAM_DATA[49]} {DRAM_DATA[50]} {DRAM_DATA[51]} {DRAM_DATA[52]} {DRAM_DATA[53]} {DRAM_DATA[54]} {DRAM_DATA[55]} {DRAM_DATA[56]} {DRAM_DATA[57]} {DRAM_DATA[58]} {DRAM_DATA[59]} {DRAM_DATA[60]} {DRAM_DATA[61]} {DRAM_DATA[62]} {DRAM_DATA[63]}}
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin DRAM_ISSUE
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin DRAM_READNOTWRITE
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin DRAM_READY
setPinAssignMode -pinEditInBatch true
editPin -use TIELOW -fixOverlap 1 -spreadDirection clockwise -side Left -layer 1 -spreadType side -pin {{IRAM_ADDRESS[0]} {IRAM_ADDRESS[1]} {IRAM_ADDRESS[2]} {IRAM_ADDRESS[3]} {IRAM_ADDRESS[4]} {IRAM_ADDRESS[5]} {IRAM_ADDRESS[6]} {IRAM_ADDRESS[7]} {IRAM_ADDRESS[8]} {IRAM_ADDRESS[9]} {IRAM_ADDRESS[10]} {IRAM_ADDRESS[11]} {IRAM_ADDRESS[12]} {IRAM_ADDRESS[13]} {IRAM_ADDRESS[14]} {IRAM_ADDRESS[15]} {IRAM_ADDRESS[16]} {IRAM_ADDRESS[17]} {IRAM_ADDRESS[18]} {IRAM_ADDRESS[19]} {IRAM_ADDRESS[20]} {IRAM_ADDRESS[21]} {IRAM_ADDRESS[22]} {IRAM_ADDRESS[23]} {IRAM_ADDRESS[24]} {IRAM_ADDRESS[25]} {IRAM_ADDRESS[26]} {IRAM_ADDRESS[27]} {IRAM_ADDRESS[28]} {IRAM_ADDRESS[29]} {IRAM_ADDRESS[30]} {IRAM_ADDRESS[31]}}
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -spreadDirection clockwise -side Right -layer 1 -spreadType side -pin {{IRAM_DATA[0]} {IRAM_DATA[1]} {IRAM_DATA[2]} {IRAM_DATA[3]} {IRAM_DATA[4]} {IRAM_DATA[5]} {IRAM_DATA[6]} {IRAM_DATA[7]} {IRAM_DATA[8]} {IRAM_DATA[9]} {IRAM_DATA[10]} {IRAM_DATA[11]} {IRAM_DATA[12]} {IRAM_DATA[13]} {IRAM_DATA[14]} {IRAM_DATA[15]} {IRAM_DATA[16]} {IRAM_DATA[17]} {IRAM_DATA[18]} {IRAM_DATA[19]} {IRAM_DATA[20]} {IRAM_DATA[21]} {IRAM_DATA[22]} {IRAM_DATA[23]} {IRAM_DATA[24]} {IRAM_DATA[25]} {IRAM_DATA[26]} {IRAM_DATA[27]} {IRAM_DATA[28]} {IRAM_DATA[29]} {IRAM_DATA[30]} {IRAM_DATA[31]} {IRAM_DATA[32]} {IRAM_DATA[33]} {IRAM_DATA[34]} {IRAM_DATA[35]} {IRAM_DATA[36]} {IRAM_DATA[37]} {IRAM_DATA[38]} {IRAM_DATA[39]} {IRAM_DATA[40]} {IRAM_DATA[41]} {IRAM_DATA[42]} {IRAM_DATA[43]} {IRAM_DATA[44]} {IRAM_DATA[45]} {IRAM_DATA[46]} {IRAM_DATA[47]} {IRAM_DATA[48]} {IRAM_DATA[49]} {IRAM_DATA[50]} {IRAM_DATA[51]} {IRAM_DATA[52]} {IRAM_DATA[53]} {IRAM_DATA[54]} {IRAM_DATA[55]} {IRAM_DATA[56]} {IRAM_DATA[57]} {IRAM_DATA[58]} {IRAM_DATA[59]} {IRAM_DATA[60]} {IRAM_DATA[61]} {IRAM_DATA[62]} {IRAM_DATA[63]}}
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin IRAM_ISSUE
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin IRAM_READY
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin RST
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin RST
setPinAssignMode -pinEditInBatch false
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS
optDesign -postCTS -hold
getFillerMode -quiet
addFiller -cell FILLCELL_X8 FILLCELL_X4 FILLCELL_X32 FILLCELL_X2 FILLCELL_X16 FILLCELL_X1 -prefix FILLER
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
setAnalysisMode -analysisType onChipVariation
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
optDesign -postRoute -hold
saveDesign DLX_IR_SIZE32_PC_SIZE32
win
reset_parasitics
extractRC
rcOut -setload DLX_IR_SIZE32_PC_SIZE32.setload -rc_corner high
rcOut -setres DLX_IR_SIZE32_PC_SIZE32.setres -rc_corner high
rcOut -spf DLX_IR_SIZE32_PC_SIZE32.spf -rc_corner high
rcOut -spef DLX_IR_SIZE32_PC_SIZE32.spef -rc_corner high
reset_parasitics
extractRC
rcOut -setload DLX_IR_SIZE32_PC_SIZE32.setload -rc_corner standard
rcOut -setres DLX_IR_SIZE32_PC_SIZE32.setres -rc_corner standard
rcOut -spf DLX_IR_SIZE32_PC_SIZE32.spf -rc_corner standard
rcOut -spef DLX_IR_SIZE32_PC_SIZE32.spef -rc_corner standard
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -slackReports -numPaths 50 -prefix DLX_IR_SIZE32_PC_SIZE32_postRoute -outDir timingReports
setVerifyGeometryMode -area { 0 0 0 0 } -minWidth true -minSpacing true -minArea true -sameNet true -short true -overlap true -offRGrid false -offMGrid true -mergedMGridCheck true -minHole true -implantCheck true -minimumCut true -minStep true -viaEnclosure true -antenna false -insuffMetalOverlap true -pinInBlkg false -diffCellViol true -sameCellViol false -padFillerCellsOverlap true -routingBlkgPinOverlap true -routingCellBlkgOverlap true -regRoutingOnly false -stackedViasOnRegNet false -wireExt true -useNonDefaultSpacing false -maxWidth true -maxNonPrefLength -1 -error 1000
verifyGeometry
setVerifyGeometryMode -area { 0 0 0 0 }
verifyConnectivity -type all -error 1000 -warning 50
reportGateCount -level 5 -limit 100 -outfile DLX_IR_SIZE32_PC_SIZE32.gateCount
saveNetlist DLX_IR_SIZE32_PC_SIZE32.v
all_hold_analysis_views 
all_setup_analysis_views 
write_sdf  -ideal_clock_network DLX_IR_SIZE32_PC_SIZE32.sdf
