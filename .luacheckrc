-- .luacheckrc 文件其实就是个 lua 代码文件

-- 缓存检查结果,下次检查时只扫描内容有变化的文件
cache = true

-- 是否检查变量重定义
-- 执行样例:sh check.sh my_tools/luacheck/spec/samples/redefined.lua
redefined = true

 -- 是否输出警告编码
-- 执行样例:sh check.sh my_tools/luacheck/spec/samples/defined.lua
codes = true

-- 是否警告无引用的方法参数或循环变量
-- 执行样例:sh check.sh my_tools/luacheck/spec/samples/unused_code.lua
-- unused_args = true

-- 是否警告无引用的变量
-- 执行样例:sh check.sh my_tools/luacheck/spec/samples/unused_code.lua
--unused = true

-- [原文解释](https://luacheck.readthedocs.io/en/0.12.0/warnings.html#secondary-values-and-variables)
-- 没理解,感觉打开检查会更严格些
-- 执行样例:sh check.sh my_tools/luacheck/spec/samples/unused_secondaries.lua
unused_secondaries = true

-- 执行样例:sh check.sh my_script/allow_defined_top.lua
-- 是否允许在任何文件里定义全局变量
allow_defined = false
-- 是否只允许根作用域定义全局变量,除此以外定义会有警告
allow_defined_top = true
-- 注:当allow_defined = true, allow_defined_top无效

-- 忽略检查,检查模式支持lua正则表达
-- 当unused = true,优先级高于ignore定义的模式
ignore = {
    "6..", -- 忽略警告编码6开头(排版格式)的warning
    "211/a", -- 忽略警告编码212情况下,a的变量的未使用警告。a变量此处只是示例。你可以换成其它名称
    "^_", -- 以_开头的变量的未使用警告。
}
-- 与ignore相反,开启检查
enable = {
    
}

-- 排除检查的文件或目录
exclude_files = {
    "my_3rd/", 
    "my_tools/",
    "**/.git/",
    ".my_temp/",
    --"^%./", -- TODO:排除.号开头的目录
}

-- 自定义全局变量
-- 执行样例:sh check.sh my_script/globals.lua
-- 方法1:
-- 全局变量成员可同时读写
globals = {
    "G_TOP_TEST"
}
--全局变量成员只读
read_globals = {
    "G_TOP_READ_ONLY_TEST"
}
-- 方法1:
-- 定义API检查集
-- luacheck提供内置的API符号检查,具体见[Command line options](https://luacheck.readthedocs.io/en/stable/cli.html#command-line-options)
-- 如下,使用了内置的lua53和lua53c的API符号集,以及自定义空间集my_script和my_tools
std = "lua53+lua53c+my_script+my_tools"
-- 自定义my_script符号集
stds.my_script = {
    -- 全局变量成员可同时读写
    globals = {"G_MY_SCRIPT_TEST"},
    --全局变量成员只读
    read_globals  = { "G_MY_SCRIPT_READ_ONLY_TEST" }, 
}
-- 自定义my_tools符号集
stds.my_tools = {

}

-- 为文件配置参数
-- files是luacheck内部的特殊变量
-- files定义的文件参数会优先于上面提到的配置,文件名支持lua正则表达

-- 在上面ingore配置中,忽略了以`_`开头的所有警告
-- 此处对于./my_sample/file_spec.lua, 需要打开警告
files["./my_sample/file_spec.lua"] = {
    enable = {"^_"}
}
--./my_sample/file_spec_dir目录下,文件格式是`file_*`,都打开以`_`开头的所有警告
files["./my_sample/file_spec_dir/file_*"] = {
    enable = {"^_"}
}