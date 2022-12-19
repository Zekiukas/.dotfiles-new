local map = function(modes, lhs, rhs)
	vim.keymap.set(modes, lhs, rhs, { silent = true })
end



map("", "<Space>", "<Nop>")
vim.g.mapleader = " "

map("n", "<C-s>", ":w<cr>")
map("n", "x", "\"_x")
map("n", "dw", "diw")
map("n", "cw", "ciw")
map("n", "vw", "viw")
map("n", "yw", "yiw")
map("n", "cc", "\"_cc")
map({ "v", "x" }, "<leader>p", "\"_dP")
map("n", "<", "<<")
map("n", ">", ">>")
map({ "v", "x" }, "<", "<gv")
map({ "v", "x" }, ">", ">gv")

map("n", "<leader><leader>", vim.lsp.buf.hover)
map("n", "gd", vim.lsp.buf.definition)
map("n", "gr", vim.lsp.buf.rename)
map("n", "ga", vim.lsp.buf.code_action)
map("n", "gi", vim.lsp.buf.implementation)
map("n", "gh", vim.lsp.buf.signature_help)
map("n", "gl", vim.diagnostic.open_float)
map("n", "gL", vim.diagnostic.goto_next)
