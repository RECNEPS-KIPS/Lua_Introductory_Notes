---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by KipKips.
--- DateTime: 2020.3.16 22:28
---


---设置普通表和元表的关联
print()
print("---------设置普通表和元表的关联-------------------------")
print()
tab={"Lua","Java","C#","C++"} --普通表
metatab={}--元表
setmetatable(tab,metatab) --将metatab设置为tab的元表,会将普通表返回,元表扩展了普通表的行为

st=setmetatable(tab,metatab)--普通表

print(st[1],st[2],st[3],st[4])

gt=getmetatable(tab)--获取元表



--简要写法
metatab={}
tab=setmetatable({"asd","asda","h"},metatab)
print()
print("--------metatable的用法-------------------------")
print()
---__metatable的用法
metatab={__metatable="assdgd",1,2}
tab=setmetatable({"asd","asda","h"},metatab)
print(tab[1])
--元表的__metatable存在值
print(getmetatable(tab)[1]) --无法访问
print(getmetatable(tab))--返回__metatable键的对应值
print()
print("--------index用法(指向函数)-------------------------")
---__index用法(指向函数)
print()
--元表中的键是有限制的,不能随意写
metatab={
    __metatable="assdgd",
    --__index为一个函数,参数是固定的,参数tab为关联的普通表,key为访问索引
    --__index指向的函数可以有返回值
    __index=function(tab,key)
        --print("不存在索引"..key.."的值")
        return "不存在索引"..key.."的值"
    end
}
tab=setmetatable({"Lua","C#","C++","Java","Python"},metatab)

print(tab[1])--若索引可以正常访问,则不调用元表的__index指向的函数
print(tab[10])--若索引不可以访问,则调用__index指向的函数,有返回值,则输出返回值
a=tab[10]
print(a)

print()
print("----------index的用法(指向表)-------------------------")
---__index的用法(指向表)
print()
indextab={}
indextab[5]="Nodejs"
indextab[6]="Golang"
indextab[7]="PHP"
indextab[8]="JavaScript"
indextab[9]="SQL"
indextab[10]="Swift"
metatab={
    __metatable="lock",
    --__index为一个表,若索引不可以访问,则在__index的表中查询,若索引可以正常访问,则正常返回
    __index=indextab
}
tab=setmetatable({"Lua","C#","C++","Java","Python"},metatab)
print(tab[10])
print(tab[5])--若索引在tab和__index指向的表中都可以访问,优先访问tab的索引值
print()
print("--------newindex的用法(指向函数)-------------------------")
print()
---newindex的用法(指向函数)
---修改新的索引才会起作用(添加新的数据),并且不进行赋值操作

tab={"Lua","C#","C++","Java","Python"}
metatab={
    __newindex=function(tab,key,value)--tab为操作的表,key为操作的索引,value为改变的值
        print("tab的索引"..key.."的值为"..value)
        rawset(tab, key,value)---rawset方法将表中值更新

    end
}
setmetatable(tab,metatab)
tab[6]="C"--调用__newindex指向的函数,不进行赋值操作,除非进行rawset(tab,key,value)操作
print(tab[6])
tab[5]="C"--无输出
print(tab[5])


---newindex的用法(指向表)
print()
print("--------newindex的用法(指向表)-------------------------")
print()
tab={"Lua","C#","C++","Java","Python"}
newindextab={}
metatab={
    __newindex=newindextab
}
setmetatable(tab,metatab)

tab[5]="Rust" --操作的索引在tab中,对tab进行操作
print(tab[5])
tab[6]="C" --若操作的索引不在tab中,将数据添加到__newindex指向的表中去,索引为该索引
print(tab[6])
print(newindextab[6])
print()
print("----------为表添加操作符-------------------------")
print()
---为表添加操作符
tab={"Lua","C#","C++","Java","Python"}
newtab={"PHP","C","Rust","SQL"}
metatab={
    --__add值指向函数,参数为当前表和新表
    __add=function(tab,newtab)
        ---第一种插入方法
        --for i=1,#newtab do
        --    table.insert(tab,newtab[i])
        --end
        ---第二种插入方法
        for i=1,#newtab do
            tab[1+#tab]=newtab[i]
        end
        return tab
    end,
    __concat=function(tab,str)
        for i=1,#tab do
            tab[i]=tab[i]..str
        end
        return tab
    end,
    --__tostring用来定义print(tab)的输出
    __tostring = function(tab)
        sum = ""
        for k in pairs(tab) do
            sum = sum..tab[k].." "
        end
        return sum
    end,
    --__unm取负数
    __unm=function(tab)
        for k in pairs(tab) do
            tab[k]="-"..tab[k]
        end
        return tab
    end
}
setmetatable(tab,metatab)
tab=tab+newtab
for i = 1, #tab do
    print(tab[i])
end

tab=tab.."_wkp"
for i = 1, #tab do
    print(tab[i])
end
print(tab)

tab=-tab
for i = 1, #tab do
    print(tab[i])
end

print()
print("------------call方法-----------------------------------")
print()
tab={"Lua",1,"C#","C++",2,3,"Java",4,"Python"}
newtab={"PHP","C","Rust","SQL"}
metatab= {
    __add=function(tab,newtab)
        ---第一种插入方法
        --for i=1,#newtab do
        --    table.insert(tab,newtab[i])
        --end
        ---第二种插入方法
        for i=1,#newtab do
            tab[1+#tab]=newtab[i]
        end
        return tab
    end,
    --当表被当做函数来调用时,会使用__call
    __call=function(tab,arg1,arg2)
        if type(arg1)=="number" then
            for i = 1, #tab do
                if type(tab[i])=="number" then
                    tab[i]=tab[i]+arg1+arg2
                end
            end
        else
            for i = 1, #tab do
                if type(tab[i])=="string" then
                    tab[i]=tab[i].." "..arg1.." "..arg2
                end
            end
        end
    end
}
setmetatable(tab,metatab)
tab("1","1")
for i = 1, #tab do
    print(tab[i])
end
