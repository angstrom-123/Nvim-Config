-- Created by angstrom

local setup = require('jdtls.setup')
local home = os.getenv 'HOME'
local workspace_path = home .. '/.local/share/jdtls-workspace/'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name
local launcher_dir = home .. '/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar'
local config_dir = home .. '/.local/share/jdtls/config_linux'
print ("Workspace dir: " .. workspace_dir)
local config = {
	java = {
		signatureHelp = {
			enabled = true,
			description = {
				enabled = true
			}
		},
		referenceCodeLens = {
			enabled = true
		},
	},
	jdt = {
		ls = {
			protoBufSupport = {
				enabled = true
			}
		}
	},
	capabilities = {
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities(),
	},
	flags = {
		debounce_text_changes = 80,
	},
	on_attach = on_attach,
	root_dir = require('jdtls.setup').find_root({
		'.git', 
		'pom.xml', 
		'.mvn', 
		'mvnw',
		'gradlew', 
		'build.gradle', 
		'build.gradle.kts',
	}),
	cmd = {
		'java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xms1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens',
		'java.base/java.util=ALL-UNNAMED',
		'--add-opens',
		'java.base/java.lang=ALL-UNNAMED',

		'-jar',
		launcher_dir,
		'-configuration',
		config_dir,
		'-data',
		workspace_dir,
	},
}
require('jdtls').start_or_attach(config)
