local lsp_ok, lsp = pcall(require, "lspconfig")
if lsp_ok then
	local lsp_group = vim.api.nvim_create_augroup("LSPGroup", { clear = true })
	local format_on_save = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = lsp_group,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format()
			end
		})
	end
	local on_attach = function(client, bufnr)
	    format_on_save(client, bufnr)
	end
	local capabilities = vim.lsp.protocol.make_client_capabilities()
    


    local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
	if cmp_ok then
		capabilities = cmp.default_capabilities()
	end

	vim.diagnostic.config {
		virtual_text = true,
		signs = { active = signs },
		update_in_insert = true,
		underline = false,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			source = "always",
			header = "",
			prefix = "",
			border = "rounded"
		},
	}
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

	local servers = {
        "clangd",
        "cssls",
        "html",
        "tsserver",
        "rust_analyzer",
	}




for _, server in ipairs(servers) do
		lsp[server].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end



local null_ls_ok, null_ls = pcall(require, "null-ls")
	if null_ls_ok then
		local diag = null_ls.builtins.diagnostics
		local format = null_ls.builtins.formatting
		local actions = null_ls.builtins.code_actions

		local null_sources = {
			format.prettier
		}

		local eslint_check = vim.fs.find({
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.yaml",
			".eslintrc.yml",
			".eslintrc.json",
			"eslint.config.js"
		}, {
			upward = true,
			stop = "/home/name",
			type = "file",
			limit = 1,
		})

		if eslint_check[1] then
			table.insert(null_sources, diag.eslint)
			table.insert(null_sources, actions.eslint)
		end
	    null_ls.setup({
			debug = false,
			sources = null_sources,
			on_attach = on_attach,
		})

    end


local mason_ok, mason = pcall(require, "mason")
	if mason_ok then
		mason.setup()
	end


















end
