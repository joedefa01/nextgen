local adapters = require("dap").adapters
adapters.python = {
    type = "executable",
    command = os.getenv("HOME") .. "/.pyenv/versions/debugpy/bin/python",
    args = { "-m", "debugpy.adapter" },
}
