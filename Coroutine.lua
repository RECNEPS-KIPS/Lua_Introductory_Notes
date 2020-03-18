---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by KipKips.
--- DateTime: 2020.3.17 21:16
---

---协程的声明和调用 方法一
print("-----------------------------------------")
--定义协程
add=coroutine.create(
        function(a,b)
            print(a+b)
        end
)
--启动协程
coroutine.resume(add,5,41)
print("-----------------------------------------")
---协程的声明和调用 方法二
add=coroutine.wrap(
        function(a,b)
            print(a+b)
        end
)
add(45,445)
print("-----------------------------------------")
---协程的声明和调用 方法三
function add(a,b)
    print("协程三 "..a+b)
end
co=coroutine.create(add)
coroutine.resume(co,1,2)

print("-----------------------------------------")
---协程的声明和调用 方法四
function add(a,b)
    print("协程四 "..a+b)
end
add=coroutine.wrap(add)
add(1,234)

print("-----------------------------------------")
---协程的继续执行 方法一
test=coroutine.create(
        function(a,b)
            print(a+b)
            coroutine.yield()
            print(a-b)
        end
)
coroutine.resume(test,4,3)
coroutine.resume(test)--协程继续执行,无论传参不传参都不影响输出结果
print("-----------------------------------------")
---协程的继续执行 方法二
test=coroutine.wrap(
        function(a,b)
            print("a,b的和为"..a+b)
            coroutine.yield()--协程的挂起函数
            print("a,b的差为"..a-b)
        end
)
test(5,2)
print("结束")
test()--协程继续执行,无论传参不传参都不影响输出结果
print("-----------------------------------------")
---案例运行
function foo (a)
    print("foo 函数输出", a)
    return coroutine.yield(2 * a) -- 返回  2*a 的值
end

co = coroutine.create(function (a , b)
    print("第一次协同程序执行输出", a, b) -- co-body 1 10
    local r,s = foo(a + 1)

    print("第二次协同程序执行输出", r,s)
    local r, s = coroutine.yield(a + b, a - b)  -- a，b的值为第一次调用协同程序时传入

    print("第三次协同程序执行输出", r, s)
    return b, "结束协同程序"                   -- b的值为第二次调用协同程序时传入
end)

print("main", coroutine.resume(co, 1, 10)) -- true, 4

print("--分割线----")
print("main", coroutine.resume(co, "rmmmm","emmmmmmm")) -- true 11 -9
print("---分割线---")
print("main", coroutine.resume(co, "x", "y")) -- true 10 end
print("---分割线---")
print("main", coroutine.resume(co, "x", "y")) -- cannot resume dead coroutine
print("---分割线---")
print("-----------------------------------------")
---协程的返回值
co=coroutine.create(
        function(a,b)
            coroutine.yield(a*b,a^b)
            return a+b
        end
)
res1,res2,res3=coroutine.resume(co,4,2)
print(res1,res2,res3)
resend1,resend2=coroutine.resume(co)
print(resend1,resend2)
print("-----------------------------------------")

---协程的挂起 方法一 直接在协程函数里yield
co=coroutine.create(

        function(a,b)
            print(a+b)
            print(coroutine.running())--返回协程的内存地址
            print(coroutine.status(co))--返回协程的状态,当前为运行态 running
            coroutine.yield()
            print(a-b)
            coroutine.yield()
            print(a*b)
            coroutine.yield()
        end
)
print(coroutine.status(co))--返回协程的状态,当前为挂起态 suspended
print(coroutine.resume(co,8,2))
print()
print(coroutine.resume(co))
print()
print(coroutine.resume(co))
print()
print(coroutine.resume(co))--true
print()
print(coroutine.status(co))--返回协程的状态,当前为终止态 dead
print(coroutine.resume(co))--false
print("-----------------------------------------")
---协程的挂起 方法二 在外部函数yield
--resume的参数作为yield的返回值,yield的参数作为resume的返回值
function outFun(a,b)
    print("outfun里面的输出"..a^b)
    return coroutine.yield(a+a,b+b)--yield的参数会作为对应resume的返回值
end
co=coroutine.create(
        function(a,b)
            print(a+b)
            r,s=outFun(a,b)
            print(r,s)
            coroutine.yield()
            print(a*b)
        end
)
print("----1----")
print(coroutine.resume(co,2,4))
print("----2----")
coroutine.resume(co,"wef","wqf")
print("----3----")
coroutine.resume(co)

