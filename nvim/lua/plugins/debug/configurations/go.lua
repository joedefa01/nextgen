local configs = require('dap').configurations

configs.go = {
    {
        type = 'go',
        name = 'Debug Current File',
        request = 'launch',
        program = '${file}',
    },
    {
        type = 'go',
        name = 'Attach to Running Process...',
        request = 'attach',
        processId = function() require('dap.utils').pick_process(); end
    },
}
