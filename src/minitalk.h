/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   minitalk.h                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ldummer- <ldummer-@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/03/06 18:18:59 by ldummer-          #+#    #+#             */
/*   Updated: 2025/03/08 18:47:43 by ldummer-         ###   ########.fr       */
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


#endif