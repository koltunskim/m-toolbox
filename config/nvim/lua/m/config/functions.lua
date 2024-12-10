function CopyFilePath()
	vim.fn.setreg('+', vim.fn.expand('%:p'))
end

function CopyDirPath()
	vim.fn.setreg('+', vim.fn.getcwd())
end

function ToggleDiagnostics()
	if vim.g.diagnostics_active then
		vim.g.diagnostics_active = false
		vim.diagnostic.disable()
	else
		vim.g.diagnostics_active = true
		vim.diagnostic.enable()
	end
end

function ToggleSetNumber()
	if vim.wo.number then
		vim.wo.number = false
		vim.wo.relativenumber = false
	else
		vim.wo.number = true
		vim.wo.relativenumber = true
	end
end
