autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   execute "normal! g`\"" |
	\ endif
