ARM_IP_PATH	:= $(abspath $(ARM_IP_DIR))
AHA_IP_PATH := $(abspath $(AHA_IP_DIR))
GATE_LEVEL_PATH := $(abspath $(GATE_LEVEL_DIR))
CUR_DIR  		:= $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

# VCS Options
LINT_OPT	:= +lint=PCWM,TFIPC,all
VCS_COMPILE_OPTS 	:= -notice +v2k -noIncrComp -debug -full64 +libext+.v+.sv -sverilog -timescale=1ps/1ps $(LINT_OPT)
#VCS_COMPILE_OPTS 	+= +define+VCD_ON
VCS_COMPILE_OPTS 	+= +define+TSMC_CM_UNIT_DELAY
VCS_COMPILE_OPTS 	+= +define+TSMC_INITIALIZE_MEM_USING_DEFAULT_TASKS
VCS_COMPILE_OPTS 	+= +define+TSMC_MEM_LOAD_0
#VCS_COMPILE_OPTS 	+= +nospecify
VCS_COMPILE_OPTS 	+= +notimingcheck
VCS_COMPILE_OPTS 	+= +define+NON_STOP_IF_INPUT_PIN_Z
VCS_COMPILE_OPTS 	+= +vcs+initreg+random

# Whether or not to include Garnet CGRA
ifeq ($(SOC_ONLY),True)
	VCS_COMPILE_OPTS += +define+NO_CGRA
endif

# TLX FWD and REV Data Port Partitionning (for pad frame)
VCS_COMPILE_OPTS += +define+TLX_FWD_DATA_LO_WIDTH=$(TLX_FWD_DATA_LO_WIDTH)
VCS_COMPILE_OPTS += +define+TLX_REV_DATA_LO_WIDTH=$(TLX_REV_DATA_LO_WIDTH)

# GLB Read Wait States
VCS_COMPILE_OPTS += +define+CGRA_RD_WS=$(CGRA_RD_WS)

# Testbench File
TBENCH_FILE 			:= tbench_files/Tbench.v
TBENCH_FILE 			+= tbench_files/dragonphy_top.v
#TBENCH_FILE 			+= -v tbench_files/*.v
TBENCH_FILE 			+= tbench_files/AhaTlxTrainingMonitor.v

# Design Files
TO_GEN_FILE_LISTS		:= file-list-tbench.vc file-list-aha.vc file-list-cm3.vc \
   										 file-list-arm_utils.vc file-list-garnet.vc
AUTO_GEN_FILE_LISTS	:= file-list-nic.vc file-list-dma.vc file-list-tlx.vc
GARNET_FILE_LISTS 	:= -F inputs/filelists/glb.list -f inputs/filelists/glc.list \
												-f inputs/filelists/garnet.list


# Top Design
#TOP_DESIGN 	:= $(AHA_IP_DIR)/hardware/logical/AhaGarnetSoC/verilog/AhaGarnetSoC.v

# All File Lists
ALL_FILE_LISTS := $(foreach file,$(TO_GEN_FILE_LISTS),-F $(file))
ALL_FILE_LISTS += $(foreach file,$(AUTO_GEN_FILE_LISTS),-F $(file))
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/design.vcs.v 
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/glb_top.vcs.v 
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/glb_tile.vcs.v 
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/global_controller.vcs.v 
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/tile_array.vcs.v 
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/Tile_MemCore.vcs.v 
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/Tile_PE.vcs.v 
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/stdcells.v 
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/stdcells-lvt.v 
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/stdcells-ulvt.v 
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/sram.v
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/sram_lake.v
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/iocells.v
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/stdcells-pm.v
ALL_FILE_LISTS += $(GATE_LEVEL_PATH)/pfiller_dummy.v


# Main target: use to compile SoC and Testbench
compile: $(TO_GEN_FILE_LISTS) $(AUTO_GEN_FILE_LISTS) pad_frame
	vcs  $(VCS_COMPILE_OPTS) $(ALL_FILE_LISTS)  $(TBENCH_FILE) | tee vcs_compile.log 
	cp -rf simv simv.daidir outputs/


# Helper targets to build ARM IP Generated by Socrates
file-list-nic.vc:
	./vc_expand_paths.py $(ARM_IP_PATH)/logical/nic400_AhaIntegration/nic400/verilog/nic400_AhaIntegration.vc $@

file-list-dma.vc:
	./vc_expand_paths.py $(ARM_IP_PATH)/logical/DMA330_AhaIntegration/logical/pl330_dma_AhaIntegration/pl330_dma_AhaIntegration/verilog/files.vc $@

file-list-tlx.vc:
	./vc_expand_paths.py $(ARM_IP_PATH)/logical/nic400_tlx_AhaIntegration/nic400/verilog/nic400_tlx_AhaIntegration.vc $@

# Helper target to build templated file-list specifications
$(TO_GEN_FILE_LISTS): file-list-%.vc:
	AHA_IP_DIR=$(AHA_IP_PATH) ARM_IP_DIR=$(ARM_IP_PATH) \
	./vc_expand_paths.py file_list_templates/file-list-$*.vc.tmpl $@

pad_frame:
	$(MAKE) -C $(AHA_IP_DIR)/hardware/logical/AhaGarnetSoCPadFrame OUT_DIR=$(CUR_DIR)/pad_frame
