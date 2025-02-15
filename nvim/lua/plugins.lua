local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
      vim.cmd [[packadd packer.nvim]]
      return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
     -- Add surround operator for text objects.
     use 'tpope/vim-surround'
     -- Comment stuff out
     use("tpope/vim-commentary")
     -- status line
     use 'vim-airline/vim-airline'
     -- Buffer bar
     use {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
    }
    use {
        'lewis6991/gitsigns.nvim',
         tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use {
      'ellisonleao/gruvbox.nvim',
    }
    use({
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/plenary.nvim" }, { "nvim-lua/popup.nvim" } },
    })
    use({
      "romgrk/fzy-lua-native",
      requires = { { "nvim-telescope/telescope.nvim" } },
    })
    use({
      "nvim-telescope/telescope-fzy-native.nvim",
      requires = { { "nvim-telescope/telescope.nvim" } },
    })
    use {
      "hood/popui.nvim",
      requires = {'RishabhRD/popfix'}
    }
    use {
      'mrcjkb/rustaceanvim',
    }
    use {
       'mfussenegger/nvim-dap'
    }
    use({"L3MON4D3/LuaSnip", tag = "v1.*"})
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("saadparwaiz1/cmp_luasnip")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    -- todo stop autosaving toml files 
    use({
      "Pocco81/auto-save.nvim",
      config = function()
         require("auto-save").setup {
            debounce_delay = 1000
         }
      end,
    })
    use {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require('crates').setup()
        end,
    }
    use("airblade/vim-rooter")
    use {
	    "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use "numToStr/FTerm.nvim"
    use("mg979/vim-visual-multi")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
end)
