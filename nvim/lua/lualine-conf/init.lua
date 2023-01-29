-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
    bg       = '#292f3a',
    fg       = '#eceff4',
    yellow   = '#ebcb8b',
    cyan     = '#88c0d0',
    darkblue = '#5e81ac',
    green    = '#a3be8c',
    orange   = '#d08770',
    violet   = '#b48ead',
    magenta  = '#b48ead',
    blue     = '#81a1c1',
    red      = '#bf616a',
    unimp    = '#616e88',
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        globalstatus = true,
        theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left {
    'mode',
    color = function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.blue,
            i = colors.green,
            v = colors.cyan,
            ['␖'] = colors.blue,
            V = colors.cyan,
            c = colors.yellow,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            ['␓'] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
            vb = colors.cyan,
        }
        return { bg = mode_color[vim.fn.mode()], fg = colors.bg, gui =  'bold' }
        -- return { fg = mode_color[vim.fn.mode()], gui =  'bold' }
    end,
    -- icons_enabled = true,
    -- icon = '▊',
    padding = { right = 1, left = 1 },
    -- padding = { right = 1 },
}

ins_left {
    -- filesize component
    'filesize',
    cond = conditions.buffer_not_empty,
    color = { fg = colors.unimp, gui = 'bold' },
    padding = { left = 2, right = 1 },
}

ins_left {
    'filename',
    cond = conditions.buffer_not_empty,
    path = 1,
    color = { fg = colors.magenta, gui = 'bold' },
}

ins_left {
    'branch',
    icon = '',
    color = { fg = colors.green, gui = 'bold' },
    padding = { right = 1, left = 1 },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
    function()
        return '%='
    end,
}

ins_right {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = { added = '+', modified = '~', removed = '-' },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
}

-- Add components to right sections
ins_right {
    'o:encoding', -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = 'bold' },
}

ins_right {
    'fileformat',
    fmt = string.upper,
    icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    color = { fg = colors.green, gui = 'bold' },
    padding = { right = 2, left = 1 }
}

-- File type 
ins_right {
    'filetype',
    fmt = string.upper,
    color = { fg = colors.bg, bg = colors.green, gui = 'bold' },
}

-- Now don't forget to initialize lualine
lualine.setup(config)

