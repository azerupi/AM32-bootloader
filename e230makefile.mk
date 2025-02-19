MCU := E230
PART := GD32E230

HAL_FOLDER_$(MCU) := $(HAL_FOLDER)/$(call lc,$(MCU))

MCU_$(MCU) := -mfloat-abi=soft -mthumb -mcpu=cortex-m23
LDSCRIPT_$(MCU) := $(wildcard $(HAL_FOLDER_$(MCU))/*.ld)

SRC_BASE_DIR_$(MCU) := \
	$(HAL_FOLDER_$(MCU))/Drivers/CMSIS/Source \
	$(HAL_FOLDER_$(MCU))/Drivers/GD32E23x_standard_peripheral/Source \
	$(HAL_FOLDER_$(MCU))/Startup 

CFLAGS_$(MCU) += \
	-I$(HAL_FOLDER_$(MCU))/Inc \
	-I$(HAL_FOLDER_$(MCU))/Drivers/CMSIS/Include \
	-I$(HAL_FOLDER_$(MCU))/Drivers/CMSIS/Core/Include \
	-I$(HAL_FOLDER_$(MCU))/Drivers/GD32E23x_standard_peripheral/Include 

CFLAGS_$(MCU) += \
	-DGD32$(MCU) \
	-D$(PART) \
	-DUSE_STDPERIPH_DRIVER

SRC_$(MCU)_BL := $(foreach dir,$(SRC_BASE_DIR_$(MCU)),$(wildcard $(dir)/*.[cs])) \
	$(wildcard $(HAL_FOLDER_$(MCU))/Src/*.c)
