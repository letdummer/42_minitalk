# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ldummer- <ldummer-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/28 19:49:32 by ldummer-          #+#    #+#              #
#    Updated: 2025/04/07 19:42:21 by ldummer-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SHELL := bash

USER			= letdummer
NAME_SERVER		= server
NAME_CLIENT		= client
UNAME 			= $(shell uname)

#------------------------------------------------------------------------------#
#					FILES  	     			       #
#------------------------------------------------------------------------------#

SRC_DIR		= src
BUILD_DIR	= .build

SRC_SERVER	= $(addprefix $(SRC_DIR)/, server.c )
SRC_CLIENT	= $(addprefix $(SRC_DIR)/, client.c )

# adicionar atalho para compilar utils.c

OBJS_SERVER	= $(SRC_SERVER:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
OBJS_CLIENT	= $(SRC_CLIENT:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
DEPS		= $(OBJS:.o=.d)

LIBFT_DIR	= libft
LIBFT_LIB	= $(LIBFT_DIR)/libft.a


#------------------------------------------------------------------------------#
#				COMPILATION 	   			       #
#------------------------------------------------------------------------------#

CC			= cc
CFLAGS		= -Wall -Wextra -Werror
DFLAGS		= -g
INC			= -I
RM			= rm -rf
AR			= ar rcs
MKDIR_P		= mkdir -p
MAKE		= make -C

# INPUT = 
#------------------------------------------------------------------------------#
#				BASE					       #
#------------------------------------------------------------------------------#

all: $(BUILD_DIR) deps $(NAME_SERVER) $(NAME_CLIENT)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

$(NAME_SERVER): $(LIBFT_LIB) $(OBJS_SERVER)
	@printf "[$(YELLOW)Compiling minitalk Server$(RESET)]"
	@cc $(CFLAGS) $(OBJS_SERVER) $(LIBFT_LIB) -o $(NAME_SERVER)
	@printf "[Compiling $(PURPLE)server:$(RESET)] $(_SUCCESS)"
	@printf "\n"

$(NAME_CLIENT): $(LIBFT_LIB) $(OBJS_CLIENT)
	@printf "[$(YELLOW)Compiling minitalk Client$(RESET)]"
	@cc $(CFLAGS) $(OBJS_CLIENT) $(LIBFT_LIB) -o $(NAME_CLIENT)
	@printf "[Compiling $(PURPLE)client:$(RESET)] $(_SUCCESS)"
	@printf "\n"

$(LIBFT_LIB):
	make extra -C $(LIBFT_DIR)

deps: get_libft
	@printf "$(GREEN_BOLD)Nothing to be done!\n$(RESET)"


get_libft:
	@if [ ! -d "$(LIBFT_DIR)" ]; then \
		echo "Getting Libft"; \
		git clone --depth 1 https://github.com/letdummer/42_libft.git $(LIBFT_DIR); \
		echo "Done downloading Libft"; \
	else \
		echo "Libft directory already exists"; \
	fi


#------------------------------------------------------------------------------#
#				CLEAN-UP RULES 		  		       #
#------------------------------------------------------------------------------#

clean:
	@echo "Cleaning Libft objects"
	@$(MAKE) $(LIBFT_DIR) clean
	@echo "Removing $(BUILD_DIR) folder & files"
	@$(RM) $(BUILD_DIR)
	@echo "Removing Server pid file"
	@$(RM) server.pid
	$(call text, "Removing libft object folder [...]")
	$(MAKE) $(LIBFT_DIR) clean
#	@make -C $(FT_PRINTF_DIR) clean
	$(call success, "		Object files cleaned. 💣");

# clean the .o objects, the objs folder and the project file
fclean: clean
	$(call text, "Removing files")
	@$(RM) $(NAME_SERVER) $(NAME_CLIENT)
	@$(MAKE) $(LIBFT_DIR) fclean
	@echo "----------------------------------"
	@printf "$(GREEN_BOLD)FULL CLEANING DONE! ✅$(RESET)"
	@printf "\n"

re: fclean all
	@printf "$(GREEN_BOLD)All files have been recompiled ✅$(RESET)"

#------------------------------------------------------------------------------#
#					EXTRA		 		       #
#------------------------------------------------------------------------------#

#________		GDB	___________________________________________#
#	Run with GDB w/ custom arg=""
gdb:				
	gdb --tui --args ./$(NAME) $(INPUT)

#________		VALGRIND___________________________________________#
#	rule to valgrind
valgrind: $(NAME)
	$(CC) $(CFLAGS) $(OBJ_DIR) $(LIBFTLIB) -o $(NAME)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(NAME) $(INPUT)
	make clean
	./push_swap $(INPUT)
	
#------------------------------------------------------------------------------#
#				HELP MENU	 		  	       #
#------------------------------------------------------------------------------#

help:
	@printf "$(CYAN_BOLD)\n\tAVAILABLE OPTIONS:$(RESET)"
	@printf "$(CYAN_BOLD)\t---------------------------------$(RESET)"
	@printf "$(CYAN)\tmake			- Compiles the project and creates the library $(NAME).$(RESET)"
	@printf "$(CYAN)\tmake clean		- Removes object files (.o).$(RESET)"
	@printf "$(CYAN)\tmake fclean	  	- Removes object files and the library $(NAME).$(RESET)"
	@printf "$(CYAN)\tmake re			- Cleans and recompiles the project.$(RESET)"
	@printf "$(CYAN)\tmake help		- Displays this help message.$(RESET)"
#	@printf "$(CYAN)\tmake manual		- Displays the $(NAME) manual.$(RESET)"



#------------------------------------------------------------------------------#
#			COLORS AND WARNINGS		 	 	       #
#------------------------------------------------------------------------------#
# font name for titles: ANSI REGULAR
# https://patorjk.com/software/taag/#p=display&f=ANSI%20Regular&t=push_swap

# or https://www.asciiart.eu/text-to-ascii-art
# Alligator width 80

#________	DEFINING ANSI COLORS___________________________________________#

RED_BOLD	  := $(shell echo "\033[1;31m")
GREEN_BOLD	:= $(shell echo "\033[1;32m")
PURPLE  := $(shell echo "\033[0;35m")
BLUEE	 := $(shell echo "\033[0;34m")
CYAN	:= $(shell echo "\e[0;36m")
CYAN_BOLD	:= $(shell echo "\e[1;36m")
YELLOW	:= $(shell echo "\033[0;33m")
RESET	:= $(shell echo "\033[0m")

#________	FUNCTIONS TO PRINT COLORS______________________________________#

text = @printf "$(PURPLE)$(1)$(RESET)"
warn = @printf "$(BLUE)$(1)$(RESET)"
error = @printf "$(RED_BOLD)$(1)$(RESET)"
success = @printf "$(GREEN_BOLD)$(1)$(RESET)"
highligth = @printf "$(CYAN)$(1)$(RESET)"
highligth_bold = @printf "$(CYAN_BOLD)$(1)$(RESET)"


### Message Vars
_SUCCESS 		= [$(GREEN_BOLD)SUCCESS$(RESET)]


#______________________________________________________________________________#
.PHONY: all clean fclean re help manual norm valgrind gdb deps get_libft