/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   minitalk.h                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ldummer- <ldummer-@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/03/06 18:18:59 by ldummer-          #+#    #+#             */
/*   Updated: 2025/04/09 18:52:11 by ldummer-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef MINITALK_H
# define MINITALK_H

# include <signal.h>
# include "../libft/libft/libft.h"
# include "../libft/ft_printf/libftprintf.h"


#include <sys/types.h>	// verificar se precisa
#include <unistd.h>		// verificar se precisa
//	criar estrutura
//	declarar funcoes
void	ft_perror_exit(char *message, int exit_number);

//	CLIENT
void	send_char(int pid, char c);
void	send_length(int pid, size_t length);

//	SERVER
void	handler(int signum, siginfo_t *info, void *context);


#endif