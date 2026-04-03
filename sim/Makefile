# ==============================================================
# Makefile : D Flip-Flop UVM Testbench
# Tool     : ModelSim SE 10.x  (Windows + Linux compatible)
#
# LAYOUT   : All .sv files are in the SAME folder as this Makefile
#
# USAGE:
#   make compile
#   make sim TEST=dff_full_cov_test
#   make coverage
#   make regress
# ==============================================================

TOP        = dff_tb_top
TIMESCALE  = 1ns/1ps
TEST      ?= dff_full_cov_test
SEED      ?= 1
VERBOSITY ?= UVM_MEDIUM
LOG_DIR    = logs
COV_DIR    = coverage_report
UCDB       = $(LOG_DIR)/$(TEST).ucdb

# Detect OS
ifeq ($(OS),Windows_NT)
  MKDIR     = if not exist $(LOG_DIR) mkdir $(LOG_DIR)
  MKDIR_COV = if not exist $(COV_DIR) mkdir $(COV_DIR)
  RM        = rmdir /s /q
  OPEN      = cmd /c start
else
  MKDIR     = mkdir -p $(LOG_DIR)
  MKDIR_COV = mkdir -p $(COV_DIR)
  RM        = rm -rf
  OPEN      = xdg-open
endif



RTL= ../rtl/*
work= work
SVTB1= ../tb/top.sv
INC = +incdir+../tb +incdir+../test +incdir+../in_agt_top +incdir+../ou_agt_top
SVTB2 = ../test/jk_pkg.sv
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1= -c -do "log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do "log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do "log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do "log -r /* ;coverage save -onexit mem_cov4;run -all; exit"
# --------------------------------------------------------------
# Default
# --------------------------------------------------------------
all: compile

# --------------------------------------------------------------
# Compile  (+cover enables coverage instrumentation)
# --------------------------------------------------------------
compile:
	$(MKDIR)
	vlib work
	vmap work work
	vlog -sv -timescale $(TIMESCALE) \
	     +define+UVM_NO_DEPRECATED \
	     +cover \
	     $(INC) \
	     $(SRC) \
	     -l $(LOG_DIR)/compile.log
	@echo ">>> Compile done. Check $(LOG_DIR)/compile.log for errors."

# --------------------------------------------------------------
# Simulate (batch / no GUI)  – saves .ucdb for coverage
# --------------------------------------------------------------
sim:
	vsim -c -sv_seed $(SEED) \
	     +UVM_TESTNAME=$(TEST) \
	     +UVM_VERBOSITY=$(VERBOSITY) \
	     -coverage \
	     -do "coverage save -onexit $(UCDB); run -all; quit -f" \
	     $(TOP) \
	     -l $(LOG_DIR)/$(TEST).log
	@echo ">>> Sim done. UCDB saved to $(UCDB)"

# Simulate with GUI waveform viewer
sim_gui:
	vsim -sv_seed $(SEED) \
	     +UVM_TESTNAME=$(TEST) \
	     +UVM_VERBOSITY=$(VERBOSITY) \
	     -coverage \
	     -do "coverage save -onexit $(UCDB); add wave -r /*; run -all" \
	     $(TOP)

# --------------------------------------------------------------
# Coverage Targets
# --------------------------------------------------------------

# Open UCDB in ModelSim GUI (interactive coverage browser)
coverage:
	vsim -viewcov $(UCDB)

# Generate HTML report  -> open coverage_report/index.html
cov_html:
	$(MKDIR_COV)
	vcover report -html -htmldir $(COV_DIR) $(UCDB)
	@echo ">>> HTML report generated. Opening $(COV_DIR)/index.html ..."
	$(OPEN) $(COV_DIR)/index.html

# Print text coverage report to console and save to file
cov_text:
	$(MKDIR)
	vcover report -details $(UCDB) | tee $(LOG_DIR)/coverage_summary.txt
	@echo ">>> Text report saved to $(LOG_DIR)/coverage_summary.txt"

# Merge all test UCDBs into one and generate combined HTML report
cov_merge:
	$(MKDIR_COV)
	vcover merge $(LOG_DIR)/merged.ucdb $(LOG_DIR)/*.ucdb
	vcover report -html -htmldir $(COV_DIR) $(LOG_DIR)/merged.ucdb
	@echo ">>> Merged HTML report at $(COV_DIR)/index.html"
	$(OPEN) $(COV_DIR)/index.html

# --------------------------------------------------------------
# Named test targets
# --------------------------------------------------------------
test_reset:
	$(MAKE) sim TEST=dff_reset_test

test_random:
	$(MAKE) sim TEST=dff_random_test

test_en_toggle:
	$(MAKE) sim TEST=dff_en_toggle_test

test_corner:
	$(MAKE) sim TEST=dff_corner_test

test_full_cov:
	$(MAKE) sim TEST=dff_full_cov_test

# --------------------------------------------------------------
# Regression - compile once, run all tests, merge coverage
# --------------------------------------------------------------
regress: compile
	@echo "=== Regression Start ==="
	$(MAKE) sim TEST=dff_reset_test
	$(MAKE) sim TEST=dff_random_test
	$(MAKE) sim TEST=dff_en_toggle_test
	$(MAKE) sim TEST=dff_corner_test
	$(MAKE) sim TEST=dff_full_cov_test
	@echo "=== All Tests Done - Merging Coverage ==="
	$(MAKE) cov_merge
	@echo "=== Regression Complete ==="

# --------------------------------------------------------------
# Clean
# --------------------------------------------------------------
clean:
ifeq ($(OS),Windows_NT)
	-$(RM) work
	-$(RM) $(LOG_DIR)
	-$(RM) $(COV_DIR)
	-del /q *.vcd *.wlf transcript modelsim.ini 2>nul
else
	$(RM) work $(LOG_DIR) $(COV_DIR) *.vcd *.wlf transcript modelsim.ini
endif

# --------------------------------------------------------------
# Help
# --------------------------------------------------------------
help:
	@echo ""
	@echo "  ================================================"
	@echo "  DFF UVM Testbench - Makefile Targets"
	@echo "  ================================================"
	@echo "  All .sv files must be in the same folder as Makefile"
	@echo ""
	@echo "  COMPILE & SIM:"
	@echo "  make compile          Compile all sources (with +cover)"
	@echo "  make sim              Simulate, saves .ucdb file"
	@echo "  make sim_gui          Simulate with waveform GUI"
	@echo ""
	@echo "  COVERAGE:"
	@echo "  make coverage         Open UCDB in ModelSim GUI"
	@echo "  make cov_html         Generate HTML report -> browser"
	@echo "  make cov_text         Print text report to console"
	@echo "  make cov_merge        Merge all UCDBs + HTML report"
	@echo ""
	@echo "  TESTS:"
	@echo "  make test_reset       Run dff_reset_test"
	@echo "  make test_random      Run dff_random_test"
	@echo "  make test_en_toggle   Run dff_en_toggle_test"
	@echo "  make test_corner      Run dff_corner_test"
	@echo "  make test_full_cov    Run dff_full_cov_test"
	@echo ""
	@echo "  REGRESSION:"
	@echo "  make regress          Compile + all tests + merged coverage"
	@echo ""
	@echo "  make clean            Delete work/ logs/ coverage_report/"
	@echo ""
	@echo "  Options:"
	@echo "    TEST=<name>         Test class name"
	@echo "    SEED=<int>          Random seed  (default: 1)"
	@echo "    VERBOSITY=<level>   UVM_NONE/LOW/MEDIUM/HIGH/FULL"
	@echo ""
