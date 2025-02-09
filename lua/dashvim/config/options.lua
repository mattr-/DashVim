vim.g.mapleader = "<Space>"
vim.g.maplocalleader = ","

local opt = vim.opt

opt.shortmess     = "f"       -- use "(3 of 5)" instead of "(file 3 of 5)"
                 .. "i"       -- use "[noeol]" instead of "[Incomplete last line]"
                 .. "l"       -- use "999L, 888C" instead of "999 lines, 888 characters"
                 .. "m"       -- use "[+]" instead of "[Modified]"
                 .. "n"       -- use "[New]" instead of "[New File]"
                 .. "o"       -- overwrite message for writing a file with subsequent message
                              -- for reading a file (useful for ":wn" or when 'autowrite' on)
                 .. "r"       -- use "[RO]" instead of "[readonly]"
                 .. "s"       -- don't give "search hit BOTTOM, continuing at TOP" style messages
                 .. "t"       -- truncate file message at the start if it is too long to fit
                              -- on the command-line, "<" will appear in the left most column.
                              -- Ignored in Ex mode.
                 .. "w"       -- use "[w]" instead of "written" for file write message
                              -- and "[a]" instead of "appended" for ':w >> file' command
                 .. "x"       -- use "[dos]" instead of "[dos format]", "[unix]" instead of
                              -- "[unix format]" and "[mac]" instead of "[mac format]".
                 .. "C"       -- don't give messages while scanning for ins-completion items
                 .. "F"       -- don't display file information when editing a file
                 .. "I"       -- don't display the info message when starting neovim
                 .. "O"       -- message for reading a file overwrites any previous message.
                              -- Also for quickfix message (e.g., ":cn").
                 .. "T"       -- truncate other messages in the middle if they are too long to
                              -- fit on the command line.  "..." will appear in the middle.
                              -- Ignored in Ex mode.

opt.formatoptions = "t"       -- Auto wrap text using textwidth
                 .. "c"       -- auto wrap comments with textwidth
                 .. "q"       -- allow formatting of comments with "gq" <3
                 .. "n"       -- recognized numbered lists when formatting
                 .. "l"       -- no automatic reformatting of existing long lines
                 .. "j"       -- remove comment leaders when joining lines where possible

opt.termguicolors = true      -- Enables 24-bit RGB color
opt.hidden        = true      -- background buffers without writing them. saves marks/undo as well
opt.confirm       = false     -- I don't really want to see confirm popups
opt.conceallevel  = 2         -- Hide markup for things like links, bold, and italics
opt.number        = true      -- Absolute line numbers
opt.ruler         = true      -- Line and column number of the cursor
opt.hlsearch      = true      -- Highlight searches
opt.incsearch     = true      -- Incrementally search
opt.inccommand    = "nosplit" -- show incremental changes of substitutions
opt.ignorecase    = true      -- Ignore case when searching...
opt.smartcase     = true      -- ...unless the query is case sensitive
opt.cursorline    = true      -- Highlight the current line of the cursor
opt.report        = 0         -- Always report number of lines changed by ex commands
opt.wrap          = false     -- Don't wrap long lines for display by default.
opt.modelines     = 5         -- Look for five modelines around the beginning and end of a file
opt.visualbell    = true      -- Don't beep
opt.belloff       = "all"     -- Seriously, don't beep
opt.expandtab     = true      -- Spaces by default
opt.shiftwidth    = 2         -- Two space indent
opt.softtabstop   = 2         -- ... and here ...
opt.tabstop       = 2         -- ... and here ...
opt.shiftround    = true      -- Round indent to a multiple of shiftwidth
opt.breakindent   = true      -- Make nice paragraphs out of comments
opt.timeoutlen    = 300       -- Give me more time for complex mappings
opt.ttimeoutlen   = 10        -- Make Escape work faster
opt.backup        = false     -- No backups
opt.swapfile      = false     -- No swap files. I too like to live...dangerously.
opt.splitbelow    = true      -- New windows on the bottom
opt.splitright    = true      -- New windows on the right
opt.splitkeep     = "screen"  -- Keep text on the same line for horizontal splits
opt.equalalways   = false     -- I'll handle the window sizes.
opt.startofline   = false     -- Attempt to keep the cursor in the same column
opt.scrolloff     = 3         -- 3 lines of context when scrolling
opt.sidescrolloff = 8         -- 8 columns of context when side scrolling
opt.showmatch     = true      -- Show matching pairs
opt.showmode      = false     -- Don't show the mode since we have a statusline
opt.updatetime    = 100       -- Update faster
opt.mouse         = ""        -- Disable mouse by default
opt.pumblend      = 10        -- 10% pseudo-transparency for the popup-menu
opt.pumheight     = 10        -- Maximum number of entries in the popup-menu
opt.signcolumn    = "yes"     -- Always display the sign column otherwise the UI moves
opt.completeopt   = {         -- Insert mode completion options
  "menu",                     -- Use a popup menu
  "menuone",                  -- Even if there's only one option
  "preview"                   -- With a preview window for extra info
}

opt.list          = true      -- Mark up my buffers
opt.listchars     = {         -- And use fancy characters to do it
  nbsp = "˽",
  extends = "»",
  precedes = "«",
  trail = "•",
  tab = "▸-",
}
opt.fillchars     = {         -- Characters to fill statuslines, vertical separators, etc.
    vert = "▕",
    fold = " ",
    eob = " ",
    diff = "─",
    msgsep = "‾",
    foldopen = "▾",
    foldclose = "▸",
    foldsep = "│",
}

-- Prevent the built in markdown support from overriding these settings
vim.g.markdown_recommended_style = 0
